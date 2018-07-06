select 
  distinct region.entity_id,
  region.hh_id,
  first_value(to_number(imp_cap.weight)) over (partition by imp_cap.entity_id order by to_number(imp_cap.weight) desc) as implied_capacity_score,
  first_value(imp_cap.dp_interest_desc) over (partition by imp_cap.entity_id order by to_number(imp_cap.weight) desc) as implied_capacity_description
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
  inner join cdw.d_bio_demographic_profile_mv imp_cap on region.entity_id = imp_cap.entity_id
where 
  imp_cap.dp_rating_type_code = 'CAP'
  