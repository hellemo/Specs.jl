# function is_valid(::Spec, data) end

terminate_early(_, ::And) = (false, false)
terminate_early(count, ::Or) = (count>0, true)
terminate_early(count, ::Min{MIN}) where {MIN} = (count >= MIN, true)
terminate_early(count, ::Max{MAX}) where {MAX} = (count > MAX, false)
terminale_early(count, ::Between{M,N} where {M,N}) = (count>N, false)

termination_value(count, ntotal, ::And) = count == ntotal
termination_value(count, _, ::Or) = count > 1
termination_value(count, _, ::Min{MIN} where {MIN}) = count >= MIN
termination_value(count, _, ::Max{MAX} where {MAX}) = count <= MAX
termination_value(count, _, ::Between{M,N} where {M,N}) = M <= count <= N

function is_valid(ms::MultiSpec{K,C}, data) where {K<:UnKeyed,C}
    count = 0
	for s in ms.specs
		if is_valid(s, data)
			count += 1
		end
		t, tv = terminate_early(count, C())
		if t
			return tv
		end
	end
	return termination_value(count, length(ms.specs), C())
end

function is_valid(ms::MultiSpec{K,C}, data) where {K<:Keyed,C}
    count = 0
	for s in ms.specs
        add_to_count, missing_key = _check_data(data, s)
        count = count + add_to_count
        if missing_key
            return false
        end
        t, tv = terminate_early(count, C())
		if t
			return tv
		end
	end
	return termination_value(count, length(ms.specs), C())
end

function _check_data(data, s)
    add_to_count = 0
    missing_key = false
    if hasproperty(data, s.first) 
        if is_valid(s.second, getproperty(data,s.first))
            add_to_count = 1
        end
    else
        missing_key = true
    end
    return (add_to_count, missing_key)
end

function _check_data(data::AbstractDict, s)
    add_to_count = 0
    missing_key = false
    if haskey(data, s.first) 
        if is_valid(s.second, data[s.first])
            add_to_count = 1
        end
    else
        missing_key = true
    end
    return (add_to_count, missing_key)
end