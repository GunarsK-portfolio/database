-- Create generic audit trigger function
-- This function captures INSERT, UPDATE, DELETE operations and logs them to audit.change_log
--
-- Usage: Application must set session context before operations:
--   SET LOCAL app.current_user_id = 123;
--   SET LOCAL app.current_username = 'admin';
-- Optional context:
--   SET LOCAL app.client_ip = '192.168.1.1';
--   SET LOCAL app.user_agent = 'Mozilla/5.0...';

CREATE OR REPLACE FUNCTION audit.log_change()
RETURNS TRIGGER AS $$
DECLARE
    v_user_id BIGINT;
    v_username VARCHAR(100);
    v_client_ip VARCHAR(50);
    v_user_agent TEXT;
    v_old_data JSONB;
    v_new_data JSONB;
    v_changed_fields TEXT[];
    v_key TEXT;
BEGIN
    -- Get user context from session variables (set by application)
    BEGIN
        v_user_id := current_setting('app.current_user_id', true)::BIGINT;
    EXCEPTION WHEN OTHERS THEN
        v_user_id := NULL;
    END;

    BEGIN
        v_username := current_setting('app.current_username', true);
    EXCEPTION WHEN OTHERS THEN
        v_username := NULL;
    END;

    BEGIN
        v_client_ip := current_setting('app.client_ip', true);
    EXCEPTION WHEN OTHERS THEN
        v_client_ip := NULL;
    END;

    BEGIN
        v_user_agent := current_setting('app.user_agent', true);
    EXCEPTION WHEN OTHERS THEN
        v_user_agent := NULL;
    END;

    -- Handle different operations
    IF (TG_OP = 'INSERT') THEN
        v_old_data := NULL;
        v_new_data := to_jsonb(NEW);
        v_changed_fields := NULL;

        INSERT INTO audit.change_log (
            table_name, schema_name, record_id, action,
            user_id, username, old_data, new_data, changed_fields,
            client_ip, user_agent
        ) VALUES (
            TG_TABLE_NAME, TG_TABLE_SCHEMA, (to_jsonb(NEW)->>'id')::BIGINT, 'INSERT',
            v_user_id, v_username, v_old_data, v_new_data, v_changed_fields,
            v_client_ip, v_user_agent
        );

        RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
        v_old_data := to_jsonb(OLD);
        v_new_data := to_jsonb(NEW);

        -- Find which fields changed
        v_changed_fields := ARRAY[]::TEXT[];
        FOR v_key IN SELECT jsonb_object_keys(v_new_data)
        LOOP
            IF v_old_data->v_key IS DISTINCT FROM v_new_data->v_key THEN
                v_changed_fields := array_append(v_changed_fields, v_key);
            END IF;
        END LOOP;

        -- Only log if something actually changed (ignore updated_at)
        IF array_length(v_changed_fields, 1) > 0 AND NOT (
            array_length(v_changed_fields, 1) = 1 AND v_changed_fields[1] = 'updated_at'
        ) THEN
            INSERT INTO audit.change_log (
                table_name, schema_name, record_id, action,
                user_id, username, old_data, new_data, changed_fields,
                client_ip, user_agent
            ) VALUES (
                TG_TABLE_NAME, TG_TABLE_SCHEMA, (to_jsonb(NEW)->>'id')::BIGINT, 'UPDATE',
                v_user_id, v_username, v_old_data, v_new_data, v_changed_fields,
                v_client_ip, v_user_agent
            );
        END IF;

        RETURN NEW;

    ELSIF (TG_OP = 'DELETE') THEN
        v_old_data := to_jsonb(OLD);
        v_new_data := NULL;
        v_changed_fields := NULL;

        INSERT INTO audit.change_log (
            table_name, schema_name, record_id, action,
            user_id, username, old_data, new_data, changed_fields,
            client_ip, user_agent
        ) VALUES (
            TG_TABLE_NAME, TG_TABLE_SCHEMA, (to_jsonb(OLD)->>'id')::BIGINT, 'DELETE',
            v_user_id, v_username, v_old_data, v_new_data, v_changed_fields,
            v_client_ip, v_user_agent
        );

        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON FUNCTION audit.log_change() IS 'Generic trigger function to log INSERT/UPDATE/DELETE to audit.change_log. Requires session variables: app.current_user_id, app.current_username';
