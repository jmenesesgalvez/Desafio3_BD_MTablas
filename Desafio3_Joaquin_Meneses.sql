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

/* 1 */
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
/* 2 */
SELECT 
u.nombre AS usuario_nombre,
u.email AS usuario_email,
p.titulo AS posts_titulo,
p.contenido AS posts_contenido 
FROM 
usuarios u,
posts p
WHERE 
u.id=p.usuario_id

/* 3 */
SELECT 
p.id,
p.titulo,
p.contenido
FROM 
posts p
WHERE 
p.usuario_id=1

/* 4 */
SELECT
u.id,
u.email,
COUNT (p.id) AS count_post
FROM
usuarios u
LEFT JOIN 
posts p ON u.id=p.usuario_id
GROUP BY
u.id,
u.email 
ORDER BY 
count_post desc 

/* 5 */
SELECT
email
FROM (
SELECT u.email,
COUNT (p.id) AS count_post
FROM usuarios u
LEFT JOIN 
posts p ON u.id=p.usuario_id
GROUP BY
u.email 
)
ORDER BY 
count_post desc limit 1

/* 6 */
SELECT 
u.nombre,
u.email,
COALESCE(MAX (p.fecha_creacion)::TEXT,'S/Post') AS fecha_uposts
FROM 
usuarios u
LEFT JOIN posts p ON u.id = p.usuario_id
GROUP BY u.id, u.nombre, u.email
ORDER BY fecha_uposts asc

/* 7 */
SELECT
p.titulo AS titulo_Post,
p.contenido AS contenido_Post,
c.count_comments
FROM posts p
JOIN (
    SELECT post_id,
    COUNT (*) AS count_comments
    FROM comentarios
    GROUP BY post_id
    ORDER BY count_comments desc limit 1)
    c ON p.id = c.post_id

/* 8 */
SELECT p.titulo AS titulo_posts,
       p.contenido AS contenido_posts,
       c.contenido AS contenido_comentarios,
       u.email AS email_usuario
FROM posts p
LEFT JOIN comentarios c ON p.id = c.post_id
LEFT JOIN usuarios u ON c.usuario_id = u.id
WHERE p.titulo IS NOT NULL
  AND p.contenido IS NOT NULL
  AND c.contenido IS NOT NULL
  AND u.email IS NOT NULL
ORDER BY p.id, c.id;

/* 9 */
SELECT 
u.nombre AS usuario_nombre,
u.email AS usuario_email,
COALESCE(c.contenido, 'S/Comments') AS comentario,
COALESCE(MAX (c.fecha_creacion)::TEXT,'S/Data') AS fecha_ucomments
FROM 
usuarios u
LEFT JOIN comentarios c ON u.id = c.usuario_id
GROUP BY u.id, u.nombre, u.email, c.contenido
ORDER BY fecha_ucomments asc

/* 10 */
SELECT u.email
FROM usuarios u
LEFT JOIN comentarios c ON u.id = c.usuario_id
WHERE c.usuario_id IS NULL;
