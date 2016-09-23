#############
# Management: getting info, deleting containers etc
import Base.stat
export list, delete

stat(serv) = serv[:stat]() |> Dict
stat(serv, container::String) = serv[:stat](container) |> Dict

function stat(serv, container::String, object::String)
    serv[:stat](container, [object]) |> first
end

function list(serv)
	response = serv[:list]() |> first |> Dict
	Dict(d["name"] => d for d in response["listing"])
end

list(serv, container::String) = serv[:list](container) |> Dict



### Delete

delete(serv, container::String) = serv[:delete](container) |> collect

function delete(serv, container::String, object::String)
    serv[:delete](container, [object]) |> first
end



