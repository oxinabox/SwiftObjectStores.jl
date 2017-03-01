#############
# Management: getting info, deleting containers etc
import Base.stat
export list, delete

stat(serv::PyObject) = serv[:stat]() |> Dict
stat(serv::PyObject, container::AbstractString) = serv[:stat](container) |> Dict

function stat(serv::PyObject, container::AbstractString, object::String)
    serv[:stat](container, [object]) |> first
end

function list(serv::PyObject)
	response = serv[:list]() |> first |> Dict
	Dict(d["name"] => d for d in response["listing"])
end

list(serv::PyObject, container::AbstractString) = serv[:list](container) |> Dict



### Delete

delete(serv::PyObject, container::AbstractString) = serv[:delete](container) |> collect

function delete(serv::PyObject, container::AbstractString, object::String)
    serv[:delete](container, [object]) |> first
end



