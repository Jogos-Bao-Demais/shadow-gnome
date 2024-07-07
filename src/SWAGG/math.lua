local SWAGG_math = {}

---@param start_v number
---@param end_v number
---@param percent number
---@return number
function SWAGG_math.lerp(start_v, end_v, percent)
    return start_v + (end_v - start_v) * percent
end

return SWAGG_math
