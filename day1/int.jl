using QuadGK

f(x) = sqrt(1 - x^2)

area, error = quadgk(f, -1, 1)

println(area)
println(error)