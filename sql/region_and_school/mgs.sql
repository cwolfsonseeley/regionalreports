select 
  distinct region.entity_id,
  region.hh_id,
  first_value(to_number(imp_cap.weight)) over (partition by imp_cap.entity_id order by to_number(imp_cap.weight) desc) as major_gift_score,
  first_value(imp_cap.dp_interest_desc) over (partition by imp_cap.entity_id order by to_number(imp_cap.weight) desc) as major_gift_description
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
  and entity.primary_geo_metro_area_code = ##msa##
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
  entity.record_status_code = 'A'
  and entity.primary_geo_metro_area_code = ##msa##
) region
  inner join cdw.d_bio_demographic_profile_mv imp_cap on region.entity_id = imp_cap.entity_id
where 
  imp_cap.dp_rating_type_code = 'MGS'
  