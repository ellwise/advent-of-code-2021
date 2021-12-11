filename = replace(basename(@__FILE__), ".jl" => "")
filepath = joinpath(@__DIR__, "data/", filename, "input")
input = readlines(filepath)

# part 1

let h = 0, d = 0
    for line = input
        cmd, val = split(line, " ")
        x = parse(Int, val)
        if cmd == "forward"
            h += x
        elseif cmd == "down"
            d += x
        elseif cmd == "up"
            d -= x
        end
    end
    part_one_answer = h * d
    println(part_one_answer)
end

# part 2

let a = 0, h = 0, d = 0
    for line = input
        cmd, val = split(line, " ")
        x = parse(Int, val)
        if cmd == "forward"
            h += x
            d += a * x
        elseif cmd == "down"
            a += x
        elseif cmd == "up"
            a -= x
        end
    end
    part_two_answer = h * d
    println(part_two_answer)
end