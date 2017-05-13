using PGFPlotsXExamples
import PGFPlotsX

using Base.Test
using NBInclude
using LaTeXStrings
using Contour
using Colors
using DataFrames

const EXAMPLE_DIR = joinpath(@__DIR__, "..", "examples/")
const MIME_types = [PGFPlotsX.Plot, PGFPlotsX.AxisLike, PGFPlotsX.TikzPicture, PGFPlotsX.TikzDocument]

function export_ans(x)
    if any(issubtype.(typeof(x), MIME_types))
        folder, file = tempdir(), tempname()
        pdffile = joinpath(folder, file) * ".pdf"
        println("saving ", typeof(x), " to ", joinpath(folder, file), ".pdf")
        PGFPlotsX.save(pdffile, x)
        rm(pdffile)
    else
        println("skipping $(typeof(x))")
    end
end

PGFPlotsX.latexengine!(PGFPlotsX.PDFLATEX)

cd(EXAMPLE_DIR) do
    for file in readdir()
        if endswith(file, ".ipynb")
            println("Testing ", file)
            nbinclude(joinpath(EXAMPLE_DIR, file); anshook = export_ans)
        end
    end
end
