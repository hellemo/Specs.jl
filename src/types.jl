abstract type Spec end
abstract type AtomicSpec <: Spec end

abstract type AbstractKeyed end
struct Keyed <: AbstractKeyed end
struct UnKeyed <: AbstractKeyed end

abstract type AbstractCondition end
struct And <: AbstractCondition end
struct Or <: AbstractCondition end
struct Min{N} <: AbstractCondition end
struct Max{N} <: AbstractCondition end
struct Between{M,N} <: AbstractCondition end

struct MultiSpec{K,C} <: Spec where {K, C}
     specs::Vector#{S} where {S<:Spec}
end