
          
  
    
        create or replace table `hive_metastore`.`snapshots`.`productmodel_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/productmodel/productmodel_snapshot'
      
      
      as
      

    select *,
        md5(coalesce(cast(ProductModelID as string ), '')
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
        



with product_snapshot as (
    SELECT
        ProductModelID,
        Name,
        CatalogDescription
    FROM `hive_metastore`.`saleslt`.`productmodel`
)

select * from product_snapshot

    ) sbq



  
      