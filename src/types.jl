abstract type Spec end
abstract type AtomicSpec <: Spec end
abstract type MultiSpec <: Spec end

# TO DO: Parametric types?
struct UnkeyedAnd <: MultiSpec
    specs
end

struct MultiSpecAnd <: MultiSpec
	# specs::Array{Pair{Symbol,S}} where {S<:Spec}
    specs::Array{Pair{Symbol,Any}}
end

struct MultiSpecOr <: MultiSpec
	# specs::Array{Pair{Symbol,S}} where {S<:Spec}
    specs::Array{Pair{Symbol,Any}}
end

struct MultiSpecAtLeast <: MultiSpec
	# specs::Array{Pair{Symbol,S}} where {S<:Spec}
    specs::Array{Pair{Symbol,Any}}
	min::Int
end

struct MultiSpecAtMost <: MultiSpec
	# specs::Array{Pair{Symbol,S}} where {S<:Spec}
    specs::Array{Pair{Symbol,Any}}
	max::Int
end

