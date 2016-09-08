###############
# Downloaders
#

"""Download from swift, writing the result to the file given by `fname`.
    `container` can either be be just a container name, or a pseudofolder path    
"""
function get_file!(serv, container::String, name::String, fname::String; verbose::Bool=false)
    container_parts = split(strip(container, '/'), "/")
    container = container_parts[1]
    if length(container_parts) > 1
        psedudofolder = join(container_parts[2:end], "/")
        name = psedudofolder*"/"*name
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
        fname = joinpath(tdir, name)
        get_file!(serv, container, name, fname; verbose=verbose)    
        open(func, fname,"r")
    end
end

"""Download a JLD file from Swift. `data` is a list of fieldnames to read."""
function get_jld(serv, container::String, name::String, verbose::Bool = false, data...)
    mktempdir() do tdir
        fname = joinpath(tdir, name)
        get_file!(serv, container, name, fname; verbose=verbose)
        JLD.load(File(format"JLD", fname), data...)
    end
end

