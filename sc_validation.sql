/*SELECT 
count(p.pageview.pageview_id) AS pageviews
FROM `nyt-digpipelines-prd.analyst.behavior`, unnest(pageviews) p --essentially telling what kind of table we want
INNER JOIN
  (SELECT
  distinct uri
  FROM `nyt-digpipelines-prd.content_master.content_master`, unnest(tags) tags 
  WHERE tags.value = 'thanksgiving' 
   AND content_type = 'recipe') cm
ON p.content_metadata.uri = cm.uri
WHERE _pt = '2020-11-26'
;
*/

SELECT
substring(start_time,1,10) as dt,
--campaign_id as id,
SUM(impressions) AS impressions,
SUM(swipes) AS swipes,
sum(conversion_page_views) as conversions
FROM `nyt-octopus-prd.snapchat.ad_measurements`
WHERE start_time>='2022-04-01'
and campaign_id in (
'5fe8cdc4-0f93-45ae-abcc-639ffc2fb214',
'a59b42ad-6f91-4156-be60-35219510dbc9',
'35220a89-e3cd-470c-ba87-498ea1ac1f70',
'6d35bc2f-2dad-484d-8d65-762c845d3056',
'27c8d6cf-a68d-4cc5-aff1-fd48e82161a9',
'd346977e-1852-41c2-9f36-b908ce132c91',
'98797b58-c170-4e6e-8c3c-58682b3a84d6'
--getting rid of cooking
--'868eca6a-7f5d-4c20-a3b9-03b8c932f4a6',
--'e4983ecf-b453-407d-a1f7-cd4b38084eac'
)
GROUP BY 1--,2
ORDER BY 1--,2
;
