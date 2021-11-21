module SpecLib
using ..Specs
const email = Specs.UnkeyedAnd(
    [
        Specs.Contains("@"),
        Specs.MinLength(3),
        Specs.MaxLength(200)
    ]
)


end