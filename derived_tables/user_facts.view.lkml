#This is a native derived table created using this query:
#https://your_instance.looker.com/explore/gaming/events?fields=user_facts.d1_retained_users,events.number_of_users,events.d1_retention_rate&fill_fields=user_facts.d1_retained_users&f[events.event_date]=&sorts=user_facts.d1_retained_users&limit=500&column_limit=50&vis=%7B%7D&filter_config=%7B%22events.event_date%22%3A%5B%7B%22type%22%3A%22anytime%22%2C%22values%22%3A%5B%7B%22constant%22%3A%227%22%2C%22unit%22%3A%22day%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%7B%22table_calculation%22%3A%22calculation_1%22%2C%22label%22%3A%22Calculation+1%22%2C%22expression%22%3A%22%24%7Bevents.number_of_users%7D%2Fsum%28%24%7Bevents.number_of_users%7D%29%22%2C%22value_format%22%3Anull%2C%22value_format_name%22%3A%22percent_2%22%2C%22_kind_hint%22%3A%22measure%22%2C%22_type_hint%22%3A%22number%22%7D%5D&origin=share-expanded

view: user_facts {
  derived_table: {
    explore_source: events {
      column: user_id {}
      column: player_first_seen {}
      column: player_last_seen {}
      filters: {
        field: events.event_date
        value: ""
      }
    }
    datagroup_trigger: events_raw
    partition_keys: ["player_first_seen"]
  }
  dimension: user_id {
    primary_key: yes
  }
  dimension_group: player_first_seen {
    description: "Not for direct use, use for NDT"
    type: time
  }
  dimension_group: player_last_seen {
    description: "Not for direct use, use for NDT"
    type: time
  }

  dimension_group: since_last_seen {
    intervals: [day,hour,week,month]
    type: duration
    sql_start: ${player_last_seen_raw} ;;
    sql_end: CURRENT_TIMESTAMP ;;
  }
  dimension_group: since_first_seen {
    type: duration
    intervals: [day,hour,week,month]
    sql_start: ${player_first_seen_raw} ;;
    sql_end: CURRENT_TIMESTAMP ;;
  }

  measure: number_of_users {
    type: count
  }
}
