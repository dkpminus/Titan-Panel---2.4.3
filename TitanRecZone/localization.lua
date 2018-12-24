TRZ_TITLE			= "Titan Panel [Recommended Zone]";
TRZ_VERSION		= "2.0 (20003)";

-- Enumerations. Same for all languages.
TRZ_ALLIANCE			= 0;
TRZ_HORDE			= 1;
TRZ_CONTESTED			= 2;
TRZ_CITY			= 3;
TRZ_KALIMDOR			= 1;
TRZ_EASTERN 			= 2;
TRZ_OUTLAND			= 3;
TRZ_INSTANCE			= 11;
TRZ_BATTLEGROUND	= 12;
TRZ_RAID20				= 13;
TRZ_RAID40				= 14;
TRZ_RAID10				= 15;
TRZ_RAID25              = 16;

TRZ_CONTINENT={ GetMapContinents() };

-- Start English
TRZ_UNKNOW_ENTITY	= "Unknown Entity";
TRZ_NONE					= "None";
TRZ_FACTION={
	[TRZ_ALLIANCE] 	= FACTION_ALLIANCE,
	[TRZ_HORDE] 		= FACTION_HORDE,
	[TRZ_CONTESTED]	= "Contested",
	[TRZ_CITY] 			= "City",
}
TRZ_INSTANCE_TYPE={
	[TRZ_INSTANCE]						= "",
	[TRZ_BATTLEGROUND] 				= " (Battleground)",
	[TRZ_RAID20]							= " (Raid 20)",
	[TRZ_RAID40]							= " (Raid 40)",
        [TRZ_RAID10]							= " (Raid 10)",
        [TRZ_RAID25]                            = " (RAID 25)",
}

TRZ_MENU_TEXT 								= 'Recommended Zone';
TRZ_BUTTON_LABEL 							= 'Zone: ';
TRZ_TOOLTIP_TITEL 						= 'Zone Info';
TRZ_TOGGLE_FACTION 						= 'Show Faction of zones';
TRZ_TOGGLE_CONTINENT 					= 'Show Continent for zones';
TRZ_TOGGLE_CUR_INSTANCE				= "Show Instances for current zone";
TRZ_TOGGLE_INSTANCE 					= 'Show Recommended Instances';
TRZ_TOGGLE_LOC								= 'Show Location of Instances';
TRZ_TOGGLE_RAID								= 'Show Raid Instances';
TRZ_TOGGLE_BG									= 'Show Battlegrounds';
TRZ_TOGGLE_LOWER							= 'Recommend slightly lower level zones';
TRZ_TOGGLE_HIGHER							= 'Recommend slightly higher level zones';
TRZ_TOGGLE_MAP_TEXT 					= 'Show Zone Levels on Main Map';

TRZ_TOOLTIP_CZONE							= "Current Zone: ";
TRZ_TOOLTIP_CRANGE						= "Zone Range: ";
TRZ_TOOLTIP_CINSTANCES				= "Instances: ";
TRZ_TOOLTIP_RECOMMEND					= "Recommended Zones:";
TRZ_TOOLTIP_RECOMMEND_INSTANCES="Recommended Instances:";
TRZ_TOOLTIP_RZONE							= "Zone: ";
TRZ_TOOLTIP_RINSTANCES				= "Instances: ";
TRZ_TOOLTIP_TO								= "to";
TRZ_TOOLTIP_MORE							= "More....";

TRZ_DESCRIPTION	= "Displays the zone level ranage of the zone you are in and also gives you a suggest zone and instances to be in.";
TRZ_LOADED			= "|cffffff00" .. TRZ_TITLE .. " v" .. TRZ_VERSION .. " loaded";

