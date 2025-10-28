-- Seed miniature themes data

WITH themes_data(theme_name, theme_description, display_order) AS (
    VALUES
    ('Stormlight Archive', 'Characters and scenes from Brandon Sanderson''s epic fantasy series', 1),
    ('Warhammer 40,000', 'Grimdark science fiction miniatures from the 41st millennium', 2),
    ('Fantasy Heroes', 'Classic fantasy adventurers, warriors, and mages', 3),
    ('Sci-Fi Collection', 'Futuristic soldiers, mechs, and alien creatures', 4),
    ('Historical Miniatures', 'Historically accurate figures from various time periods', 5),
    ('Terrain & Dioramas', 'Scenic bases, terrain pieces, and complete dioramas', 6)
)
INSERT INTO miniatures.miniature_themes (name, description, display_order)
SELECT td.theme_name, td.theme_description, td.display_order
FROM themes_data td
ON CONFLICT (name) DO UPDATE SET
    description = EXCLUDED.description,
    display_order = EXCLUDED.display_order;
