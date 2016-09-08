module SwiftObjectStores

using PyCall
using JLD
using FileIO


const keystone = PyNULL()
const service = PyNULL()

function __init__()
	copy!(keystone, pyimport_conda("keystoneauth1","python-keystoneclient")) #Even if not used, is required for swift
    copy!(service, pyimport_conda("swiftclient.service", "python-swiftclient"))
end

include("service_options.jl")
include("responses.jl")
include("upload.jl")
include("download.jl")
include("management.jl")
include("util.jl")
end # module
