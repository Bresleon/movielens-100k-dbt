-- ============================================================
-- 1. Capa STAGING: Restricciones de Integridad y 3FN
-- ============================================================
-- Primary Keys
ALTER TABLE staging.stg_movies ADD CONSTRAINT pk_stg_movies PRIMARY KEY (movie_id);
ALTER TABLE staging.stg_genres ADD CONSTRAINT pk_stg_genres PRIMARY KEY (genre_id);
ALTER TABLE staging.stg_users ADD CONSTRAINT pk_stg_users PRIMARY KEY (user_id);
ALTER TABLE staging.stg_movie_genres ADD CONSTRAINT pk_stg_movie_genres PRIMARY KEY (movie_id, genre_id);

-- Foreign Keys en la tabla asociativa 3FN
ALTER TABLE staging.stg_movie_genres
    ADD CONSTRAINT fk_stg_movie_genres_movies
    FOREIGN KEY (movie_id) REFERENCES staging.stg_movies (movie_id) ON DELETE CASCADE;

ALTER TABLE staging.stg_movie_genres
    ADD CONSTRAINT fk_stg_movie_genres_genres
    FOREIGN KEY (genre_id) REFERENCES staging.stg_genres (genre_id) ON DELETE CASCADE;

-- Foreign Keys en ratings
ALTER TABLE staging.stg_ratings
    ADD CONSTRAINT fk_stg_ratings_movies
    FOREIGN KEY (movie_id) REFERENCES staging.stg_movies (movie_id);

ALTER TABLE staging.stg_ratings
    ADD CONSTRAINT fk_stg_ratings_users
    FOREIGN KEY (user_id) REFERENCES staging.stg_users (user_id);


-- ============================================================
-- 2. Capa MARTS: Esquema en Estrella (Star Schema)
-- ============================================================
-- Primary Keys de Dimensiones y Hechos
ALTER TABLE marts.dim_movies ADD CONSTRAINT pk_dim_movies PRIMARY KEY (movie_id);
ALTER TABLE marts.dim_users ADD CONSTRAINT pk_dim_users PRIMARY KEY (user_id);
ALTER TABLE marts.fct_ratings ADD CONSTRAINT pk_fct_ratings PRIMARY KEY (rating_id);

-- Foreign Keys de la Tabla de Hechos hacia las Dimensiones
ALTER TABLE marts.fct_ratings
    ADD CONSTRAINT fk_fct_ratings_dim_movies
    FOREIGN KEY (movie_id) REFERENCES marts.dim_movies (movie_id);

ALTER TABLE marts.fct_ratings
    ADD CONSTRAINT fk_fct_ratings_dim_users
    FOREIGN KEY (user_id) REFERENCES marts.dim_users (user_id);
