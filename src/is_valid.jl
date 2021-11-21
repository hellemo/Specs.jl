function is_valid(::Spec, data) end

function is_valid(ms::MultiSpec, data)
	isvalid = true
	for f in ms.specs
		if hasproperty(data, f.first) 
			isvalid = isvalid && is_valid(f.second, getproperty(data, f.first))
		else
			return false
		end
	end
	return isvalid
end

function is_valid(uk::UnkeyedAnd, data)
    sum(map(s->is_valid(s,data), uk.specs)) == length(uk.specs)
end




function is_valid(ms::MultiSpecOr, data)
	isvalid = false
	for f in ms.specs
		if hasproperty(data, f.first) 
			isvalid = isvalid || is_valid(f.second, getproperty(data, f.first))
		end
		if isvalid
			return true
		end
	end
	return isvalid
end

function is_valid(ms::MultiSpec, data, combine)
isvalid = Bool[]
for f in ms.specs
    if hasproperty(data, f.first) 
        push!(isvalid, is_valid(f.second, getproperty(data, f.first)))
    else
        return false
    end
end
combine(isvalid)
end
is_valid(ms::MultiSpecAtLeast, data) = is_valid(ms, data, x->sum(x)>=ms.min)
is_valid(ms::MultiSpecAtMost, data) = is_valid(ms, data, x->sum(x)<=ms.max)