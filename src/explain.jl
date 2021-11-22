function explain(ms::MultiSpec{K, C}, data) where {K<:Keyed, C}
	for s in ms.specs
		if hasproperty(data, s.first)
			explain(s.second, getproperty(data, s.first))
		else
			@info "$data failed at $(s.first) Spec: $(string(s))"
		end
	end
end

function explain(ms::MultiSpec{K, C}, data::AbstractDict) where {K<:Keyed, C}
	for s in ms.specs
		if haskey(data, s.first)
			explain(s.second, data[s.first])
		else
			@info "$data failed at $(s.first) Spec: $(string(s))"
		end
	end
end


function explain(uk::MultiSpec{K, C}, data) where {K<:UnKeyed, C}
    for s in uk.specs
        explain(s, data)
    end
end

function explain(s::Spec, data)
	if !is_valid(s, data)
		@info "$data failed Spec: $(string(s))"
	end
end
explain(_, _) = nothing