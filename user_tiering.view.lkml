view: user_tiering {
  derived_table: {
    sql: SELECT
          user_id
        ,ntile(3) over (order by number_of_sessions ) as session_tier
        ,case when total_revenue = 0 then 0 else ntile(3) over (order by total_iap_revenue ) end as iap_tier
      FROM
      ${user_facts.SQL_TABLE_NAME}  ;;
    datagroup_trigger: events_raw
  }


  dimension: user_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_session_tier {
    type: number
    sql: ${TABLE}.session_tier ;;
  }

  dimension: iap_tier {
    hidden: yes
    type: number
    sql: ${TABLE}.iap_tier ;;
  }

  dimension: lifetime_spend_tier {
    description: "Based on Lifetime LTV spend, are they Minnow/Dolphin/Whale"
    type: string
    sql: case
           when ${iap_tier} = 0 THEN '0 - Non-Spender'
           when ${iap_tier} = 1 THEN '1 - Minnow'
           when ${iap_tier} = 2 THEN '2 - Dolphin'
           when ${iap_tier} = 3 THEN '3 - Whale'
          end;;
          drill_fields: [user_facts.total_iap_revenue,user_facts.number_of_users]
  }

  set: detail {
    fields: [user_id, lifetime_session_tier, iap_tier]
  }
}
