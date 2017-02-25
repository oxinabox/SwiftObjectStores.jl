###############
# Downloaders
#

export get_file, get_stream, get_jld

"""Download from swift, writing the result to the file given by `fname`.
	`container` is just the container object_name, pseudofolder should be part of object object_name
"""
function get_file(serv::PyObject, container::AbstractString, object_name::String, fname::String; verbose::Bool=false)
	if '/' in container || '\\' in container
		error("No slashes allowed in container object_name (got $container). Pseudodir should be part of the object object_name.")
	end
		
    async_get = serv[:download](container, [object_name], Dict("out_file" => fname))
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
function get_file(func::Function, serv::PyObject, container::AbstractString, object_name::String; verbose::Bool=false)
	fname = splitdir(object_name)[end]
	mktempdir() do tdir
	    fpathname = joinpath(tdir, fname)
        get_file(serv::PyObject, container, object_name, fpathname; verbose=verbose)    
        func(fpathname)
    end
end

"""Read IO stream, from Swift, and call func, on it, returning the result """
function get_stream(func::Function, serv::PyObject, container::AbstractString, object_name::String; verbose::Bool=false)
    get_file(serv::PyObject, container, object_name; verbose=verbose) do fname
		open(func, fname, "r")
    end
end

"""Download a JLD file from Swift. `dataname` is a list of fieldnames to read."""
function get_jld(serv::PyObject, container::AbstractString, object_name::String, datanames...; verbose::Bool=false)
    get_file(serv::PyObject, container, object_name; verbose=verbose) do fname
		JLD.load(File(format"JLD", fname), datanames...)
    end
end

