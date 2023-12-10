def part1()
    content = File.read('../inputs/dec4.input')
    sum = 0
    lines = content.lines.each do |line|
        rest = line.split(":")[1].strip()
        winning = line.split("|")[0].strip().split(" ")
        actual = line.split("|")[1].strip().split(" ")

        matches = (actual & winning).length
        sum += (2**(matches - 1)).to_i
    end
    print "Part1: #{sum}\n"
end

def part2()
    content = File.read('../inputs/dec4.input')
    map = {}
    sum = 0
    idx = 0
    lines = content.lines.each do |line|
        idx += 1
        rest = line.split(":")[1].strip()
        winning = line.split("|")[0].strip().split(" ")
        actual = line.split("|")[1].strip().split(" ")
        
        matches = (actual & winning).length
        copies = if map.key?(idx) then map[idx] + 1 else 1 end
        sum += copies

        for i in (idx+1)..(idx+matches) do
            if map.key?(i)
                map[i] += copies
            else
                map[i] = copies
            end
        end
    end
    print "Part2: #{sum}\n"
end

part1()
part2()