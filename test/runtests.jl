using Associates
import Associates: unwrapsinglet
using Test

x=[1,2]
unwrapsinglet(x)

v = collect(1:1:26)

D1 = Dict(zip('A':'Z',v))

import Base.Iterators.product

D2 = Dict(zip(v,rand(26)))

m1= GMap(D1)
inverse(m1)

dom(m1)
codom(m1)
dom(m1)

m2= GMap(D2)
dom(m2)
codom(m2)
dom(m2∘m1)


m1
inv(m1).forward

using AbstractTrees
Tree(m2.forward)

# function (+)(D1::Dict, D2::Dict) 
#     for k in keys(D1)
#         if k in keys(D2)
#             push!(D2[k], k)
#         else
#             D2[k] = D1[k]
#         end
#     end
# end
    
Dict(zip(["1","b","z"], [1,2,3])) ∪ Dict(zip(["1","b","z"], [4,5,6]))

@testset "Associates.jl" begin
    # Write your tests here.

end
