DROP FUNCTION IF EXISTS pi_existe_id_usuario;
DELIMITER //
CREATE FUNCTION pi_existe_id_usuario(i bigint) RETURNS BOOLEAN
BEGIN
	DECLARE total INT;
	SELECT  COUNT(*) INTO total 
	FROM  vista_login
	WHERE ID_CONTACTO=i;
	RETURN total>0;
END
//
DELIMITER ;

DROP FUNCTION IF EXISTS pi_existe_email_usuario;
DELIMITER //
CREATE FUNCTION pi_existe_email_usuario(email varchar(255)) RETURNS BOOLEAN
BEGIN
	DECLARE total INT;
	SELECT  COUNT(*) INTO total 
	FROM  vista_login
	WHERE EMAIL_CONTACTO=email;
	RETURN total>0;
END
//
DELIMITER ;

DROP FUNCTION IF EXISTS pi_existe_email_contacto;
DELIMITER //
CREATE FUNCTION pi_existe_email_contacto(email varchar(255)) RETURNS BOOLEAN
BEGIN
	DECLARE total INT;
	SELECT  COUNT(*) INTO total 
	FROM  vista_lista_contactos
	WHERE EMAIL_CONTACTO=email;
	RETURN total>0;
END
//
DELIMITER ;

DROP PROCEDURE IF EXISTS pi_usuarios_crear;
DELIMITER //
CREATE PROCEDURE pi_usuarios_crear ( nombre varchar(255), email varchar(255), pwd varchar(40) )
BEGIN
	INSERT INTO CONTACTOS (NOMBRE_CONTACTO,EMAIL_CONTACTO) VALUES(nombre, email);
	INSERT INTO ES_USUARIO VALUES(LAST_INSERT_ID(), SHA1(pwd));	
END
//
DELIMITER ;

DROP PROCEDURE IF EXISTS pi_contacto_crear;
DELIMITER //
CREATE PROCEDURE pi_contacto_crear ( nombre varchar(255), email varchar(255), usuario bigint )
BEGIN
	IF pi_existe_id_usuario(usuario) THEN
		INSERT INTO CONTACTOS (NOMBRE_CONTACTO,EMAIL_CONTACTO) VALUES(nombre, email);
		INSERT INTO ES_CONTACTO VALUES(LAST_INSERT_ID(), usuario);
	END IF;
END
//
DELIMITER ;

#select pi_existe_email_usuario('pablo@pablo.com')