# Specs.jl

An experiment in implementing something like [Clojure/Spec](https://clojure.org/guides/spec) with multiple dispatch in [Julia](https://julialang.org). If it works out, maybe I'll add some macros for a succinct API.

## Examples

```julia
using Specs

# Simple demo email spec
struct Email <: Spec
    address::String
    Email(s) = contains(s,"@") ? new(s) : error("Email does not contain @")
end

# Composite Height spec
struct Height <: Spec 
	h
	Height(h)= new(And{Union{MinHeight, 
				             MaxHeight}}(h))
end

struct MinHeight <: Spec
	h
	MinHeight(h::T) where T <: Number = h>30 ? new(h) : error("Height $h below minimum 30")
end

struct MaxHeight <: Spec
	h
	MaxHeight(h::T) where T <: Number = h<250 ? new(h) : error("Height $h above maximum 250")
end

# Composite spec
struct UserSpec <: Spec
	name::String
	email::Email
	height::Height
end

# Struct adhering to UserSpec
struct User
    name::String
    email::String
    height::Int
end

p1 = (name="Per", email="my@email", height=83)  # Valid Named Tuple
p2 =(name="Petter",email="invalid", height=122) # Invalid Named Tuple
p3 = User("Oda", "oda@oda.com", 110)            # Valid User
# Valid Dictionary with extra field
p4 = Dict(:name=>"Dictionary", :height=>120, :email=>"hei@com", :other=>π)





```