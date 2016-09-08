#############
# Info

function list(serv) 
    serv[:stat]()
end
function list(serv, containter::String)
    serv[:stat](container)
end
function list(serv, containter::String, object::String)
    serv[:stat](container, object)
end
stat = list

