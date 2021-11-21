abstract type Spec end
abstract type AtomicSpec <: Spec end
abstract type MultiSpec <: Spec end

# TO DO: Parametric types?
struct UnkeyedAnd <: MultiSpec
    specs::Vector{S} where {S<:Spec}
end

struct MultiSpecAnd <: MultiSpec
    specs::Vector{Pair{Symbol, S}} where {S<:Spec}
end

struct MultiSpecOr <: MultiSpec
    specs::Vector{Pair{Symbol, S}} where {S<:Spec}
end

struct MultiSpecAtLeast <: MultiSpec
    specs::Vector{Pair{Symbol, S}} where {S<:Spec}
	min::Int
end

struct MultiSpecAtMost <: MultiSpec
    specs::Vector{Pair{Symbol, S}} where {S<:Spec}
	max::Int
end

