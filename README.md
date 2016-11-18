# SwiftObjectStores

[![Build Status](https://travis-ci.org/oxinabox/SwiftObjectStores.jl.svg?branch=master)](https://travis-ci.org/oxinabox/SwiftObjectStores.jl)

[![Coverage Status](https://coveralls.io/repos/oxinabox/SwiftObjectStores.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/oxinabox/SwiftObjectStores.jl?branch=master)

[![codecov.io](http://codecov.io/github/oxinabox/SwiftObjectStores.jl/coverage.svg?branch=master)](http://codecov.io/github/oxinabox/SwiftObjectStores.jl?branch=master)

>Swift is a highly available, distributed, eventually consistent object/blob store. Organizations can use Swift to store lots of data efficiently, safely, and cheaply.


Makes [Open Stack Swift Object Stores](http://docs.openstack.org/developer/swift/) available from within Julia.
This package wraps the Python Swift Client, but makes significant changes in terms of interface.


The implementation makes significant uses of temporary files.
It is thus desirable to ensure your `TMPDIR` is set to be on a RAM disk.
In most modern unixen, this is done by adding `export TMPDIR=/dev/shm` to your `.bashrc` or similar.
The package will work fine without this -- and depending on your OS may effectively use a RAM disk anyway.


As is the Open Stack fasion, the package will default to reading your various username and password from enviroment variables.
If you want to make use of this feature, you should  `source ~/openstack.rc`  or similar, before starting julia (Or Jupyter).



## Examples of use:


### Get a file, and perform a loading operation on it
Use [RData.jl](https://github.com/JuliaStats/RData.jl/) to load a RData file off the object store.
Using the container `ResearchData`, the pseudodir `simulated`, and the object name `sim-100000.RData`.
Note that the pseudodir is part of the object name -- pseudodir's are not real, just convention in the key value store.

```julia
using SwiftObjectStores
using RData
serv = SwiftService()
data = get_file(serv, "ResearchData", "simulated/sim-100000.RData") do fn
    load(fn)
end
```



