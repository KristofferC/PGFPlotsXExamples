using PGFPlotsXExamples
import PGFPlotsX

using Base.Test
using NBInclude
using LaTeXStrings
using Contour
using Colors
using DataFrames

const EXAMPLE_DIR = joinpath(@__DIR__, "..", "examples/")

const MIME_types = [PGFPlotsX.Axis, PGFPlotsX.TikzPicture, PGFPlotsX.Plot, PGFPlotsX.TikzDocument]

function export_ans(x)
    if typeof(x) in MIME_types
        folder, file = tempdir(), tempname()
        pdffile = joinpath(folder, file) * ".pdf"
        println("saving ", typeof(x), " to ", joinpath(folder, file), ".pdf")
        PGFPlotsX.save(pdffile, x)
        rm(pdffile)
    else
        println("skipping $(typeof(x))")
    end
end


cd(EXAMPLE_DIR) do
    for file in readdir()
        if endswith(file, ".ipynb")
            println("Testing ", file)
            if get(ENV, "CI", false)
                println("Setting f to ...")
                f = identity
            else
                f = export_ans
            end
            nbinclude(joinpath(EXAMPLE_DIR, file); anshook = f)
        end
    end
end
