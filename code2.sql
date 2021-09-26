CREATE TABLE IF NOT EXISTS public.human
( id integer NOT NULL DEFAULT nextval('serial1'::regclass),
name character varying(50),
surname character varying(45),
PRIMARY KEY (id)
);



ALTER TABLE public.human
OWNER to "Aladin";




-- Table: public.boy



-- DROP TABLE public.boy;



CREATE TABLE IF NOT EXISTS public.boy
(
-- Inherited from table public.human: id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
-- Inherited from table public.human: name character varying(50) COLLATE pg_catalog."default",
-- Inherited from table public.human: surname character varying(45) COLLATE pg_catalog."default",
weight numeric(10,2),
height numeric(10,2),
"bornDate" date,
CONSTRAINT boy_pkey PRIMARY KEY (id)
)
INHERITS (public.human)
TABLESPACE pg_default;



ALTER TABLE public.boy
OWNER to "Aladin";



-- Table: public.girl



-- DROP TABLE public.girl;



CREATE TABLE IF NOT EXISTS public.girl
(
-- Inherited from table public.human: id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
-- Inherited from table public.human: name character varying(50) COLLATE pg_catalog."default",
-- Inherited from table public.human: surname character varying(45) COLLATE pg_catalog."default",
skin character varying(40) COLLATE pg_catalog."default",
"eyeColor" character varying(8) COLLATE pg_catalog."default",
age integer,
CONSTRAINT girl_pkey PRIMARY KEY (id)
)
INHERITS (public.human)
TABLESPACE pg_default;



ALTER TABLE public.girl
OWNER to "Aladin";