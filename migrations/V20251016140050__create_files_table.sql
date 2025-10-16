-- Create files table - simple S3 file storage for any file type
-- Supports images, PDFs, documents, resumes, etc.
-- Relationships to projects/miniatures/themes are handled via junction tables
CREATE TABLE storage.files (
    id BIGSERIAL PRIMARY KEY,
    s3_key VARCHAR(500) NOT NULL UNIQUE,
    s3_bucket VARCHAR(100) NOT NULL,
    file_name VARCHAR(255),
    file_size BIGINT,
    mime_type VARCHAR(100),
    file_type VARCHAR(50), -- 'image', 'pdf', 'document', etc. for easier filtering
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on s3_key for lookups
CREATE INDEX idx_files_s3_key ON storage.files(s3_key);

-- Create index on file_type for filtering
CREATE INDEX idx_files_file_type ON storage.files(file_type);
