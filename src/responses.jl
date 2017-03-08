"Method to print the responses, for debug purposes"
function show_responses(responses)
    local shown::Set
    function subshow(prefix, value) #Non-dict
        println("** $prefix **:")
        println("\t",value)
    end
    
    function subshow(prefix, dict::Dict)
        for (key, value) in dict
            value ∈ shown && continue  # Skip any fields already shown
            push!(shown, value)
            subshow("$prefix $key", value)
        end
    end
    
    function subshow(prefix, vec::Vector)
        for entry in vec
            entry ∈ shown && continue  # Skip any fields already shown
            push!(shown, entry)
            subshow("$prefix - ", entry)
        end
    end
        
    
    println("Swift  Responses:")
    println("-------------------------")
    for resp in responses
        shown = Set()
        push!(shown, resp)
        subshow("", resp)
        println()
    end
end

