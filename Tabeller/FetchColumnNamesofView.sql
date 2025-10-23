--1) hitta olika kolumntyper
-----------------------------------------
with CTE as (SELECT COLUMN_NAME
                  ,DATA_TYPE
             FROM INFORMATION_SCHEMA.COLUMNS
             WHERE TABLE_SCHEMA = 'DW'
               AND TABLE_NAME = 'BC_SALESQUOTE')

SELECT
    t.COLUMN_NAME,
    t.DATA_TYPE DW_COLUMN,
    s.DATA_TYPE STG_VY
FROM INFORMATION_SCHEMA.COLUMNS t

left join CTE s on s.COLUMN_NAME = t.COLUMN_NAME

WHERE TABLE_SCHEMA = 'STG'
  AND TABLE_NAME = 'BC_CUSTOMERLEDGERENTRIES_V'
  --and    s.DATA_TYPE <> t.DATA_TYPE
;

--Skapa DW tabelle från vy
SELECT
    t.COLUMN_NAME,
    t.DATA_TYPE DW_COLUMN,
    case
        when t.DATA_TYPE = 'NUMBER' then concat(t.COLUMN_NAME,'(NUMBER(',t.numeric_precision,',',t.numeric_scale,')),')
        when t.DATA_TYPE = 'TIMESTAMP_NTZ' then concat(t.COLUMN_NAME,' ',t.DATA_TYPE,',')
        else concat(t.COLUMN_NAME,' VARCHAR,')
    end
FROM INFORMATION_SCHEMA.COLUMNS t
WHERE TABLE_SCHEMA = 'STG'
  AND TABLE_NAME = 'BC_CUSTOMERLEDGERENTRIES_V'

