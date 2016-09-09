module SwiftObjectStores

using PyCall
using JLD
using FileIO


const service = pyimport("swiftclient.service")


include("service_options.jl")
include("responses.jl")
include("upload.jl")
include("download.jl")
include("management.jl")
include("util.jl")
end # module
