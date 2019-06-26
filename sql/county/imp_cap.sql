select 
  distinct imp_cap.entity_id,
  entity.household_entity_id as hh_id,
  first_value(to_number(imp_cap.weight)) over (partition by imp_cap.entity_id order by to_number(imp_cap.weight) desc) as implied_capacity_score,
  first_value(imp_cap.dp_interest_desc) over (partition by imp_cap.entity_id order by to_number(imp_cap.weight) desc) as implied_capacity_description
from 
  cdw.d_bio_demographic_profile_mv imp_cap
  inner join cdw.d_entity_mv entity on imp_cap.entity_id = entity.entity_id
where 
  imp_cap.dp_rating_type_code = 'CAP'
  