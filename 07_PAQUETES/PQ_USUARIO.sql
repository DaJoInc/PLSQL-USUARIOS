create or replace PACKAGE USUARIO AS

  PROCEDURE INSERTAR(
           P_DOCUMENTO  USUARIOS.DOCUMENTO%TYPE,
            P_NOMBRE    USUARIOS.NOMBRE%TYPE,
            P_APELLIDOS  USUARIOS.APELLIDOS%TYPE,
            P_EDAD      USUARIOS.EDAD%TYPE,
            P_SALARIO   USUARIOS.SALARIO%TYPE,
            P_FECHA_DE_INGRESO   USUARIOS.FECHA_DE_INGRESO%TYPE
  );

  PROCEDURE ANTIGUEDAD_USUARIO(
            P_DOCUMENTO USUARIOS.DOCUMENTO%TYPE
  );

END USUARIO;


 /




prompt
prompt PACKAGE BODY: USUARIO
prompt

create or replace PACKAGE BODY USUARIO AS

  PROCEDURE INSERTAR(
            P_DOCUMENTO  USUARIOS.DOCUMENTO%TYPE,
            P_NOMBRE    USUARIOS.NOMBRE%TYPE,
            P_APELLIDOS  USUARIOS.APELLIDOS%TYPE,
            P_EDAD      USUARIOS.EDAD%TYPE,
            P_SALARIO   USUARIOS.SALARIO%TYPE,
            P_FECHA_DE_INGRESO   USUARIOS.FECHA_DE_INGRESO%TYPE
  ) IS
    BEGIN
			INSERT INTO USUARIOS(DOCUMENTO,NOMBRE,APELLIDOS,EDAD,SALARIO,FECHA_DE_INGRESO) VALUES (P_DOCUMENTO, P_NOMBRE, P_APELLIDOS, P_EDAD, P_SALARIO, P_FECHA_DE_INGRESO);
			COMMIT;
	END ;
    
    PROCEDURE ANTIGUEDAD_USUARIO (
              P_DOCUMENTO  USUARIOS.DOCUMENTO%TYPE
    )IS
    v_nombre varchar(100);
    v_ano_ingreso number; 
	v_mes_ingreso number  ;
    v_ano_sysdate  number ;
	v_mes_sysdate   number ;
	v_ano_antiguedad   number ;
    v_mes_antiguedad number;
	BEGIN


				select nombre , TO_NUMBER(to_char(fecha_de_ingreso,'yyyy')) into v_nombre ,v_ano_ingreso  from USUARIOS where DOCUMENTO = P_DOCUMENTO;
				select TO_NUMBER(to_char(fecha_de_ingreso,'mm')) into v_mes_ingreso  from USUARIOS where DOCUMENTO = P_DOCUMENTO;

				select TO_NUMBER(to_char(sysdate,'yyyy')) into v_ano_sysdate  FROM DUAL ;
				select TO_NUMBER(to_char(sysdate,'mm')) into v_mes_sysdate FROM DUAL  ;
				v_ano_antiguedad := v_ano_sysdate - v_ano_ingreso ;
                v_mes_antiguedad := v_mes_sysdate - v_mes_ingreso;
			
			   dbms_output.put_line('El usuario:'||v_nombre||'  tiene '||v_ano_antiguedad||'  años  y '||v_mes_ingreso||' mese de antiguedad');
    END;

END USUARIO;