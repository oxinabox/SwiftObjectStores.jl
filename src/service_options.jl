"""
Creates a swift service object, which describes the properties of your connection.
Default values for are read from enviroment variables, using the names from your `openstackrc.sh`.
Just like for the swift commandline client
"""
function SwiftService(;auth_url = ENV["OS_AUTH_URL"],
                        username::String = ENV["OS_USERNAME"],
                        password::String = ENV["OS_PASSWORD"],
                        tenant_name::String = ENV["OS_TENANT_NAME",
                        auth_version::String = "2",
                        segement_size::Integer = 1024^3,
                        segment_threads::Integer=24,
                        object_threads::Integer=24)
    service.SwiftService(Dict(
        "os_auth_url"     => auth_url,
        "os_username"     => username,
        "os_password"     => password,
        "os_tenant_name"  => tenant_name,
        "auth_version"    => auth_version,
        "segment_size"    => segment_size, #1GB
        "segment_threads" => segment_threads,
        "object_threads"  => object_threads
    ))
end

