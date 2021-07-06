macro checkerr(expr)
  quote
    ex = $(esc(expr))
    if haskey(ex, "error")
      error("API Error: $(ex["error"]["message"])")
    else
      ex["result"]
    end
  end
end

function showres(results::Vector)
  println("Result List:")
  for res in results
    showres(res; offset=1)
  end
end
function showres(result::Dict; offset=0)
  println(repeat(" ", offset), "Result:")
  for (key,val) in result
    println(repeat(" ", offset+1), key, " => ", val)
  end
end

macro showres(expr)
  :(showres($(esc(expr))))
end