TRZ_ZONES={ 
     [0]={ nr= 1, low=18,high=30,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={[0]=5,[1]=20} },	-- Ashenvale
     [1]={ nr= 2, low=45,high=55,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={} },	-- Azshara
     [2]={ nr= 3, low= 1,high=10,faction=TRZ_ALLIANCE ,continent=TRZ_KALIMDOR,instances={} },	-- Azuremyst Isle
     [3]={ nr= 4, low=10,high=20,faction=TRZ_ALLIANCE ,continent=TRZ_KALIMDOR,instances={} },	-- Bloodmyst Isle
     [4]={ nr= 5, low=10,high=20,faction=TRZ_ALLIANCE ,continent=TRZ_KALIMDOR,instances={} },	-- Darkshore
     [5]={ nr= 6, low= 0,high= 0,faction=TRZ_CITY     ,continent=TRZ_KALIMDOR,instances={} },	-- Darnassus
     [6]={ nr= 7, low=30,high=40,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={[0]=11} },	-- Desolace
     [7]={ nr= 8, low= 1,high=10,faction=TRZ_HORDE    ,continent=TRZ_KALIMDOR,instances={} },	-- Durotar
     [8]={ nr= 9, low=35,high=45,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={[0]=25} },	-- Dustwallow Marsh
     [9]={ nr=10, low=48,high=55,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={} },	-- Felwood
    [10]={ nr=11, low=40,high=50,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={[0]=17} },	-- Feralas
    [11]={ nr=12, low= 1,high=60,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={} },	-- Moonglade
    [12]={ nr=13, low= 1,high=10,faction=TRZ_HORDE    ,continent=TRZ_KALIMDOR,instances={} },	-- Mulgore
    [13]={ nr=14, low= 0,high= 0,faction=TRZ_CITY     ,continent=TRZ_KALIMDOR,instances={[0]=0} },	-- Orgrimmar
    [14]={ nr=15, low=55,high=60,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={[0]=27,[1]=28} },	-- Silithus
    [15]={ nr=16, low=15,high=27,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={} },	-- Stonetalon Mountains
    [16]={ nr=17, low=40,high=50,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={[0]=12,[1]=45,[2]=46,[3]=51} },	-- Tanaris
    [17]={ nr=18, low= 1,high=10,faction=TRZ_ALLIANCE ,continent=TRZ_KALIMDOR,instances={} },	-- Teldrassil
    [18]={ nr=19, low=10,high=25,faction=TRZ_HORDE    ,continent=TRZ_KALIMDOR,instances={[0]=1,[1]=7,[2]=9,[3]=19}},	-- The Barrens
    [19]={ nr=20, low=0 ,high=0 ,faction=TRZ_CITY     ,continent=TRZ_KALIMDOR,instances={} },    -- The Exodar
    [20]={ nr=21, low=25,high=35,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={} },	-- Thousand Needles
    [21]={ nr=22, low= 0,high= 0,faction=TRZ_CITY     ,continent=TRZ_KALIMDOR,instances={} },	-- Thunder Bluff
    [22]={ nr=23, low=48,high=55,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={} },	-- Un'Goro Crater
    [23]={ nr=24, low=55,high=60,faction=TRZ_CONTESTED,continent=TRZ_KALIMDOR,instances={} },	-- Winterspring
    [24]={ nr= 1, low=30,high=40,faction=TRZ_CONTESTED,continent=TRZ_EASTERN ,instances={} },	-- Alterac Mountains
    [25]={ nr= 2, low=30,high=40,faction=TRZ_CONTESTED,continent=TRZ_EASTERN ,instances={[0]=21} },	-- Arathi Highlands
    [26]={ nr= 3, low=35,high=45,faction=TRZ_CONTESTED,continent=TRZ_EASTERN ,instances={[0]=10} },	-- Badlands
    [27]={ nr= 4, low=45,high=55,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={} },	-- Blasted Lands
    [28]={ nr= 5, low=50,high=58,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={[0]=14,[1]=15,[2]=37,[3]=23,[4]=24} },	-- Burning Steppes
    [29]={ nr= 6, low=55,high=60,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={[0]=47} },	-- Deadwind Pass
    [30]={ nr= 7, low= 1,high=10,faction=TRZ_ALLIANCE ,continent=TRZ_EASTERN, instances={[0]=6} },	-- Dun Morogh
    [31]={ nr= 8, low=18,high=30,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={} },	-- Duskwood
    [32]={ nr= 9, low=53,high=60,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={[0]=16,[1]=29} },	-- Eastern Plaguelands
    [33]={ nr=10, low= 1,high=10,faction=TRZ_ALLIANCE ,continent=TRZ_EASTERN, instances={} },	-- Elwynn Forest
    [34]={ nr=11, low= 1,high=10,faction=TRZ_HORDE    ,continent=TRZ_EASTERN, instances={} },	-- Eversong Woods
    [35]={ nr=12, low=10,high=20,faction=TRZ_HORDE    ,continent=TRZ_EASTERN, instances={} },	-- Ghostlands
    [36]={ nr=13, low=20,high=30,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={[0]=22} },	-- Hillsbrad Foothills
    [37]={ nr=14, low= 0,high= 0,faction=TRZ_CITY     ,continent=TRZ_EASTERN, instances={} },	-- Ironforge
    [38]={ nr=15, low=70,high=70,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={[0]=53,[1]=54} },   -- Isle of Quel'Danas
    [39]={ nr=16, low=10,high=20,faction=TRZ_ALLIANCE ,continent=TRZ_EASTERN, instances={} },	-- Loch Modan
    [40]={ nr=17, low=15,high=25,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={} },	-- Redridge Mountains
    [41]={ nr=18, low=43,high=50,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={} },	-- Searing Gorge
    [42]={ nr=19, low= 0,high= 0,faction=TRZ_CITY     ,continent=TRZ_EASTERN, instances={} },	-- Silvermoon City
    [43]={ nr=20, low=10,high=20,faction=TRZ_HORDE    ,continent=TRZ_EASTERN, instances={[0]=4} },	-- Silverpine Forest
    [44]={ nr=21, low= 0,high= 0,faction=TRZ_CITY     ,continent=TRZ_EASTERN, instances={[0]=3} },	-- Stormwind City
    [45]={ nr=22, low=30,high=45,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={[0]=26} },	-- Stranglethorn Vale
    [46]={ nr=23, low=35,high=45,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={[0]=13} },	-- Swamp of Sorrows
    [47]={ nr=24, low=40,high=50,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={} },	-- The Hinterlands
    [48]={ nr=25, low= 1,high=10,faction=TRZ_HORDE    ,continent=TRZ_EASTERN, instances={[0]=8} },	-- Tirisfal Glades
    [49]={ nr=26, low= 0,high= 0,faction=TRZ_CITY     ,continent=TRZ_EASTERN, instances={} },	-- Undercity
    [50]={ nr=27, low=51,high=58,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={[0]=18} },	-- Western Plaguelands
    [51]={ nr=28, low=10,high=20,faction=TRZ_ALLIANCE ,continent=TRZ_EASTERN, instances={[0]=2} },	-- Westfall
    [52]={ nr=29, low=20,high=30,faction=TRZ_CONTESTED,continent=TRZ_EASTERN, instances={} },	-- Wetlands
    [53]={ nr= 1, low=65,high=68,faction=TRZ_CONTESTED,continent=TRZ_OUTLAND, instances={[0]=48} },	--  Blade's Edge Mountains
    [54]={ nr= 2, low=58,high=63,faction=TRZ_CONTESTED,continent=TRZ_OUTLAND, instances={[0]=30,[1]=31,[2]=35,[3]=36} },	--  Hellfire Peninsula
    [55]={ nr= 3, low=64,high=67,faction=TRZ_CONTESTED,continent=TRZ_OUTLAND, instances={} },	--  Nagrand
    [56]={ nr= 4, low=67,high=70,faction=TRZ_CONTESTED,continent=TRZ_OUTLAND, instances={[0]=42,[1]=43,[2]=44,[3]=50} },	--  Netherstorm
    [57]={ nr= 5, low=67,high=70,faction=TRZ_CONTESTED,continent=TRZ_OUTLAND, instances={[0]=52} },	--  Shadowmoon Valley
    [58]={ nr= 6, low= 0,high= 0,faction=TRZ_CITY     ,continent=TRZ_OUTLAND, instances={} },	--  Shattrath City
    [59]={ nr= 7, low=62,high=65,faction=TRZ_CONTESTED,continent=TRZ_OUTLAND, instances={[0]=38,[1]=39,[2]=40,[3]=41} },	--  Terokkar Forest
    [60]={ nr= 8, low=60,high=64,faction=TRZ_CONTESTED,continent=TRZ_OUTLAND, instances={[0]=32,[1]=33,[2]=34,[3]=49} },	--  Zangarmarsh
}

