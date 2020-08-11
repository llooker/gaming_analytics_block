################################################################
# Events View
################################################################

view: events_sessionized {
  view_label: "Events"
  derived_table: {
    sql: SELECT
      events.*
    , sessions.unique_session_id
    , ROW_NUMBER () OVER (PARTITION BY unique_session_id ORDER BY events.@timestamp_field) AS event_sequence_within_session
    , ROW_NUMBER () OVER (PARTITION BY unique_session_id ORDER BY events.@timestamp_field desc) AS inverse_event_sequence_within_session
FROM ${events.SQL_TABLE_NAME} AS events
INNER JOIN ${sessions.SQL_TABLE_NAME} AS sessions
  ON events.user_id = sessions.user_id
  AND events.@timestamp_field >= sessions.session_start
  AND events.@timestamp_field < sessions.next_session_start
 ;;
    datagroup_trigger: events_raw
    partition_keys: ["@timestamp_field"]
    cluster_keys: ["game_name"]
  }


  dimension: event_id {
    primary_key: yes
    type: string
    value_format_name: id
    sql: ${TABLE}.unique_event_id ;;
  }

  dimension: unique_session_id {
    type: string
    value_format_name: id
    hidden: yes
    sql: ${TABLE}.unique_session_id ;;
  }

  dimension: event_sequence_within_session {
    type: number
    value_format_name: id
    sql: ${TABLE}.event_sequence_within_session ;;
  }

  dimension: inverse_event_sequence_within_session {
    type: number
    value_format_name: id
    sql: ${TABLE}.inverse_event_sequence_within_session ;;
  }

}
