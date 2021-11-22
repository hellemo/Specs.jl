using Test
using Specs

# Test user struct
struct User
    name::String
    email::String
    height::Int
end


# Testdata
p1 = (name="Per", email="my@email", height=83)              # Valid Named Tuple
p2 = (name="Petter", email="invalid", height=122)           # Invalid Named Tuple
p3 = User("Oda", "oda@oda.com", 110)                        # Valid User
p4 = User("Oda", "o@", 473)                                 # Invalid User
p5 = Dict(:name =>"Per",:email=>"my@email", 
    :height =>83, :weight => 91)                            # Valid Dict (extra field)
p6 = Dict(:name =>"Per",:email=>"my@email", :height =>283)  # Invalid Dict

users = [p1, p2, p3, p4, p5, p6]


user_spec = Specs.MultiSpec{Keyed, And}(
    [
        :email => Specs.SpecLib.email,
        :height => Specs.NMax(235)
    ]
)

@testset "Specs.jl" begin

@testset "Is valid" begin
    @test is_valid(user_spec, p1)
    @test !is_valid(user_spec, p2)
    @test is_valid(user_spec, p3)
    @test !is_valid(user_spec, p4)
end

@testset "Conform" begin
    @test conform(user_spec, p1) == p1
    @test conform(user_spec, p2) === nothing
    @test conform(user_spec, p3) == p3
    @test conform(user_spec, p4) === nothing
end

end