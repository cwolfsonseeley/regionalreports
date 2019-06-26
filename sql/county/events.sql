select
  distinct activity.entity_id, 
  entity.household_entity_id as hh_id,
  extract(YEAR from round(activity.start_dt, 'YYYY')) as fiscal_year,
  activity.activity_code,
  activity.unit_code_desc
from 
  cdw.d_bio_activity_mv activity
  inner join cdw.d_entity_mv entity on activity.entity_id = entity.entity_id
where
  activity.activity_participation_code in ('P', 'ST', 'SP', 'V', 'H', 'S', 'C', 'KN', 'MD', 'E')
  and activity.start_dt between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')