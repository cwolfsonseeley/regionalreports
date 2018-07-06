select 
  distinct region.entity_id,
  region.hh_id,
  extract(YEAR from round(gifts.gift_credit_dt, 'YYYY')) as fiscal_year,
  gifts.cads_giving_receipt_nbr,
  gifts.benefit_aog_credited_amt as gift_amt,
  gifts.summary_aog_desc as area_of_giving
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
  inner join cdw.f_transaction_detail_mv gifts on region.entity_id = gifts.donor_entity_id_nbr
where
  gifts.gift_credit_dt between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')
  and gifts.pledged_basis_flg = 'Y'
  and benefit_aog_credited_amt > 0
  
