module Associates

# import InverseFunctions: inverse
import Base: inv

#export types
export AssociativeHashMap

#export functions
export dom, image, preimage, codom, inverse, inv

struct AssociativeHashMap
    forward::Dict
    backward::Dict
end

AssociativeHashMap(forward::Dict) = AssociativeHashMap(forward, invert(forward))

(m::AssociativeHashMap)(x) = applymap(m, x)
applymap(m::AssociativeHashMap, x) = m.forward[x]
dom(m::AssociativeHashMap) = reduce(∪, keys(m.forward))
inverse(m::AssociativeHashMap) = AssociativeHashMap(m.backward, m.forward)
inv(m::AssociativeHashMap) = inverse(m)


image(m::AssociativeHashMap, x) = unique(m.(x))
image(m::AssociativeHashMap) = codom(m)
preimage(m::AssociativeHashMap) = dom(m)
preimage(m::AssociativeHashMap, x) = image(inverse(m), x)
codom(m::AssociativeHashMap) = dom(inverse(m))


function invert(D::Dict)
    invD = Dict()
    for k in keys(D)
        if D[k] in keys(invD)
           push!(invD[D[k]], k)
        else
            invD[D[k]] =[k]
        end
    end
    for k in keys(invD)
        invD[k] = length(invD[k]) == 1 ? invD[k][1] : invD[k]
    end
    K = typejoin(typeof.(keys(invD))...)
    V = typejoin(typeof.(values(invD))...)
    Dict{K,V}(invD)
end


#some utilities 
hashkv(D) = Dict(hash(value) => hash(key) for (key, value) in D)









end
