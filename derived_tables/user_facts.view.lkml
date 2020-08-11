#This is a native derived table created using this query:
#https://demoexpo.looker.com/explore/gaming/events?fields=user_facts.d1_retained_users,events.number_of_users,events.d1_retention_rate&fill_fields=user_facts.d1_retained_users&f[events.event_date]=&sorts=user_facts.d1_retained_users&limit=500&column_limit=50&vis=%7B%7D&filter_config=%7B%22events.event_date%22%3A%5B%7B%22type%22%3A%22anytime%22%2C%22values%22%3A%5B%7B%22constant%22%3A%227%22%2C%22unit%22%3A%22day%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%7B%22table_calculation%22%3A%22calculation_1%22%2C%22label%22%3A%22Calculation+1%22%2C%22expression%22%3A%22%24%7Bevents.number_of_users%7D%2Fsum%28%24%7Bevents.number_of_users%7D%29%22%2C%22value_format%22%3Anull%2C%22value_format_name%22%3A%22percent_2%22%2C%22_kind_hint%22%3A%22measure%22%2C%22_type_hint%22%3A%22number%22%7D%5D&origin=share-expanded

view: user_facts {
  derived_table: {
    explore_source: events {
      column: user_id {}
      column: total_d1_revenue {}
      column: total_d7_revenue {}
      column: total_d14_revenue {}
      column: total_d30_revenue {}
      column: total_revenue {}
      column: total_iap_revenue {}
      column: total_revenue_after_UA {}
      column: number_of_sessions { field: session_facts.number_of_sessions }
      column: cost_per_install {}
      column: d1_retained_users {}
      column: d7_retained_users {}
      column: d14_retained_users {}
      column: d30_retained_users {}
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
  dimension: total_d1_revenue {
    group_label: "LTV"
    label: "D1_LTV"
    description: "Revenue (ads + IAP) on day 1"
    value_format_name: usd
    type: number
  }
  dimension: total_d7_revenue {
    group_label: "LTV"
    label: "D7_LTV"
    description: "Revenue (ads + IAP) on day 7"
    value_format_name: usd
    type: number
  }
  dimension: total_d14_revenue {
    group_label: "LTV"
    label: "D14_LTV"
    description: "Revenue (ads + IAP) on day 14"
    value_format_name: usd
    type: number
  }
  dimension: total_d30_revenue {
    group_label: "LTV"
    label: "D30_LTV"
    description: "Revenue (ads + IAP) on day 30"
    value_format_name: usd
    type: number
  }
  dimension: total_revenue {
    group_label: "LTV"
    label: "total_ltv"
    description: "IAP + Ad Revenue"
    value_format_name: usd
    type: number
  }
  dimension: total_iap_revenue {
    group_label: "LTV"
    label: "Total IAP Revenue"
    description: "Total Revenue from In-App Purchases"
    value_format_name: usd
    type: number
  }
  dimension: total_revenue_after_UA {
    group_label: "LTV"
    label: "LTV Revenue After UA"
    description: "Revenue - Marketing Spend"
    value_format_name: usd
    type: number
  }
  dimension: number_of_sessions {
    label: "Lifetime Sessions"
    type: number
  }
  dimension: cost_per_install {
    value_format_name: usd
    type: number
  }
  dimension: d1_retained_users {
    group_label: "Retention"
    label: "D1 Retained"
    type: yesno
    description: "Number of players that came back to play on day 1"
    sql: CAST(${TABLE}.d1_retained_users as bool) ;;
  }
  dimension: d7_retained_users {
    group_label: "Retention"
    label: "D7 Retained"
    description: "Number of players that came back to play on day 7"
    type: yesno
    sql: CAST(${TABLE}.d7_retained_users as bool) ;;
  }
  dimension: d14_retained_users {
    group_label: "Retention"
    label: "D14 Retained"
    description: "Number of players that came back to play on day 14"
    type: yesno
    sql: CAST(${TABLE}.d14_retained_users as bool) ;;
  }
  dimension: d30_retained_users {
    group_label: "Retention"
    label: "D30 Retained"
    description: "Number of players that came back to play on day 30"
    type: yesno
    sql: CAST(${TABLE}.d30_retained_users as bool) ;;
  }
  dimension: player_first_seen {
    description: "Not for direct use, use for NDT"
    type: date_time
  }
  dimension: player_last_seen {
    description: "Not for direct use, use for NDT"
    type: date_time
  }

  dimension_group: since_last_seen {
    intervals: [day,hour,week,month]
    type: duration
    sql_start: ${player_last_seen} ;;
    sql_end: CURRENT_TIMESTAMP ;;
  }
  dimension_group: since_first_seen {
    type: duration
    intervals: [day,hour,week,month]
    sql_start: ${player_first_seen} ;;
    sql_end: CURRENT_TIMESTAMP ;;
  }

  measure: number_of_users {
    type: count
  }
}
