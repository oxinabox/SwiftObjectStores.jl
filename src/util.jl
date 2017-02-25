export validate_file

"Note this reads out the streams to their ends"
function validate_equal!(a_stream::IO, b_stream::IO; buffer_len=4*1024)
    a_buf = Vector{UInt8}(buffer_len)
    b_buf = Vector{UInt8}(buffer_len)
    
    while(true)
        a_len_read = readbytes!(a_stream, a_buf)
        b_len_read = readbytes!(b_stream, b_buf)
        if a_buf[1:a_len_read] != b_buf[1:b_len_read]
            return false
        end
        @assert(a_len_read == b_len_read)
        if a_len_read<length(a_buf)
            return true #we have reached the end
        end
    end
    
end

"""
Downloads a file file from Swift and checks if it the same as the local file given by `fname`.
Note: this is a comprehense check. Normally you would prefer to just check Hash's.
This method is for testing checking that the hash checking method works.
"""
function validate_file(serv::PyObject, container::AbstractString, objectname::String, fname::String; verbose::Bool=false)
    get_stream(serv::PyObject, container, objectname; verbose=verbose) do rfp
        open(fname, "r") do lfp
            validate_equal!(rfp, lfp)
        end
    end
end

