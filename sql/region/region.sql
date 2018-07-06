select 
  distinct record_type.entity_id,
  entity.household_entity_id as hh_id,
  record_type.record_type_desc,
  extract(YEAR from round(entity.birth_dt, 'YYYY')) as birth_year,
  entity.pref_class_year,
  entity.capacity_rating_code,
  entity.capacity_rating_desc,
  entity.pref_school_desc
from 
  cdw.d_bio_entity_record_type_mv record_type
  inner join cdw.d_entity_mv entity on record_type.entity_id = entity.entity_id
where
  record_type.record_type_code in ('PA', 'AU', 'AG')
  and entity.primary_geo_metro_area_code = ##msa##
  
