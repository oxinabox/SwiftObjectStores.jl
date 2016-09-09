#############
# Management: getting info, deleting containers etc

export list, stat, delete

stat(serv) = serv[:stat]() |> Dict
stat(serv, container::String) = serv[:stat](container) |> Dict

function stat(serv, container::String, object::String)
    serv[:stat](container, [object]) |> first
end

function list(serv)
	response = serv[:list]() |> first |> Dict
	@show response
	Dict(d["name"] => d for d in response["listing"])
end

list(serv, container::String) = serv[:list](container) |> Dict



### Delete

delete(serv, container::String) = serv[:delete](container) |> collect

function delete(serv, container::String, object::String)
    serv[:delete](container, [object]) |> first
end



