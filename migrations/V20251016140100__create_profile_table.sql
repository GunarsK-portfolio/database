-- Create profile table
CREATE TABLE portfolio.profile (
    id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    title VARCHAR(100),
    bio TEXT,
    email VARCHAR(100),
    phone VARCHAR(20),
    location VARCHAR(100),
    avatar_file_id BIGINT,
    resume_file_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_avatar_file FOREIGN KEY (avatar_file_id)
        REFERENCES storage.files(id) ON DELETE SET NULL,
    CONSTRAINT fk_resume_file FOREIGN KEY (resume_file_id)
        REFERENCES storage.files(id) ON DELETE SET NULL
);

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_profile_updated_at BEFORE UPDATE ON portfolio.profile
FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
