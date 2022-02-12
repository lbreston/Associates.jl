module Associates

# import InverseFunctions: inverse
import Base: inv, ∘, +, ×, \, /, ∪, ∩

#export types
export GMap

#export functions
export dom, image, preimage, codom, inverse, inv, ∘, compose, \, /, ∪, ∩
struct GMap
    forward::Dict
    backward::Dict
end

GMap(forward::Dict) = GMap(forward, invert(forward))
GMap(fun::Function, d) = GMap(fun2dict(fun, d))

(m::GMap)(x) = applymap(m, x)
applymap(m::GMap, x) = m.forward[x]
dom(m::GMap) = keys(m.forward)
inverse(m::GMap) = GMap(m.backward, m.forward)
inv(m::GMap) = inverse(m)


image(m::GMap, x) = unique(m.(x))
image(m::GMap) = codom(m)
preimage(m::GMap) = dom(m)
preimage(m::GMap, x) = image(inverse(m), x)
codom(m::GMap) = dom(inverse(m))


pull_back(m2,m1) = dom(m2) ∩ codom(m1) |> x -> preimage(m1, x) 
push_forward(m2, m1) = m2.(m1.(pull_back(m2, m1)))

compose(m2, m1) = GMap(Dict(zip(pull_back(m2, m1), push_forward(m2, m1))))

(∘)(m2::GMap, m1::GMap) = compose(m2, m1)

(∘)(s::Set, m1::GMap) = Set(S ∩ codom(m1))

(∘)(m2::GMap, S::Set) = Set(image(m2, S ∩ dom(m2)))

(∪)(m1::GMap, m2::GMap) = GMap(Dict(m1.forward ∪ m2.forward))

(∩)(m1::GMap, m2::GMap) = GMap(Dict(m1.forward ∩ m2.forward))

(/)(m1::GMap, m2::GMap) = m2∘inverse(m1)

(\)(m1::GMap, m2::GMap) = inverse(m2)∘m1








#some utilities 

hashkv(D) = Dict(hash(value) => hash(key) for (key, value) in D)

fun2dict(fun, d)= Dict(zip(d, map(fun, d)))

function invert(D::Dict)
    invD = Dict()
    for k in keys(D)
        if D[k] in keys(invD)
           push!(invD[D[k]], k)
        else
            invD[D[k]] = [k]
        end
    end
    for k in keys(invD)
        invD[k] = length(invD[k]) == 1 ? invD[k][1] : invD[k]
    end
    K = typejoin(typeof.(keys(invD))...)
    V = typejoin(typeof.(values(invD))...)
    Dict{K,V}(invD)
end



end
