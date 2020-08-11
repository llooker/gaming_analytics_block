## What table houses your events?
constant: events_table {
  value: "`se-pbl.gaming_demo_dev.raw_events`"
}
## When did the event occour?
constant: timestamp_field {
  value: "event"
}

## What country was the event fired from?
constant: country_field {
  value: "country"
}

## is as the device's platform?
constant: platform_field {
  value: "device_platform"
}

## What is the game version?
constant: version_field {
  value: "game_version"
}

## What is the game name field? (for schemas with multiple fields)
constant: game_name_field {
  value: "game_name"
}

## What is the user/player ID field?
constant: user_id_field {
  value: "user_id"
}

## What is name of the event field (i.e. start_match)?
constant: event_name_field {
  value: "event_name"
}

## What is name of the acquisition cost field?
constant: acquisition_cost_field {
  value: "install_cost"
}


## What is name of the ad revenue field?
constant: ad_revenue_field {
  value: "ad_revenue"
}


## What is name of the event field (i.e. start_match)?
constant: iap_revenue_field {
  value: "iap_revenue"
}
