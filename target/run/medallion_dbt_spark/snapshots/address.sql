
          
  
    
        create or replace table `hive_metastore`.`snapshots`.`address_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/address/address_snapshot'
      
      
      as
      

    select *,
        md5(coalesce(cast(AddressID as string ), '')
         || '|' || coalesce(cast(
    current_timestamp()
 as string ), '')
        ) as dbt_scd_id,
        
    current_timestamp()
 as dbt_updated_at,
        
    current_timestamp()
 as dbt_valid_from,
        nullif(
    current_timestamp()
, 
    current_timestamp()
) as dbt_valid_to
    from (
        



with source_data as (
    select
        AddressID,
        AddressLine1,
        AddressLine2,
        City,
        StateProvince,
        CountryRegion,
        PostalCode
    from `hive_metastore`.`saleslt`.`address`
)
select *
from source_data

    ) sbq



  
      