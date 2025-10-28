-- Seed miniature projects data

WITH theme_lookup AS (
    SELECT id, name FROM miniatures.miniature_themes
),
projects_data(
    project_title, project_description, completed_date, scale_size, manufacturer_name,
    time_spent_hours, difficulty_level, theme_name, display_order
) AS (
    VALUES
    -- Stormlight Archive projects
    ('Kaladin Stormblessed', 'Bridge Four captain painted with weathered blue uniform and spear. Used NMM techniques for the spear blade and OSL for the Stormlight glow effect.', DATE '2024-01-15', '32mm', 'Custom 3D Print', 15.5, 'Advanced', 'Stormlight Archive', 1),
    ('Shallan Davar', 'Lightweaver scholar with intricate pattern details on her safehand sleeve. Freehand work on the sketchbook pages.', DATE '2024-02-20', '32mm', 'Custom 3D Print', 12.0, 'Intermediate', 'Stormlight Archive', 2),
    ('Dalinar Kholin', 'Blackthorn in full Shardplate armor. Extensive NMM work and battle damage weathering.', DATE '2023-12-10', '32mm', 'Custom 3D Print', 20.0, 'Expert', 'Stormlight Archive', 3),

    -- Warhammer 40k projects
    ('Primaris Space Marine Captain', 'Ultramarine captain with power sword and plasma pistol. Edge highlighting and battle damage effects.', DATE '2023-11-05', '28mm', 'Games Workshop', 8.5, 'Intermediate', 'Warhammer 40,000', 1),
    ('Necron Overlord', 'Sautekh Dynasty overlord with glowing green energy effects using OSL techniques.', DATE '2023-10-12', '28mm', 'Games Workshop', 10.0, 'Advanced', 'Warhammer 40,000', 2),
    ('Ork Warboss', 'Big bad ork with extensive weathering, rust, and dirt effects. Emphasis on skin tone blending.', DATE '2023-09-20', '28mm', 'Games Workshop', 12.5, 'Intermediate', 'Warhammer 40,000', 3),

    -- Fantasy Heroes projects
    ('Dwarf Warrior', 'Classic dwarf fighter with chainmail armor and battle axe. Practiced TMM (True Metallic Metal) techniques.', DATE '2023-08-15', '32mm', 'Reaper Miniatures', 6.0, 'Beginner', 'Fantasy Heroes', 1),
    ('Elven Mage', 'High elf wizard with flowing robes and magical staff. Color modulation on the robes and OSL on the staff crystal.', DATE '2023-07-22', '32mm', 'Reaper Miniatures', 9.5, 'Advanced', 'Fantasy Heroes', 2),
    ('Human Paladin', 'Noble paladin in shining plate armor with holy symbol shield. Extensive NMM gold work.', DATE '2023-06-30', '32mm', 'Reaper Miniatures', 11.0, 'Advanced', 'Fantasy Heroes', 3),

    -- Sci-Fi Collection
    ('Cyberpunk Mercenary', 'Futuristic soldier with tactical gear and cybernetic enhancements. OSL from visor and weapon.', DATE '2023-05-18', '35mm', 'Infinity', 7.5, 'Intermediate', 'Sci-Fi Collection', 1),
    ('Alien Xenomorph', 'Biomechanical alien creature with wet blending for the carapace shine effect.', DATE '2023-04-25', '40mm', 'Prodos Games', 8.0, 'Intermediate', 'Sci-Fi Collection', 2),

    -- Historical Miniatures
    ('Roman Centurion', 'Historically accurate Roman officer with detailed armor and weathered leather.', DATE '2023-03-12', '28mm', 'Warlord Games', 7.0, 'Intermediate', 'Historical Miniatures', 1),
    ('Medieval Knight', 'Late medieval knight in full plate armor. Practiced heraldry freehand on the shield.', DATE '2023-02-08', '28mm', 'Perry Miniatures', 9.0, 'Advanced', 'Historical Miniatures', 2),

    -- Terrain & Dioramas
    ('Ruined Temple Base', 'Scenic base with crumbling stone pillars and overgrown vegetation. Weathering and pigment work.', DATE '2023-01-20', 'Multiple', 'Scratch Built', 15.0, 'Intermediate', 'Terrain & Dioramas', 1),
    ('Sci-Fi Industrial Platform', 'Industrial walkway with rusted metal, hazard stripes, and OSL from control panels.', DATE '2022-12-15', 'Multiple', 'Scratch Built', 18.0, 'Advanced', 'Terrain & Dioramas', 2)
)
INSERT INTO miniatures.miniature_projects (
    title, description, completed_date, scale, manufacturer,
    time_spent, difficulty, theme_id, display_order
)
SELECT
    pd.project_title, pd.project_description, pd.completed_date, pd.scale_size, pd.manufacturer_name,
    pd.time_spent_hours, pd.difficulty_level, tl.id, pd.display_order
FROM projects_data pd
LEFT JOIN theme_lookup tl ON pd.theme_name = tl.name
ON CONFLICT (title) DO UPDATE SET
    description = EXCLUDED.description,
    completed_date = EXCLUDED.completed_date,
    scale = EXCLUDED.scale,
    manufacturer = EXCLUDED.manufacturer,
    time_spent = EXCLUDED.time_spent,
    difficulty = EXCLUDED.difficulty,
    theme_id = EXCLUDED.theme_id,
    display_order = EXCLUDED.display_order;
