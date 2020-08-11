include: "/upstream_views/raw_events.view.lkml"
view: events {
  sql_table_name: @{events_table} ;;
  extends: [raw_events]

# Configured fields from manifest file:
dimension_group: event { type:time sql: ${TABLE}.@{timestamp_field} ;;}
dimension: user_id { type:string sql: ${TABLE}.@{user_id_field} ;; }
dimension: event_name { type:string sql: ${TABLE}.@{event_name_field} ;; }
dimension: country { type: string sql: ${TABLE}.@{country_field} ;;}
dimension: device_platform { type: string sql: ${TABLE}.@{platform_field} ;; }
dimension: game_version { type: string sql: ${TABLE}.@{version_field} ;; }
dimension: game_name { type: string sql: ${TABLE}.@{game_name_field} ;; }
dimension: acquisition_cost { type:number description: "How much did this player cost to acquire?" sql: ${TABLE}.@{acquisition_cost_field} ;;}
dimension: iap_revenue { type:number description: "Amount of $ paid for this purchase" sql: ${TABLE}.@{iap_revenue_field} ;;}
dimension: ad_revenue { type:number description: "Amount of $ made by watching an ad" sql: ${TABLE}.@{ad_revenue_field} ;;}



# Drill Selector
parameter: drill_by {
  type: string
  default_value: "device_platform"
  allowed_value: { label: "Country" value: "country" }
  allowed_value: { label: "Platform" value: "device_platform" }
  allowed_value: { label: "Game" value: "game_name" }
  allowed_value: { label: "Game Version" value: "game_version" }
  allowed_value: { label: "Install Source" value: "install_source" }
}

dimension: drill_field {
  hidden: yes
  type: string
  label_from_parameter: drill_by
  sql:
  {% case  drill_by._parameter_value %}
    {% when "'country'" %}
      ${country}
    {% when "'device_platform'" %}
      ${device_platform}
    {% when "'game_name'" %}
      ${game_name}
    {% when "'game_version'" %}
      ${game_version}
    {% when "'install_source'" %}
      ${install_source}
    {% else %}
     null
  {% endcase %} ;;
}

# Dimensions
  dimension: install_group {
    description: "Where did the user originate? (organic or paid)"
    type: string
    sql: CASE
            WHEN ${install_source} = 'organic' then 'organic'
            ELSE 'paid'
          END ;;
          drill_fields: [install_source]
  }

  dimension: install_source {
    drill_fields: [campaign_name]
  }

  dimension: campaign_name {
    link: {
      label: "Manage this campaign in {{ events.install_source._value }}"
      url: "http://{{events.install_source._value}}/manage/{{value}}"
    }
  }

  dimension: campaign_type {
    sql:
      case
       when ${campaign_name} LIKE '%video%' THEN 'video'
       when ${campaign_name} LIKE '%playable%' THEN 'playable'
       when ${campaign_name} LIKE '%low%' THEN 'banner - low density'
       when ${campaign_name} LIKE '%high%' THEN 'banner - high density'
       else 'banner - low density'
     END ;;
    drill_fields: [install_source,campaign_name]
  }

  dimension: is_top_10_country {
    type: yesno
    sql: ${country} in ('United States','Russia','Germany','Turkey','United Kingdom','Vietnam','France','Poland','Mexico','Brazil' ) ;;
  }

  dimension: is_first_session {
    type: yesno
    sql: ${sessions.player_session_sequence} = '1' ;;
  }


# User Counts

  measure: number_of_users {
    group_label: "User Counts"
    type: count_distinct
    sql: ${user_id};;
    value_format_name: large_number
    drill_fields: [drill_field,number_of_users]
  }

  measure: number_of_new_users {
    group_label: "User Counts"
    description: "Start date = Play Date"
    type: count_distinct
    sql: ${user_id};;
    filters: {
      field: retention_day
      value: "0"
    }
    value_format_name: large_number
    drill_fields: [drill_field,number_of_new_users]
  }

  measure: number_of_paid_users {
    group_label: "User Counts"
    label: "Number of non-organic users"
    type: count_distinct
    sql: ${user_id};;
    filters: {
      field: install_group
      value: "paid"
    }
    value_format_name: large_number
    drill_fields: [drill_field,number_of_paid_users]
  }



# Event Counts

  measure: count {
    group_label: "Event Counts"
    label: "Number of Events"
    type: count
    value_format_name: large_number
    drill_fields: [drill_field,count]
  }

  measure: number_of_ads_shown {
    group_label: "Event Counts"
    type: count
    filters: {
      field: event_name
      value: "Ad_Watched"
    }
    drill_fields: [drill_field,count]
  }

  measure: ads_shown_per_user {
    group_label: "Event Counts"
    description: "No. of Ads Shown / Number of Users"
    type: number
    value_format_name: decimal_2
    sql: 1.0 * ${number_of_ads_shown} / NULLIF(${number_of_users},0) ;;
    drill_fields: [drill_field,ads_shown_per_user]
  }

# Misc

  dimension_group: current {
    description: "the time right now"
    type: time
    sql: CURRENT_TIMESTAMP() ;;
  }

  dimension: days_since_user_signup {
    type: number
    description: "Days since first seen (from today)"
    sql:  DATE_DIFF(${current_date}, ${user_facts.player_first_seen_date}, DAY);;
  }



# Retention

  dimension: retention_day {
    group_label: "Retention"
    description: "Days since first seen (from event date)"
    type:  number
    sql:  DATE_DIFF(${event_date}, ${user_facts.player_first_seen_date}, DAY);;
  }

 # D1

  measure: d1_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 1"
    type: count_distinct sql: ${user_id} ;;
    filters: {
      field: retention_day
      value: "1"
    }
    drill_fields: [drill_field,d1_retained_users]
  }

  measure: d1_eligible_users {
    hidden: yes
    group_label: "Retention"
    description: "Number of players older than 0 days"
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">0"
    }
  }

  measure: d1_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 0 days) that came back to play on day 1"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d1_retained_users}/ NULLIF(${d1_eligible_users},0);;
    drill_fields: [drill_field,d1_retention_rate]
  }

  # D7

  measure: d7_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 7"
    type: count_distinct sql: ${user_id} ;;
    filters: {
      field: retention_day
      value: "7"
    }
    drill_fields: [drill_field,d7_retained_users]
  }

  measure: d7_eligible_users {
    hidden: yes
    group_label: "Retention"
    description: "Number of players older than 7 days"
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">7"
    }
    drill_fields: [drill_field,d7_eligible_users]
  }

  measure: d7_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 7 days) that came back to play on day 7"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d7_retained_users}/ NULLIF(${d7_eligible_users},0);;
    drill_fields: [drill_field,d7_retention_rate]
  }

  # D14

  measure: d14_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 14"
    type: count_distinct sql: ${user_id} ;;
    filters: {
      field: retention_day
      value: "14"
    }
    drill_fields: [drill_field,d14_retained_users]
  }

  measure: d14_eligible_users {
    hidden: yes
    group_label: "Retention"
    description: "Number of players older than 14 days"
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">14"
    }
    drill_fields: [drill_field,d14_eligible_users]
  }

  measure: d14_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 14 days) that came back to play on day 14"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d14_retained_users}/ NULLIF(${d14_eligible_users},0);;
    drill_fields: [drill_field,d14_retention_rate]
  }

  # D30

  measure: d30_retained_users {
    group_label: "Retention"
    description: "Number of players that came back to play on day 30"
    type: count_distinct sql: ${user_id} ;;
    filters: {
      field: retention_day
      value: "30"
    }
    drill_fields: [drill_field,d30_retained_users]
  }

  measure: d30_eligible_users {
    hidden: yes
    group_label: "Retention"
    description: "Number of players older than 30 days"
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: days_since_user_signup
      value: ">30"
    }
    drill_fields: [drill_field,d30_eligible_users]
  }

  measure: d30_retention_rate {
    group_label: "Retention"
    description: "% of players (that are older than 30 days) that came back to play on day 30"
    value_format_name: percent_2
    type: number
    sql: 1.0 * ${d30_retained_users}/ NULLIF(${d30_eligible_users},0);;
    drill_fields: [drill_field,d30_retention_rate]
  }

