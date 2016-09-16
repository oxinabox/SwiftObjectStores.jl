###############
# Downloaders
#

export get_file, get_file!, get_jld

"""Download from swift, writing the result to the file given by `fname`.
	`container` is just the container name, pseudofolder should be part of object name
"""
function get_file!(serv, container::String, name::String, fname::String; verbose::Bool=false)
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

"""Read IO stream, from Swift, and call func, on it, returning the result """
function get_file(func::Function, serv, container::String, name::String; verbose::Bool=false)
    mktempdir() do tdir
        fname = joinpath(tdir, "lastdownswift")
        get_file!(serv, container, name, fname; verbose=verbose)    
        open(func, fname,"r")
    end
end

"""Download a JLD file from Swift. `dataname` is a list of fieldnames to read."""
function get_jld(serv, container::String, name::String, datanames...; verbose::Bool=false)
    mktempdir() do tdir
        fname = joinpath(tdir, "lastdownswift.jld")
        get_file!(serv, container, name, fname; verbose=verbose)
        JLD.load(File(format"JLD", fname), datanames...)
    end
end

