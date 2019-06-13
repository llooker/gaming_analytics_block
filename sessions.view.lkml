################################################################
# Sessions View
################################################################

view: sessions {
  derived_table: {
    sql: WITH lag AS
        (SELECT
                  logs.event AS created_at
                , logs.user_id AS user_id
                , TIMESTAMP_DIFF(logs.event, LAG(logs.event) OVER ( PARTITION BY logs.user_id ORDER BY logs.event), minute) AS idle_time
              FROM gaming_demo_dev.raw_events as logs
              )
        SELECT
          lag.created_at AS session_start
          , lag.idle_time AS idle_time
          , lag.user_id AS user_id
          , GENERATE_UUID() AS unique_session_id
          --, ROW_NUMBER () OVER (PARTITION BY lag.user_id ORDER BY lag.created_at) AS session_sequence
          , COALESCE(
                LEAD(lag.created_at) OVER (PARTITION BY lag.user_id ORDER BY lag.created_at)
              , '6000-01-01') AS next_session_start
        FROM lag
        WHERE (lag.idle_time > 15 OR lag.idle_time IS NULL)  -- session threshold (currently set at 15 minutes)
       ;;
      datagroup_trigger: events_raw
      partition_keys: ["session_start"]
  }

}
