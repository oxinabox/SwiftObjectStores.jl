module SwiftObjectStores

using PyCall
using JLD
using FileIO

@pyimport swiftclient.service as service

include("service_options.jl")
include("responses.jl")
include("upload.jl")
include("download.jl")
include("info.jl")
include("util.jl")
end # module
