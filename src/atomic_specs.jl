struct Contains{S<:AbstractString} <: AtomicSpec
    substring::S
end
is_valid(cs::Specs.Contains, data::AbstractString) = contains(data, cs.substring)

struct MinLength{T} <: AtomicSpec
    min::T
end
is_valid(ml::MinLength, data) = length(data) >= ml.min

struct MaxLength{T} <: AtomicSpec
    max::T
end
is_valid(ml::MaxLength, data) = length(data) <= ml.max

struct Min{T} <: AtomicSpec
    min::T
end
is_valid(ml::Min, data) =  data >= ml.min

struct Max{T} <: AtomicSpec
    max::T
end
is_valid(ml::Max, data) = data <= ml.max