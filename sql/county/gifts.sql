select 
  distinct transaction.donor_entity_id_nbr as entity_id,
  entity.household_entity_id as hh_id,
  extract(YEAR from round(transaction.gift_credit_dt, 'YYYY')) as fiscal_year,
  transaction.cads_giving_receipt_nbr,
  transaction.benefit_aog_credited_amt as gift_amt,
  transaction.summary_aog_desc as area_of_giving
from 
  cdw.f_transaction_detail_mv transaction
  inner join cdw.d_entity_mv entity on transaction.donor_entity_id_nbr = entity.entity_id
where
  transaction.gift_credit_dt between to_date(##from##, 'yyyymmdd') and to_date(##to##, 'yyyymmdd')
  and transaction.pledged_basis_flg = 'Y'
  and transaction.benefit_aog_credited_amt > 0

