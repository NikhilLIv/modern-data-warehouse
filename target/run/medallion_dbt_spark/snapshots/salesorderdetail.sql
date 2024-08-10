
          
  
    
        create or replace table `hive_metastore`.`snapshots`.`salesorderdetail_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/salesorderdetail/salesorderdetail_snapshot'
      
      
      as
      

    select *,
        md5(coalesce(cast(SalesOrderDetailID as string ), '')
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
        



with salesorderdetail_snapshot as (
    SELECT
        SalesOrderID,
        SalesOrderDetailID,
        OrderQty,
        ProductID,
        UnitPrice,
        UnitPriceDiscount,
        LineTotal
    FROM `hive_metastore`.`saleslt`.`salesorderdetail`
)

select * from salesorderdetail_snapshot

    ) sbq



  
      