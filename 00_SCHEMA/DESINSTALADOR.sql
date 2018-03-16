REM ******************************************************************
REM Fecha         : 26/07/2017
REM Realizado por : Ownk
REM Base de Datos : OW_TST_US
REM ******************************************************************

REM TABLESPACE Y SEGMENTOS DE ROLLBACK
set feedback off
spool TMP.lst
select distinct 'pause DEBE estar conectado con Usuario SYSTEM' || chr(10) || 'ROLL' || chr(10) || 'EXIT'
from dual
where user <> 'SYSTEM'
/
spool off
start TMP.lst
set feedback on

REM USUARIO  DUENHO DEL APLICATIVO OW_TST_US
drop user OW_TST_US cascade;
/


REM TABLESPACE DE DATOS
DROP TABLESPACE TS_DTST INCLUDING CONTENTS
/

REM TABLESPACE DE INDICES 
DROP TABLESPACE TS_ITST INCLUDING CONTENTS
/

REM TABLESPACE TEMPORAL
DROP tablespace TS_TTST
/






