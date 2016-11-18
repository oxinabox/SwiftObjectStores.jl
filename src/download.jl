###############
# Downloaders
#

export get_file, get_stream, get_jld

"""Download from swift, writing the result to the file given by `fname`.
	`container` is just the container name, pseudofolder should be part of object name
"""
function get_file(serv, container::String, name::String, fname::String; verbose::Bool=false)
	if '/' in container || '\\' in container
		error("No slashes allowed in container name (got $container). Pseudodir should be part of the object name.")
	end
		
    async_get = serv[:download](container, [name], Dict("out_file" => fname))
    responses=collect(async_get)
    if verbose
        show_responses(responses)
    end
    ret = responses[end]
    ret["success"] || error(ret["error"])
    ret
end



"""Download a file from Swift, apply `func` to it, returning the result.
`func` should be a function that takes a filename as an input.
"""
function get_file(func::Function, serv, container::String, name::String; verbose::Bool=false)
    mktempdir() do tdir
        fname = joinpath(tdir, "lastdownswift")
        get_file(serv, container, name, fname; verbose=verbose)    
        func(fname)
    end
end

"""Read IO stream, from Swift, and call func, on it, returning the result """
function get_stream(func::Function, serv, container::String, name::String; verbose::Bool=false)
    get_file(serv, container, name; verbose=verbose) do fname
		open(func, fname, "r")
    end
end

"""Download a JLD file from Swift. `dataname` is a list of fieldnames to read."""
function get_jld(serv, container::String, name::String, datanames...; verbose::Bool=false)
    get_file(serv, container, name; verbose=verbose) do fname
		JLD.load(File(format"JLD", fname), datanames...)
    end
end

