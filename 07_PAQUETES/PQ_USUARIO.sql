--------------------------------------------------------
-- Archivo creado  - martes-marzo-20-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package USUARIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "OW_TST_US"."USUARIO" AS

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

  PROCEDURE ACTUALIZAR_FECHA_RETIRO(
            P_DOCUMENTO  USUARIOS.DOCUMENTO%TYPE,
            P_FECHA_DE_RETIRO   USUARIOS.FECHA_DE_RETIRO%TYPE
  );
END USUARIO;

 /

prompt
prompt PACKAGE BODY: USUARIO
prompt

create or replace PACKAGE BODY USUARIO AS
--INSERTAR DATOS A UNA TABLA
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
-- ACTUALIZAR LA FECHA DE RETIRO    
    PROCEDURE ACTUALIZAR_FECHA_RETIRO(
            P_DOCUMENTO  USUARIOS.DOCUMENTO%TYPE,
            P_FECHA_DE_RETIRO   USUARIOS.FECHA_DE_RETIRO%TYPE
  ) IS
    BEGIN
    UPDATE USUARIOS
      SET FECHA_DE_RETIRO = P_FECHA_DE_RETIRO
        WHERE DOCUMENTO = P_DOCUMENTO;
    END;
-- OBTENER TIEMPO DE ANTIGUEDAD DEL USUARIO   
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
    v_mes_contador int;
    v_ano_contador int;
    v_mesfinal_contador int;
    
	BEGIN
				select nombre , TO_NUMBER(to_char(fecha_de_ingreso,'yyyy')) into v_nombre ,v_ano_ingreso  from USUARIOS where DOCUMENTO = P_DOCUMENTO;
				select TO_NUMBER(to_char(fecha_de_ingreso,'mm')) into v_mes_ingreso  from USUARIOS where DOCUMENTO = P_DOCUMENTO;

				select TO_NUMBER(to_char(sysdate,'yyyy')) into v_ano_sysdate  FROM DUAL ;
				select TO_NUMBER(to_char(sysdate,'mm')) into v_mes_sysdate FROM DUAL  ;
                
				v_ano_antiguedad := (v_ano_sysdate - v_ano_ingreso)*12 ;
                IF v_mes_ingreso > v_mes_sysdate THEN
                   v_mes_antiguedad :=  (v_mes_ingreso-v_mes_sysdate);
                ELSE
                   v_mes_antiguedad := (v_mes_sysdate - v_mes_ingreso); 
                END IF;
                
                    IF v_mes_ingreso >= v_mes_sysdate THEN
                     v_mes_contador := v_ano_antiguedad-v_mes_antiguedad; 
                     DBMS_OUTPUT.PUT_LINE('El usuario : '||v_nombre||' tiene '||v_mes_contador||' mese de antiguedad');
                    ELSE
                        v_mes_contador := (v_ano_antiguedad+v_mes_antiguedad); 
                        v_ano_contador := v_mes_contador/12;
                        v_mesfinal_contador := 30/v_mes_contador;
                        DBMS_OUTPUT.PUT_LINE('El usuario : '||v_nombre||' tiene '||v_ano_contador||' año(s) y  '||v_mesfinal_contador||' mese de antiguedad');
                    END IF;   
    END;
    
END USUARIO;