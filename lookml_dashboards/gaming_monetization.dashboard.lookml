- dashboard: game_monetization
  title: Game Monetization
  layout: newspaper
  elements:
  - name: "<span class='fa fa-coffee'> Ad Revenue </span>"
    type: text
    title_text: "<span class='fa fa-coffee'> Ad Revenue </span>"
    subtitle_text: Are we doing well monetizing with ads while not affecting gameplay?
    row: 18
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-credit-card'> IAP Revenue </span>"
    type: text
    title_text: "<span class='fa fa-credit-card'> IAP Revenue </span>"
    subtitle_text: Are users finding our in-app products attractive?
    body_text: ''
    row: 9
    col: 0
    width: 24
    height: 2
  - name: "<span class='fa fa-usd'> Monetization </span>"
    type: text
    title_text: "<span class='fa fa-usd'> Monetization </span>"
    subtitle_text: "<p> Are we building a sustainable business? </p>"
    row: 0
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
  - title: ARPDAU - Ads
    name: ARPDAU - Ads
    model: gaming
    explore: events
    type: single_value
    fields: [events.average_ad_revenue_per_user, events.event_date]
    fill_fields: [events.event_date]
    filters: {}
    limit: 500
    dynamic_fields: [{table_calculation: arpdau_ads, label: ARPDAU - Ads, expression: 'mean(${events.average_ad_revenue_per_user})',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    hidden_fields: [events.average_ad_revenue_per_user]
    note_state: collapsed
    note_display: hover
    note_text: Average Revenue Per Daily Active User - for ad revenue only
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
  - title: Revenue After UA
    name: Revenue After UA
    model: gaming
    explore: events
    type: looker_column
    fields: [events.event_date, events.total_revenue, events.total_install_spend]
    fill_fields: [events.event_date]
    filters: {}
    sorts: [events.event_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: ua, label: UA, expression: "${events.total_install_spend}\
          \ * -1", value_format: !!null '', value_format_name: usd_0, _kind_hint: measure,
        _type_hint: number}]
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    series_types: {}
    point_style: none
    series_colors: {}
    series_labels:
      events.number_of_users: Active Users
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    hidden_fields: [events.total_install_spend]
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
  - title: Revenue after UA
    name: Revenue after UA
    model: gaming
    explore: events
    type: single_value
    fields: [events.total_revenue_after_UA]
    filters: {}
    limit: 500
    query_timezone: America/Los_Angeles
    note_state: collapsed
    note_display: hover
    note_text: Revenue after UA (Revenue - Marketing Spend)
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
  - title: ARPDAU - IAP
    name: ARPDAU - IAP
    model: gaming
    explore: events
    type: single_value
    fields: [events.average_iap_revenue_per_user, events.event_date]
    fill_fields: [events.event_date]
    filters: {}
    sorts: [events.event_date desc]
    limit: 500
    dynamic_fields: [{table_calculation: arpdau_iap, label: ARPDAU - IAP, expression: 'mean(${events.average_iap_revenue_per_user})',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    query_timezone: America/Los_Angeles
    hidden_fields: [events.average_iap_revenue_per_user]
    y_axes: []
    note_state: collapsed
    note_display: hover
    note_text: Average Revenue Per Daily Active User - for in-app purchases revenue
      only
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
  - title: IAP/Ad Revenue per Player
    name: IAP/Ad Revenue per Player
    model: gaming
    explore: events
    type: looker_column
    fields: [events.event_date, events.average_ad_revenue_per_user, events.average_iap_revenue_per_user]
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
    y_axes: [{label: '', orientation: left, series: [{axisId: events.average_ad_revenue_per_user,
            id: events.average_ad_revenue_per_user, name: ARPU - Ads}, {axisId: events.average_iap_revenue_per_user,
            id: events.average_iap_revenue_per_user, name: ARPU - IAP}], showLabels: true,
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: right
    series_types: {}
    point_style: none
    series_colors: {}
    series_labels:
      events.number_of_users: Active Users
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
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
  - title: LTV (0-7 days) Per Country
    name: LTV (0-7 days) Per Country
    model: gaming
    explore: events
    type: looker_column
    fields: [events.retention_day, events.average_revenue_per_user, events.cost_per_install,
      events.country]
    pivots: [events.country]
    filters:
      events.retention_day: "<=7"
      events.is_top_10_country: 'Yes'
    sorts: [events.country 0, events.retention_day]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: ltv_total, label: LTV - Total, expression: 'running_total(${events.average_revenue_per_user})',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number},
      {table_calculation: less_than_cpi, label: Less than CPI, expression: 'if(${ltv_total}
          < ${cpi},${ltv_total},null)', value_format: !!null '', value_format_name: usd,
        _kind_hint: measure, _type_hint: number}, {table_calculation: more_than_cpi,
        label: More than CPI, expression: 'if(${ltv_total} >= ${cpi},${ltv_total},null)',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number},
      {table_calculation: cpi, label: CPI, expression: 'running_total(${events.cost_per_install})',
        value_format: !!null '', value_format_name: usd, _kind_hint: measure, _type_hint: number}]
    color_application:
      collection_id: 611da387-0e33-4239-aef0-a187c149cf88
      palette_id: f31efe28-e698-428c-8420-fcb37f2010aa
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{id: events.total_revenue, name: Total
              Revenue, axisId: events.total_revenue}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: right, series: [{id: ltv, name: LTV, axisId: ltv}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Days since start (0-7)
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: pivot
    stacking: normal
    limit_displayed_rows: false
    hide_legend: true
    legend_position: left
    trellis_rows: 5
    series_types: {}
    point_style: none
    series_colors:
      Brazil - less_than_1: "#FFEB3B"
      Brazil - more_than_1: "#4CAF50"
      France - less_than_1: "#FFEB3B"
      France - more_than_1: "#4CAF50"
      Germany - less_than_1: "#FFEB3B"
      Germany - more_than_1: "#4CAF50"
      Mexico - more_than_1: "#4CAF50"
      Mexico - less_than_1: "#FFEB3B"
      Poland - less_than_1: "#FFEB3B"
      Poland - more_than_1: "#4CAF50"
      Russia - less_than_1: "#FFEB3B"
      Russia - more_than_1: "#4CAF50"
      Turkey - less_than_1: "#FFEB3B"
      Turkey - more_than_1: "#4CAF50"
      United Kingdom - less_than_1: "#FFEB3B"
      United Kingdom - more_than_1: "#4CAF50"
      United States - more_than_1: "#4CAF50"
      United States - less_than_1: "#FFEB3B"
      Vietnam - less_than_1: "#FFEB3B"
      Vietnam - more_than_1: "#4CAF50"
      Brazil - less_than_cpi: "#CDDC39"
      Brazil - more_than_cpi: "#009688"
      France - less_than_cpi: "#CDDC39"
      Germany - less_than_cpi: "#CDDC39"
      Germany - more_than_cpi: "#009688"
      Mexico - less_than_cpi: "#CDDC39"
      Mexico - more_than_cpi: "#009688"
      Poland - less_than_cpi: "#CDDC39"
      Poland - more_than_cpi: "#009688"
      Russia - less_than_cpi: "#CDDC39"
      Russia - more_than_cpi: "#009688"
      Turkey - less_than_cpi: "#CDDC39"
      Turkey - more_than_cpi: "#009688"
      United Kingdom - less_than_cpi: "#CDDC39"
      United Kingdom - more_than_cpi: "#009688"
      United States - less_than_cpi: "#CDDC39"
      United States - more_than_cpi: "#009688"
      Vietnam - less_than_cpi: "#CDDC39"
      Vietnam - more_than_cpi: "#009688"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    reference_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    hidden_fields: [events.average_revenue_per_user, ltv_total, events.cost_per_install,
      cpi]
    note_state: collapsed
    note_display: hover
    note_text: How long does it take to make our CPI back?
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 31
    col: 0
    width: 24
    height: 11
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
    row: 11
    col: 10
    width: 7
    height: 2
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
    row: 2
    col: 0
    width: 8
    height: 7
  - title: IAP Purchase Sizes
    name: IAP Purchase Sizes
    model: gaming
    explore: events
    type: looker_scatter
    fields: [events.iap_purchase_tier, events.total_iap_revenue, events.number_of_iap_purchases]
    filters:
      events.iap_purchase_tier: "-Below 0,-Undefined"
    sorts: [events.iap_purchase_tier]
    limit: 500
    column_limit: 50
    total: true
    dynamic_fields: [{table_calculation: of_total, label: "% of total", expression: "${events.total_iap_revenue}/\
          \ ${events.total_iap_revenue:total}", value_format: !!null '', value_format_name: percent_2,
        _kind_hint: measure, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: events.total_iap_revenue,
            id: events.total_iap_revenue, name: Total IAP Revenue}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: of_total,
            id: of_total, name: "% of total"}], showLabels: true, showValues: true,
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
    size_by_field: events.number_of_iap_purchases
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    hide_legend: true
    legend_position: center
    series_types: {}
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 11
    col: 0
    width: 10
    height: 7
  - title: Transactions per Spender
    name: Transactions per Spender
    model: gaming
    explore: events
    type: single_value
    fields: [events.number_of_spenders, events.number_of_iap_purchases]
    filters: {}
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: transactions_per_spender, label: Transactions
          per Spender, expression: "${events.number_of_iap_purchases}/${events.number_of_spenders}",
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}]
    hidden_fields: [events.number_of_iap_purchases, events.number_of_spenders]
    series_types: {}
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 11
    col: 17
    width: 7
    height: 2
  - title: Retaining Spenders
    name: Retaining Spenders
    model: gaming
    explore: events
    type: looker_column
    fields: [events.retention_day, events.percent_spenders, events.total_iap_revenue]
    filters:
      events.retention_day: "<=70"
    sorts: [events.retention_day]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: total_iap_revenue, label: Total IAP Revenue,
        expression: 'running_total(${events.total_iap_revenue})', value_format: !!null '',
        value_format_name: usd_0, _kind_hint: measure, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: events.percent_spenders,
            id: events.percent_spenders, name: Percent Spenders}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: total_iap_revenue,
            id: total_iap_revenue, name: Total IAP Revenue}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
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
    stacking: ''
    limit_displayed_rows: false
    hidden_series: [transactions_per_spender]
    legend_position: center
    series_types:
      total_iap_revenue: line
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    trend_lines: []
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields: [events.total_iap_revenue]
    note_state: expanded
    note_display: hover
    note_text: The "whales" don't become whales for a long time
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 13
    col: 10
    width: 14
    height: 5
  - title: Revenue per Ad Shown
    name: Revenue per Ad Shown
    model: gaming
    explore: events
    type: looker_map
    fields: [events.country, events.number_of_ads_shown, events.total_ad_revenue]
    filters:
      events.number_of_ads_shown: ">1000"
    sorts: [revenue_per_ad_shown desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: revenue_per_ad_shown, label: Revenue per
          Ad Shown, expression: "${events.total_ad_revenue}/${events.number_of_ads_shown}",
        value_format: "$#.000", value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 52.70468296296837
    map_longitude: 23.807373046875004
    map_zoom: 1
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    map_value_colors: ["#8BC34A"]
    quantize_map_value_colors: false
    reverse_map_value_colors: true
    hidden_fields: [events.total_ad_revenue, events.number_of_ads_shown]
    note_state: expanded
    note_display: hover
    note_text: Where are networks paying the most for the ads we show in the app?
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 20
    col: 0
    width: 10
    height: 9
  - title: Revenue per Ad
    name: Revenue per Ad
    model: gaming
    explore: events
    type: single_value
    fields: [events.number_of_ads_shown, events.total_ad_revenue]
    filters:
      events.number_of_ads_shown: ">1000"
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: revenue_per_ad_shown, label: Revenue per
          Ad Shown, expression: "${events.total_ad_revenue}/${events.number_of_ads_shown}",
        value_format: "$0.000", value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 52.70468296296837
    map_longitude: 23.807373046875004
    map_zoom: 1
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    map_value_colors: ["#8BC34A"]
    quantize_map_value_colors: false
    reverse_map_value_colors: true
    hidden_fields: [events.total_ad_revenue, events.number_of_ads_shown]
    series_types: {}
    note_state: expanded
    note_display: hover
    note_text: Each ad played is an annoyance for a player - are we getting the most
      value out of it?
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 20
    col: 10
    width: 8
    height: 2
  - title: Ads Per Session
    name: Ads Per Session
    model: gaming
    explore: events
    type: single_value
    fields: [events.number_of_ads_shown, sessions.number_of_sessions]
    filters:
      events.number_of_ads_shown: ">1000"
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: ads_per_session, label: Ads per Session,
        expression: "${events.number_of_ads_shown}/${sessions.number_of_sessions}",
        value_format: !!null '', value_format_name: decimal_1, _kind_hint: measure,
        _type_hint: number}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 52.70468296296837
    map_longitude: 23.807373046875004
    map_zoom: 1
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    map_value_colors: ["#8BC34A"]
    quantize_map_value_colors: false
    reverse_map_value_colors: true
    hidden_fields: [events.number_of_ads_shown, sessions.number_of_sessions]
    series_types: {}
    note_state: expanded
    note_display: hover
    note_text: Are we inundating players with ads?
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 20
    col: 18
    width: 6
    height: 2
  - name: "<span class='fa fa-money'> CPI Recovery </span>"
    type: text
    title_text: "<span class='fa fa-money'> CPI Recovery </span>"
    subtitle_text: How quickly are we recovering our marketing costs?
    body_text: ''
    row: 29
    col: 0
    width: 24
    height: 2
  - title: Revenue by Network
    name: Revenue by Network
    model: gaming
    explore: events
    type: table
    fields: [events.number_of_ads_shown, events.total_ad_revenue, events.install_source]
    filters:
      events.number_of_ads_shown: ">1000"
    sorts: [revenue_per_ad_shown desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: revenue_per_ad_shown, label: Revenue per
          Ad Shown, expression: "${events.total_ad_revenue}/${events.number_of_ads_shown}",
        value_format: "$0.000", value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}]
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825}, bold: false, italic: false,
        strikethrough: false, fields: [revenue_per_ad_shown]}, {type: along a scale...,
        value: !!null '', background_color: "#3EB0D5", font_color: !!null '', color_application: {
          collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7, palette_id: 1e4d66b9-f066-4c33-b0b7-cc10b4810688,
          options: {steps: 5, constraints: {mid: {type: middle}}, reverse: true, mirror: false}},
        bold: false, italic: false, strikethrough: false, fields: [events.number_of_ads_shown]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_latitude: 52.70468296296837
    map_longitude: 23.807373046875004
    map_zoom: 1
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    map_value_colors: ["#8BC34A"]
    quantize_map_value_colors: false
    reverse_map_value_colors: true
    hidden_fields:
    series_types: {}
    note_state: expanded
    note_display: hover
    note_text: Each ad played is an annoyance for a player - are we getting the most
      value out of it?
    listen:
      Date Range: events.event_date
      Drill Down: events.drill_by
      Platform: events.device_platform
      Install Source: events.install_source
      Country: events.country
      Game: events.game_name
    row: 22
    col: 10
    width: 14
    height: 7
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
