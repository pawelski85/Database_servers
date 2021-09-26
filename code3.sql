-- SEQUENCE: public.serial1

-- DROP SEQUENCE public.serial1;

CREATE SEQUENCE public.serial1
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.serial1
    OWNER TO postgres;
-- Table: public.logs

-- DROP TABLE public.logs;

CREATE TABLE IF NOT EXISTS public.logs
(
    "logId" integer NOT NULL DEFAULT nextval('"logs_logId_seq"'::regclass),
    "logUser" character varying(50) COLLATE pg_catalog."default",
    "logOperation" character varying(200) COLLATE pg_catalog."default",
    "logData" character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT logs_pkey PRIMARY KEY ("logId")
)

TABLESPACE pg_default;

ALTER TABLE public.logs
    OWNER to postgres;
-- Trigger: humanMonitoring

-- DROP TRIGGER "humanMonitoring" ON public.human;

CREATE TRIGGER "humanMonitoring"
    AFTER INSERT OR UPDATE 
    ON public.human
    FOR EACH ROW
    EXECUTE FUNCTION public.insert_log();
-- FUNCTION: public.insert_log()

-- DROP FUNCTION public.insert_log();

CREATE OR REPLACE FUNCTION public.insert_log()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
begin
INSERT INTO public.logs(
	"logUser", "logOperation", "logData")
	VALUES (current_user, TG_OP, NEW.surname);
	RETURN NEW;
	END;
$BODY$;

ALTER FUNCTION public.insert_log()
    OWNER TO postgres;


