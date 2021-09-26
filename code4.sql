-- FUNCTION: public.tigger_all()

-- DROP FUNCTION public.tigger_all();

CREATE OR REPLACE FUNCTION public.tigger_all()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
IF (TG_OP = 'DELETE') THEN
INSERT INTO public.logs(
"logUser", "logOperation", "logData")
VALUES (CURRENT_USER, TG_OP, row_to_json(OLD.*));
RETURN OLD;
ELSEIF (TG_OP='UPDATE') THEN
INSERT INTO public.logs(
"logUser", "logOperation", "logData")
VALUES (CURRENT_USER, TG_OP, (row_to_json(OLD.*)::TEXT) || (row_to_json(NEW.*)::TEXT));
RETURN OLD;
ELSEIF (TG_OP='INSERT') THEN
INSERT INTO public.logs(
"logUser", "logOperation", "logData")
VALUES (CURRENT_USER, TG_OP, row_to_json(NEW.*));
RETURN NEW;
END IF;
RETURN NULL;
END;

$BODY$;

ALTER FUNCTION public.tigger_all()
    OWNER TO postgres;

-- Trigger: checking

-- DROP TRIGGER checking ON public.human;

CREATE TRIGGER checking
    AFTER INSERT OR DELETE OR UPDATE 
    ON public.human
    FOR EACH ROW
    EXECUTE FUNCTION public.tigger_all();