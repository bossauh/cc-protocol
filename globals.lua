require "apis"

IN = "__in.coms"
OUT = "__out.json"
MODULES = {
    turtle = {
        forward = turtle.forward,
        back = turtle.back,
        up = turtle.up,
        down = turtle.down,
        turnLeft = turtle.turnLeft,
        turnRight = turtle.turnRight,
        dig = turtle.dig,
        digUp = turtle.digUp,
        digDown = turtle.digDown,
        place = turtle.place,
        placeUp = turtle.placeUp,
        placeDown = turtle.placeDown,
        drop = turtle.drop,
        dropUp = turtle.dropUp,
        dropDown = turtle.dropDown,
        select = turtle.select,
        getItemCount = turtle.getItemCount,
        getItemSpace = turtle.getItemSpace,
        detect = turtle.detect,
        detectUp = turtle.detectUp,
        detectDown = turtle.detectDown,
        compare = turtle.compare,
        compareUp = turtle.compareUp,
        compareDown = turtle.compareDown,
        attack = turtle.attack,
        attackUp = turtle.attackUp,
        attackDown = turtle.attackDown,
        suck = turtle.suck,
        suckUp = turtle.suckUp,
        suckDown = turtle.suckDown,
        getFuelLevel = turtle.getFuelLevel,
        refuel = turtle.refuel,
        compareTo = turtle.compareTo,
        transferTo = turtle.transferTo,
        getSelectedSlot = turtle.getSelectedSlot,
        getFuelLimit = turtle.getFuelLimit,
        equipLeft = turtle.equipLeft,
        equipRight = turtle.equipRight,
        inspect = turtle.inspect,
        inspectUp = turtle.inspectUp,
        inspectDown = turtle.inspectDown,
        getItemDetail = turtle.getItemDetail,
        craft = turtle.craft
    },
    ["peripheral"] = {
        getNames = peripheral.getNames,
        call = peripheral.call,
        getMethods = peripheral.getMethods,
        isPresent = peripheral.isPresent,
        getType = peripheral.getType,
    },
    gps = {
        locate = gps.locate
    },
    server = {
        ping = server_ping
    }
}
