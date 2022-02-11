using Associates
import Associates: hashkv
using Accessors
using Test

    v = collect(1:1:26)
v
D1 = Dict(zip('A':'Z',v))
D2 = Dict(zip(v,rand(26)))
    m1= GMap(D1)

    dom(m1)
    codom(m2)
    m2= GMap(D2)
    m2∘m1
    inv(m1).forward
    

@testset "Associates.jl" begin
    # Write your tests here.

end
