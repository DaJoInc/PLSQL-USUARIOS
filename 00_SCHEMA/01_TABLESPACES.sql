REM ******************************************************************
REM Fecha         : 26/12/2017
REM Realizado por : Ownk
REM Base de Datos : OW_TST_US
REM ******************************************************************


REM TABLESPACE TEMPORAL

Create Temporary tablespace TS_TTST TEMPFILE
'C:\oraclexe\app\oracle\oradata\XE\TTST.dbf' size 300m
         Extent management local uniform size 2m
;


REM TABLESPACE DE DATOS

CREATE TABLESPACE TS_DTST DATAFILE 
  'C:\oraclexe\app\oracle\oradata\XE\DTST.DBF' SIZE 300M AUTOEXTEND ON NEXT 1024M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


REM TABLESPACE DE INDICES 
                                                            
CREATE TABLESPACE TS_ITST DATAFILE 
  'C:\oraclexe\app\oracle\oradata\XE\ITST.DBF' SIZE 300M AUTOEXTEND ON NEXT 1024M MAXSIZE UNLIMITED
LOGGING
ONLINE
PERMANENT
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;   

