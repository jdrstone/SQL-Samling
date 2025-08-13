select
    COLUMN_NAME
from INFORMATION_SCHEMA.columns
where TABLE_SCHEMA = 'DM' and
      table_NAME = 'F_INKURANS_V'
