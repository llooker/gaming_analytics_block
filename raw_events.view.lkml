view: raw_events {
  sql_table_name: gaming_demo_dev.raw_events ;; # this will come from your database - replace this file :) 

  dimension: unique_event_id {
    primary_key: yes
    type: string
    sql: 'abcdefg' ;;
  }

  dimension: ad_revenue {
    type: number
    sql: '0.2' ;;
  }

  dimension: campaign_name {
    type: string
    sql: 'campaign_1' ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: 'USA' ;;
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
    sql: CURRENT_TIMESTAMP() ;;
  }

  dimension: event_name {
    type: string
    sql: 'kill_player' ;;
  }

  dimension: game_name {
    type: string
    sql: 'Lookerwood Farms' ;;
  }

  dimension: game_version {
    type: string
    sql: '11' ;;
  }

  dimension: iap_revenue {
    type: number
    sql: 0.5 ;;
  }

  dimension: install_cost {
    type: number
    sql: 1.2 ;;
  }

  dimension: install_source {
    type: string
    sql: 'facebook' ;;
  }

  dimension: user_id {
    type: string
    sql: '1234' ;;
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
    sql: CURRENT_TIMESTAMP() ;;

  }

  measure: count {
    type: count
    drill_fields: [game_name, campaign_name, event_name]
  }
}