TRZ_INSTANCES={
   [0] ={ zone="Ragefire Chasm",		low=13, high=18, type=TRZ_INSTANCE,     faction=TRZ_HORDE,     loc=13 },--Orgrimmar
   [1] ={ zone="Wailing Caverns",		low=17, high=24, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=18 },--The Barrens
   [2] ={ zone="The Deadmines",			low=17, high=26, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=51 },--Westfall
   [3] ={ zone="Stockades",			low=24, high=32, type=TRZ_INSTANCE,     faction=TRZ_ALLIANCE,  loc=44 },--Stormwind City
   [4] ={ zone="Shadowfang Keep",		low=22, high=30, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=43 },--Silverpine Forest
   [5] ={ zone="Blackfathom Deeps",		low=24, high=32, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=0 },--ashenvale
   [6] ={ zone="Gnomeregan",			low=29, high=38, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=30 },-- Dun Morgoht
   [7] ={ zone="Razorfen Kraul",		low=29, high=38, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=18 },--The Barrens
   [8] ={ zone="Scarlet Monastary",		low=34, high=45, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=48 },-- Tirsifal Glades
   [9] ={ zone="Razorfen Downs",		low=37, high=46, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=18 },--The Barrens
   [10]={ zone="Uldaman",			low=35, high=47, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=26 },--Badlands
   [11]={ zone="Maraudon",			low=46, high=55, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=6 },--Desolace
   [12]={ zone="Zul'Farrak",			low=44, high=54, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=16 },--Tanaris
   [13]={ zone="Sunken Temple of Atal'Hakkar",  low=45, high=55, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=46 },--Swamp of sorrows
   [14]={ zone="Blackrock Depths",		low=52, high=60, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=28 },--Burning Steppes
   [15]={ zone="Lower Blackrock Spire",		low=54, high=61, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=28 },--Burning Steppes
   [16]={ zone="Stratholme",			low=58, high=63, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=32},--Eastern Plaguelands
   [17]={ zone="Dire Maul",			low=55, high=63, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=10},-- Feralas
   [18]={ zone="Scholomance",			low=58, high=63, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=50 },-- Western Plaguelands
   [19]={ zone="Warsong Gulch",			low=10, high=60, type=TRZ_BATTLEGROUND, faction=TRZ_HORDE,     loc=18 },--Barrens
   [20]={ zone="Warsong Gulch",			low=10, high=60, type=TRZ_BATTLEGROUND, faction=TRZ_ALLIANCE,  loc=0 },--Ashenvale
   [21]={ zone="Arathi Basin",			low=20, high=60, type=TRZ_BATTLEGROUND, faction=TRZ_CONTESTED, loc= 25},--Arathi Highlands
   [22]={ zone="Alterac Valley",		low=51, high=60, type=TRZ_BATTLEGROUND, faction=TRZ_CONTESTED, loc=36 },--Hilsbarad Foothills
   [23]={ zone="Blackwing Lair",		low=60, high=70, type=TRZ_RAID40,       faction=TRZ_CONTESTED, loc=28, iloc=42 },--Burning Steppes,Silverpine
   [24]={ zone="Molten Core",			low=60, high=70, type=TRZ_RAID40,       faction=TRZ_CONTESTED, loc=28, iloc=50 },--Burning Steppes,Westfall
   [25]={ zone="Onyxia's Lair",			low=60, high=70, type=TRZ_RAID40,       faction=TRZ_CONTESTED, loc=8 },-- Dustshallow March
   [26]={ zone="Zul'Gurub",			low=60, high=70, type=TRZ_RAID20,       faction=TRZ_CONTESTED, loc=45 },--Stranglethorn Vale
   [27]={ zone="Ruins of Ahn'Qiraj",		low=60, high=70, type=TRZ_RAID20,       faction=TRZ_CONTESTED, loc=14 },--Silithus
   [28]={ zone="Temple of Ahn'Qiraj",		low=60, high=70, type=TRZ_RAID40,       faction=TRZ_CONTESTED, loc=14 },--Silithus
   [29]={ zone="Naxxramas",			low=60, high=70, type=TRZ_RAID40,       faction=TRZ_CONTESTED, loc=32},--Eastern Plaguelands
   [30]={ zone="Blood Furnaces",		low=59, high=65, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=54 },--Hellfire Peninsula
   [31]={ zone="The Shattered Halls",		low=70, high=70, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=54 },--Hellfire Peninsula
   [32]={ zone="The Underbog",			low=61, high=67, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=60 },--Zangarmarsh
   [33]={ zone="The Steamvault",		low=70, high=70, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=60 },--Zangarmarsh
   [34]={ zone="The Slave Pens",		low=60, high=66, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=60 },--Zangarmarsh
   [35]={ zone="Magtheridons Lair",		low=70, high=70, type=TRZ_RAID25,       faction=TRZ_CONTESTED, loc=54 },--Hellfire Peninsula
   [36]={ zone="Hellfire Rampart",    		low=58, high=64, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=54 },--Hellfire Peninsula
   [37]={ zone="Upper Blackrock Spire",		low=55, high=62, type=TRZ_RAID10,       faction=TRZ_CONTESTED, loc=28 },--Burning Steppes
   [38]={ zone="Mana Tombs",		        low=62, high=68, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=59 },--Terokkar Forest
   [39]={ zone="Auchenai Crypts",		low=63, high=69, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=59 },--Terokkar Forest
   [40]={ zone="Sethekk Halls",		        low=65, high=70, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=59 },--Terokkar Forest
   [41]={ zone="Shadow Labyrinth",		low=70, high=70, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=59 },--Terokkar Forest
   [42]={ zone="The Mechanar",		        low=70, high=70, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=56 },--Netherstorm
   [43]={ zone="The Botanica",			low=70, high=70, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=56 },--Netherstorm
   [44]={ zone="The Arcatraz",			low=70, high=70, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=56 },--Netherstorm
   [45]={ zone="Caverns of time - Escape from Durnholde Keep",	low=66, high=68, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=16 },--Tanaris
   [46]={ zone="Caverns of time - Opening the Dark Portal",	low=70, high=70, type=TRZ_INSTANCE,     faction=TRZ_CONTESTED, loc=16 },--Tanaris
   [47]={ zone="Karazhan",			low=70, high=70, type=TRZ_RAID10,     faction=TRZ_CONTESTED, loc=29 },--Deadwind Pass
   [48]={ zone="Gruul's Lair",			low=70, high=70, type=TRZ_RAID25,     faction=TRZ_CONTESTED, loc=53 },--Blade's Edge Mountains
   [49]={ zone="Serpentshrine Cavern",		low=70, high=70, type=TRZ_RAID25,     faction=TRZ_CONTESTED, loc=60 },--Zangarmarsh
   [50]={ zone="The Eye",			low=70, high=70, type=TRZ_RAID25,     faction=TRZ_CONTESTED, loc=56 },--Netherstorm
   [51]={ zone="Caverns of time - The Battle for Mount Hyjal",	low=70, high=70, type=TRZ_RAID25,     faction=TRZ_CONTESTED, loc=16 },--Tanaris
   [52]={ zone="The Black Temple",		low=70, high=70, type=TRZ_RAID25,     faction=TRZ_CONTESTED, loc=57 },--Shadowmoon Valley
   [53]={ zone="Magisters' Terrace",    low=70, high=70, type=TRZ_INSTANCE, faction=TRZ_CONTESTED, loc=38 }, --Isle of Quel'Danas
   [54]={ zone="Sunwell Plateau",       low=70, high=70, type=TRZ_RAID25, faction=TRZ_CONTESTED, loc=38 }, --Isle of Quel'Danas

}

