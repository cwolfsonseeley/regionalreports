select
  distinct region.entity_id,
  region.hh_id,
  extract(YEAR from round(visits.contact_date, 'YYYY')) as fiscal_year,
  visits.report_id,
  visits.unit_desc
from 
  (select 
  distinct degree.entity_id,
  entity.household_entity_id as hh_id
from
  cdw.d_bio_degrees_mv degree
  inner join cdw.d_entity_mv entity on degree.entity_id = entity.entity_id
where
  degree.school_code = '##school_code##'
  and degree.degree_level_code in ('U', 'G')
  and entity.record_status_code = 'A'
union 
select
  distinct students.entity_id,
  entity.household_entity_id as hh_id
from
  (select 
    entity_id,
    relation_entity_id as student_id
  from 
    cdw.d_bio_relationship_mv
  where 
    relation_type_code in ('FS', 'FD', 'MS', 'MD', 'SD', 'SR', 'SN', 'SH')) students
inner join (select 
    distinct record_type.entity_id as student_id
  from 
    cdw.d_bio_entity_record_type_mv record_type
    inner join cdw.d_bio_degrees_mv degree on record_type.entity_id = degree.entity_id
  where
    record_type.record_type_code = 'ST'
    and degree.school_code = '##school_code##') school
    on students.student_id = school.student_id
  inner join cdw.d_entity_mv entity on students.entity_id = entity.entity_id
where
  entity.record_status_code = 'A') region
  inner join cdw.f_contact_reports_mv visits on region.entity_id = visits.contact_entity_id
where
  visits.contact_type = 'V' 
  and visits.contact_date between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')
  