

using Conda

Conda.add("pip")
pip = joinpath(Conda.BINDIR, "pip")
run(`$pip install python-keystoneclient`)
run(`$pip install python-swiftclient`)


