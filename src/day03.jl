filename = replace(basename(@__FILE__), ".jl" => "")
filepath = joinpath(@__DIR__, "data/", filename, "input")
input = readlines(filepath)

diagnostic_report = transpose(parse.(Int, reduce(hcat, collect.(input)), base=2))
n, m = size(diagnostic_report)

# part 1

gamma_rate_bin = sum(diagnostic_report, dims=1) .> n/2
gamma_rate = sum(gamma_rate_bin[m-j]*2^j for j = 0:m-1)

epsilon_rate_bin = sum(diagnostic_report, dims=1) .< n/2
epsilon_rate = sum(epsilon_rate_bin[m-j]*2^j for j = 0:m-1)

part_one_answer = gamma_rate * epsilon_rate
println(part_one_answer)

# part 2

global oxygen_generator_rating, co2_scrubber_rating
let oxygen_generator_rating_bin = copy(diagnostic_report), co2_scrubber_rating_bin = copy(diagnostic_report)
    for j = 1:m
        count_one = sum(oxygen_generator_rating_bin[:, j])
        count_zero = sum(1 .- oxygen_generator_rating_bin[:, j])
        most_common = count_one .>= count_zero ? 1 : 0
        mask = oxygen_generator_rating_bin[:, j] .== most_common
        oxygen_generator_rating_bin = oxygen_generator_rating_bin[mask, :]
        if size(oxygen_generator_rating_bin, 1) == 1
            global oxygen_generator_rating = sum(oxygen_generator_rating_bin[m-j]*2^j for j = 0:m-1)
            break
        end
    end
    for j = 1:m
        count_one = sum(co2_scrubber_rating_bin[:, j])
        count_zero = sum(1 .- co2_scrubber_rating_bin[:, j])
        least_common = count_one .< count_zero ? 1 : 0
        mask = co2_scrubber_rating_bin[:, j] .== least_common
        co2_scrubber_rating_bin = co2_scrubber_rating_bin[mask, :]
        if size(co2_scrubber_rating_bin, 1) == 1
            global co2_scrubber_rating = sum(co2_scrubber_rating_bin[m-j]*2^j for j = 0:m-1)
            break
        end
    end
    part_two_answer = oxygen_generator_rating * co2_scrubber_rating
    println(part_two_answer)
end
