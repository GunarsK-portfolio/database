-- Seed miniature paints

WITH paints_data(paint_name, manufacturer_name, color_hex, paint_type) AS (
    VALUES
    -- AK Interactive Basics
    ('White', 'AK Interactive', '#FFFFFF', 'Base'),
    ('Black', 'AK Interactive', '#000000', 'Base'),
    ('Grey', 'AK Interactive', '#808080', 'Base'),
    ('Light Grey', 'AK Interactive', '#C0C0C0', 'Layer'),
    ('Dark Grey', 'AK Interactive', '#404040', 'Base'),

    -- AK Interactive Reds
    ('Red', 'AK Interactive', '#C1272D', 'Base'),
    ('Dark Red', 'AK Interactive', '#8B0000', 'Base'),
    ('Burnt Red', 'AK Interactive', '#A52A2A', 'Layer'),

    -- AK Interactive Blues
    ('Blue', 'AK Interactive', '#0047AB', 'Base'),
    ('Dark Blue', 'AK Interactive', '#00008B', 'Base'),
    ('Light Blue', 'AK Interactive', '#87CEEB', 'Layer'),
    ('Sky Blue', 'AK Interactive', '#87CEEB', 'Layer'),

    -- AK Interactive Greens
    ('Green', 'AK Interactive', '#228B22', 'Base'),
    ('Dark Green', 'AK Interactive', '#006400', 'Base'),
    ('Olive Green', 'AK Interactive', '#556B2F', 'Base'),

    -- AK Interactive Yellows/Oranges
    ('Yellow', 'AK Interactive', '#FFFF00', 'Base'),
    ('Dark Yellow', 'AK Interactive', '#FFB300', 'Base'),
    ('Orange', 'AK Interactive', '#FF8C00', 'Base'),

    -- AK Interactive Browns/Earth Tones
    ('Brown', 'AK Interactive', '#8B4513', 'Base'),
    ('Dark Brown', 'AK Interactive', '#654321', 'Base'),
    ('Leather Brown', 'AK Interactive', '#8B4513', 'Base'),
    ('Flat Earth', 'AK Interactive', '#8B7355', 'Base'),

    -- AK Interactive Flesh Tones
    ('Pale Flesh', 'AK Interactive', '#F5DEB3', 'Layer'),
    ('Basic Flesh', 'AK Interactive', '#E0AC69', 'Base'),
    ('Dark Flesh', 'AK Interactive', '#CD853F', 'Shade'),

    -- AK Interactive Metallics
    ('Silver', 'AK Interactive', '#C0C0C0', 'Metallic'),
    ('Gold', 'AK Interactive', '#FFD700', 'Metallic'),
    ('Bronze', 'AK Interactive', '#CD7F32', 'Metallic'),
    ('Copper', 'AK Interactive', '#B87333', 'Metallic'),
    ('Gunmetal', 'AK Interactive', '#2C3539', 'Metallic'),

    -- Army Painter Warband Core Colors
    ('Fog Grey', 'Army Painter', '#D3D3D3', 'Base'),
    ('Drake Tooth', 'Army Painter', '#F5E6D3', 'Base'),
    ('Dungeon Grey', 'Army Painter', '#696969', 'Base'),
    ('Hardened Carapace', 'Army Painter', '#2F4F4F', 'Base'),
    ('Necrotic Flesh', 'Army Painter', '#8B8B7A', 'Base'),
    ('Wasteland Soil', 'Army Painter', '#8B7355', 'Base'),

    -- Army Painter Warband Reds/Oranges
    ('Plasma Coil Glow', 'Army Painter', '#FF6347', 'Layer'),
    ('Lava Orange', 'Army Painter', '#FF4500', 'Layer'),

    -- Army Painter Warband Blues/Purples
    ('Deep Blue', 'Army Painter', '#000080', 'Base'),
    ('Electric Blue', 'Army Painter', '#7DF9FF', 'Layer'),
    ('Alien Purple', 'Army Painter', '#8B00FF', 'Base'),

    -- Army Painter Warband Greens
    ('Mutation Green', 'Army Painter', '#32CD32', 'Layer'),
    ('Venom', 'Army Painter', '#ADFF2F', 'Layer'),
    ('Crusted Sore', 'Army Painter', '#556B2F', 'Base'),

    -- Army Painter Warband Metallics
    ('Plate Mail Metal', 'Army Painter', '#B8B8B8', 'Metallic'),
    ('Greedy Gold', 'Army Painter', '#FFD700', 'Metallic'),
    ('Weapon Bronze', 'Army Painter', '#CD7F32', 'Metallic'),

    -- Army Painter Warband Washes/Shades
    ('Dark Tone', 'Army Painter', '#000000', 'Shade'),
    ('Strong Tone', 'Army Painter', '#8B4513', 'Shade'),
    ('Soft Tone', 'Army Painter', '#D2B48C', 'Shade'),
    ('Military Shader', 'Army Painter', '#556B2F', 'Shade'),

    -- AK Interactive Real Colors (Additional)
    ('Ivory', 'AK Interactive', '#FFFFF0', 'Base'),
    ('Cream', 'AK Interactive', '#FFFDD0', 'Base'),
    ('Buff', 'AK Interactive', '#F0DC82', 'Layer'),
    ('Sand Yellow', 'AK Interactive', '#FCE883', 'Base'),
    ('Desert Yellow', 'AK Interactive', '#EDC9AF', 'Base'),
    ('Ochre', 'AK Interactive', '#CC7722', 'Base'),
    ('Rust', 'AK Interactive', '#B7410E', 'Technical'),
    ('Bright Red', 'AK Interactive', '#FF0000', 'Layer'),
    ('Scarlet', 'AK Interactive', '#FF2400', 'Layer'),
    ('Deep Red', 'AK Interactive', '#850101', 'Base'),
    ('Pink', 'AK Interactive', '#FFC0CB', 'Layer'),
    ('Purple', 'AK Interactive', '#800080', 'Base'),
    ('Violet', 'AK Interactive', '#8F00FF', 'Layer'),
    ('Navy Blue', 'AK Interactive', '#000080', 'Base'),
    ('Prussian Blue', 'AK Interactive', '#003153', 'Base'),
    ('Turquoise', 'AK Interactive', '#40E0D0', 'Layer'),
    ('Cyan', 'AK Interactive', '#00FFFF', 'Layer'),
    ('Bright Green', 'AK Interactive', '#00FF00', 'Layer'),
    ('Lime Green', 'AK Interactive', '#32CD32', 'Layer'),
    ('Forest Green', 'AK Interactive', '#228B22', 'Base'),
    ('Camouflage Green', 'AK Interactive', '#78866B', 'Base'),
    ('Sea Green', 'AK Interactive', '#2E8B57', 'Layer'),

    -- AK Interactive Weathering/Effects
    ('Rust Streaks', 'AK Interactive', '#8B4513', 'Technical'),
    ('Dark Wash', 'AK Interactive', '#1A1A1A', 'Wash'),
    ('Brown Wash', 'AK Interactive', '#654321', 'Wash'),
    ('Green Wash', 'AK Interactive', '#2F4F2F', 'Wash'),
    ('Blue Wash', 'AK Interactive', '#191970', 'Wash'),

    -- Army Painter Warband Additional Colors
    ('Pure Red', 'Army Painter', '#ED1C24', 'Base'),
    ('Royal Blue', 'Army Painter', '#4169E1', 'Base'),
    ('Moon Dust', 'Army Painter', '#E5E4E2', 'Layer'),
    ('Spaceship Exterior', 'Army Painter', '#36454F', 'Base'),
    ('Brainmatter Beige', 'Army Painter', '#C9A9A6', 'Base'),
    ('Glistening Blood', 'Army Painter', '#8B0000', 'Technical'),
    ('Toxic Boils', 'Army Painter', '#9ACD32', 'Technical'),
    ('Hydra Turquoise', 'Army Painter', '#00CED1', 'Layer'),
    ('Scaly Hide', 'Army Painter', '#4B5320', 'Base'),
    ('Dirt Spatter', 'Army Painter', '#8B7355', 'Technical'),
    ('Arid Earth', 'Army Painter', '#D2B48C', 'Base'),
    ('Filthy Cape', 'Army Painter', '#483C32', 'Base'),
    ('Zombie Shader', 'Army Painter', '#556B2F', 'Shade'),
    ('Blue Tone', 'Army Painter', '#4169E1', 'Shade'),
    ('Red Tone', 'Army Painter', '#8B0000', 'Shade'),
    ('Green Tone', 'Army Painter', '#228B22', 'Shade'),
    ('Purple Tone', 'Army Painter', '#800080', 'Shade'),

    -- AK Interactive Metallics (Extended)
    ('Steel', 'AK Interactive', '#B0C4DE', 'Metallic'),
    ('Brass', 'AK Interactive', '#B5A642', 'Metallic'),
    ('Dark Steel', 'AK Interactive', '#4C4C4C', 'Metallic'),
    ('Chrome', 'AK Interactive', '#E5E4E2', 'Metallic'),
    ('Iron', 'AK Interactive', '#808080', 'Metallic'),
    ('Old Brass', 'AK Interactive', '#8B7355', 'Metallic'),
    ('Burnt Metal', 'AK Interactive', '#6E4B26', 'Metallic'),

    -- Army Painter Warband Metallics (Extended)
    ('Dark Silver', 'Army Painter', '#696969', 'Metallic'),
    ('Shining Silver', 'Army Painter', '#E8E8E8', 'Metallic'),
    ('Gun Metal', 'Army Painter', '#2C3539', 'Metallic'),
    ('Rough Iron', 'Army Painter', '#5C5C5C', 'Metallic')
)
INSERT INTO miniatures.cl_paints (name, manufacturer, color_hex, paint_type)
SELECT pd.paint_name, pd.manufacturer_name, pd.color_hex, pd.paint_type
FROM paints_data pd
ON CONFLICT (name, manufacturer) DO UPDATE SET
    color_hex = EXCLUDED.color_hex,
    paint_type = EXCLUDED.paint_type;
