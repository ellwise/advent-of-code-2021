filepath = joinpath(@__DIR__, "data/day01/input")

# part 1

measurements = parse.(Int, readlines(filepath))
single_differences = diff(measurements)
part_1_answer = sum(single_differences .> 0)
println(part_1_answer)

# part 2

n = length(measurements)
window_sums = measurements[1:n-2] + measurements[2:n-1] + measurements[3:n]
triple_differences = diff(window_sums)
part_2_answer = sum(triple_differences .> 0)
println(part_2_answer)
