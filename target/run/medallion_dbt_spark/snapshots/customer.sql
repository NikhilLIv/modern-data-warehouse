
          
  
    
        create or replace table `hive_metastore`.`snapshots`.`customer_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/customer/customer_snapshot'
      
      
      as
      

    select *,
        md5(coalesce(cast(CustomerId as string ), '')
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
        NameStyle,
        Title,
        FirstName,
        MiddleName,
        LastName,
        Suffix,
        CompanyName,
        SalesPerson,
        EmailAddress,
        Phone,
        PasswordHash,
        PasswordSalt
    from `hive_metastore`.`saleslt`.`customer`
)
select *
from source_data

    ) sbq



  
      