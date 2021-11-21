function explain(ms::MultiSpec, data)
	for f in ms.specs
		if hasproperty(data, f.first)
			explain(f.second, getproperty(data, f.first))
		else
			@info "$data failed at $(f.first) Spec: $(string(s))"
		end
	end
end

function explain(uk::UnkeyedAnd, data)
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