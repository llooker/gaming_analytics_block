################################################################
# Funnel Explorer View
################################################################

view: funnel_explorer {
  # In this query, we retrieve, for each session, the first and last instance of each event in our sequence. If,
  # for each event, its first instance occurs before the last instance of the next event in the sequence, then
  # that is considered a completion of the sequence.
  derived_table: {
    sql: SELECT sessions.unique_session_id as unique_session_id
        , events_sessionized.user_id
        , sessions.session_start AS session_start
        , MIN(
            CASE WHEN
              {% condition event_1 %} events_sessionized.event_name {% endcondition %}
              THEN events_sessionized.event
              ELSE NULL END
            ) AS event_1
        , MIN(
            CASE WHEN
              {% condition event_2 %} events_sessionized.event_name {% endcondition %}
              THEN events_sessionized.event
              ELSE NULL END
            ) AS event_2_first
        , MAX(
            CASE WHEN
              {% condition event_2 %} events_sessionized.event_name {% endcondition %}
              THEN events_sessionized.event
              ELSE NULL END
            ) AS event_2_last
        , MIN(
            CASE WHEN
              {% condition event_3 %} events_sessionized.event_name {% endcondition %}
              THEN events_sessionized.event
              ELSE NULL END
            ) AS event_3_first
        , MAX(
            CASE WHEN
              {% condition event_3 %} events_sessionized.event_name {% endcondition %}
              THEN events_sessionized.event
              ELSE NULL END
            ) AS event_3_last
        , MIN(
            CASE WHEN
              {% condition event_4 %} events_sessionized.event_name {% endcondition %}
              THEN events_sessionized.event
              ELSE NULL END
            ) AS event_4_first
          , MAX(
            CASE WHEN
              {% condition event_4 %} events_sessionized.event_name {% endcondition %}
              THEN events_sessionized.event
              ELSE NULL END
            ) AS event_4_last
      FROM ${events_sessionized.SQL_TABLE_NAME} AS events_sessionized
      LEFT JOIN ${sessions.SQL_TABLE_NAME} AS sessions
        ON events_sessionized.unique_session_id = sessions.unique_session_id
      WHERE {% condition event_time %} event {% endcondition %}
           and {% condition game_name %} game_name {% endcondition %}
      GROUP BY 1,2,3
       ;;
  }

  parameter: event_1 {
    suggest_dimension: events.event_name
    suggest_explore: events
  }

  parameter: event_2 {
    suggest_dimension: events.event_name
    suggest_explore: events
  }

  parameter: event_3 {
    suggest_dimension: events.event_name
    suggest_explore: events
  }

  parameter: event_4 {
    suggest_dimension: events.event_name
    suggest_explore: events
  }

  filter: event_time {
    type: date_time
  }

  filter: game_name {
    type: string
    suggest_dimension: events.game_name
    suggest_explore: events
  }

  dimension: unique_session_id {
    type: string
    primary_key: yes
    #     hidden: TRUE
    sql: ${TABLE}.unique_session_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: session_start {
    type: time
    #     hidden: TRUE
    convert_tz: no
    timeframes: [
      time,
      date,
      week,
      month,
      year,
      raw
    ]
    sql: ${TABLE}.session_start ;;
  }

  dimension_group: event_1 {
    description: "First occurrence of event 1"
    type: time
    convert_tz: no
    timeframes: [raw,time]
    hidden: yes
    sql: ${TABLE}.event_1 ;;
  }

  dimension_group: event_2_first {
    description: "First occurrence of event 2"
    type: time
    convert_tz: no
    timeframes: [raw,time]
    hidden: yes
    sql: ${TABLE}.event_2_first ;;
  }

  dimension_group: event_2_last {
    description: "Last occurrence of event 2"
    type: time
    convert_tz: no
    timeframes: [raw,time]
    hidden: yes
    sql: ${TABLE}.event_2_last ;;
  }

  dimension_group: event_3_first {
    description: "First occurrence of event 3"
    type: time
    convert_tz: no
    timeframes: [raw,time]
    hidden: yes
    sql: ${TABLE}.event_3_first ;;
  }

  dimension_group: event_3_last {
    description: "Last occurrence of event 3"
    type: time
    convert_tz: no
    timeframes: [raw,time]
    hidden: yes
    sql: ${TABLE}.event_3_last ;;
  }

  dimension_group: event_4_first {
    description: "First occurrence of event 4"
    type: time
    convert_tz: no
    timeframes: [raw,time]
    hidden: yes
    sql: ${TABLE}.event_4_first ;;
  }

  dimension_group: event_4_last {
    description: "Last occurrence of event 4"
    type: time
    convert_tz: no
    timeframes: [raw,time]
    hidden: yes
    sql: ${TABLE}.event_4_last ;;
  }

  dimension: event1_before_event2 {
    type: yesno
    hidden: yes
    sql: ${TABLE}.event_1 < ${TABLE}.event_2_last ;;
  }

  dimension: event1_before_event3 {
    type: yesno
    hidden: yes
    sql: ${TABLE}.event_1 < ${TABLE}.event_3_last ;;
  }

  dimension: event1_before_event4 {
    type: yesno
    hidden: yes
    sql: ${TABLE}.event_1 < ${TABLE}.event_4_last ;;
  }

  dimension: event2_before_event3 {
    type: yesno
    hidden: yes
    sql: ${TABLE}.event_2_first < ${TABLE}.event_3_last ;;
  }

  dimension: event2_before_event4 {
    type: yesno
    hidden: yes
    sql: ${TABLE}.event_2_first < ${TABLE}.event_4_last ;;
  }

  dimension: event3_before_event4 {
    type: yesno
    hidden: yes
    sql: ${TABLE}.event_3_first < ${TABLE}.event_4_last ;;
  }

  dimension: reached_event_1 {
    hidden: yes
    type: yesno
    sql: (${event_1_raw} IS NOT NULL)
      ;;
  }

  dimension: reached_event_2 {
    hidden: yes
    type: yesno
    sql: (${event_1_raw} IS NOT NULL AND ${event_2_first_raw} IS NOT NULL AND ${event_1_raw} < ${event_2_last_raw})
      ;;
  }

  dimension: reached_event_3 {
    hidden: yes
    type: yesno
    sql: (${event_1_raw} IS NOT NULL AND ${event_2_last_raw} IS NOT NULL AND ${event_3_last_raw}  IS NOT NULL
      AND ${event_1_raw} < ${event_2_last_raw} AND ${event_1_raw} < ${event_3_last_raw} AND ${event_2_first_raw} < ${event_3_last_raw})
       ;;
  }

  dimension: reached_event_4 {
    hidden: yes
    type: yesno
    sql: (${event_1_raw} IS NOT NULL AND ${event_2_last_raw} IS NOT NULL AND ${event_3_last_raw}  IS NOT NULL AND ${event_4_last_raw} IS NOT NULL
      AND ${event_1_raw} < ${event_2_last_raw} AND ${event_1_raw} < ${event_3_last_raw} AND ${event_1_raw} < ${event_4_last_raw} AND ${event_2_first_raw} < ${event_3_last_raw} AND ${event_2_first_raw} < ${event_4_last_raw} AND ${event_3_first_raw} < ${event_4_last_raw})
 ;;
  }

  dimension: furthest_step {
    label: "Furthest Funnel Step Reached"

    case: {
      when: {
        sql: ${reached_event_4} = true ;;
        label: "4th"
      }

      when: {
        sql: ${reached_event_3} = true ;;
        label: "3rd"
      }

      when: {
        sql: ${reached_event_2} = true ;;
        label: "2nd"
      }

      when: {
        sql: ${reached_event_1} = true ;;
        label: "1st"
      }

      else: "no"
    }
  }

  measure: number_of_sessions {
    type: count_distinct
    drill_fields: [detail*]
    sql: ${unique_session_id} ;;
  }

  measure: count_sessions_event1 {
    label: "event 1"
    label_from_parameter: event_1
    type: count_distinct
    sql: ${unique_session_id} ;;
    drill_fields: [detail*]

    filters: {
      field: furthest_step
      value: "1st,2nd,3rd,4th"
    }
  }

  measure: count_sessions_event12 {
    label: "event 2"
    label_from_parameter: event_2
    description: "Only includes sessions which also completed event 1"
    type: count_distinct
    sql: ${unique_session_id} ;;
    drill_fields: [detail*]

    filters: {
      field: furthest_step
      value: "2nd,3rd,4th"
    }
  }

  measure: count_sessions_event123 {
    label: "event 3"
    label_from_parameter: event_3
    description: "Only includes sessions which also completed events 1 and 2"
    type: count_distinct
    sql: ${unique_session_id} ;;
    drill_fields: [detail*]

    filters: {
      field: furthest_step
      value: "3rd, 4th"
    }
  }

  measure: count_sessions_event1234 {
    label: "event 4"
    label_from_parameter: event_4
    description: "Only includes sessions which also completed events 1, 2 and 3"
    type: count_distinct
    sql: ${unique_session_id} ;;
    drill_fields: [detail*]

    filters: {
      field: furthest_step
      value: "4th"
    }
  }

  set: detail {
    fields: [unique_session_id, user_id, session_start_time,session_facts.session_revenue,session_facts.minutes_session_length]
  }
}
