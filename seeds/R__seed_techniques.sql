-- Seed miniature painting techniques
INSERT INTO miniatures.cl_techniques (name, description, difficulty_level, display_order)
VALUES
    ('Basecoating', 'Applying the first layer of paint to establish base colors', 'Beginner', 1),
    ('Drybrushing', 'Technique using a nearly dry brush to highlight raised surfaces', 'Beginner', 2),
    ('Washing', 'Applying thinned paint to flow into recesses for shading', 'Beginner', 3),
    ('Edge Highlighting', 'Painting fine lines along edges to create definition', 'Beginner', 4),
    ('Layering', 'Building up multiple thin coats to create smooth transitions', 'Intermediate', 5),
    ('Glazing', 'Applying very thin, translucent layers to adjust colors', 'Intermediate', 6),
    ('Wet Blending', 'Blending colors while paint is still wet on the model', 'Intermediate', 7),
    ('Stippling', 'Creating texture by applying paint with a dabbing motion', 'Intermediate', 8),
    ('Two Brush Blending', 'Using two brushes to blend colors smoothly', 'Intermediate', 9),
    ('Feathering', 'Creating soft transitions by dragging paint with light strokes', 'Intermediate', 10),
    ('Non-Metallic Metal (NMM)', 'Painting metallic effects using non-metallic paints', 'Advanced', 11),
    ('Object Source Lighting (OSL)', 'Simulating light sources on the miniature', 'Advanced', 12),
    ('Freehand', 'Painting detailed designs without stencils or transfers', 'Advanced', 13),
    ('Airbrushing', 'Using an airbrush for smooth gradients and priming', 'Advanced', 14),
    ('Zenithal Highlighting', 'Priming technique simulating overhead lighting', 'Intermediate', 15),
    ('Color Modulation', 'Varying color saturation and tone across surfaces', 'Advanced', 16),
    ('Weathering', 'Adding effects like rust, dirt, and wear', 'Intermediate', 17),
    ('Chipping', 'Creating paint damage and wear effects', 'Intermediate', 18),
    ('Pigment Weathering', 'Using dry pigments for dust and weathering effects', 'Intermediate', 19),
    ('Sponge Weathering', 'Using a sponge to create textured weathering effects', 'Beginner', 20)
ON CONFLICT (name) DO UPDATE SET
    description = EXCLUDED.description,
    difficulty_level = EXCLUDED.difficulty_level,
    display_order = EXCLUDED.display_order;
