-- Part 1: 530849

local file = io.open( "../dec3.input", "r" )
if file then
    local content = file:read("*a")
    local lines = 1;
    local column = 0;

    local idx = 1

    local symbols = "!\"#$%&'()*+,-/:;<=>?@[]\\^_`{|}~"

    local covered = {}
    covered[lines - 1] = {}
    covered[lines] = {}
    covered[lines + 1] = {}

    local line_len = 0

    while idx <= #content do
        local char = content:sub(idx, idx)
        if char == "\n" then
            lines = lines + 1
            line_len = column
            column = 0
            covered[lines + 1] = {}
        else
            column = column + 1
        end
        if string.find(symbols, char, 1, true) then
            print(lines, column, char)
            covered[lines - 1][column - 1] = true
            covered[lines - 1][column] = true
            covered[lines - 1][column + 1] = true
            covered[lines][column + 1] = true
            covered[lines][column] = true
            covered[lines][column - 1] = true
            covered[lines + 1][column + 1] = true
            covered[lines + 1][column] = true
            covered[lines + 1][column - 1] = true
        end
        idx = idx + 1
    end

    local sum = 0
    print("-----------")

    local line_nr = 0
    for line in content:gmatch("[^\n]+") do
        line_nr = line_nr + 1
        local offset = 0
        while true do
            local startPos, endPos = line:find("[0-9]+", offset)
            if not startPos then
                break
            end
            if not endPos then
                endPos = line_len - 1
            end

            local numstr = line:sub(startPos, endPos)
            local number = tonumber(numstr)
            --print("start", number, offset, startPos)
            local match_len = endPos - startPos + 1
            --print(offset, ":", line:sub(offset))
            for i = 0, match_len-1 do
                --print("--", startPos + i)
                if covered[line_nr][startPos + i] then
                    sum = sum + number
                    print(number)
                    break
                end
            end
            offset = match_len + startPos
            --print("new offset: ", offset)
        end
    end

    print("Part 1:", sum)

    file:close()
else
    print("Error opening the file.")
end