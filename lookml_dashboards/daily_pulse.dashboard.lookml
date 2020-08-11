- dashboard: daily_pulse
  title: Daily Pulse
  layout: newspaper
  elements:
  - title: New Tile
    name: New Tile
    model: gaming
    explore: events
    type: looker_line
    fields: [events.number_of_new_users, events.event_date, events.number_of_users]
    fill_fields: [events.event_date]
    filters: {}
    sorts: [events.event_date desc]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: events.number_of_new_users,
            name: Number of New Users, axisId: events.number_of_new_users}, {id: events.number_of_users,
            name: Active Users, axisId: events.number_of_users}], showLabels: true,
        showValues: true, unpinAxis: true, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors: {}
    series_labels:
      events.number_of_users: Active Users
      events.number_of_new_users: New Installs
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    swap_axes: false
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 2
    col: 4
    width: 4
    height: 7
  - title: Daily Active Users
    name: Daily Active Users
    model: gaming
    explore: events
    type: single_value
    fields: [events.number_of_users, events.event_date]
    fill_fields: [events.event_date]
    filters: {}
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: daily_active_users, label: Daily Active Users,
        expression: 'mean(${events.number_of_users})', value_format: '[>=1000000]0.00,,"M";[>=1000]0.00,"K";0',
        value_format_name: !!null '', _kind_hint: measure, _type_hint: number}]
    note_state: collapsed
    note_display: hover
    note_text: The average number of unique users per day who played at least one
      session in the selected time period
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 2
    col: 0
    width: 4
    height: 4
  - name: "<span class='fa fa-tachometer'> Topline KPIs</span>"
    type: text
    title_text: "<span class='fa fa-tachometer'> Topline KPIs</span>"
    subtitle_text: Are we headed in the right direction?
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-smile-o'> Retention </span>"
    type: text
    title_text: "<span class='fa fa-smile-o'> Retention </span>"
    subtitle_text: Are our games fun?
    row: 18
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-users'> User Acquistion </span>"
    type: text
    title_text: "<span class='fa fa-users'> User Acquistion </span>"
    subtitle_text: Are we acquiring players from the best places?
    body_text: ''
    row: 9
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-usd'> Monetization </span>"
    type: text
    title_text: "<span class='fa fa-usd'> Monetization </span>"
    subtitle_text: <p> Are we building a sustainable business? Go to <a href="/dashboards/100"
      target="_blank">monetization dashboard</a></p>
    row: 27
    col: 0
    width: 24
    height: 2
  - title: Revenue
    name: Revenue
    model: gaming
    explore: events
    type: single_value
    fields: [events.total_revenue]
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    note_state: collapsed
    note_display: hover
    note_text: Total revenue (In-app Purhcases + Ad)
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 2
    col: 8
    width: 4
    height: 3
  - title: ARPPU
    name: ARPPU
    model: gaming
    explore: events
    type: single_value
    fields: [events.average_revenue_per_spender]
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    note_state: collapsed
    note_display: hover
    note_text: |-
      Average Revenue Per Paying User
      (Revenue / IAP Paying Users)
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 2
    col: 12
    width: 4
    height: 3
  - title: New Tile (copy)
    name: New Tile (copy)
    model: gaming
    explore: events
    type: looker_line
    fields: [events.event_date, events.total_revenue, events.average_revenue_per_spender]
    fill_fields: [events.event_date]
    filters: {}
    sorts: [events.event_date desc]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: events.total_revenue,
            id: events.total_revenue, name: Total Revenue}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: events.average_revenue_per_spender,
            id: events.average_revenue_per_spender, name: ARPPU (IAP)}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types:
      events.average_revenue_per_paying_user: column
      events.average_revenue_per_spender: column
    point_style: none
    series_colors: {}
    series_labels:
      events.number_of_users: Active Users
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 5
    col: 8
    width: 8
    height: 4
  - title: ROAS
    name: ROAS
    model: gaming
    explore: events
    type: single_value
    fields: [events.return_on_ad_spend]
    filters:
      events.install_group: paid
    limit: 500
    query_timezone: America/Los_Angeles
    note_state: collapsed
    note_display: hover
    note_text: |-
      Return on Ad Spend (revenue/ad spend)

      NOTE: only counts revenue from paid users
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 2
    col: 20
    width: 4
    height: 3
  - title: Marketing Spend
    name: Marketing Spend
    model: gaming
    explore: events
    type: single_value
    fields: [events.total_install_spend]
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    hidden_fields: []
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Return on Ad Spend (revenue/ad spend)
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 2
    col: 16
    width: 4
    height: 3
  - title: UA Overview
    name: UA Overview
    model: gaming
    explore: events
    type: looker_line
    fields: [events.event_date, events.total_install_spend, events.return_on_ad_spend]
    fill_fields: [events.event_date]
    filters:
      events.install_group: paid
    sorts: [events.event_date desc]
    limit: 500
    column_limit: 50
    stacking: ''
    trellis: ''
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    point_style: none
    series_colors: {}
    series_labels:
      events.number_of_users: Active Users
    series_types:
      events.average_revenue_per_paying_user: column
      events.return_on_ad_spend: column
    limit_displayed_rows: false
    y_axes: [{label: '', orientation: left, series: [{id: events.total_install_spend,
            name: Total Install Cost, axisId: events.total_install_spend}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: !!null '', orientation: right, series: [{id: events.return_on_ad_spend,
            name: ROAS, axisId: events.return_on_ad_spend}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    hidden_fields: []
    title_hidden: true
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 5
    col: 16
    width: 8
    height: 4
  - title: CPI (paid only)
    name: CPI (paid only)
    model: gaming
    explore: events
    type: single_value
    fields: [events.cost_per_install]
    filters:
      events.install_group: paid
    limit: 500
    column_limit: 50
    note_state: collapsed
    note_display: hover
    note_text: Cost per Install
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 11
    col: 0
    width: 4
    height: 2
  - title: Install Sources
    name: Install Sources
    model: gaming
    explore: events
    type: table
    fields: [events.install_source, events.return_on_ad_spend, events.total_revenue,
      events.total_install_spend, events.number_of_new_users, events.device_platform]
    pivots: [events.device_platform]
    filters:
      events.install_group: paid
    sorts: [events.number_of_new_users desc 0, events.device_platform]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      events.number_of_users: Active Users
      events.d7_revenue_per_retained_user: D7 Revenue
      events.number_of_new_users: Installs
      events.total_install_spend: Spend
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 611da387-0e33-4239-aef0-a187c149cf88,
          palette_id: 4f09bd77-8e34-41d6-a356-12c05cdb2de5, options: {steps: 5, reverse: true}},
        bold: false, italic: false, strikethrough: false, fields: []}, {type: along
          a scale..., value: !!null '', background_color: !!null '', font_color: !!null '',
        color_application: {collection_id: 611da387-0e33-4239-aef0-a187c149cf88, palette_id: 4f09bd77-8e34-41d6-a356-12c05cdb2de5},
        bold: false, italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    trellis: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    point_style: none
    series_colors: {}
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: events.total_revenue, name: Total
              Revenue, axisId: events.total_revenue}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{id: events.average_revenue_per_paying_user,
            name: ARPPU (IAP), axisId: events.average_revenue_per_paying_user}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 11
    col: 10
    width: 14
    height: 3
  - title: Installs by Day
    name: Installs by Day
    model: gaming
    explore: events
    type: looker_line
    fields: [events.install_group, events.number_of_new_users, events.event_date]
    pivots: [events.install_group]
    fill_fields: [events.event_date]
    filters: {}
    sorts: [events.number_of_new_users desc 0, events.install_group]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: cross - events.number_of_new_users,
            name: cross, axisId: events.number_of_new_users}, {id: organic - events.number_of_new_users,
            name: organic, axisId: events.number_of_new_users}, {id: paid - events.number_of_new_users,
            name: paid, axisId: events.number_of_new_users}], showLabels: false, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    value_labels: labels
    label_type: labPer
    inner_radius: 60
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 11
    col: 4
    width: 6
    height: 7
  - title: Retention by Source
    name: Retention by Source
    model: gaming
    explore: events
    type: looker_line
    fields: [events.retention_day, events.number_of_new_users, events.number_of_users,
      events.install_source]
    pivots: [events.install_source]
    filters:
      events.retention_day: "<=30"
    sorts: [events.retention_day, events.install_source]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: still_active, label: "% still active", expression: "${events.number_of_users}/max(${events.number_of_new_users})",
        value_format: !!null '', value_format_name: percent_2, _kind_hint: measure,
        _type_hint: number}]
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: cross - still_active, name: cross,
            axisId: still_active}, {id: organic - still_active, name: organic, axisId: still_active},
          {id: paid - still_active, name: paid, axisId: still_active}], showLabels: true,
        showValues: true, maxValue: 0.6, unpinAxis: false, tickDensity: default, type: log}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: days since signup
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    value_labels: labels
    label_type: labPer
    inner_radius: 60
    hidden_fields: [events.number_of_new_users, events.number_of_users]
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 20
    col: 12
    width: 12
    height: 7
  - title: D7 Retention
    name: D7 Retention
    model: gaming
    explore: events
    type: single_value
    fields: [events.d7_retention_rate]
    filters:
      user_facts.player_first_seen_date: 30 days ago for 30 days
    limit: 500
    column_limit: 50
    note_state: collapsed
    note_display: hover
    note_text: D7 % = session on D7/ session on D0
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 23
    col: 0
    width: 4
    height: 2
  - title: D1 Retention
    name: D1 Retention
    model: gaming
    explore: events
    type: single_value
    fields: [events.d1_retention_rate]
    filters:
      user_facts.player_first_seen_date: 30 days ago for 30 days
    limit: 500
    column_limit: 50
    note_state: collapsed
    note_display: hover
    note_text: D1 % = session on D1/ session on D0
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 20
    col: 0
    width: 4
    height: 3
  - title: D14 Retention
    name: D14 Retention
    model: gaming
    explore: events
    type: single_value
    fields: [events.d14_retention_rate]
    filters:
      user_facts.player_first_seen_date: 30 days ago for 30 days
    limit: 500
    column_limit: 50
    note_state: collapsed
    note_display: hover
    note_text: D14 % = session on D14/ session on D0
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 25
    col: 0
    width: 4
    height: 2
  - title: Campaign Types
    name: Campaign Types
    model: gaming
    explore: events
    type: table
    fields: [events.campaign_type, events.return_on_ad_spend, events.total_revenue,
      events.total_install_spend, events.number_of_new_users, events.device_platform]
    pivots: [events.device_platform]
    filters:
      events.install_group: paid
    sorts: [events.number_of_new_users desc 0, events.device_platform]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      events.number_of_users: Active Users
      events.d7_revenue_per_retained_user: D7 Revenue
      events.number_of_new_users: Installs
      events.total_install_spend: Spend
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: !!null '',
        font_color: !!null '', color_application: {collection_id: 611da387-0e33-4239-aef0-a187c149cf88,
          palette_id: 4f09bd77-8e34-41d6-a356-12c05cdb2de5, options: {steps: 5, reverse: true}},
        bold: false, italic: false, strikethrough: false, fields: []}, {type: along
          a scale..., value: !!null '', background_color: !!null '', font_color: !!null '',
        color_application: {collection_id: 611da387-0e33-4239-aef0-a187c149cf88, palette_id: 4f09bd77-8e34-41d6-a356-12c05cdb2de5},
        bold: false, italic: false, strikethrough: false, fields: []}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    trellis: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: false
    point_style: none
    series_colors: {}
    series_types: {}
    y_axes: [{label: '', orientation: left, series: [{id: events.total_revenue, name: Total
              Revenue, axisId: events.total_revenue}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, type: linear}, {label: !!null '',
        orientation: right, series: [{id: events.average_revenue_per_paying_user,
            name: ARPPU (IAP), axisId: events.average_revenue_per_paying_user}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 14
    col: 10
    width: 14
    height: 4
  - title: "% New Paid Users"
    name: "% New Paid Users"
    model: gaming
    explore: events
    type: looker_donut_multiples
    fields: [events.install_group, events.number_of_new_users]
    pivots: [events.install_group]
    filters: {}
    sorts: [events.install_group]
    limit: 500
    column_limit: 50
    show_value_labels: true
    font_size: 12
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: bottom, series: [{axisId: paid - events.number_of_new_users,
            id: paid - events.number_of_new_users, name: paid}, {axisId: organic -
              events.number_of_new_users, id: organic - events.number_of_new_users,
            name: organic}], showLabels: false, showValues: false, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: false
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: percent
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: labels
    label_type: labPer
    inner_radius: 60
    up_color: "#2196F3"
    down_color: "#03d7f4"
    total_color: "#00BCD4"
    custom_color_enabled: true
    custom_color: ''
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields:
    note_state: collapsed
    note_display: hover
    note_text: What percentage of users did we pay for (vs organic)?
    title_hidden: true
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 13
    col: 0
    width: 4
    height: 5
  - title: D1& D7 Retention
    name: D1& D7 Retention
    model: gaming
    explore: events
    type: looker_line
    fields: [events.d1_retention_rate, user_facts.player_first_seen_date, events.d7_retention_rate]
    filters:
      user_facts.player_first_seen_date: 30 days ago for 30 days
    sorts: [user_facts.player_first_seen_date desc]
    limit: 500
    column_limit: 50
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: false
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: events.d1_retention_rate,
            name: D1 Retention Rate, axisId: events.d1_retention_rate}], showLabels: true,
        showValues: true, maxValue: !!null '', minValue: !!null '', unpinAxis: false,
        tickDensity: default, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '1'
    legend_position: center
    series_types: {}
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: center, color: "#8BC34A",
        line_value: '0.45', label: d1 goal 45%}, {reference_type: line, range_start: max,
        range_end: min, margin_top: deviation, margin_value: mean, margin_bottom: deviation,
        label_position: right, color: "#ff3b3b", line_value: '0.16', label: d7 goal
          16%}]
    show_null_points: false
    interpolation: linear
    value_labels: labels
    label_type: labPer
    inner_radius: 60
    hidden_fields: []
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 20
    col: 4
    width: 8
    height: 7
  - title: LTV (0-30 days)
    name: LTV (0-30 days)
    model: gaming
    explore: events
    type: looker_area
    fields: [events.retention_day, events.average_ad_revenue_per_user, events.average_iap_revenue_per_user]
    filters:
      events.retention_day: "<=30"
    sorts: [events.retention_day]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: ltv_iap, label: LTV - IAP, expression: 'running_total(${events.average_iap_revenue_per_user})',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number},
      {table_calculation: ltv_ads, label: LTV - Ads, expression: 'running_total(${events.average_ad_revenue_per_user})',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number},
      {table_calculation: ltv_growth, label: ltv growth %, expression: "(${total}\
          \ - ${prev_day})/${prev_day}", value_format: !!null '', value_format_name: percent_2,
        _kind_hint: measure, _type_hint: number}, {table_calculation: total, label: total,
        expression: "${ltv_ads}+ ${ltv_iap}", value_format: !!null '', value_format_name: usd,
        _kind_hint: measure, _type_hint: number}, {table_calculation: prev_day, label: prev
          day, expression: 'offset(${total},-1)', value_format: !!null '', value_format_name: usd,
        _kind_hint: measure, _type_hint: number}]
    stacking: normal
    trellis: ''
    trellis_rows: 5
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    show_value_labels: false
    label_density: 25
    legend_position: center
    hide_legend: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_labels:
      growth: ltv growth
    series_types:
      growth: column
      ltv_growth: column
    limit_displayed_rows: false
    hidden_series: [ltv_total, ltv_growth]
    y_axes: [{label: '', orientation: left, series: [{id: ltv_iap, name: LTV - IAP,
            axisId: ltv_iap}, {id: ltv_ads, name: LTV - Ads, axisId: ltv_ads}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, type: linear}, {
        label: '', orientation: right, series: [{id: ltv_growth, name: ltv growth
              %, axisId: ltv_growth}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, type: linear}]
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Days since player start
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    reference_lines: [{reference_type: line, range_start: max, range_end: min, margin_top: deviation,
        margin_value: mean, margin_bottom: deviation, label_position: left, color: "#8BC34A",
        line_value: '1'}]
    trend_lines: []
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    hidden_fields: [events.average_iap_revenue_per_user, events.average_ad_revenue_per_user,
      total, prev_day]
    note_state: expanded
    note_display: hover
    note_text: How long does it take to make $1? (for all users)
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 29
    col: 0
    width: 12
    height: 6
  - title: "% Spenders"
    name: "% Spenders"
    model: gaming
    explore: events
    type: single_value
    fields: [events.percent_spenders]
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    series_types: {}
    up_color: "#2196F3"
    down_color: "#03d7f4"
    total_color: "#00BCD4"
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 29
    col: 12
    width: 4
    height: 6
  - title: Revenue Breadkdown
    name: Revenue Breadkdown
    model: gaming
    explore: events
    type: looker_bar
    fields: [events.total_iap_revenue, events.total_ad_revenue]
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    hide_legend: false
    legend_position: center
    font_size: '12'
    series_types: {}
    point_style: none
    series_labels:
      events.total_ad_revenue: Ad Revenue
      events.total_iap_revenue: IAP revenue
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    up_color: "#2196F3"
    down_color: "#03d7f4"
    total_color: "#00BCD4"
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 29
    col: 16
    width: 8
    height: 6
  - title: Daily Installs
    name: Daily Installs
    model: gaming
    explore: events
    type: single_value
    fields: [events.event_date, events.number_of_new_users]
    fill_fields: [events.event_date]
    filters: {}
    sorts: [events.event_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: daily_installs, label: Daily Installs, expression: 'mean(${events.number_of_new_users})',
        value_format: '[>=1000000]0.00,,"M";[>=1000]0.00,"K";0', value_format_name: !!null '',
        _kind_hint: measure, _type_hint: number}]
    note_state: expanded
    note_display: hover
    note_text: Average daily new players
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 6
    col: 0
    width: 4
    height: 3
  filters:
  - name: Date Range
    title: Date Range
    type: field_filter
    default_value: 30 days ago for 30 days
    allow_multiple_values: true
    required: false
    model: gaming
    explore: events
    listens_to_filters: []
    field: events.event_date
  - name: Drill Down
    title: Drill Down
    type: field_filter
    default_value: device^_platform
    allow_multiple_values: true
    required: false
    model: gaming
    explore: events
    listens_to_filters: []
    field: events.drill_by
  - name: Platform
    title: Platform
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: gaming
    explore: events
    listens_to_filters: []
    field: events.device_platform
  - name: Install Source
    title: Install Source
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: gaming
    explore: events
    listens_to_filters: []
    field: events.install_source
  - name: Country
    title: Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: gaming
    explore: events
    listens_to_filters: []
    field: events.country
  - name: Game
    title: Game
    type: field_filter
    default_value: Lookerwood Farm
    allow_multiple_values: true
    required: false
    model: gaming
    explore: events
    listens_to_filters: []
    field: events.game_name
