using PGFPlotsXExamples
using Base.Test
using NBInclude

const EXAMPLE_DIR = joinpath(@__DIR__, "..", "examples/")

for file in readdir(EXAMPLE_DIR)
    if endswith(file, ".ipynb")
        println("Testing ", file)
        nbinclude(joinpath(EXAMPLE_DIR, file))
    end
end
