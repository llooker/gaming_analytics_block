### What does this Looker Block do for me?
**(1) Look at acquisition, retention and monetization in one place** - The way you acquire users, the way you retain them and make money all occur on the same plane of existance. The idea behind this block coupled with centralized data is to be able to examine the entire lifecycle of your players, not just pieces of their journey in silo'd tools.

**(2) Share KPI Definition for All Your Games** - Industry retention KPIs like (e.g. D7 retention), monetization (e.g. ARPPU) and acquisition (e.g. ROAS) should be measured exactly the same way for your entire game portfolio. This Block has 50+ measures that can be combined with 100s of dimensions to let you ask any question from your data.

**(3) Optimize Spend** - ROAS (Return on Ad Spend) is the industry standard way to understand how a campaign is performing from an ROI perspective (I bought this player for $2 and they have already spent $3, therefore my ROAS is 150%). The issue is that we need to know how a campaign is performing BEFORE our players reach their full potential LTV. This block calculates daily ROAS targets and allows you to benchmark them to decide if you should spend more or less for each campaign. 

**(4) Measure Fun** - Retention metrics are some of the most important to look at, while the basic metrics of D1, D7 retention are included in this block, it allows you to dive deeper into what's important: what are your players doing before they drop off? How long did they play on their first session? 

**(5) Measure Monetization** - Calculate metrics like Revenue after UA at any level, per game, per country, per player segment. Beyond that, this block allows you to see revenue before a user has fully matured to understand LTV at a deeper level than before and focus on segments that are monetizing best.

**(6) Session Deep Dives** - Calculate what events go together and create a unique session identifier to track behaviour in terms of sessions. Then use the Funnel Explorer to answer questions about what behaviours players did within a session.

**(7) Deep Player Segmentation** - Whales and Minnows are easy to categorize (and are done so in this block). Going deeper is usually too difficult, especially for ad-revenue games that don't rely on IAP. The user fact tables provided in this block show great examples of custom segmentation that can help you understand your players better than ever. 

**(8) Session and Player Rollups** - Save on database queries by using Session and Player level metrics instead of event level metrics. 


### Data Structure Required 
Generally gaming event data should be in an event log, each event should contain a minimum of these parameters:
 * **Timestamp** When did it happen? (called event in the block)
 * **User ID** Unique identifier for the player
 * **Event Name** What is the event that happened?
 * **Install Cost** How much did it cost to acquire this player?
 * **Install Source/Campaign** Where did this player originate from, Organic, Ironsrc, etc. 
 * **User First Seen** When was the first event from this player (it can be calculated in the user_facts view if needed)
 * **IAP Revenue** If this is a purchase, what was the associated revenue? 
 * **Ad Revenue** If this is an ad-watched event, what is the revenue you received from this? Not straightforward to calculate but look at libring as an option to help.
 * **Game Name** (optional) This is if you have separate games in the same event log (recommended). 


### Block Structure
#### Base:
* ``raw_events.view.lkml``: this is the raw data coming from your database tables. Either rename your events to match the ones in the block or find/replace the names to match yours. `sql_table_name` should be changed to match your table name.
* ``events.view.lkml``	This extends (link to docs for extends) your raw_events with the primary logic for the block. 
* ``user_facts.view.lkml`` This rolls up user activity to the lifetime level (Did player X ever finish the tutorial, LTV etc)
* ``user_tiering.view.lkml`` This calculates additional facts about players in relation to their standing with other players (like if they are Whales or Minnows). 
#### Optional:
* ``sessions.view.lkml`` Uses (Link to sessionization block) to break events into user sessions
* ``session_facts.view.lkml`` Calculates length of session and any session level rollups
* ``events_sessionized.view.lkml`` Combines events and sessions into one table for performance
* ``funnel_explorer.view.lkml``	Ask intra session questions
#### Dashboards: 
* ``daily_pulse.dashboard.lookml`` - Pulse dashboard with top level KPIs, UA, Retention and Monetization
* ``monetization.dashboard.lookml`` - Monetization Deeper dive

### Customizations

* **Connection**: in the `gaming` model file, change the connection name at the top to the name of your connection.

* **Dialect**: This block was written for BigQuery but can easily be customized to support Snowflake, Redshift or others. Make sure to find any lines starting with ``sql:``or ``derived_table:`` that contain dialect specific code (like DATE DIFF).

* **Nested Events**: Often times its easier to drop in event or user properties as a JSON object, this is fully supported but requires customizing the block. 

### What if I find an error? Suggestions for improvements?

Great! Blocks were designed for continuous improvement through the help of the entire Looker community, and we'd love your input. To log an error or improvement recommendations, simply create a "New Issue" in the corresponding [Github repo for this Block](https://github.com/llooker/gaming_demo_block/issues). Please be as detailed as possible in your explanation, and we'll address it as quick as we can.

### Sreenshots
![1](https://user-images.githubusercontent.com/47784/61128655-6c4ea600-a4aa-11e9-9849-6d325f2d65c5.png)
![2](https://user-images.githubusercontent.com/47784/61128656-6c4ea600-a4aa-11e9-87e5-4b65b309e23b.png)
![3](https://user-images.githubusercontent.com/47784/61128657-6c4ea600-a4aa-11e9-80f0-ec3f17a3e9fc.png)
