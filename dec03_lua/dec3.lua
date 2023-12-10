function Part1()
    local file = io.open( "../inputs/dec3.input", "r" )
    if not file then error("") end
    local content = file:read("*a")
    file:close()

    -- Prep
    local symbols = "!\"#$%&'()*+,-/:;<=>?@[]\\^_`{|}~"
    local covered = {}
    local line_len = content:find("[\n]")
    for idx = 1, #content do
        local char = content:sub(idx, idx)
        if string.find(symbols, char, 1, true) then
            local line = math.floor(idx / line_len) * line_len
            local col = idx % line_len
            covered[line - line_len  + col - 1] = true
            covered[line - line_len  + col] = true
            covered[line - line_len  + col + 1] = true
            covered[line +  col + 1] = true
            covered[line +  col] = true
            covered[line +  col - 1] = true
            covered[line + line_len  + col + 1] = true
            covered[line + line_len  + col] = true
            covered[line + line_len  + col - 1] = true
        end
    end

    -- Calc
    local sum = 0
    local idx = 1
    while idx < #content do
        local startPos, endPos = content:find("[0-9]+", idx)
        if not startPos then break end
        if not endPos then
            endPos = line_len - 1
        end

        local numstr = content:sub(startPos, endPos)
        local number = tonumber(numstr)
        for j = startPos, endPos do
            if covered[j] then
                sum = sum + number
                break
            end
        end
        idx = endPos + 1
    end

    print("Part 1:", sum)
end

function Part2()
    local file = io.open( "../inputs/dec3.input", "r" )
    if not file then error("") end
    local content = file:read("*a")
    file:close()

    -- Prep
    local covered = {}
    local line_len = content:find("[\n]")
    for idx = 1, #content do
        local char = content:sub(idx, idx)
        if char == "*" then
            local line = math.floor(idx / line_len) * line_len
            local col = idx % line_len
            covered[line - line_len  + col - 1] = idx
            covered[line - line_len  + col] = idx
            covered[line - line_len  + col + 1] = idx
            covered[line +  col + 1] = idx
            covered[line +  col] = idx
            covered[line +  col - 1] = idx
            covered[line + line_len  + col + 1] = idx
            covered[line + line_len  + col] = idx
            covered[line + line_len  + col - 1] = idx
        end
    end

    -- Calc
    local sum = 0
    local idx = 1
    local gears = {}
    while idx < #content do
        local startPos, endPos = content:find("[0-9]+", idx)
        if not startPos then break end
        if not endPos then
            endPos = line_len - 1
        end

        local numstr = content:sub(startPos, endPos)
        local number = tonumber(numstr)
        for j = startPos, endPos do
            local gear = covered[j]
            if gear then
                local lookup = gears[gear]
                if lookup then
                    sum = sum + lookup * number
                else
                    gears[gear] = number
                end
                break
            end
        end
        idx = endPos + 1
    end

    print("Part 2:", sum)
end

Part1()
Part2()