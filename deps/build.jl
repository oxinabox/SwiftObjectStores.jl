using PyCall
using Conda


if PyCall.conda
	Conda.add("pip")
	pip = joinpath(Conda.SCRIPTDIR, "pip")
    run(`$pip install python-keystoneclient`)
	run(`$pip install python-swiftclient`)
else
	try
		pyimport("keystoneclient")
		pyimport("swiftclient")
	catch ee
		typeof(ee) <: PyCall.PyError || rethrow(ee)
		warn("""
Python Dependancies not installed
Please either:

 - Rebuild PyCall to use Conda, by running in the julia REPL:
    - `ENV["PYTHON"]=""; Pkg.build("PyCall"); Pkg.build("SwiftObjectStores")`
 - Or install the depencences yourself, eg by running pip
	- `pip install python-keystoneclient`
	- `pip install python-swiftclient`
	"""
		)
	end
end
