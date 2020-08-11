connection: "gaming_events"

include: "/*/*.view.lkml"                       # include all views in this project
include: "/lookml_dashboards/*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# Model Configuration
datagroup: events_raw { sql_trigger:  SELECT current_date  ;; }
named_value_format: large_usd { value_format: "[>=1000000]\"$\"0.00,,\"M\";[>=1000]\"$\"0.00,\"K\";\"$\"0.00" }
named_value_format: large_number { value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0" }

# Explores
explore: events {
  persist_with: events_raw

  always_filter: {
    filters: {
      field: event_date
      value: "last 7 days"
    }
  }

  join: session_facts {
    relationship: many_to_one
    sql_on: ${events.unique_session_id} = ${session_facts.unique_session_id} ;;
  }

  join: user_facts {
    view_label: "User Lifetime Values"
    relationship: many_to_one
    sql_on: ${events.user_id} = ${user_facts.user_id} ;;
  }
}

explore: funnel_explorer {
  description: "Player Session Funnels"
  persist_for: "24 hours"

  always_filter: {
    filters: {
      field: event_time
      value: "30 days"
    }
    filters: {
      field: game_name
      value: "Lookerwood Farm"
    }
  }
  join: session_facts {
    sql_on: ${funnel_explorer.unique_session_id} = ${session_facts.unique_session_id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    sql_on: ${funnel_explorer.user_id} = ${user_facts.user_id} ;;
    relationship: many_to_one
  }
}

explore: session_facts {
  label: "Sessions and Users"
  description: "Use this to look at a compressed view of Users and Sessions (without event level data)"
  join: user_facts {
    relationship: many_to_one
    sql_on: ${session_facts.user_id} = ${user_facts.user_id} ;;
  }
}
