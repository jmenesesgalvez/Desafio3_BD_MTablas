-- Active: 1720985866681@@127.0.0.1@5432
CREATE DATABASE desafio3_Joaquin_Meneses_993;
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    nombre VARCHAR(30) NOT NULL, 
    apellido VARCHAR(30)NOT NULL, 
    rol VARCHAR(50)
    );

    INSERT INTO usuarios(email,nombre,apellido,rol)
        VALUES ('joaquinmenesesgalvez@gmail.com','joaquin','meneses','administrador'),
                ('carolinaconcha@gmail.com','carolina','concha','usuario'),
                ('albertorodriguez@gmail.com','alberto','rodriguez','usuario'),
                ('monica.arango@gmail.com','monica','arango','usuario'),
                ('jose.1986@gmail.com','jose','tapia','usuario');

select * from usuarios;

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    destacado BOOLEAN NOT NULL DEFAULT FALSE,
    usuario_id BIGINT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE comentarios (
    id SERIAL PRIMARY KEY,
    contenido TEXT NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    usuario_id BIGINT NOT NULL,
    post_id BIGINT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);
INSERT INTO posts (titulo,contenido,destacado,usuario_id)
VALUES ('caso de estudio','Utilizar el término de “caso de estudio” es muy interesante',TRUE,1),
('Comparativas y listados de productos','En contenidos relacionados con productos, las comparativas son algo que funciona siempre',FALSE,1),
('Como conseguir objetivo en tiempo', 'En todos los nichos hay ciertos tipos de objetivos que sabes que la gente interesada desea conseguir',FALSE,2),
('Conclusiones','En blog bien llevado necesita que publiques de manera regular nuevos contenidos',TRUE,	2),
('Enterrar mitos','La última técnica es una técnica que, personalmente, me ha funcionado',FALSE,5);

select * from posts;

INSERT INTO comentarios (contenido, usuario_id, post_id) 
VALUES 
('Es muy importante poder tomar consiencia de estos casos', 1, 1),
('Podria subir cosas mas interesantes ...', 2, 1),
('Muy buen tema, super conforme con la explicacion', 3, 1),
('siempre es bueno obtener conclusiones nos ayuda a crecer', 1, 2),
('este es un contenido clasico de relleno :(', 2, 2);

select * from comentarios;
