##Notes:
# Session pattern from https://stackoverflow.com/a/55116882/1108832
datagroup: sessions {
  sql_trigger: select current_date ;;
}
view: last {
  derived_table: {
    datagroup_trigger: sessions
    sql:
      SELECT
              user_id,
              @{timestamp_field},
              CASE WHEN TIMESTAMP_DIFF(@{timestamp_field}, last_event,MINUTE) >= 20 --session timout = 20 minutes
                     OR last_event IS NULL
                   THEN 1 ELSE 0 END AS is_new_session
         FROM (
              SELECT user_id,
                     @{timestamp_field},
                     LAG(@{timestamp_field},1) OVER (PARTITION BY user_id ORDER BY @{timestamp_field}) AS last_event
                 FROM ${events.SQL_TABLE_NAME}
                 -- WHERE event_name NOT IN('XX','YY') --don't look at every single event to limit rows needed
                  )
       ;;
  }
  dimension: is_new_session {
  }
}

view: sessions {
  derived_table: {
    datagroup_trigger:sessions
    partition_keys: ["session_start"]
    sql: SELECT unique_session_id,
      player_session_sequence,
       user_id,
       MAX(@{timestamp_field}) as session_end,
       MIN(@{timestamp_field}) as session_start,
       TIMESTAMP_DIFF(MAX(@{timestamp_field}), MIN(@{timestamp_field}),MINUTE) AS session_length_minutes
  FROM (
SELECT user_id,
       @{timestamp_field},
       SUM(is_new_session) OVER (ORDER BY user_id, @{timestamp_field}) AS unique_session_id,
       SUM(is_new_session) OVER (PARTITION BY user_id ORDER BY @{timestamp_field}) AS player_session_sequence
  FROM ${last.SQL_TABLE_NAME} as final
       ) session
WHERE unique_session_id is not null
GROUP BY 1,2,3
 ;;
  }

  dimension: unique_session_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.unique_session_id ;;
  }

  dimension: player_session_sequence {
    description: "Is this the first, second, etc session for the user"
    type: number
    sql: ${TABLE}.player_session_sequence ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: session_end {
    type: time
    sql: ${TABLE}.session_end ;;
  }

  dimension_group: session_start {
    type: time
    sql: ${TABLE}.session_start ;;
  }

  dimension: session_length_minutes {
    type: number
    sql: ${TABLE}.session_length_minutes ;;
    value_format_name: decimal_2
  }

  measure: number_of_sessions {
    group_label: "Sessions"
    type: count
    drill_fields: [detail*]
  }

  dimension: session_length_minutes_tier {
    type: tier
    tiers: [
      0,
      1,
      5,
      15
    ]
    style: integer
    sql: ${session_length_minutes} ;;
  }

  measure: average_session_length {
    group_label: "Sessions"
    description: "(minutes)"
    type: average
    sql: ${session_length_minutes} ;;
    value_format_name: decimal_2
  }

  measure: average_first_session_length {
    group_label: "Sessions"
    description: "(minutes)"
    type: average
    sql: ${session_length_minutes} ;;
    filters: {
      field: player_session_sequence
      value: "1"
    }
    value_format_name: decimal_2
  }

  set: detail {
    fields: [
      unique_session_id,
      player_session_sequence,
      user_id,
      session_end_time,
      session_start_time,
      session_length_minutes
    ]
  }
}
