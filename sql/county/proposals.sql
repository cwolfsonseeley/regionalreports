select 
  distinct prospect.entity_id,
  entity.household_entity_id as hh_id,
  extract(YEAR from round(proposal.start_dt, 'YYYY')) as fiscal_year,
  proposal.proposal_id,
  proposal.stage_desc,
  proposal.commmit_turndown_date as commit_turndown_date,
  assignment.office_desc as unit,
  proposal.actual_ask_amt as ask_amt,
  proposal.commit_turndown_amt as gift
from 
  cdw.d_prospect_mv prospect
  inner join cdw.f_proposal_summary_mv proposal on proposal.prospect_id = prospect.prospect_id
  inner join cdw.f_assignment_mv assignment on proposal.proposal_id = assignment.proposal_id
  inner join cdw.d_entity_mv entity on prospect.entity_id = entity.entity_id
where
  proposal.start_dt between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')
