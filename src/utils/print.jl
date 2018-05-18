function printBus(short, io, b)
    # print(io)
    if short
        print("Name: ", b.name)
        print(", Type: ", b.bustype)
    else
        print("Bus Number ", b.number, ":")
        print("\n   ", b) # Prints short version
        print("\n   Angle: ", b.angle)
        print("\n   Voltage: ", b.voltage)
        print("\n   Voltage Limits: ", b.voltagelimits)
        print("\n   Base Voltage: ", b.basevoltage)
    end
end
# Single-line format
Base.show(io::IO, b::Bus) = printBus(true, io, b)
# Multi-line format for plaintext (e.g. from repl); can specify for HTML and others too
Base.show(io::IO, ::MIME"text/plain", b::Bus) = printBus(false, io, b)

function printTechGen(short, io, t)
    # print(io)
    if short
        print("Tech Gen")
    else
        print(t, ":") # Prints short version
        print("\n   Real Power: ", t.realpower)
        print("\n   Real Power Limits: ", t.realpowerlimits)
        print("\n   Reactive Power: ", t.reactivepower)
        print("\n   Reactive Power Limits: ", t.reactivepowerlimits)
        print("\n   Ramp Limits: ", t.ramplimits)
        print("\n   Time Limits: ", t.timelimits)
    end
end
Base.show(io::IO, t::TechGen) = printTechGen(true, io, t)
Base.show(io::IO, ::MIME"text/plain", t::TechGen) = printTechGen(false, io, t)

function printEconGen(short, io, e)
    # print(io)
    if short
        print("Econ Gen: ")
        print("\n   Capacity: ", e.capacity)
    else
        print(e) # Prints short version
        print("\n   Var Cost: ", e.variablecost)
        print("\n   Fixed Cost: ", e.fixedcost)
        print("\n   Startup Cost: ", e.startupcost)
        print("\n   Shutdown Cost: ", e.shutdncost)
        print("\n   Annual Capacity Factor: ", e.annualcapacityfactor)
    end
end
Base.show(io::IO, e::EconGen) = printEconGen(true, io, e)
Base.show(io::IO, ::MIME"text/plain", e::EconGen) = printEconGen(false, io, e)

function printThermalGen(short, io, t)
    # print(io)
    if short
        print("Thermal Gen: ")
        print("\n   Name: ", t.name)
        print(", Status: ", t.status)
    else
        print(t) # Prints short version
        print("\n   Bus:\n      ", t.bus)
        if t.tech != nothing
            print("\n   Tech:\n      ", t.tech)
        else
            print("\n   No Tech")
        end
        if t.econ != nothing
            print("\n   Econ:\n      ", t.econ)
        else
            print("\n   No Econ")
        end
    end
end
Base.show(io::IO, t::ThermalGen) = printThermalGen(true, io, t)
Base.show(io::IO, ::MIME"text/plain", t::ThermalGen) = printThermalGen(false, io, t)

# Renewable Gen

function printTechRenewable(short, io, t)
    # print(io)
    if short
        print("Tech RE: ")
        print("\n   Capacity: ", t.installedcapacity)
        print("\n   Power Limits: ", t.reactivepowerlimits)
        print("\n   Power Factor: ", t.powerfactor)
    else
        print(t) # Prints short version
    end
end
Base.show(io::IO, t::TechRenewable) = printTechRenewable(true, io, t)
Base.show(io::IO, ::MIME"text/plain", t::TechRenewable) = printTechRenewable(false, io, t)

function printEconRenewable(short, io, t)
    # print(io)
    if short
        print("Econ RE: ")
        print("\n   Curtail Cost: ", t.curtailcost)
        print("\n   Interrupt Cost: ", t.interruptioncost)
    else
        print(t) # Prints short version
    end
end
Base.show(io::IO, t::EconRenewable) = printEconRenewable(true, io, t)
Base.show(io::IO, ::MIME"text/plain", t::EconRenewable) = printEconRenewable(false, io, t)

function printRenewableFix(short, io, t)
    # print(io)
    if short
        print("RenewableFix: ")
        print("\n   Name: ", t.name)
        print(", Status: ", t.status)
    else
        print(t) # Prints short version
        print("\n   Bus:\n      ", t.bus)
        if t.tech != nothing
            print("\n   Tech:\n      ", t.tech)
        else
            print("\n   No Tech")
        end
    end
end
Base.show(io::IO, t::RenewableFix) = printRenewableFix(true, io, t)
Base.show(io::IO, ::MIME"text/plain", t::RenewableFix) = printRenewableFix(false, io, t)

function printRenewableCurtailment(short, io, t)
    # print(io)
    if short
        print("RenewableCurtailment: ")
        print("\n   Name: ", t.name)
        print(", Status: ", t.status)
    else
        print(t) # Prints short version
        print("\n   Bus:\n      ", t.bus)
        if t.tech != nothing
            print("\n   Tech:\n      ", t.tech)
        else
            print("\n   No Tech")
        end
        if t.econ != nothing
            print("\n   Econ:\n      ", t.econ)
        else
            print("\n   No Econ")
        end
        print("\n   Scaling Factor: ", t.scalingfactor) # TODO: only print start, end, etc, not whole series
    end
end
Base.show(io::IO, t::RenewableCurtailment) = printRenewableCurtailment(true, io, t)
Base.show(io::IO, ::MIME"text/plain", t::RenewableCurtailment) = printRenewableCurtailment(false, io, t)