# UA

  measure: cost_per_install {
    label: "CPI"
    description: "Total install spend/number of new users"
    group_label: "User Acquistion"
    type: number
    sql: ${total_install_spend}/ NULLIF(${number_of_new_users},0) ;;
    value_format_name: large_usd
    drill_fields: [drill_field,cost_per_install]
  }

  measure: total_install_spend {
    group_label: "User Acquistion"
    description: "Total spent to acquire users"
    type: sum
    sql: ${acquisition_cost} ;;
    value_format_name: large_usd
    drill_fields: [drill_field,total_install_spend]
  }


  measure: return_on_ad_spend {
    group_label: "User Acquistion"
    label: "ROAS"
    description: "Revenue (from paid users) / Cost (to acquire those users) "
    type: number
    sql: 1.0 * ${total_revenue_from_paid_users} / NULLIF(${total_install_spend},0) ;;
    value_format_name: percent_2
    html:
    {% if value <= 1.0 %}
    <a style="color: red; font-size:100%" href="#drillmenu" target="_self">{{ rendered_value }}</a>
    {% elsif value > 1.0 %}
    <a style="color: green; font-size:100%" href="#drillmenu" target="_self">{{ rendered_value }}</a>
    {% endif %} ;;
    drill_fields: [drill_field,total_install_spend,return_on_ad_spend,number_of_paid_users,total_revenue_from_paid_users,cost_per_install]
  }

