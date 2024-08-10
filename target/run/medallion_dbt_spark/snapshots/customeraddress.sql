
          
  
    
        create or replace table `hive_metastore`.`snapshots`.`customeraddress_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/customeraddress/customeraddress_snapshot'
      
      
      as
      

    select *,
        md5(coalesce(cast(CustomerId||'-'||AddressId as string ), '')
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
        CustomerId,
        AddressId,
        AddressType
    from `hive_metastore`.`saleslt`.`customeraddress`
)
select *
from source_data

    ) sbq



  
      