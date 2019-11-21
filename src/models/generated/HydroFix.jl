#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct HydroFix <: HydroGen
        name::String
        available::Bool
        bus::Bus
        activepower::Float64
        reactivepower::Float64
        tech::TechHydro
        _forecasts::InfrastructureSystems.Forecasts
        ext::Union{Nothing, Dict{String, Any}}
        internal::InfrastructureSystemsInternal
    end



# Arguments
- `name::String`
- `available::Bool`
- `bus::Bus`
- `activepower::Float64`
- `reactivepower::Float64`
- `tech::TechHydro`
- `_forecasts::InfrastructureSystems.Forecasts`
- `ext::Union{Nothing, Dict{String, Any}}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct HydroFix <: HydroGen
    name::String
    available::Bool
    bus::Bus
    activepower::Float64
    reactivepower::Float64
    tech::TechHydro
    _forecasts::InfrastructureSystems.Forecasts
    ext::Union{Nothing, Dict{String, Any}}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function HydroFix(name, available, bus, activepower, reactivepower, tech, _forecasts=InfrastructureSystems.Forecasts(), ext=nothing, )
    HydroFix(name, available, bus, activepower, reactivepower, tech, _forecasts, ext, InfrastructureSystemsInternal())
end

function HydroFix(; name, available, bus, activepower, reactivepower, tech, _forecasts=InfrastructureSystems.Forecasts(), ext=nothing, )
    HydroFix(name, available, bus, activepower, reactivepower, tech, _forecasts, ext, )
end


function HydroFix(name, available, bus, activepower, reactivepower, tech, ; ext=nothing)
    _forecasts=InfrastructureSystems.Forecasts()
    HydroFix(name, available, bus, activepower, reactivepower, tech, _forecasts, ext, InfrastructureSystemsInternal())
end

# Constructor for demo purposes; non-functional.

function HydroFix(::Nothing)
    HydroFix(;
        name="init",
        available=false,
        bus=Bus(nothing),
        activepower=0.0,
        reactivepower=0.0,
        tech=TechHydro(nothing),
        _forecasts=InfrastructureSystems.Forecasts(),
        ext=nothing,
    )
end

"""Get HydroFix name."""
get_name(value::HydroFix) = value.name
"""Get HydroFix available."""
get_available(value::HydroFix) = value.available
"""Get HydroFix bus."""
get_bus(value::HydroFix) = value.bus
"""Get HydroFix activepower."""
get_activepower(value::HydroFix) = value.activepower
"""Get HydroFix reactivepower."""
get_reactivepower(value::HydroFix) = value.reactivepower
"""Get HydroFix tech."""
get_tech(value::HydroFix) = value.tech
"""Get HydroFix _forecasts."""
get__forecasts(value::HydroFix) = value._forecasts
"""Get HydroFix ext."""
get_ext(value::HydroFix) = value.ext
"""Get HydroFix internal."""
get_internal(value::HydroFix) = value.internal
