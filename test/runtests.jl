using Associates
import Associates: hashkv
using Accessors
using Test

    v = collect(1:1:26)
    v2 = hash.(repeat(collect(1:1:13),2))
    D1 = hashkv(Dict(zip('A':'Z',v)))
    D2=Dict([(hash.(rand(26)).=>v2)...])
    m1= AssociativeHashMap(D1)

    m1
    m1

    m2= AssociativeHashMap(D2)
    m2.forward
    m2.backward

    inv(m1).forward
    

@testset "Associates.jl" begin
    # Write your tests here.

end
