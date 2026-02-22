require 'cairo'

function conky_draw_bg()
    if conky_window == nil then return end

    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height
    )
    local cr = cairo_create(cs)

    local x, y = 0, 0
    local w, h = conky_window.width, conky_window.height
    local r = 18  -- corner radius

    -- rounded rectangle path
    cairo_move_to(cr, x + r, y)
    cairo_line_to(cr, x + w - r, y)
    cairo_arc(cr, x + w - r, y + r,     r, -math.pi / 2, 0)
    cairo_line_to(cr, x + w, y + h - r)
    cairo_arc(cr, x + w - r, y + h - r, r,  0,           math.pi / 2)
    cairo_line_to(cr, x + r, y + h)
    cairo_arc(cr, x + r,     y + h - r, r,  math.pi / 2, math.pi)
    cairo_line_to(cr, x, y + r)
    cairo_arc(cr, x + r,     y + r,     r,  math.pi,     3 * math.pi / 2)
    cairo_close_path(cr)

    -- 0a0a0f at ~35% opacity
    cairo_set_source_rgba(cr, 0.039, 0.039, 0.059, 0.35)
    cairo_fill(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end