if GetLocale() == "deDE" then
   -- German translation provided by Gizpiella & Farook AUT

-- "Unknown Entitiy" as used in game
TRZ_UNKNOW_ENTITY	= "Unbekannte Entit\195\164t";
TRZ_NONE					= "Keine";
TRZ_FACTION={
	[TRZ_ALLIANCE] 	= FACTION_ALLIANCE,
	[TRZ_HORDE] 		= FACTION_HORDE,
	[TRZ_CONTESTED]	=	"Umk\195\164mpft",
	[TRZ_CITY] 			= "Stadt",
}
TRZ_INSTANCE_TYPE={
	[TRZ_INSTANCE]						= "",
	[TRZ_BATTLEGROUND] 				= " (Schlachtfeld)",
	[TRZ_RAID20]							= " (Raid 20)",
	[TRZ_RAID40]							= " (Raid 40)",
	[TRZ_RAID10]							= " (Raid 10)",
}

TRZ_MENU_TEXT 								= "Recommended Zone";
TRZ_BUTTON_LABEL 							= "Zonenlevel: ";
TRZ_TOOLTIP_TITEL 						= "Zoneninfo";
TRZ_TOGGLE_FACTION 						= 'Zeige Fraktion der Zonen';
TRZ_TOGGLE_CONTINENT 					= 'Zeige Kontinent der Zonen';
TRZ_TOGGLE_CUR_INSTANCE				= "Zeigen Instanzen f\195\188r gegenw\195\164rtige Zone";
TRZ_TOGGLE_INSTANCE 					= 'Zeige empfohlene Instanzen';
TRZ_TOGGLE_LOC								= 'Zeige Standort der Instanzen';
TRZ_TOGGLE_RAID								= 'Zeige Raid Instanzen';
TRZ_TOGGLE_BG									= 'Zeige Schlachtfeld';
TRZ_TOGGLE_LOWER							= 'Empfehle etwas niedrigere Zonen';
TRZ_TOGGLE_HIGHER							= 'Empfehle etwas h\195\182here Zonen';
TRZ_TOGGLE_MAP_TEXT 					= 'Zeige Zonenlevel auf der Weltkarte';

