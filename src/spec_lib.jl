module SpecLib
using ..Specs
const email = Specs.MultiSpec{Specs.UnKeyed,Specs.And}(
    [
        Specs.Contains("@"),
        Specs.MinLength(3),
        Specs.MaxLength(200)
    ]
)


end