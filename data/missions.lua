------------------------------------------------------------------------------
-- Missions
------------------------------------------------------------------------------

gMissions = {}




------------------------------------------------------------------------------
-- Intro
------------------------------------------------------------------------------

gMissions["mall_intro"] = 
{
	level="mall",
	file = "mall_intro.xml",
	layers="mall_intro",
	title="The old building problem",
	desc="An old building is blocking Gordon's plans for a new wing at the mall. Help him demolish it.",
	securityTitle="",
	securityDesc="",
	primary=1,
	secondary=0,
	required=1,
	bonus = {},
}

------------------------------------------------------------------------------
-- Lee
------------------------------------------------------------------------------

gMissions["lee_computers"] = 
{
	level="lee",
	file = "lee.xml",
	layers="lee_computers secrets",
	title="The Lee Computers",
	desc="Parisa wants access to Lee's customer registry. Pick up three computers at the site for her.",
	securityTitle="Fire alarm",
	securityDesc="Large fires will trigger the alarm",
	primary=3,
	secondary=0,
	required=3,
	bonus = {},
}

gMissions["lee_login"] = 
{
	level="lee",
	file = "lee.xml",
	layers="lee_login secrets",
	title="The login devices",
	desc="Pick up three login devices for Parisa. They are protected by an alarm system. Security arrives 60 seconds after alarm is triggered. Make sure to plan ahead.",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=3,
	secondary=0,
	required=3,
	bonus = {},
}

gMissions["lee_safe"] = 
{
	level="lee",
	file = "lee.xml",
	layers="lee_safe secrets",
	title="Heavy lifting",
	desc="The GPS decryption key is in Lee's safe. Move the safe to your escape vehicle. If possible, also get the other safe and pick up all key cabinets.",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=1,
	secondary=4,
	required=1,
	bonus = {},
}

gMissions["lee_tower"] = 
{
	level="lee",
	file = "lee.xml",
	layers="lee_tower secrets",
	title="The tower",
	desc="Gordon wants to get back at Lee by making his iconic tower shorter. Remove the upper part of the tower.",
	securityTitle="Fire alarm",
	securityDesc="Large fires will trigger the alarm",
	primary=1,
	secondary=0,
	required=1,
	bonus = {},
}

gMissions["lee_powerplant"] = 
{
	level="lee",
	file = "lee.xml",
	layers="lee_powerplant secrets",
	title="Power outage",
	desc="Sabotage Lee Chemical's power supply system. Place the large bomb within the marked area by the dam turbines and detonate. Take out switchgear stations and transformers.",
	securityTitle="Explosion sensors",
	securityDesc="Breaking a target will trigger the alarm",
	primary=4,
	secondary=4,
	required=4,
	bonus = {},
}

gMissions["lee_flooding"] = 
{
	level="lee",
	file = "lee.xml",
	layers="lee_flooding secrets",
	title="Flooding",
	desc="Steal Lee's bookkeeping documents for Parisa.",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=5,
	secondary=3,
	required=5,
	bonus = {},
}

------------------------------------------------------------------------------
-- Mansion
------------------------------------------------------------------------------

gMissions["marina_demolish"] = 
{
	level="marina",
	file = "marina.xml",
	layers="marina_demolish secrets",
	title="Making space",
	desc="Make room for Gordon's new yacht at the Marina by demolishing the outermost cabin. Destroy proof of ownership by dumping safes in the ocean.",
	securityTitle="Fire alarm",
	securityDesc="Large fires will trigger the alarm",
	primary=2,
	secondary=1,
	required=2,
	bonus = {},
}

gMissions["marina_gps"] = 
{
	level="marina",
	file = "marina.xml",
	layers="marina_gps secrets",
	title="The GPS devices",
	desc="Steal GPS devices from Lee's boats and get the log files from harbor office.",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=3,
	secondary=2,
	required=3,
	bonus = {},
}

gMissions["marina_cars"] = 
{
	level="marina",
	file = "marina.xml",
	layers="marina_cars secrets",
	title="Classic cars",
	desc="Get the two classic cars for Gordon. Drive them to the marked area at the back of the truck. If possible, also pick up spare parts and vehicle registration documents.",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=2,
	secondary=2,
	required=2,
	bonus = {},
}

gMissions["marina_tools"] = 
{
	level="marina",
	file = "marina.xml",
	layers="marina_tools secrets",
	title="Tool up",
	desc="Lee needs new tools for rebuilding the tower. Help him get them from the marina",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=4,
	secondary=2,
	required=4,
	bonus = {},
}

