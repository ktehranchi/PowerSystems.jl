using Documenter, PowerSystems
import DataStructures: OrderedDict
using Literate

# This is commented out because the output is not user-friendly. Deliberation on how to best
# communicate this information to users is ongoing.
#include(joinpath(@__DIR__, "src", "generate_validation_table.jl"))
include(joinpath(@__DIR__, "make_model_library.jl"))

pages = OrderedDict(
        "Welcome Page" => "index.md",
        "Tutorials" =>  Any[
            "Create and Explore a Power `System`" => "tutorials/creating_system.md",
            "Working with Time Series" => "tutorials/working_with_time_series.md",
            "Adding dynamic devices" => "tutorials/add_dynamic_device.md",
        ],
        "How to..." =>  Any[
            "...install PowerSystems.jl" => "how_to/install.md",
            "...load a `system` from `PowerSystemCaseBuilder`" => "how_to/powersystembuilder.md",
            "...parse data from Matpower, PSSE, or CSV files" => "how_to/parsing.md",
            "...add time series data from CSVs" => "how_to/add_ts_from_csvs.md",
            "...customize the tabular data parser" => "how_to/extend_tabular_parsing.md",
            "...get all the buses in a system" => "how_to/get_buses.md",
            "...get the available generators in a system" => "how_to/get_available_generators.md",
            "...add an Operating Cost" => "how_to/add_cost_curve.md",
            "...add additional data to a component" => "how_to/adding_additional_fields.md",
            "...add a new Type" => "how_to/add_new_types.md",
            "...improve performance with time series data" => "how_to/improve_ts_performance.md",
            "...serialize data to a JSON" => "how_to/serialize_data.md",
            "...reduce REPL printing" => "how_to/reduce_repl_printing.md",
            "...migrate from version 3.0 to 4.0" => "how_to/migrating_to_psy4.md"
        ],
        "Explanation" =>
            Any[
            "explanation/system.md",
            "explanation/type_structure.md",
            "explanation/per_unit.md",
            "explanation/time_series.md",
            "explanation/example_dynamic_data.md",
            "explanation/cost_functions.md",
            "explanation/market_bid_cost.md"
            ],
        "Model Library" => Any[],
        "Reference" =>
            Any["Public API" => "api/public.md",
            "Internal API Reference" => "api/internal.md",
            "Glossary and Acronyms" => "api/glossary.md",
            "Specifying the category of..." => "api/enumerated_types.md",
            "Developer Guidelines" => "api/developer_guidelines.md",
            "Citation" => "api/citation.md"
            ]


)

pages["Model Library"] = make_model_library(
     categories = [
        Topology,
        StaticInjection,
        Service,
        Branch
    ],
    exceptions = [PSY.DynamicComponent,
                  PSY.ActivePowerControl,
                  PSY.ReactivePowerControl,
                  PSY.DynamicBranch,
                  PSY.HybridSystem,
                  PSY.OperationalCost
                  ],
    manual_additions =
        Dict("Service" => ["Reserves" => "model_library/reserves.md"],
        "StaticInjection" => ["HybridSystem" => "model_library/hybrid_system.md"],
        "DynamicInjection" => ["Dynamic Inverter" => "model_library/dynamic_inverter.md",
        "Dynamic Generator" => "model_library/dynamic_generator.md",
        ],
        "Branch" => ["Dynamic Lines" => "model_library/dynamic_branch.md"],
        "Operating Costs" => ["ThermalGenerationCost" =>"model_library/thermal_generation_cost.md",
        "HydroGenerationCost" =>"model_library/hydro_generation_cost.md",
        "RenewableGenerationCost" =>"model_library/renewable_generation_cost.md",
        "StorageCost" =>"model_library/storage_cost.md",
        "LoadCost" =>"model_library/load_cost.md",
        "MarketBidCost" =>"model_library/market_bid_cost.md"],
        "Cost Curves" => ["Variable Cost Curves" => "model_library/cost_curves.md",
        "Value Curves" => "model_library/value_curves.md"]
        )
)

# postprocess function to insert md
function insert_md(content)
    m = match(r"APPEND_MARKDOWN\(\"(.*)\"\)", content)
    if !isnothing(m)
        md_content = read(m.captures[1], String)
        content = replace(content, r"APPEND_MARKDOWN\(\"(.*)\"\)" => md_content)
    end
    return content
end

# This code performs the automated addition of Literate - Generated Markdowns. The desired
# section name should be the name of the file for instance network_matrices.jl -> Network Matrices
julia_file_filter = x -> occursin(".jl", x)
folders = Dict(
    "Model Library" => filter(julia_file_filter, readdir("docs/src/model_library")),
    "Explanation" => filter(julia_file_filter, readdir("docs/src/explanation")),
    "How to..." => filter(julia_file_filter, readdir("docs/src/how_to")),
)
for (section, folder) in folders
    for file in folder
        @show file
        section_folder_name = lowercase(replace(section, " " => "_"))
        outputdir = joinpath(pwd(), "docs", "src", "$section_folder_name")
        inputfile = joinpath("$section_folder_name", "$file")
        infile_path = joinpath(pwd(), "docs", "src", inputfile)
        outputfile = string("generated_", replace("$file", ".jl" => ""))
        execute = occursin("EXECUTE = TRUE", uppercase(readline(infile_path))) ? true : false
        execute && include(infile_path)
        Literate.markdown(infile_path,
                          outputdir;
                          name = outputfile,
                          credit = false,
                          flavor = Literate.DocumenterFlavor(),
                          documenter = true,
                          postprocess = insert_md,
                          execute = execute)
        subsection = titlecase(replace(split(file, ".")[1], "_" => " "))
        push!(pages[section], ("$subsection" =>  joinpath("$section_folder_name", "$(outputfile).md")))
    end
end

makedocs(
    modules = [PowerSystems, InfrastructureSystems],
    format = Documenter.HTML(prettyurls = haskey(ENV, "GITHUB_ACTIONS"),),
    sitename = "PowerSystems.jl",
    authors = "Jose Daniel Lara, Daniel Thom, Kate Doubleday, and Clayton Barrows",
    pages = Any[p for p in pages]
)

deploydocs(
    repo = "github.com/NREL-Sienna/PowerSystems.jl.git",
    target = "build",
    branch = "gh-pages",
    devbranch = "main",
    devurl = "dev",
    push_preview=true,
    versions = ["stable" => "v^", "v#.#"],
)
