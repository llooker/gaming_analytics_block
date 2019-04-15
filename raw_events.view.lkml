view: raw_events {
  sql_table_name: gaming_demo_dev.raw_events ;;

  dimension: unique_event_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.unique_event_id ;;
  }

  dimension: ad_revenue {
    type: number
    sql: ${TABLE}.ad_revenue ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: continent {
    type: string
    sql: ${TABLE}.continent ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: device_brand {
    type: string
    sql: ${TABLE}.device_brand ;;
  }

  dimension: device_language {
    type: string
    sql: ${TABLE}.device_language ;;
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
  }

  dimension: device_os_version {
    type: string
    sql: ${TABLE}.device_os_version ;;
  }

  dimension: device_platform {
    type: string
    sql: ${TABLE}.device_platform ;;
  }

  dimension_group: event {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.event ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: game_name {
    type: string
    sql: ${TABLE}.game_name ;;
  }

  dimension: game_version {
    type: string
    sql: ${TABLE}.game_version ;;
  }

  dimension: iap_revenue {
    type: number
    sql: ${TABLE}.iap_revenue ;;
  }

  dimension: install_cost {
    type: number
    sql: ${TABLE}.install_cost ;;
  }

  dimension: install_source {
    type: string
    sql: ${TABLE}.install_source ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: player_session_sequence {
    type: number
    sql: ${TABLE}.player_session_sequence ;;
  }

  dimension_group: user_first_seen {
    #you might need to calculate this!
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.user_first_seen ;;

  }

  measure: count {
    type: count
    drill_fields: [game_name, campaign_name, event_name]
  }
}
