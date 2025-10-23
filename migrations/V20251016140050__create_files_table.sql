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
    -- 'image', 'pdf', 'document', etc. for easier filtering
    file_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on s3_key for lookups
CREATE INDEX idx_files_s3_key ON storage.files (s3_key);

-- Create index on file_type for filtering
CREATE INDEX idx_files_file_type ON storage.files (file_type);

-- Add table and column comments
COMMENT ON TABLE storage.files IS 'Generic S3 file storage for images, PDFs, documents, and other files';
COMMENT ON COLUMN storage.files.id IS 'Unique file identifier';
COMMENT ON COLUMN storage.files.s3_key IS 'Unique S3 object key (path in bucket)';
COMMENT ON COLUMN storage.files.s3_bucket IS 'S3 bucket name where file is stored';
COMMENT ON COLUMN storage.files.file_name IS 'Original filename uploaded by user';
COMMENT ON COLUMN storage.files.file_size IS 'File size in bytes';
COMMENT ON COLUMN storage.files.mime_type IS 'MIME type (e.g., image/png, application/pdf)';
COMMENT ON COLUMN storage.files.file_type IS 'Category for filtering: image, pdf, document, etc.';
COMMENT ON COLUMN storage.files.created_at IS 'Timestamp when file was uploaded';
