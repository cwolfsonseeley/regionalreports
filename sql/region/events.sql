select
  distinct region.entity_id,
  region.hh_id,
  extract(YEAR from round(activity.start_dt, 'YYYY')) as fiscal_year,
  activity.activity_code,
  activity.unit_code_desc
from 
  (select 
  distinct record_type.entity_id,
  entity.household_entity_id as hh_id
  from 
  cdw.d_bio_entity_record_type_mv record_type
  inner join cdw.d_entity_mv entity on record_type.entity_id = entity.entity_id
where
  record_type.record_type_code in ('PA', 'AU', 'AG')
  and entity.primary_geo_metro_area_code = ##msa##) region
  inner join cdw.d_bio_activity_mv activity on region.entity_id = activity.entity_id
where
  activity.activity_participation_code in ('P', 'ST', 'SP', 'V', 'H', 'S', 'C', 'KN', 'MD', 'E')
  and activity.start_dt between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')

