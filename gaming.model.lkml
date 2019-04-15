connection: "gaming_demo"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# Model Configuration
datagroup: events_raw { sql_trigger:  SELECT max(event) FROM `se-pbl.gaming_demo_dev.raw_events` WHERE DATE(event) = CURRENT_DATE  ;; }
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
}