-- MouseOver Tooltip
TRZ_TOOLTIP_CZONE								= "Aktuelle Zone: ";
TRZ_TOOLTIP_CRANGE							= "Zonenlevel: ";
TRZ_TOOLTIP_CINSTANCES					= "Instanzen: ";
TRZ_TOOLTIP_RECOMMEND						= "Empfohlene Zonen:";
TRZ_TOOLTIP_RECOMMEND_INSTANCES	=	"Empfohlene Instanzen:";
TRZ_TOOLTIP_RZONE								= "Zone: ";
TRZ_TOOLTIP_RINSTANCES					= "Instanzen: ";
TRZ_TOOLTIP_TO									= "to";
TRZ_TOOLTIP_MORE								= "Mehr....";

TRZ_DESCRIPTION	= "Zeigt den Levelbereich der aktuellen Zone an und gibt eine Zonenempfehlung f\195\188r dein Level.";
TRZ_LOADED		= "|cffffff00" .. TRZ_VERSION .. " v" .. TRZ_TITLE .. " geladen";

--TRZ_ZONES[0].nr=14;  -- "Stormwind"
--TRZ_ZONES[1].nr=8;   -- "Ironforge"
--TRZ_ZONES[2].nr=4;   -- "Darnassus"
--TRZ_ZONES[3].nr=18;  -- "Undercity"
--TRZ_ZONES[4].nr=12;  -- "Orgrimmar"
--TRZ_ZONES[5].nr=19;  -- "Thunder Bluff"
--TRZ_ZONES[6].nr=10;  -- "Moonglade"
--TRZ_ZONES[7].nr=4;   -- "Dun Morogh"
--TRZ_ZONES[8].nr=21;  -- "Der Wald von Elwynn"
--TRZ_ZONES[9].nr=17;  -- "Teldrassil"
--TRZ_ZONES[10].nr=17; -- "Tirisfal"
--TRZ_ZONES[11].nr=7;  -- "Durotar"
--TRZ_ZONES[12].nr=11; -- "Mulgore"
--TRZ_ZONES[13].nr=9;  -- "Loch Modan"
--TRZ_ZONES[14].nr=22; -- "Westfall"
--TRZ_ZONES[15].nr=13; -- "Der Silberwald"
--TRZ_ZONES[16].nr=6;  -- "Dunkelk/195/188ste"
--TRZ_ZONES[17].nr=3;  -- "Das Brachland"
--TRZ_ZONES[18].nr=10; -- "Das Rotkammgebirge"
--TRZ_ZONES[19].nr=14; -- "Das Steinkrallengebirge"
--TRZ_ZONES[20].nr=1;  -- "Ashenvale"
--TRZ_ZONES[21].nr=15; -- "Das Sumpfland"
--TRZ_ZONES[22].nr=5;  -- "D/195/164mmerwald"
--TRZ_ZONES[23].nr=20; -- "Die Vorgebirge von Hillsbrad"
--TRZ_ZONES[24].nr=16; -- "Tausend Nadeln"
--TRZ_ZONES[25].nr=1;  -- "Das Alteracgebirge"
--TRZ_ZONES[26].nr=2;  -- "Das Arathihochland"
--TRZ_ZONES[27].nr=5;  -- "Desolace"
--TRZ_ZONES[28].nr=11; -- "Schlingendorntal"
--TRZ_ZONES[29].nr=24; -- "Das \195\150dland"
--TRZ_ZONES[30].nr=16; -- "Die S\195\188mpfe des Elends"
--TRZ_ZONES[31].nr=9;  -- "Die Marschen von Dustwallow"
--TRZ_ZONES[32].nr=7;  -- "Das Hinterland"
--TRZ_ZONES[33].nr=8;  -- "Feralas"
--TRZ_ZONES[34].nr=15; -- "Tanaris"
--TRZ_ZONES[35].nr=12; -- "Die Sengende Schlucht"
--TRZ_ZONES[36].nr=19; -- "Die verw\195\188steten Lande"
--TRZ_ZONES[37].nr=20; -- "Der Un'Goro Krater"
--TRZ_ZONES[38].nr=2;  -- "Azshara"
--TRZ_ZONES[39].nr=18; -- "Teufelswald"
--TRZ_ZONES[40].nr=3;  -- "Die Brennende Steppe"
--TRZ_ZONES[41].nr=23; -- "Die Westlichen Pestl\195\164nder"
--TRZ_ZONES[42].nr=6;  -- "Der Gebirgspass der Totenwinde"
--TRZ_ZONES[43].nr=25; -- "Die \195\182stlichen Pestl\195\164nder"
--TRZ_ZONES[44].nr=13; -- "Silithus"
--TRZ_ZONES[45].nr=21; -- "Winterspring"

