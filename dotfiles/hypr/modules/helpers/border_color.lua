local M = {}

function M.getBorderColor(first_color, second_color, angle_val)
    return { colors = { first_color, second_color }, angle = angle_val }
end

-- TODO:refactor later
function M.setBorderColor(left, right)
    local accent_color = "rgba(723ec3ff)"
    local default_color = "rgba(595959aa)"
    local border_angle = "180"
    local none_rule = function()
        hl.config({
            general = {
                col = {
                    active_border = M.getBorderColor(default_color, default_color, border_angle),
                    inactive_border = M.getBorderColor(default_color, default_color, border_angle),
                }
            }
        })
    end

    local left_rule = function()
        hl.config({
            general = {
                col = {
                    active_border = M.getBorderColor(default_color, accent_color, border_angle),
                    inactive_border = M.getBorderColor(default_color, default_color, border_angle),
                }
            }
        })
    end

    local right_rule = function()
        hl.config({
            general = {
                col = {
                    active_border = M.getBorderColor(accent_color, default_color, border_angle),
                    inactive_border = M.getBorderColor(default_color, default_color, border_angle),
                }
            }
        })
    end

    local both_rule = function()
        hl.config({
            general = {
                col = {
                    active_border = M.getBorderColor(accent_color, accent_color, border_angle),
                    inactive_border = M.getBorderColor(default_color, default_color, border_angle),
                }
            }
        })
    end

    if left == true and right == true then
        both_rule()
    elseif left == false and right == true then
        right_rule()
    elseif left == true and right == false then
        left_rule()
    elseif left == false and right == false then
        none_rule()
    end
end

function M.EvaluateBorderColor()
    local hasLeftNeighbor = false
    local hasRightNeighbor = false
    local active_window_x = 0

    local active_window = hl.get_active_window()
    if active_window ~= nil then
        active_window_x = active_window.at.x
    end

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

return M
