#=
This file is auto-generated. Do not edit.
=#
"""
    mutable struct VariableReserve <: Reserve
        name::String
        contributingdevices::Vector{<:Device}
        timeframe::Float64
        requirement::Float64
        _forecasts::InfrastructureSystems.Forecasts
        ext::Union{Nothing, Dict{String, Any}}
        internal::InfrastructureSystemsInternal
    end

Data Structure for the procurement products for system simulations.

# Arguments
- `name::String`
- `contributingdevices::Vector{<:Device}`: devices from which the product can be procured
- `timeframe::Float64`: the relative saturation timeframe
- `requirement::Float64`: the required quantity of the product should be scaled by a Forecast
- `_forecasts::InfrastructureSystems.Forecasts`: component forecasts
- `ext::Union{Nothing, Dict{String, Any}}`
- `internal::InfrastructureSystemsInternal`: power system internal reference, do not modify
"""
mutable struct VariableReserve <: Reserve
    name::String
    "devices from which the product can be procured"
    contributingdevices::Vector{<:Device}
    "the relative saturation timeframe"
    timeframe::Float64
    "the required quantity of the product should be scaled by a Forecast"
    requirement::Float64
    "component forecasts"
    _forecasts::InfrastructureSystems.Forecasts
    ext::Union{Nothing, Dict{String, Any}}
    "power system internal reference, do not modify"
    internal::InfrastructureSystemsInternal
end

function VariableReserve(name, contributingdevices, timeframe, requirement, _forecasts=InfrastructureSystems.Forecasts(), ext=nothing, )
    VariableReserve(name, contributingdevices, timeframe, requirement, _forecasts, ext, InfrastructureSystemsInternal())
end

function VariableReserve(; name, contributingdevices, timeframe, requirement, _forecasts=InfrastructureSystems.Forecasts(), ext=nothing, )
    VariableReserve(name, contributingdevices, timeframe, requirement, _forecasts, ext, )
end


function VariableReserve(name, contributingdevices, timeframe, requirement, ; ext=nothing)
    _forecasts=InfrastructureSystems.Forecasts()
    VariableReserve(name, contributingdevices, timeframe, requirement, _forecasts, ext, InfrastructureSystemsInternal())
end

# Constructor for demo purposes; non-functional.

function VariableReserve(::Nothing)
    VariableReserve(;
        name="init",
        contributingdevices=[ThermalStandard(nothing)],
        timeframe=0.0,
        requirement=0.0,
        _forecasts=InfrastructureSystems.Forecasts(),
        ext=nothing,
    )
end

"""Get VariableReserve name."""
get_name(value::VariableReserve) = value.name
"""Get VariableReserve contributingdevices."""
get_contributingdevices(value::VariableReserve) = value.contributingdevices
"""Get VariableReserve timeframe."""
get_timeframe(value::VariableReserve) = value.timeframe
"""Get VariableReserve requirement."""
get_requirement(value::VariableReserve) = value.requirement
"""Get VariableReserve _forecasts."""
get__forecasts(value::VariableReserve) = value._forecasts
"""Get VariableReserve ext."""
get_ext(value::VariableReserve) = value.ext
"""Get VariableReserve internal."""
get_internal(value::VariableReserve) = value.internal
