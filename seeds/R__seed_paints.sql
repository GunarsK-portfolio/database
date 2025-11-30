-- Seed miniature paints
-- Paint catalog for AK Interactive 3GEN and Army Painter Warpaints Fanatic

WITH paints_data(paint_name, manufacturer_name, color_hex, paint_type) AS (
    VALUES
    -- ============================================
    -- AK INTERACTIVE 3rd GENERATION ACRYLICS
    -- ============================================
    ('AK11081 Fluorescent Orange', 'AK Interactive', '#FF6600', 'Layer'),
    ('AK11049 Fluorescent Yellow', 'AK Interactive', '#CCFF00', 'Layer'),
    ('AK11035 Sand Yellow', 'AK Interactive', '#C2A355', 'Base'),
    ('AK11046 Radiant Yellow', 'AK Interactive', '#FFEA00', 'Layer'),
    ('AK11088 Deep Red', 'AK Interactive', '#850101', 'Base'),
    ('AK11067 Magenta', 'AK Interactive', '#FF0090', 'Base'),
    ('AK11072 Deep Violet', 'AK Interactive', '#5A189A', 'Base'),
    ('AK11061 Salmon', 'AK Interactive', '#FA8072', 'Layer'),
    ('AK11176 Deep Sky Blue', 'AK Interactive', '#00BFFF', 'Layer'),
    ('AK11179 Ultramarine', 'AK Interactive', '#4166F5', 'Base'),
    ('AK11133 Dark Green Grey', 'AK Interactive', '#4A5D4A', 'Base'),
    ('AK11140 Grass Green', 'AK Interactive', '#7CFC00', 'Layer'),
    ('AK11142 Deep Green', 'AK Interactive', '#004D00', 'Base'),
    ('AK11029 Black', 'AK Interactive', '#000000', 'Base'),
    ('AK11006 Silver Grey', 'AK Interactive', '#C4C4C4', 'Layer'),
    ('AK11019 Graphite', 'AK Interactive', '#383838', 'Base'),
    ('AK11001 White', 'AK Interactive', '#FFFFFF', 'Base'),
    ('AK11167 Anthracite Grey', 'AK Interactive', '#3D3D3D', 'Base'),
    ('AK11173 Ocean Blue', 'AK Interactive', '#006994', 'Base'),
    ('AK11078 Medium Orange', 'AK Interactive', '#FF8C00', 'Base'),
    ('AK11115 Light Earth', 'AK Interactive', '#C4A57B', 'Layer'),
    ('AK11102 Deep Brown', 'AK Interactive', '#4A2C2A', 'Base'),
    ('AK11110 Leather Brown', 'AK Interactive', '#8B4513', 'Base'),
    ('AK11405 Dark Shadow Flesh', 'AK Interactive', '#8B6355', 'Shade'),
    ('AK11401 Base Flesh', 'AK Interactive', '#E0AC69', 'Base'),
    ('AK11404 Shadow Flesh', 'AK Interactive', '#C48B6D', 'Shade'),
    ('AK11402 Light Flesh', 'AK Interactive', '#F5DEB3', 'Layer'),
    ('AK11403 Highlight Flesh', 'AK Interactive', '#FFE4C4', 'Layer'),
    ('AK11406 Reddish Black', 'AK Interactive', '#2B1B17', 'Shade'),
    ('AK11208 Dark Aluminium', 'AK Interactive', '#A9A9A9', 'Metallic'),
    ('AK11118 Ochre', 'AK Interactive', '#CC7722', 'Base'),
    ('AK11212 Gun Metal', 'AK Interactive', '#2C3539', 'Metallic'),
    ('AK11210 Natural Steel', 'AK Interactive', '#71797E', 'Metallic'),
    ('AK11193 Rusty Gold', 'AK Interactive', '#B8860B', 'Metallic'),
    ('AK11198 Burnt Tin', 'AK Interactive', '#6B4E31', 'Metallic'),
    ('AK11191 Gold', 'AK Interactive', '#FFD700', 'Metallic'),
    -- Primers & Varnishes
    ('AK11252 Ultra Matt Varnish', 'AK Interactive', NULL, 'Technical'),
    ('AK11242 Black Primer', 'AK Interactive', '#000000', 'Primer'),
    ('AK11241 Grey Primer', 'AK Interactive', '#808080', 'Primer'),
    -- Specialty Bottles
    ('AK11268 Oxidized Bronze', 'AK Interactive', '#4A9A8A', 'Technical'),
    ('AK472 Xtreme Metal Bronze', 'AK Interactive', '#CD7F32', 'Metallic'),
    ('AK11265 Xtreme Metal Iron', 'AK Interactive', '#434B4D', 'Metallic'),

    -- ============================================
    -- ARMY PAINTER WARPAINTS FANATIC
    -- ============================================

    -- Most Wanted Set (WP8071) - 22 paints
    ('Night Sky', 'Army Painter', '#1A1F3A', 'Base'),
    ('Uniform Grey', 'Army Painter', '#5E6A73', 'Base'),
    ('Skeleton Bone', 'Army Painter', '#D3C89D', 'Layer'),
    ('Brainmatter Beige', 'Army Painter', '#F1F0E0', 'Layer'),
    ('Dragon Red', 'Army Painter', '#9A1B1E', 'Base'),
    ('Basilisk Red', 'Army Painter', '#7A2A1A', 'Base'),
    ('Talisman Teal', 'Army Painter', '#4A9A8A', 'Layer'),
    ('Wild Green', 'Army Painter', '#3A6A4A', 'Layer'),
    ('Olive Drab', 'Army Painter', '#5A6A3A', 'Base'),
    ('Warped Yellow', 'Army Painter', '#EACA2A', 'Layer'),
    ('Burning Ore', 'Army Painter', '#DA5A2A', 'Base'),
    ('Warlock Magenta', 'Army Painter', '#AA5A9A', 'Layer'),
    ('Cultist Purple', 'Army Painter', '#5A3A7A', 'Base'),
    ('Baron Blue', 'Army Painter', '#5A7AAA', 'Layer'),
    ('Jasper Skin', 'Army Painter', '#A06040', 'Base'),
    ('Onyx Skin', 'Army Painter', '#402010', 'Base'),
    ('Dark Skin Shade', 'Army Painter', '#4A2A2A', 'Wash'),
    ('True Copper', 'Army Painter', '#DA8A5A', 'Metallic'),
    ('Gun Metal', 'Army Painter', '#2C3539', 'Metallic'),
    ('Disgusting Slime', 'Army Painter', '#8ACA3A', 'Technical'),
    ('Dry Blood', 'Army Painter', '#5A1A1A', 'Technical'),
    ('Brush-On Primer', 'Army Painter', NULL, 'Technical'),

    -- Washes Paint Set (WP8068) - 10 washes
    ('Dark Tone', 'Army Painter', '#1A1A1A', 'Wash'),
    ('Strong Tone', 'Army Painter', '#5A4A3A', 'Wash'),
    ('Soft Tone', 'Army Painter', '#8A7A6A', 'Wash'),
    ('Light Tone', 'Army Painter', '#BAAAA0', 'Wash'),
    ('Sepia Tone', 'Army Painter', '#6A5A4A', 'Wash'),
    ('Dark Red Tone', 'Army Painter', '#4A1A1A', 'Wash'),
    ('Military Shade', 'Army Painter', '#4A5A3A', 'Wash'),
    ('Dark Blue Tone', 'Army Painter', '#1A2A4A', 'Wash'),
    ('Purple Tone', 'Army Painter', '#4A2A5A', 'Wash'),
    ('Strong Skin Shade', 'Army Painter', '#6A4A4A', 'Wash'),

    -- ============================================
    -- ARMY PAINTER STORMLIGHT PAINT SET
    -- ============================================

    -- Stormlight Set - 11 Themed Colors
    ('Stormlight Blue', 'Army Painter', '#5AAACA', 'Base'),
    ('Kholin Blue', 'Army Painter', '#1A4A8A', 'Base'),
    ('Parshendi Red', 'Army Painter', '#8A2A2A', 'Base'),
    ('Shardplate Silver', 'Army Painter', '#C0C8D0', 'Metallic'),
    ('Highstorm Grey', 'Army Painter', '#6A7A8A', 'Base'),
    ('Rosharan Stone', 'Army Painter', '#9A8A7A', 'Base'),
    ('Chasmfiend Chitin', 'Army Painter', '#3A4A3A', 'Base'),
    ('Spherelight Gold', 'Army Painter', '#EACA3A', 'Metallic'),
    ('Voidbringer Purple', 'Army Painter', '#4A2A5A', 'Base'),
    ('Cremling Brown', 'Army Painter', '#6A5040', 'Base'),
    ('Everstorm Black', 'Army Painter', '#1A1A2A', 'Base'),

    -- ============================================
    -- MONUMENT HOBBIES PRO ACRYL
    -- Signature Series Set 5 - Flameon Miniatures
    -- (Gold NMM palette - warm ochre tones)
    -- ============================================
    ('Bright Pale Yellow', 'Monument Hobbies', '#FFF4D6', 'Layer'),
    ('Bright Yellow Ochre', 'Monument Hobbies', '#E6B84D', 'Layer'),
    ('Caramel Brown', 'Monument Hobbies', '#A67B4A', 'Base'),
    ('Orange Brown', 'Monument Hobbies', '#B5652A', 'Base'),
    ('Dark Orange Brown', 'Monument Hobbies', '#7A4420', 'Base'),
    ('Dark Green Brown', 'Monument Hobbies', '#4A4A30', 'Shade')
)
INSERT INTO miniatures.cl_paints (name, manufacturer, color_hex, paint_type)
SELECT pd.paint_name, pd.manufacturer_name, pd.color_hex, pd.paint_type
FROM paints_data pd
ON CONFLICT (name, manufacturer) DO UPDATE SET
    color_hex = EXCLUDED.color_hex,
    paint_type = EXCLUDED.paint_type;
