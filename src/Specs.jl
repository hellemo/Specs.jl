module Specs


include("types.jl")
include("atomic_specs.jl")
include("is_valid.jl")
include("conform.jl")
include("explain.jl")
include("spec_lib.jl")

export is_valid, conform, explain
export Spec
export Contains
export Keyed, UnKeyed
export MultiSpec
export And, Or, Min, Max, Between

end # module