# Monetization

dimension: is_paying_user {
  type: yesno
  description: "Had an IAP purhcase in selected time period"
  sql: ${iap_revenue} > 0 ;;
}

dimension: is_iap_purchase {
  type: yesno
  hidden: yes
  sql: ${event_name} = 'in_app_purchase' ;;
}

dimension: iap_purchase_tier {
  group_label: "Monetization"
  label: "IAP Purchase Tier"
  description: "How big was each purchase?"
  type: tier
  tiers: [0,10,20,30]
  sql: ${iap_revenue} ;;
  style: integer
  value_format_name: usd_0
}

measure: number_of_iap_purchases {
  group_label: "Monetization"
  label: "Number of IAP Purchases"
  type: count
  filters: {
    field: is_iap_purchase
    value: "yes"
  }
  drill_fields: [drill_field,total_iap_revenue]
}

measure: transactions_per_spender {
  type: number
  description: "For paying users, how many transactions do they make"
  group_label: "Monetization"
  sql: 1.0 * ${number_of_iap_purchases}/nullif(${number_of_spenders},0) ;;
  value_format_name: decimal_2
  drill_fields: [drill_field,transactions_per_spender]
}

measure: total_iap_revenue {
  label: "Total IAP Revenue"
  group_label: "Monetization"
  description: "Total Revenue from In-App Purchases"
  type: sum
  sql: ${iap_revenue} ;;
  value_format_name: large_usd
  drill_fields: [drill_field,total_iap_revenue]
}

  measure: total_ad_revenue {
    group_label: "Monetization"
    description: "Total Revenue from Ads"
    type: sum
    sql: ${ad_revenue} ;;
    value_format_name: large_usd
    drill_fields: [drill_field,total_ad_revenue]
  }

  dimension: combined_revenue {
    type: number
    sql: IFNULL(${iap_revenue},0) + IFNULL(${ad_revenue},0) ;;
    value_format_name: large_usd
  }

  measure: total_revenue {
    group_label: "Monetization"
    description: "IAP + Ad Revenue"
    type: sum
    sql: ${combined_revenue} ;;
    value_format_name: large_usd
    drill_fields: [drill_field,total_revenue]
  }

  measure: total_revenue_after_UA {
    label: "Total Revenue After UA"
    group_label: "Monetization"
    description: "Revenue - Marketing Spend"
    type: number
    sql: ${total_revenue} - ${total_install_spend}  ;;
    value_format_name: large_usd
    drill_fields: [drill_field,total_revenue_after_UA]
  }

  measure: total_revenue_from_paid_users {
      group_label: "Monetization"
    description: "IAP + Ad Revenue (for users acquiried by marketing)"
    type: sum
    sql: ${combined_revenue} ;;
    filters: {
      field: install_group
      value: "paid"
    }
    value_format_name: large_usd
    drill_fields: [drill_field,total_revenue]
  }

  measure: average_revenue {
    group_label: "Monetization"
    description: "IAP + Ad Revenue"
    type: average
    sql: ${combined_revenue} ;;
    value_format_name: large_usd
    drill_fields: [drill_field,average_revenue]
  }

  measure: number_of_spenders {
    group_label: "Monetization"
    description: "Number of users with IAP purchases"
    type: count_distinct
    sql: ${user_id} ;;
    filters: {
      field: is_paying_user
      value: "Yes"
    }
    drill_fields: [drill_field,number_of_spenders]
  }

  measure: percent_spenders {
    group_label: "Monetization"
    description: "% of users with IAP purchases"
    type: number
    sql: 1.0 * ${number_of_spenders} / NULLIF(${number_of_users},0) ;;
    value_format_name: percent_2
    drill_fields: [drill_field,percent_spenders]
  }

  measure: average_revenue_per_spender {
    group_label: "Monetization"
    label: "ARPPU (IAP)"
    description: " Total Revenue / Number of IAP Paying Users"
    type: number
    sql: 1.0 * ${total_iap_revenue} / NULLIF(${number_of_spenders},0) ;;
    value_format_name: large_usd
    drill_fields: [drill_field,average_revenue_per_spender]
  }

  measure: average_revenue_per_user {
    group_label: "Monetization"
    label: "ARPU"
    description: "(Average revenue per user) = Total Revenue (IAP + Ad) / Total Number of Users"
    type: number
    sql: 1.0 * ${total_revenue} / NULLIF(${number_of_users},0) ;;
    value_format_name: large_usd
    drill_fields: [drill_field,average_revenue_per_user]
  }

  measure: average_ad_revenue_per_user {
    group_label: "Monetization"
    label: "ARPU - Ads"
    description: "(Average revenue per user) = Ad Revenue / Total Number of Users"
    type: number
    sql: 1.0 * ${total_ad_revenue} / NULLIF(${number_of_users},0) ;;
    value_format_name: large_usd
    drill_fields: [drill_field,average_revenue_per_user]
  }

  measure: average_iap_revenue_per_user {
    group_label: "Monetization"
    label: "ARPU - IAP"
    description: "(Average revenue per user) = IAP Revenue / Total Number of Users"
    type: number
    sql: 1.0 * ${total_iap_revenue} / NULLIF(${number_of_users},0) ;;
    value_format_name: large_usd
    drill_fields: [drill_field,average_revenue_per_user]
  }

  measure: total_d1_revenue {
    group_label: "Monetization"
    description: "Revenue (ads + IAP) on day 1"
    type: sum
    sql: ${combined_revenue} ;;
    filters: {
      field: retention_day
      value: "<=1"
    }
    filters: {
      field: days_since_user_signup
      value: ">0"
    }
    drill_fields: [drill_field,total_d1_revenue]
    value_format_name: large_usd
  }

  measure: d1_revenue_per_retained_user {
    group_label: "Monetization"
    description: "Revenue per user (that are retained for 1 days)"
    value_format_name: large_usd
    type: number
    sql: 1.0 * ${total_d1_revenue}/ NULLIF(${d1_retained_users},0);;
    drill_fields: [drill_field,d1_revenue_per_retained_user]
  }

  measure: total_d7_revenue {
    group_label: "Monetization"
    description: "Revenue (ads + IAP) on day 7"
    type: sum
    sql: ${combined_revenue} ;;
    filters: {
      field: retention_day
      value: "<=7"
    }
    filters: {
      field: days_since_user_signup
      value: ">7"
    }
    drill_fields: [drill_field,total_d7_revenue]
    value_format_name: large_usd
  }

  measure: d7_revenue_per_retained_user {
    group_label: "Monetization"
    description: "Revenue per user (that are retained for 7 days)"
    value_format_name: large_usd
    type: number
    sql: 1.0 * ${total_d7_revenue}/ NULLIF(${d7_retained_users},0);;
    drill_fields: [drill_field,d7_revenue_per_retained_user]
  }

  measure: total_d14_revenue {
    group_label: "Monetization"
    description: "Revenue (ads + IAP) on day 14"
    type: sum
    sql: ${combined_revenue} ;;
    filters: {
      field: retention_day
      value: "<=14"
    }
    filters: {
      field: days_since_user_signup
      value: ">14"
    }
    drill_fields: [drill_field,total_d14_revenue]
    value_format_name: large_usd
  }

  measure: d14_revenue_per_retained_user {
    group_label: "Monetization"
    description: "Revenue per user (that are retained for 14 days)"
    value_format_name: large_usd
    type: number
    sql: 1.0 * ${total_d14_revenue}/ NULLIF(${d14_retained_users},0);;
    drill_fields: [drill_field,d14_revenue_per_retained_user]
  }

  measure: total_d30_revenue {
    group_label: "Monetization"
    description: "Revenue (ads + IAP) on day 30"
    type: sum
    sql: ${combined_revenue} ;;
    filters: {
      field: retention_day
      value: "<=30"
    }
    filters: {
      field: days_since_user_signup
      value: ">30"
    }
    drill_fields: [drill_field,total_d30_revenue]
    value_format_name: large_usd
  }

  measure: d30_revenue_per_retained_user {
    group_label: "Monetization"
    description: "Revenue per user (that are retained for 30 days)"
    value_format_name: large_usd
    type: number
    sql: 1.0 * ${total_d30_revenue}/ NULLIF(${d30_retained_users},0);;
    drill_fields: [drill_field,d30_revenue_per_retained_user]
  }

  ### For Calculating User Fact Table with Native Derived Table

  measure: player_first_seen {
    group_label: "User Fact Table"
    description: "Not for direct use, use for NDT"
    type: date_time
    sql: min(${event_raw}) ;;
  }

  measure: player_last_seen {
    group_label: "User Fact Table"
    description: "Not for direct use, use for NDT"
    type: date_time
    sql: max(${event_raw}) ;;
  }


}