TRZ_INSTANCES[0].zone="Ragefireabgrund"
TRZ_INSTANCES[1].zone="H\195\182hlen des Wehklagens"
TRZ_INSTANCES[2].zone="Die Todesminen"
TRZ_INSTANCES[3].zone="Das Verlies"
TRZ_INSTANCES[4].zone="Burg Shadowfang"
TRZ_INSTANCES[5].zone="Blackfathom-Tiefe"
TRZ_INSTANCES[6].zone="Gnomeregan"
TRZ_INSTANCES[7].zone="Kral von Razorfen"
TRZ_INSTANCES[8].zone="Das scharlachrote Kloster"
TRZ_INSTANCES[9].zone="H\195\188gel von Razorfen"
TRZ_INSTANCES[10].zone="Uldaman"
TRZ_INSTANCES[11].zone="Maraudon"
TRZ_INSTANCES[12].zone="Zul'Farrak"
TRZ_INSTANCES[13].zone="Der Tempel von Atal'Hakkar"
TRZ_INSTANCES[14].zone="Blackrocktiefen"
TRZ_INSTANCES[15].zone="Lower Blackrockspitze"
TRZ_INSTANCES[16].zone="Stratholme"
TRZ_INSTANCES[17].zone="D\195\188sterbruch"
TRZ_INSTANCES[18].zone="Scholomance"
TRZ_INSTANCES[19].zone="Warsongschlucht"
TRZ_INSTANCES[20].zone="Arathibecken"
TRZ_INSTANCES[21].zone="Arathibecken"
TRZ_INSTANCES[22].zone="Alteractal"
TRZ_INSTANCES[23].zone="Pechschwingenhort"
TRZ_INSTANCES[24].zone="Der geschmolzene Kern"
TRZ_INSTANCES[25].zone="Onyxias Hort"
TRZ_INSTANCES[26].zone="Zul'Gurub"
TRZ_INSTANCES[27].zone="Ruinen von Ahn'Qiraj"
TRZ_INSTANCES[28].zone="Ahn'Qiraj"
TRZ_INSTANCES[29].zone="Naxxramas"
TRZ_INSTANCES[30].zone="The Blood Furnaces"
TRZ_INSTANCES[31].zone="The Shattered Halls"
TRZ_INSTANCES[32].zone="The Underbog"
TRZ_INSTANCES[33].zone="The Steam Vault"
TRZ_INSTANCES[34].zone="The Slave Pens"
TRZ_INSTANCES[35].zone="Magtheridons Lair"
TRZ_INSTANCES[36].zone="Hellfire Rampart"
TRZ_INSTANCES[37].zone="Upper Blackrock Spire"
TRZ_INSTANCES[38].zone="Mana Tombs"
TRZ_INSTANCES[39].zone="Auchenai Crypts"
TRZ_INSTANCES[40].zone="Sethekk Halls"
TRZ_INSTANCES[41].zone="Shadow Labyrinth"
TRZ_INSTANCES[42].zone="The Mechanar"
TRZ_INSTANCES[43].zone="The Botanica"
TRZ_INSTANCES[44].zone="The Arcatraz"
TRZ_INSTANCES[45].zone="Caverns of time - Escape from Durnholde Keep"
TRZ_INSTANCES[46].zone="Caverns of time - Opening the Dark Portal"
TRZ_INSTANCES[47].zone="Karazhan"
TRZ_INSTANCES[48].zone="Gruul's Lair"
TRZ_INSTANCES[49].zone="Serpentshirine Cavern"
TRZ_INSTANCES[50].zone="The Eye"
TRZ_INSTANCES[51].zone="Caverns of time - The Battle for Mount Hyjal"
TRZ_INSTANCES[52].zone="The Black Temple"
TRZ_INSTANCES[53].zone="Magisters' Terrace"
TRZ_INSTANCES[54].zone="Sunwell Plateau"
end

if GetLocale() == "frFR" then
	
TRZ_UNKNOW_ENTITY = "Entit\195\169e inconnue";
TRZ_NONE					= "Rien";
TRZ_FACTION={
	[TRZ_ALLIANCE] 	= FACTION_ALLIANCE,
	[TRZ_HORDE] 		= FACTION_HORDE,
	[TRZ_CONTESTED]	=	"Contest\195\169",
	[TRZ_CITY] 			= "Cit\195\169",
}
TRZ_INSTANCE_TYPE={
	[TRZ_INSTANCE]						= "",
	[TRZ_BATTLEGROUND] 				= " (Champs de bataille)",
	[TRZ_RAID20]							= " (Incursion 20)",
	[TRZ_RAID40]							= " (Incursion 40)",
	[TRZ_RAID10]							= " (Incursion 10)",
}
	
