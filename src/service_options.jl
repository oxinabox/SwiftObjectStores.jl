export SwiftService

"""
Creates a swift service object, which describes the properties of your connection.
Default values for are read from enviroment variables, using the names from your `openstackrc.sh`.
Just like for the swift commandline client.

	- Note that `segment_size` is in bytes -- so `1024^3` is 1Gb
"""
function SwiftService(;auth_url = ENV["OS_AUTH_URL"],
                        username::String = ENV["OS_USERNAME"],
                        password::String = ENV["OS_PASSWORD"],
                        tenant_name::String = ENV["OS_TENANT_NAME"],
                        auth_version::String = "2",
                        segment_size::Integer = 1024^3, #1GB
                        segment_threads::Integer=24,
                        object_threads::Integer=24)
    service[:SwiftService](Dict(
        "os_auth_url"     => auth_url,
        "os_username"     => username,
        "os_password"     => password,
        "os_tenant_name"  => tenant_name,
        "auth_version"    => auth_version,
        "segment_size"    => segment_size,
        "segment_threads" => segment_threads,
        "object_threads"  => object_threads
    ))
end

