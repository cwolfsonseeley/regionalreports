select 
  distinct mgs.entity_id,
  entity.household_entity_id as hh_id,
  first_value(to_number(mgs.weight)) over (partition by mgs.entity_id order by to_number(mgs.weight) desc) as major_gift_score,
  first_value(mgs.dp_interest_desc) over (partition by mgs.entity_id order by to_number(mgs.weight) desc) as major_gift_description
from 
  cdw.d_bio_demographic_profile_mv mgs
  inner join cdw.d_entity_mv entity on mgs.entity_id = entity.entity_id
where 
  mgs.dp_rating_type_code = 'MGS'
  