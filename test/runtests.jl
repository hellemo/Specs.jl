using Test
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


@testset "Conform" begin
    @test conform(p1, UserSpec) == p1
    @test ismissing(conform(p2, UserSpec))
    @test conform(p3, UserSpec) == p3
    @test conform(p4, UserSpec) == p4

    ps = (p1, p3, p4)
    for p in ps
        @test isvalid(p, UserSpec)
    end

    @test length(collect(skipmissing(conform(p, UserSpec) for p in (p1,p2,p3,p4)))) == 3
end
