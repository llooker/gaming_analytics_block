################################################################
# Session Facts View
################################################################

view: session_facts {
  derived_table: {
    sql: WITH session_facts AS
        (SELECT
             unique_session_id
            , event
            , user_id
            , event_name
            , game_version
            , COALESCE(SUM((IFNULL(iap_revenue,0) + IFNULL(ad_revenue,0)) ), 0) as session_revenue
            , COUNT(CASE WHEN (event_name = 'Ad_Watched') THEN 1 ELSE NULL END) AS number_of_ads_shown
            , FIRST_VALUE (event) OVER (PARTITION BY unique_session_id ORDER BY event ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS session_start
            , LAST_VALUE (event) OVER (PARTITION BY unique_session_id ORDER BY event ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS session_end
            , FIRST_VALUE (event_name) OVER (PARTITION BY unique_session_id ORDER BY event ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS session_first_event
            , LAST_VALUE  (event_name) OVER (PARTITION BY unique_session_id ORDER BY event ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS session_last_event
          FROM
              ${events_sessionized.SQL_TABLE_NAME} AS logs_with_session_info
          GROUP BY 1,2,3,4,5
          ORDER BY unique_session_id asc
        )
      SELECT
          session_facts.unique_session_id
        , session_facts.user_id
        , session_facts.session_start
        , session_facts.session_end
        , session_first_event
        , session_last_event
        , session_facts.game_version
        , SUM(session_facts.session_revenue) as session_revenue
        , SUM(session_facts.number_of_ads_shown) as number_of_ads_shown
        , ROW_NUMBER () OVER (PARTITION BY session_facts.user_id ORDER BY MIN(session_start)) AS session_sequence_for_user
        , ROW_NUMBER () OVER (PARTITION BY session_facts.user_id ORDER BY MIN(session_start) desc) AS inverse_session_sequence_for_user
        , count(1) as events_in_session
      FROM session_facts
      INNER JOIN
        ${events_sessionized.SQL_TABLE_NAME} AS logs_with_session_info
      ON  logs_with_session_info.event = session_facts.session_start
      AND logs_with_session_info.unique_session_id = session_facts.unique_session_id
      GROUP BY 1,2,3,4,5,6,7
       ;;
    datagroup_trigger: events_raw
    partition_keys: ["session_start"]
  }

  dimension: unique_session_id {
    primary_key: yes
    type: string
    value_format_name: id
    sql: ${TABLE}.unique_session_id ;;
  }

  dimension: user_id {}

  dimension: game_version {}

  dimension_group: session_start_at {
    type: time
    convert_tz: no
    timeframes: [raw,time, date, week, month]
    sql: ${TABLE}.session_start ;;
  }

  dimension_group: session_end_at {
    type: time
    convert_tz: no
    timeframes: [raw,time, date, week, month]
    sql: ${TABLE}.session_end ;;
  }

  dimension: session_sequence_for_user {
    type: number
    sql: ${TABLE}.session_sequence_for_user ;;
  }

  dimension: inverse_session_sequence_for_user {
    type: number
    sql: ${TABLE}.inverse_session_sequence_for_user ;;
  }

  dimension: number_of_events_in_session {
    type: number
    sql: ${TABLE}.events_in_session ;;
  }

  dimension: session_first_event {
    type: string
    sql: ${TABLE}.session_first_event ;;
  }

  dimension: session_last_event {
    type: string
    sql: ${TABLE}.session_last_event ;;
  }

  dimension_group: session_length {
    type: duration
    intervals: [second,minute,hour]
    sql_start: ${session_start_at_raw} ;;
    sql_end: ${session_end_at_raw} ;;
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
    sql: ${minutes_session_length} ;;
  }

  dimension: session_revenue {
    type: number
    description: "IAP and Ad Revenue in Session"
    sql: ${TABLE}.session_revenue ;;
    value_format_name: usd
  }

  dimension: number_of_ads_shown {
    type: number
    sql: ${TABLE}.number_of_ads_shown ;;
  }

  measure: average_session_length_seconds {
    type: average
    sql: ${seconds_session_length} ;;
  }

  measure: number_of_sessions {
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      unique_session_id,
      session_start_at_time,
      session_end_at_time,
      session_sequence_for_user,
      inverse_session_sequence_for_user,
      number_of_events_in_session,
      session_first_event,
      session_last_event,
      session_revenue
    ]
  }
}
