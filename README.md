# Specs.jl

An experiment in implementing something like [Clojure/Spec](https://clojure.org/guides/spec) with multiple dispatch in [Julia](https://julialang.org). If it works out, maybe I'll add some macros for a succinct API.

## Examples

```julia
using Specs
struct User
    name::String
    email::String
    height::Int
end

# Testdata
p1 = (name="Per", email="my@email", height=83)  # Valid Named Tuple
p2 =(name="Petter",email="invalid", height=122) # Invalid Named Tuple
p3 = User("Oda", "oda@oda.com", 110)            # Valid User
p4 = User("Oda". "o@", 473)
users = [p1, p2, p3, p4]

# Define a user Spec:
user_spec = Specs.MultiSpecAnd(
    [
        :email => Specs.SpecLib.email,
        :height => Specs.Max(235)
    ]
)

for p in users
    @info "User $(p.name): " is_valid(user_spec, p)
    @info conform(user_spec, p)
    @info explain(user_spec, p)
    println()
end



```