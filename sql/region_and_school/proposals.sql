select 
  distinct region.entity_id,
  region.hh_id,
  extract(YEAR from round(proposal.start_dt, 'YYYY')) as fiscal_year,
  proposal.proposal_id,
  proposal.stage_desc,
  proposal.commmit_turndown_date as commit_turndown_date,
  assignment.office_desc as unit,
  proposal.actual_ask_amt as ask_amt,
  proposal.commit_turndown_amt as gift
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
  inner join cdw.d_prospect_mv prospect on region.entity_id = prospect.entity_id
  inner join cdw.f_proposal_summary_mv proposal on proposal.prospect_id = prospect.prospect_id
  inner join cdw.f_assignment_mv assignment on proposal.proposal_id = assignment.proposal_id
where
  proposal.start_dt between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')
