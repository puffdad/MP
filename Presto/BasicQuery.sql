SELECT 
  ecg_session_start_dt, 
  ga_vstr_id, 
  CONCAT(CAST(ga_vstr_id AS VARCHAR), '_', CAST(ga_vst_id AS VARCHAR)) AS visit, 
  CASE WHEN clsfd_dvic_id = 10 THEN 'desktop'
       WHEN clsfd_dvic_id = 20 THEN 'mobile'
       WHEN clsfd_dvic_id = 30 THEN 'tablet'
       END AS device_type, 
  CASE WHEN clsfd_pltfrm_id = 1 THEN 'web'
       WHEN clsfd_pltfrm_id = 3 THEN 'ios_app'
       WHEN clsfd_pltfrm_id = 4 THEN 'android_app'
       END AS platform, 
  ecg_hit_id, 
  hit_type, 
  clsfd_event_categ, 
  clsfd_event_action, 
  clsfd_event_label, 
  app_vrsn_txt, 
  app_id, 
  element_at(hit_cd, 127) AS car_package, 
  element_at(hit_cd, 25) AS abgroup, 
  IF(hit_type IN ('PAGE', 'APPVIEW'), 1, 0) AS page_view, 
  IF(hit_type IN ('PAGE', 'APPVIEW') AND element_at(hit_cd, 1) = 'VIP', 1, 0) AS vip, 
  IF(hit_type IN ('PAGE', 'APPVIEW') AND element_at(hit_cd, 1) IN ('L1Page', 'LandingPageCategory'), 1, 0) AS l1page, 
  IF(hit_type IN ('PAGE', 'APPVIEW') AND element_at(hit_cd, 1) IN ('ResultsSeller','ResultsSearch','ResultsBrowse'), 1, 0) AS srp, 
  IF(hit_type IN ('PAGE', 'APPVIEW') AND element_at(hit_cd, 1) = 'ResultsSearch', 1, 0) AS srp_search, 
  IF(hit_type IN ('PAGE', 'APPVIEW') AND element_at(hit_cd, 1) = 'ResultsBrowse', 1, 0) AS srp_browse, 
  IF(hit_type IN ('PAGE', 'APPVIEW') AND element_at(hit_cd, 1) = 'Homepage', 1, 0) AS homepage, 
  IF(hit_type = 'EVENT' AND clsfd_event_categ IN ('VIP', 'VipDescription') AND clsfd_event_action = 'R2SEmailSuccess', 1, 0) AS asq, 
  IF(hit_type = 'EVENT' AND clsfd_event_categ IN ('VIP', 'VipDescription') AND clsfd_event_action = 'R2SBidSuccess'  , 1, 0) AS bid, 
  IF(hit_type = 'EVENT' AND clsfd_event_categ IN ('VIP', 'VipDescription') AND clsfd_event_action = 'R2SChatSuccess' , 1, 0) AS chat, 
  IF(hit_type = 'EVENT' AND clsfd_event_categ IN ('VIP', 'VipDescription') AND clsfd_event_action = 'R2SPhoneBegin'  , 1, 0) AS phone_call, 
  IF(hit_type = 'EVENT' AND clsfd_event_categ IN ('VIP', 'VipDescription') AND clsfd_event_action = 'R2SSMSBegin'    , 1, 0) AS sms

FROM 
  dw_clsfd.clsfd_ecg_hit

WHERE 
  ecg_session_start_dt BETWEEN DATE('2018-05-01') AND DATE('2018-05-07')
AND 
  clsfd_site_id = 3001
