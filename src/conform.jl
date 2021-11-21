function conform(spec::Spec, data)
    is_valid(spec, data) ? data : nothing
end

function conform(spec::Spec, data::Array)
    r = []
    for d in data
        if is_valid(spec, d)
            push!(r, d)
        end
    end
    return r
end