module Specs


include("types.jl")
include("atomic_specs.jl")
include("is_valid.jl")
include("conform.jl")
include("explain.jl")
include("spec_lib.jl")

export is_valid, conform, explain
export Contains


# struct And{T} <: Spec where {T <: Union}
# 	as
# 	And{T}(as) where T = length([Tᵢ(as) for Tᵢ in _collect(T)])>0 ? new{T}(as) : error("")
# end

# Base.isvalid(s::Type{T}, d) where {T <: Spec} = ismissing(conform(d, s) == d) ? false : d

# function conform(d, s::Type{T}) where {T <: Spec}
#     try
#         for f in fieldnames(T)
#             fieldtype(T,f)(getproperty(d, f))
#         end
#         return d
#     catch err
#         return missing
#     end
# end

# function conform(d::Dict, s::Type{T}) where {T <: Spec}
# 	try
# 		for f in fieldnames(T)
# 			fieldtype(T,f)(d[f])
# 		end
# 		return d
# 	catch err
# 		return missing
# 	end
# end

# function explain(d, T)
# 	try
# 		for f in fieldnames(T)
# 			fieldtype(T,f)(getproperty(d, f))
# 		end
# 		return nothing
# 	catch err
#         if isa(err, MethodError)
#             buf = IOBuffer()
#             Base.show_method_candidates(buf, err)
#             println(String(take!(buf)))
#             # return err
#         else
# 		    return err.msg
#         end
# 	end
# end


# _collect(t::Union{Type, DataType, Union{}}) = _collect(t, [])
# _collect(t::Type, list) = t<:Union{} ? push!(list, t) : _collect(t.b, push!(list, t.a))
# _collect(t::Union{DataType,Core.TypeofBottom}, list) = push!(list, t)

# export Spec
# export And
# export conform
# export isvalid

end # module
