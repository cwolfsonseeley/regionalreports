select
  distinct region.entity_id,
  region.hh_id,
  extract(YEAR from round(visits.contact_date, 'YYYY')) as fiscal_year,
  visits.report_id,
  visits.unit_desc
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
  inner join cdw.f_contact_reports_mv visits on region.entity_id = visits.contact_entity_id
where
  visits.contact_type = 'V' 
  and visits.contact_date between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')
  