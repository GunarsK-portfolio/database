-- Seed miniature paints
-- Focus on AK Interactive and Army Painter Warband ranges

-- AK Interactive 3rd Generation Acrylics
INSERT INTO miniatures.cl_paints (name, manufacturer, color_hex, paint_type, finish)
VALUES
    -- AK Interactive Basics
    ('White', 'AK Interactive', '#FFFFFF', 'Acrylic', 'Matte'),
    ('Black', 'AK Interactive', '#000000', 'Acrylic', 'Matte'),
    ('Grey', 'AK Interactive', '#808080', 'Acrylic', 'Matte'),
    ('Light Grey', 'AK Interactive', '#C0C0C0', 'Acrylic', 'Matte'),
    ('Dark Grey', 'AK Interactive', '#404040', 'Acrylic', 'Matte'),

    -- AK Interactive Reds
    ('Red', 'AK Interactive', '#C1272D', 'Acrylic', 'Matte'),
    ('Dark Red', 'AK Interactive', '#8B0000', 'Acrylic', 'Matte'),
    ('Burnt Red', 'AK Interactive', '#A52A2A', 'Acrylic', 'Matte'),

    -- AK Interactive Blues
    ('Blue', 'AK Interactive', '#0047AB', 'Acrylic', 'Matte'),
    ('Dark Blue', 'AK Interactive', '#00008B', 'Acrylic', 'Matte'),
    ('Light Blue', 'AK Interactive', '#87CEEB', 'Acrylic', 'Matte'),
    ('Sky Blue', 'AK Interactive', '#87CEEB', 'Acrylic', 'Matte'),

    -- AK Interactive Greens
    ('Green', 'AK Interactive', '#228B22', 'Acrylic', 'Matte'),
    ('Dark Green', 'AK Interactive', '#006400', 'Acrylic', 'Matte'),
    ('Olive Green', 'AK Interactive', '#556B2F', 'Acrylic', 'Matte'),

    -- AK Interactive Yellows/Oranges
    ('Yellow', 'AK Interactive', '#FFFF00', 'Acrylic', 'Matte'),
    ('Dark Yellow', 'AK Interactive', '#FFB300', 'Acrylic', 'Matte'),
    ('Orange', 'AK Interactive', '#FF8C00', 'Acrylic', 'Matte'),

    -- AK Interactive Browns/Earth Tones
    ('Brown', 'AK Interactive', '#8B4513', 'Acrylic', 'Matte'),
    ('Dark Brown', 'AK Interactive', '#654321', 'Acrylic', 'Matte'),
    ('Leather Brown', 'AK Interactive', '#8B4513', 'Acrylic', 'Matte'),
    ('Flat Earth', 'AK Interactive', '#8B7355', 'Acrylic', 'Matte'),

    -- AK Interactive Flesh Tones
    ('Pale Flesh', 'AK Interactive', '#F5DEB3', 'Acrylic', 'Matte'),
    ('Basic Flesh', 'AK Interactive', '#E0AC69', 'Acrylic', 'Matte'),
    ('Dark Flesh', 'AK Interactive', '#CD853F', 'Acrylic', 'Matte'),

    -- AK Interactive Metallics
    ('Silver', 'AK Interactive', '#C0C0C0', 'Acrylic', 'Metallic'),
    ('Gold', 'AK Interactive', '#FFD700', 'Acrylic', 'Metallic'),
    ('Bronze', 'AK Interactive', '#CD7F32', 'Acrylic', 'Metallic'),
    ('Copper', 'AK Interactive', '#B87333', 'Acrylic', 'Metallic'),
    ('Gunmetal', 'AK Interactive', '#2C3539', 'Acrylic', 'Metallic'),

    -- Army Painter Warband Core Colors
    ('Fog Grey', 'Army Painter', '#D3D3D3', 'Acrylic', 'Matte'),
    ('Drake Tooth', 'Army Painter', '#F5E6D3', 'Acrylic', 'Matte'),
    ('Dungeon Grey', 'Army Painter', '#696969', 'Acrylic', 'Matte'),
    ('Hardened Carapace', 'Army Painter', '#2F4F4F', 'Acrylic', 'Matte'),
    ('Necrotic Flesh', 'Army Painter', '#8B8B7A', 'Acrylic', 'Matte'),
    ('Wasteland Soil', 'Army Painter', '#8B7355', 'Acrylic', 'Matte'),

    -- Army Painter Warband Reds/Oranges
    ('Plasma Coil Glow', 'Army Painter', '#FF6347', 'Acrylic', 'Matte'),
    ('Lava Orange', 'Army Painter', '#FF4500', 'Acrylic', 'Matte'),

    -- Army Painter Warband Blues/Purples
    ('Deep Blue', 'Army Painter', '#000080', 'Acrylic', 'Matte'),
    ('Electric Blue', 'Army Painter', '#7DF9FF', 'Acrylic', 'Matte'),
    ('Alien Purple', 'Army Painter', '#8B00FF', 'Acrylic', 'Matte'),

    -- Army Painter Warband Greens
    ('Mutation Green', 'Army Painter', '#32CD32', 'Acrylic', 'Matte'),
    ('Venom', 'Army Painter', '#ADFF2F', 'Acrylic', 'Matte'),
    ('Crusted Sore', 'Army Painter', '#556B2F', 'Acrylic', 'Matte'),

    -- Army Painter Warband Metallics
    ('Plate Mail Metal', 'Army Painter', '#B8B8B8', 'Acrylic', 'Metallic'),
    ('Greedy Gold', 'Army Painter', '#FFD700', 'Acrylic', 'Metallic'),
    ('Weapon Bronze', 'Army Painter', '#CD7F32', 'Acrylic', 'Metallic'),

    -- Army Painter Warband Washes/Shades
    ('Dark Tone', 'Army Painter', '#000000', 'Wash', 'Matte'),
    ('Strong Tone', 'Army Painter', '#8B4513', 'Wash', 'Matte'),
    ('Soft Tone', 'Army Painter', '#D2B48C', 'Wash', 'Matte'),
    ('Military Shader', 'Army Painter', '#556B2F', 'Wash', 'Matte'),

    -- AK Interactive Real Colors (Additional)
    ('Ivory', 'AK Interactive', '#FFFFF0', 'Acrylic', 'Matte'),
    ('Cream', 'AK Interactive', '#FFFDD0', 'Acrylic', 'Matte'),
    ('Buff', 'AK Interactive', '#F0DC82', 'Acrylic', 'Matte'),
    ('Sand Yellow', 'AK Interactive', '#FCE883', 'Acrylic', 'Matte'),
    ('Desert Yellow', 'AK Interactive', '#EDC9AF', 'Acrylic', 'Matte'),
    ('Ochre', 'AK Interactive', '#CC7722', 'Acrylic', 'Matte'),
    ('Rust', 'AK Interactive', '#B7410E', 'Acrylic', 'Matte'),
    ('Bright Red', 'AK Interactive', '#FF0000', 'Acrylic', 'Matte'),
    ('Scarlet', 'AK Interactive', '#FF2400', 'Acrylic', 'Matte'),
    ('Deep Red', 'AK Interactive', '#850101', 'Acrylic', 'Matte'),
    ('Pink', 'AK Interactive', '#FFC0CB', 'Acrylic', 'Matte'),
    ('Purple', 'AK Interactive', '#800080', 'Acrylic', 'Matte'),
    ('Violet', 'AK Interactive', '#8F00FF', 'Acrylic', 'Matte'),
    ('Navy Blue', 'AK Interactive', '#000080', 'Acrylic', 'Matte'),
    ('Prussian Blue', 'AK Interactive', '#003153', 'Acrylic', 'Matte'),
    ('Turquoise', 'AK Interactive', '#40E0D0', 'Acrylic', 'Matte'),
    ('Cyan', 'AK Interactive', '#00FFFF', 'Acrylic', 'Matte'),
    ('Bright Green', 'AK Interactive', '#00FF00', 'Acrylic', 'Matte'),
    ('Lime Green', 'AK Interactive', '#32CD32', 'Acrylic', 'Matte'),
    ('Forest Green', 'AK Interactive', '#228B22', 'Acrylic', 'Matte'),
    ('Camouflage Green', 'AK Interactive', '#78866B', 'Acrylic', 'Matte'),
    ('Sea Green', 'AK Interactive', '#2E8B57', 'Acrylic', 'Matte'),

    -- AK Interactive Weathering/Effects
    ('Rust Streaks', 'AK Interactive', '#8B4513', 'Wash', 'Matte'),
    ('Dark Wash', 'AK Interactive', '#1A1A1A', 'Wash', 'Matte'),
    ('Brown Wash', 'AK Interactive', '#654321', 'Wash', 'Matte'),
    ('Green Wash', 'AK Interactive', '#2F4F2F', 'Wash', 'Matte'),
    ('Blue Wash', 'AK Interactive', '#191970', 'Wash', 'Matte'),

    -- Army Painter Warband Additional Colors
    ('Pure Red', 'Army Painter', '#ED1C24', 'Acrylic', 'Matte'),
    ('Royal Blue', 'Army Painter', '#4169E1', 'Acrylic', 'Matte'),
    ('Moon Dust', 'Army Painter', '#E5E4E2', 'Acrylic', 'Matte'),
    ('Spaceship Exterior', 'Army Painter', '#36454F', 'Acrylic', 'Matte'),
    ('Brainmatter Beige', 'Army Painter', '#C9A9A6', 'Acrylic', 'Matte'),
    ('Glistening Blood', 'Army Painter', '#8B0000', 'Acrylic', 'Gloss'),
    ('Toxic Boils', 'Army Painter', '#9ACD32', 'Acrylic', 'Matte'),
    ('Hydra Turquoise', 'Army Parser', '#00CED1', 'Acrylic', 'Matte'),
    ('Scaly Hide', 'Army Painter', '#4B5320', 'Acrylic', 'Matte'),
    ('Dirt Spatter', 'Army Painter', '#8B7355', 'Acrylic', 'Matte'),
    ('Arid Earth', 'Army Painter', '#D2B48C', 'Acrylic', 'Matte'),
    ('Filthy Cape', 'Army Painter', '#483C32', 'Acrylic', 'Matte'),
    ('Zombie Shader', 'Army Painter', '#556B2F', 'Wash', 'Matte'),
    ('Blue Tone', 'Army Painter', '#4169E1', 'Wash', 'Matte'),
    ('Red Tone', 'Army Painter', '#8B0000', 'Wash', 'Matte'),
    ('Green Tone', 'Army Painter', '#228B22', 'Wash', 'Matte'),
    ('Purple Tone', 'Army Painter', '#800080', 'Wash', 'Matte'),

    -- AK Interactive Metallics (Extended)
    ('Steel', 'AK Interactive', '#B0C4DE', 'Acrylic', 'Metallic'),
    ('Brass', 'AK Interactive', '#B5A642', 'Acrylic', 'Metallic'),
    ('Dark Steel', 'AK Interactive', '#4C4C4C', 'Acrylic', 'Metallic'),
    ('Chrome', 'AK Interactive', '#E5E4E2', 'Acrylic', 'Metallic'),
    ('Iron', 'AK Interactive', '#808080', 'Acrylic', 'Metallic'),
    ('Old Brass', 'AK Interactive', '#8B7355', 'Acrylic', 'Metallic'),
    ('Burnt Metal', 'AK Interactive', '#6E4B26', 'Acrylic', 'Metallic'),

    -- Army Painter Warband Metallics (Extended)
    ('Dark Silver', 'Army Painter', '#696969', 'Acrylic', 'Metallic'),
    ('Shining Silver', 'Army Painter', '#E8E8E8', 'Acrylic', 'Metallic'),
    ('Gun Metal', 'Army Painter', '#2C3539', 'Acrylic', 'Metallic'),
    ('Rough Iron', 'Army Painter', '#5C5C5C', 'Acrylic', 'Metallic')

ON CONFLICT (name, manufacturer) DO UPDATE SET
    color_hex = EXCLUDED.color_hex,
    paint_type = EXCLUDED.paint_type,
    finish = EXCLUDED.finish;