TRZ_MENU_TEXT 									= "Zone Recommand\195\169e";
TRZ_BUTTON_LABEL 								= "Zone: ";
TRZ_TOOLTIP_TITEL 							= "Zone L'information";
TRZ_TOGGLE_FACTION 						= "Montrez la faction de la zone";
TRZ_TOGGLE_CONTINENT 					= "Montrez le continent pour des zones";
TRZ_TOGGLE_CUR_INSTANCE				= "Montrez les Instances pour la Zone courante";
TRZ_TOGGLE_INSTANCE 					= "Montrez Les Instances Recommand\195\169s";
TRZ_TOGGLE_LOC								= "Montrez l'endroit des Instances";
TRZ_TOGGLE_RAID								= "Montrez Les Instances D'Incursion";
TRZ_TOGGLE_BG									= "Montrez Les Champss de bataille";
TRZ_TOGGLE_LOWER							= "Recommandez les zones l\195\169g\195\170rement plus basses";
TRZ_TOGGLE_HIGHER							= "Recommandez les zones de niveau l\195\169g\195\170rement plus \195\169lev\195\169";
TRZ_TOGGLE_MAP_TEXT 					= "Montrez les niveaux de zone sur la carte";

TRZ_TOOLTIP_CZONE 							= "Zone actuelle: ";
TRZ_TOOLTIP_CRANGE 							= "Niveaux de la zone: ";
TRZ_TOOLTIP_CINSTANCES 					= "Instances: ";
TRZ_TOOLTIP_RECOMMEND 					= "Zones recommand\195\169es:";
TRZ_TOOLTIP_RECOMMEND_INSTANCES	= "Instances recommand\195\169es:";
TRZ_TOOLTIP_RZONE 							= "Zone: ";
TRZ_TOOLTIP_RINSTANCES 					= "Instances: ";
TRZ_TOOLTIP_TO									= "\195\160";
TRZ_TOOLTIP_MORE								= "Plus....";

TRZ_DESCRIPTION="Montre le niveau de la zone et vous conseille des alternatives.";
TRZ_LOADED="|cffffff00" .. TRZ_TITLE .. " v" .. TRZ_VERSION .. " Charg\195\169e";
	
--TRZ_ZONES[0].nr=2;   --  "Cit/195/169 de Stormwind"
--TRZ_ZONES[1].nr=11;  --  "Ironforge"
--TRZ_ZONES[2].nr=5;   --  "Darnassus"
--TRZ_ZONES[3].nr=24;  --  "Undercity"
--TRZ_ZONES[4].nr=15;  --  "Orgrimmar"
--TRZ_ZONES[5].nr=21;  --  "Thunder Bluff"
--TRZ_ZONES[6].nr=16;  --  "Reflet-de-Lune (Moonglade)"
--TRZ_ZONES[7].nr=5;   --  "Dun Morogh"
--TRZ_ZONES[8].nr=7;   --  "For/195/170t d'Elwynn"
--TRZ_ZONES[9].nr=20;  --  "Teldrassil"
--TRZ_ZONES[10].nr=3;  --  "Clairi/195/168res de Tirisfal"
--TRZ_ZONES[11].nr=6;  --  "Durotar"
--TRZ_ZONES[12].nr=14; --  "Mulgore"
--TRZ_ZONES[13].nr=15; --  "Loch Modan"
--TRZ_ZONES[14].nr=19; --  "Marche de l'Ouest (Westfall)"
--TRZ_ZONES[15].nr=8;  --  "For/195/170t des Pins argent/195/169s (Silverpine Forest)"
--TRZ_ZONES[16].nr=18; --  "Sombrivage (Darkshore)"
--TRZ_ZONES[17].nr=11; --  "Les Tarides (the Barrens)"
--TRZ_ZONES[18].nr=12; --  "Les Carmines (Redridge Mts)"
--TRZ_ZONES[19].nr=10; --  "Les Serres-Rocheuses (Stonetalon Mts)"
--TRZ_ZONES[20].nr=1;  --  "Ashenvale"
--TRZ_ZONES[21].nr=14; --  "Les Paluns (Wetlands)"
--TRZ_ZONES[22].nr=1;  --  "Bois de la p/195/169nombre (Duskwood)"
--TRZ_ZONES[23].nr=4;  --  "Contreforts d'Hillsbrad"
--TRZ_ZONES[24].nr=13; --  "Mille pointes (Thousand Needles)"
--TRZ_ZONES[25].nr=20; --  "Montagnes d'Alterac"
--TRZ_ZONES[26].nr=10; --  "Hautes-terres d'Arathi"
--TRZ_ZONES[27].nr=7;  --  "D/195/169solace"
--TRZ_ZONES[28].nr=25; --  "Vall/195/169e de Strangleronce (Stranglethorn Vale)"
--TRZ_ZONES[29].nr=23; --  "Terres ingrates (Badlands)"
--TRZ_ZONES[30].nr=18; --  "Marais des Chagrins (Swamp of Sorrows)"
--TRZ_ZONES[31].nr=12; --  "Mar/195/169cage d'/195/130prefange (Dustwallow Marsh)"
--TRZ_ZONES[32].nr=13; --  "Les Hinterlands"
--TRZ_ZONES[33].nr=8;  --  "Feralas"
--TRZ_ZONES[34].nr=19; --  "Tanaris"
--TRZ_ZONES[35].nr=9;  --  "Gorge des Vents br/195/187lants (Searing Gorge)"
--TRZ_ZONES[36].nr=22; --  "Terres foudroy/195/169es (Blasted Lands)"
--TRZ_ZONES[37].nr=4;  --  "Crat/195/168re d'Un'Goro"
--TRZ_ZONES[38].nr=2;  --  "Azshara"
--TRZ_ZONES[39].nr=9;  --  "Gangrebois (Felwood)"
--TRZ_ZONES[40].nr=21; --  "Steppes ardentes"
--TRZ_ZONES[41].nr=17; --  "Maleterres de l'ouest (Western Plaguelands)"
--TRZ_ZONES[42].nr=6;  --  "D/195/169fil/195/169 de Deuillevent (Deadwind Pass)"
--TRZ_ZONES[43].nr=16; --  "Maleterres de l'est (Eastern Plaguelands)"
--TRZ_ZONES[44].nr=17; --  "Silithus"
--TRZ_ZONES[45].nr=3;  --  "Berceau-de-l'Hiver (Winterspring)"

