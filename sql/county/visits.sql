select
  distinct contact.contact_entity_id as entity_id,
  entity.household_entity_id as hh_id,
  extract(YEAR from round(contact.contact_date, 'YYYY')) as fiscal_year,
  contact.report_id,
  contact.unit_desc
from 
  cdw.f_contact_reports_mv contact
  inner join cdw.d_entity_mv entity on contact.contact_entity_id = entity.entity_id
where
  contact.contact_type = 'V' 
  and contact.contact_date between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')
union
select 
  contact.contact_alt_entity_id as entity_id,
  entity.household_entity_id as hh_id,
  extract(YEAR from round(contact.contact_date, 'YYYY')) as fiscal_year,
  contact.report_id,
  contact.unit_desc
from 
  cdw.f_contact_reports_mv contact
  inner join cdw.d_entity_mv entity on contact.contact_alt_entity_id = entity.entity_id
where
  contact.contact_type = 'V' 
  and contact.contact_date between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')


