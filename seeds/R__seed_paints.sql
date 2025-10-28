-- Seed miniature paints

WITH paints_data(paint_name, manufacturer_name, color_hex) AS (
    VALUES
    -- AK Interactive Basics
    ('White', 'AK Interactive', '#FFFFFF'),
    ('Black', 'AK Interactive', '#000000'),
    ('Grey', 'AK Interactive', '#808080'),
    ('Light Grey', 'AK Interactive', '#C0C0C0'),
    ('Dark Grey', 'AK Interactive', '#404040'),

    -- AK Interactive Reds
    ('Red', 'AK Interactive', '#C1272D'),
    ('Dark Red', 'AK Interactive', '#8B0000'),
    ('Burnt Red', 'AK Interactive', '#A52A2A'),

    -- AK Interactive Blues
    ('Blue', 'AK Interactive', '#0047AB'),
    ('Dark Blue', 'AK Interactive', '#00008B'),
    ('Light Blue', 'AK Interactive', '#87CEEB'),
    ('Sky Blue', 'AK Interactive', '#87CEEB'),

    -- AK Interactive Greens
    ('Green', 'AK Interactive', '#228B22'),
    ('Dark Green', 'AK Interactive', '#006400'),
    ('Olive Green', 'AK Interactive', '#556B2F'),

    -- AK Interactive Yellows/Oranges
    ('Yellow', 'AK Interactive', '#FFFF00'),
    ('Dark Yellow', 'AK Interactive', '#FFB300'),
    ('Orange', 'AK Interactive', '#FF8C00'),

    -- AK Interactive Browns/Earth Tones
    ('Brown', 'AK Interactive', '#8B4513'),
    ('Dark Brown', 'AK Interactive', '#654321'),
    ('Leather Brown', 'AK Interactive', '#8B4513'),
    ('Flat Earth', 'AK Interactive', '#8B7355'),

    -- AK Interactive Flesh Tones
    ('Pale Flesh', 'AK Interactive', '#F5DEB3'),
    ('Basic Flesh', 'AK Interactive', '#E0AC69'),
    ('Dark Flesh', 'AK Interactive', '#CD853F'),

    -- AK Interactive Metallics
    ('Silver', 'AK Interactive', '#C0C0C0'),
    ('Gold', 'AK Interactive', '#FFD700'),
    ('Bronze', 'AK Interactive', '#CD7F32'),
    ('Copper', 'AK Interactive', '#B87333'),
    ('Gunmetal', 'AK Interactive', '#2C3539'),

    -- Army Painter Warband Core Colors
    ('Fog Grey', 'Army Painter', '#D3D3D3'),
    ('Drake Tooth', 'Army Painter', '#F5E6D3'),
    ('Dungeon Grey', 'Army Painter', '#696969'),
    ('Hardened Carapace', 'Army Painter', '#2F4F4F'),
    ('Necrotic Flesh', 'Army Painter', '#8B8B7A'),
    ('Wasteland Soil', 'Army Painter', '#8B7355'),

    -- Army Painter Warband Reds/Oranges
    ('Plasma Coil Glow', 'Army Painter', '#FF6347'),
    ('Lava Orange', 'Army Painter', '#FF4500'),

    -- Army Painter Warband Blues/Purples
    ('Deep Blue', 'Army Painter', '#000080'),
    ('Electric Blue', 'Army Painter', '#7DF9FF'),
    ('Alien Purple', 'Army Painter', '#8B00FF'),

    -- Army Painter Warband Greens
    ('Mutation Green', 'Army Painter', '#32CD32'),
    ('Venom', 'Army Painter', '#ADFF2F'),
    ('Crusted Sore', 'Army Painter', '#556B2F'),

    -- Army Painter Warband Metallics
    ('Plate Mail Metal', 'Army Painter', '#B8B8B8'),
    ('Greedy Gold', 'Army Painter', '#FFD700'),
    ('Weapon Bronze', 'Army Painter', '#CD7F32'),

    -- Army Painter Warband Washes/Shades
    ('Dark Tone', 'Army Painter', '#000000'),
    ('Strong Tone', 'Army Painter', '#8B4513'),
    ('Soft Tone', 'Army Painter', '#D2B48C'),
    ('Military Shader', 'Army Painter', '#556B2F'),

    -- AK Interactive Real Colors (Additional)
    ('Ivory', 'AK Interactive', '#FFFFF0'),
    ('Cream', 'AK Interactive', '#FFFDD0'),
    ('Buff', 'AK Interactive', '#F0DC82'),
    ('Sand Yellow', 'AK Interactive', '#FCE883'),
    ('Desert Yellow', 'AK Interactive', '#EDC9AF'),
    ('Ochre', 'AK Interactive', '#CC7722'),
    ('Rust', 'AK Interactive', '#B7410E'),
    ('Bright Red', 'AK Interactive', '#FF0000'),
    ('Scarlet', 'AK Interactive', '#FF2400'),
    ('Deep Red', 'AK Interactive', '#850101'),
    ('Pink', 'AK Interactive', '#FFC0CB'),
    ('Purple', 'AK Interactive', '#800080'),
    ('Violet', 'AK Interactive', '#8F00FF'),
    ('Navy Blue', 'AK Interactive', '#000080'),
    ('Prussian Blue', 'AK Interactive', '#003153'),
    ('Turquoise', 'AK Interactive', '#40E0D0'),
    ('Cyan', 'AK Interactive', '#00FFFF'),
    ('Bright Green', 'AK Interactive', '#00FF00'),
    ('Lime Green', 'AK Interactive', '#32CD32'),
    ('Forest Green', 'AK Interactive', '#228B22'),
    ('Camouflage Green', 'AK Interactive', '#78866B'),
    ('Sea Green', 'AK Interactive', '#2E8B57'),

    -- AK Interactive Weathering/Effects
    ('Rust Streaks', 'AK Interactive', '#8B4513'),
    ('Dark Wash', 'AK Interactive', '#1A1A1A'),
    ('Brown Wash', 'AK Interactive', '#654321'),
    ('Green Wash', 'AK Interactive', '#2F4F2F'),
    ('Blue Wash', 'AK Interactive', '#191970'),

    -- Army Painter Warband Additional Colors
    ('Pure Red', 'Army Painter', '#ED1C24'),
    ('Royal Blue', 'Army Painter', '#4169E1'),
    ('Moon Dust', 'Army Painter', '#E5E4E2'),
    ('Spaceship Exterior', 'Army Painter', '#36454F'),
    ('Brainmatter Beige', 'Army Painter', '#C9A9A6'),
    ('Glistening Blood', 'Army Painter', '#8B0000'),
    ('Toxic Boils', 'Army Painter', '#9ACD32'),
    ('Hydra Turquoise', 'Army Painter', '#00CED1'),
    ('Scaly Hide', 'Army Painter', '#4B5320'),
    ('Dirt Spatter', 'Army Painter', '#8B7355'),
    ('Arid Earth', 'Army Painter', '#D2B48C'),
    ('Filthy Cape', 'Army Painter', '#483C32'),
    ('Zombie Shader', 'Army Painter', '#556B2F'),
    ('Blue Tone', 'Army Painter', '#4169E1'),
    ('Red Tone', 'Army Painter', '#8B0000'),
    ('Green Tone', 'Army Painter', '#228B22'),
    ('Purple Tone', 'Army Painter', '#800080'),

    -- AK Interactive Metallics (Extended)
    ('Steel', 'AK Interactive', '#B0C4DE'),
    ('Brass', 'AK Interactive', '#B5A642'),
    ('Dark Steel', 'AK Interactive', '#4C4C4C'),
    ('Chrome', 'AK Interactive', '#E5E4E2'),
    ('Iron', 'AK Interactive', '#808080'),
    ('Old Brass', 'AK Interactive', '#8B7355'),
    ('Burnt Metal', 'AK Interactive', '#6E4B26'),

    -- Army Painter Warband Metallics (Extended)
    ('Dark Silver', 'Army Painter', '#696969'),
    ('Shining Silver', 'Army Painter', '#E8E8E8'),
    ('Gun Metal', 'Army Painter', '#2C3539'),
    ('Rough Iron', 'Army Painter', '#5C5C5C')
)
INSERT INTO miniatures.cl_paints (name, manufacturer, color_hex)
SELECT pd.paint_name, pd.manufacturer_name, pd.color_hex
FROM paints_data pd
ON CONFLICT (name, manufacturer) DO UPDATE SET
    color_hex = EXCLUDED.color_hex;
