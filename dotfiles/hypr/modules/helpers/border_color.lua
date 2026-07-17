local M = {}
M.accent_color = "rgba(723ec3ff)"
M.default_color = "rgba(595959aa)"
M.border_angle = "0"

function M.getBorderColor(first_color, second_color, angle_val)
    return { colors = { first_color, second_color }, angle = angle_val }
end

function M.setBorderColor(left, right)
    local first_color = left and M.accent_color or M.default_color
    local second_color = right and M.accent_color or M.default_color

    local border_rule = function()
        hl.config({
            general = {
                col = {
                    active_border = M.getBorderColor(first_color, second_color, M.border_angle),
                }
            }
        })
    end

    border_rule()
end

function M.EvaluateBorderColor()
    local hasLeftNeighbor = false
    local hasRightNeighbor = false
    local active_window_x = 0

    local active_window = hl.get_active_window()
    if active_window ~= nil then
        active_window_x = active_window.at.x

        local active_workspace = hl.get_active_workspace()
        if active_workspace ~= nil then
            local windows = active_workspace:get_windows()

            for _, val in pairs(windows) do
                if val.at.x < active_window_x then
                    hasLeftNeighbor = true
                elseif val.at.x > active_window_x then
                    hasRightNeighbor = true
                end
            end

            M.setBorderColor(hasLeftNeighbor, hasRightNeighbor)
        end
    end
end

return M