gMissions["marina_art_back"] = 
{
	level="marina",
	file = "marina.xml",
	layers="marina_art_back secrets",
	title="Art return",
	desc="Lee has hidden four paintings at the marina. Help the insurance company retrieve them. Avoid setting off the fire alarm.",
	securityTitle="Fire alarm",
	securityDesc="Too much fire triggers the alarm",
	primary=4,
	secondary=0,
	required=4,
	bonus = {},
}

------------------------------------------------------------------------------
-- Mansion
------------------------------------------------------------------------------

gMissions["mansion_pool"] = 
{
	level="mansion",
	file = "mansion.xml",
	layers="mansion_pool secrets",
	title="The car wash",
	desc="Dump at least three of Gordon's expensive cars in water",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=0,
	secondary=6,
	required=3,
	bonus = {},
}

gMissions["mansion_art"] = 
{
	level="mansion",
	file = "mansion.xml",
	layers="mansion_art secrets",
	title="Fine arts",
	desc="Steal at least four paintings from Gordon's art collection for Lee",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=0,
	secondary=8,
	required=4,
	bonus = {},
}


gMissions["mansion_fraud"] = 
{
	level="mansion",
	file = "mansion.xml",
	layers="mansion_fraud secrets",
	title="Insurance fraud",
	desc="Help Gordon steal at least three of his own cars to help him with the insurance payout.",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=0,
	secondary=7,
	required=3,
	bonus = {},
}


gMissions["mansion_safe"] = 
{
	level="mansion",
	file = "mansion.xml",
	layers="mansion_safe secrets",
	title="A wet affair",
	desc="Destroy Gordon's insurance papers by dumping his brand new safes in water. The safes feature a moisture alarm that triggers in contact with water or rain.",
	securityTitle="Moisture sensor alarm",
	securityDesc="A safe in rain or water will trigger alarm",
	primary=3,
	secondary=3,
	required=3,
	bonus = {},
}


gMissions["mansion_race"] = 
{
	level="mansion",
	file = "mansion.xml",
	layers="mansion_race secrets",
	title="The speed deal",
	desc="Help Lee annoy Gordon by beating the track record on his private race track.",
	securityTitle="Fire alarm",
	securityDesc="Too much fire triggers the alarm",
	primary=1,
	secondary=2,
	required=1,
	bonus = {},
}

------------------------------------------------------------------------------
-- Cave Island
------------------------------------------------------------------------------

gMissions["caveisland_computers"] = 
{
	level="caveisland",
	file = "caveisland.xml",
	layers="caveisland_computers secrets",
	title="The BlueTide Computers",
	desc="Steal computers for Parisa to investigate Lee's payments from BlueTide",
	securityTitle="Wired alarm boxes",
	securityDesc="Breaking an alarm box or wire triggers the alarm",
	primary=5,
	secondary=3,
	required=5,
	bonus = {},
}

gMissions["caveisland_propane"] = 
{
	level="caveisland",
	file = "caveisland.xml",
	layers="caveisland_propane secrets",
	title="Motivational reminder",
	desc="Destroy Mr Amanatides propane tanks for Gillian to demonstrate the true value of proper insurance.",
	securityTitle="Explosion sensors",
	securityDesc="Blowing up a propane tank will trigger the alarm",
	primary=5,
	secondary=3,
	required=5,
	bonus = {},
}

gMissions["caveisland_dishes"] = 
{
	level="caveisland",
	file = "caveisland.xml",
	layers="caveisland_dishes secrets",
	title="An assortment of dishes",
	desc="Download communication data from three satellite dishes and at least two communication terminals. The island is protected by an armed  guard helicopter that arrives shortly after hacking the first target.",
	securityTitle="",
	securityDesc="",
	primary=3,
	secondary=6,
	required=5,
	bonus = {},
}

------------------------------------------------------------------------------
-- Frustrum
------------------------------------------------------------------------------

gMissions["frustrum_chase"] = 
{
	level="frustrum",
	file = "frustrum.xml",
	layers="frustrum_chase",
	title="The chase",
	desc="The security helicopter caught you while escaping from Lee Chemicals. Get through the flooded village of Frustrum, reach the speedboat at the far end and escape through the tunnel.",
	securityTitle="",
	securityDesc="",
	primary=1,
	secondary=0,
	required=1,
	bonus = {},
}
