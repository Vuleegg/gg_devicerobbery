Config = {}
Config.Debug = false -- if you want to see zone change to true
Config.Blip = true -- if you want to have blip for robbery change to true
Config.Time = 10000 --Time for table rob (1000 = 1 second)
Config.Rprogres = true -- change to true if you want rprogress,default is ox_lib progress
Config.RobberyTime = 180000 -- time for robbery (1000 - 1 second)
Config.Neededpolice = 0 -- Needed police officers for robbery
Config.Start = { -- where rob starts
    robbery = { 
        coords = vector3(142.2210, -233.879, 54.424),
},
}

Config.Blipsettings = {
      vulegg =  {  --[BLIP]
        id = 606,
        color = 1,
        blipcoords = vector3(149.1028, -227.237, 55.373),
        blipname = "Device robbery",
},
}

Config.Settings = {
    table1 = {
        --[TABLES]
        name = "table1", --zone name always must to be different
        coords = vector3(149.1028, -227.237, 55.373), --table coords   
    },
    table2 = {
       name = "table2",
       coords = vector3(152.7091, -228.887, 55.609), 
    },
    table3 = {
        name = "table3",
        coords = vector3(155.9101, -230.007, 55.396),
     },
     table4 = {
        name = "table4",
        coords = vector3(157.8217, -225.564, 55.373),
     },
     table5 = {
        name = "table5",
        coords = vector3(154.7259, -224.037, 55.373),
     },
     table6 = {
        name = "table6",
        coords = vector3(151.3875, -223.021, 55.372),
     },
     table7 = {
        name = "table7",
        coords = vector3(147.699996, -221.199996, 55.700000),
     },
     table8 = {
        name = "table8",
        coords = vector3(145.9705, -225.838, 55.373),
     },
}

Config.Sell = {
    {
    --[PED POSITION & ZONE]
    coords = vector3(-1838.26, 787.9520, 137.62), --ped position,zone,blip
    heading = 220.0,   --ped heading 
    price = 1386, -- price per part
    },
}

Config.Locale = { --notification
    ["sellfinish"] = {
        message = 'You sell items to the dealer',
        type = "sucess",
        time = 5000
    },
    ["missing"] = {
        message = 'You dont have items for sell',
        type = "sucess",
        time = 5000
    },
    ["needbag"] = {
        message = 'You need bag for robbery',
        type = "sucess",
        time = 5000
    },
    ["missionstart"] = {
        message = 'Robbery started,search tables',
        type = "sucess",
        time = 5000
    },
    ["time"] = {
        message = 'Its early',
        type = "sucess",
        time = 5000
    },
    ["robberytime"] = {
        message = 'You have per minutes to rob and run',
        type = "sucess",
        time = 5000
    },
    ["finish"] = {
        message = 'Robbery is finished,run!!!',
        type = "sucess",
        time = 5000
    },
    ["pdnotify"] = {
        message = 'Device robbery has startet,be careful',
        type = "sucess",
        time = 5000
    },
    ["neededpolice"] = {
        message = 'Police is not in city',
        type = "sucess",
        time = 5000
    },
}