TRZ_INSTANCES[0].zone="Gouffre de Ragefeu"
TRZ_INSTANCES[1].zone="Cavernes des lamentations"
TRZ_INSTANCES[2].zone="Mortemines"
TRZ_INSTANCES[3].zone="La Prison"
TRZ_INSTANCES[4].zone="Donjon d\'Ombrecroc"
TRZ_INSTANCES[5].zone="Profondeurs de Brassenoire"
TRZ_INSTANCES[6].zone="Gnomeregan"
TRZ_INSTANCES[7].zone="Kraal de Tranchebauge"
TRZ_INSTANCES[8].zone="Monast\195\168re \195\169carlate"
TRZ_INSTANCES[9].zone="Souilles de Tranchebauge"
TRZ_INSTANCES[10].zone="Uldaman"
TRZ_INSTANCES[11].zone="Maraudon"
TRZ_INSTANCES[12].zone="Zul'Farrak"
TRZ_INSTANCES[13].zone="Le Temple d'Atal'Hakkar"
TRZ_INSTANCES[14].zone="Profondeurs de Blackrock"
TRZ_INSTANCES[15].zone="Pic Blackrock"
TRZ_INSTANCES[16].zone="Stratholme"
TRZ_INSTANCES[17].zone="Haches-Tripes"
TRZ_INSTANCES[18].zone="Scholomance"
TRZ_INSTANCES[19].zone="Warsong Gulch"
TRZ_INSTANCES[20].zone="Arathi Basin"
TRZ_INSTANCES[21].zone="Arathi Basin"
TRZ_INSTANCES[22].zone="Alterac Valley"
TRZ_INSTANCES[23].zone="Blackwing Lair"
TRZ_INSTANCES[24].zone="Molten Core"
TRZ_INSTANCES[25].zone="l'Antre d'Onyxia"
TRZ_INSTANCES[26].zone="Zul'Gurub"
TRZ_INSTANCES[27].zone="Ruines d'Ahn'Qiraj"
TRZ_INSTANCES[28].zone="Temple of Ahn'Qiraj"
TRZ_INSTANCES[29].zone="Naxxramas"
TRZ_INSTANCES[30].zone="La Fournaise du sang"
TRZ_INSTANCES[31].zone="Les Salles brisées"
TRZ_INSTANCES[32].zone="The Underbog"
TRZ_INSTANCES[33].zone="The Steam Vault"
TRZ_INSTANCES[34].zone="The Slave Pens"
TRZ_INSTANCES[35].zone="Magtheridons Lair"
TRZ_INSTANCES[36].zone="Hellfire Rampart"
TRZ_INSTANCES[37].zone="Upper Blackrock Spire"
TRZ_INSTANCES[38].zone="Mana Tombs"
TRZ_INSTANCES[39].zone="Auchenai Crypts"
TRZ_INSTANCES[40].zone="Sethekk Halls"
TRZ_INSTANCES[41].zone="Shadow Labyrinth"
TRZ_INSTANCES[42].zone="The Mechanar"
TRZ_INSTANCES[43].zone="The Botanica"
TRZ_INSTANCES[44].zone="The Arcatraz"
TRZ_INSTANCES[45].zone="Caverns of time - Escape from Durnholde Keep"
TRZ_INSTANCES[46].zone="Caverns of time - Opening the Dark Portal"
TRZ_INSTANCES[47].zone="Karazhan"
TRZ_INSTANCES[48].zone="Gruul's Lair"
TRZ_INSTANCES[49].zone="Serpentshirine Cavern"
TRZ_INSTANCES[50].zone="The Eye"
TRZ_INSTANCES[51].zone="Caverns of time - The Battle for Mount Hyjal"
TRZ_INSTANCES[52].zone="The Black Temple"
TRZ_INSTANCES[53].zone="Magisters' Terrace"
TRZ_INSTANCES[54].zone="Sunwell Plateau"
end