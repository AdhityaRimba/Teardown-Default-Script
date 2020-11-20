------------------------------------------------------------------------------
-- Messages
------------------------------------------------------------------------------

TRACY_SIGNATURE = {"txt gray", "Head of Sales\nLockelle Teardown Services"}

gMessages = {}
gMessages["boss_intro"] = 
{
	from = "tracy",
	subject = "Gas bill",
	body = 	
	{
		{"txt", "Gas bill just dropped on the floor. Honestly I'm not sure we can make it through the month. Are you getting any requests? At this point we pretty much have to accept anything. Be creative."},
		{"txt", "Hugs,\nMom"},
		{"div", ""},
		TRACY_SIGNATURE
	},
}

gMessages["mall_intro"] = 
{
	from = "tracy",
	subject = "Fwd: Old building problem",
	body = 	
	{
		{"txt", "This just came in. Sound kind of fishy, but we need the money. You up for it?"},
		{"div", ""},
		{"txt gray", "Forwarded message\nFrom: Gordon Woo\nSubject: Old building problem"},
		{"txt", "Good evening, my name is Gordon Woo, general manager at the Evertides Mall. I have a slight problem with an old building that's blocking our plans for a new wing and I'd need someone to knock it over."},
		{"img", "terminal/attachments/old_building.jpg"},
		{"txt", "I need it gone by tomorrow and I'd even be willing to pay more than the standard rate for some extra discretion, quick execution and uncomfortable working hours."},
		{"txt", "Would you be able to take care of it?"},
	},
	mission="mall_intro"
}

gMessages["boss_busted"] = 
{
	from = "tracy",
	subject = "Investigation...",
	body = 	
	{
		{"txt", "Uh, what a morning.. Shouldn't have taken that job, I knew something wasn't right. That building was under cultural heritage protection and the demolition is now part of a criminal investigation. Ms Terdiman at the police just sent me this photo:"},
		{"img", "terminal/attachments/speedcam.jpg"},
		{"txt", "They must have caught you on a traffic camera heading towards the mall. The very last thing we need right now is an investigation. I tried sweet talking her and she thought she could get the case dropped but asked for a favor in return.\n\nI don't know what she wants, but just do it. She'll e-mail you directly."},
		{"div", ""},
		TRACY_SIGNATURE
	},
}

gMessages["boss_coffee"] = 
{
	from = "tracy",
	subject = "Need coffee",
	body = 	
	{
		{"txt", "They turned off the gas. I can't even make a proper coffee any more. We really need to bring in more clients. I'll reach out to Gordon and see if he has something else."},
		{"txt", "I haven't heard back from the police. That thing sorted?"},
		{"txt", "/Mom"},
		{"div", ""},
		TRACY_SIGNATURE
	},
}

gMessages["boss_encourage_1"] = 
{
	from = "tracy",
	subject = "Looking better",
	body = 	
	{
		{"txt", "They turned the gas back on. Coffee never tasted better. I was skeptical about working with Mr Woo in the first place but he does pay well, so does the new client, Lee Chemicals, did they contact you directly?"},
		{"txt", "By the way, I heard on the news there's some madman on the loose around here. I hope you remember to lock the door at night."},
		{"txt", "Stay safe\n/Mom"},
		{"div", ""},
		TRACY_SIGNATURE
	},
}

gMessages["boss_encourage_2"] = 
{
	from = "tracy",
	subject = "Best month",
	body = 	
	{
		{"txt", "It looks like this is going to be our best month in years! If this continues we'll finally be able to replace the heating we talked about. Anyway, just wanted to say thanks. Well done."},
		{"txt", "Hugs and kisses,\nMom"},
		{"div", ""},
		TRACY_SIGNATURE
	},
}


------------------------------------------------------------------------------

PARISA_SIGNATURE = {"txt gray", "Parisa Terdiman, Criminal Investigator\nLockelle Police Department"}

gMessages["lee_computers"] = 
{
	from = "parisa",
	subject = "A favor",
	body = 	
	{
		{"txt", "Just so you know, I don't usually do this, but I'm stuck on a case and I feel like I should try something new."},
		{"txt", "I've been investigating Lawrence Lee Junior over tax evasion for months now, but he has so many friends in town that I can't get a warrant. How about you use your skills to \"borrow\" the computers over at Lee Chemicals so that I can finally access his customer registry and sort this mess out."},
		{"txt", "If you do this for me, I'll make sure your little blunder will be forgotten"},
		{"div", ""},
		PARISA_SIGNATURE,
	},
	mission="lee_computers"
}

gMessages["lee_login"] = 
{
	from = "parisa",
	subject = "Login devices",
	body = 	
	{
		{"txt", "The customer registry indicates that Lee has worked almost exclusively with a single client recently. The client is only refered to as BT and no further details, so I really have to bother you with one more favor."},
		{"img", "terminal/attachments/login_device.jpg"},
		{"txt", "Head back to Lee Chemicals and fetch their employee login devices. I should be able to cross reference their log files with the delivery schedule to figure out where they are moving the product and what BT means. I heard they installed a new security system. Be careful."},
		{"div", ""},
		PARISA_SIGNATURE,
	},
	mission="lee_login"
}

gMessages["marina_gps"] = 
{
	from = "parisa",
	subject = "GPS",
	body = 	
	{
		{"txt", "I've been up all night digging through the login devices and managed to find a connection to the West Point Marina."},
		{"txt", "I haven't been able to figure out more on BT, but Lee has a warehouse in West Point. I guess whatever fishy business he is up to, the marina is not the final destination."},
		{"txt", "I was thinking the boat GPS devices can give me an idea where he is moving the product, especially if I could compare their recent destinations to the shipping log. Can you get them for me?"},
		{"div", ""},
		PARISA_SIGNATURE,
	},
	mission="marina_gps"
}

gMessages["marina_gps_reminder"] = 
{
	from = "parisa",
	subject = "Re: GPS",
	body = 	
	{
		{"txt", "Still need those GPS devices... would be a shame to open that demolition investigation again wouldn't it?"},
		{"div", ""},
		PARISA_SIGNATURE,
	}
}

gMessages["lee_safe"] = 
{
	from = "parisa",
	subject = "Need decryption key",
	body = 	
	{
		{"txt", "Thanks for taking care of the GPS devices. Just one problem - they seem to be of a new, more secure type and I can't find out their recent locations without the decryption key."},
		{"txt", "My best bet is that Lee keeps the decryption key in his office safe, but it might also be in the production safe. I have one last favor to ask you and I think you already know what that might be."},
		{"div", ""},
		PARISA_SIGNATURE,
	},
	mission="lee_safe"
}

gMessages["lee_safe_done"] = 
{
	from = "parisa",
	subject = "Re: Heavy lifting",
	body = 	
	{
		{"txt", "Thanks. Now I just need to find someone who can work a safe. I'll get back to you in a bit and let you know how it goes."},
		{"div", ""},
		PARISA_SIGNATURE,
	},
}


gMessages["caveisland_computers"] = 
{
	from = "parisa",
	subject = "BlueTide",
	body = 	
	{
		{"txt", "Guess what! I managed to decrypt the GPS locations and it pointed me to Hollowrock Island. An old fish processing plant now making some kind of energy drink. BT is short for BlueTide! Why didn't I think of that before? My daughter is totally addicted to that disgusting, sugary sludge."},
		{"img", "terminal/attachments/caveisland.jpg"},
		{"txt", "I'm here right now. It's a bit worn down, but pretty (better than image, I'm still trying to figure out the mobile telephone camera). Most of the island is closed off for visitors and they don't seem very interested in answering questions."},
		{"txt", "I need to find out where the Lee payments go and if I could just have a look in the BlueTide computers that might bring some clarity. I was hoping you could do me this last favour?"},
		{"div", ""},
		{"txt gray", "Sent from mobile"},
	},
	mission="caveisland_computers"
}


gMessages["caveisland_dishes"] = 
{
	from = "parisa",
	subject = "Satellite dishes",
	body = 	
	{
		{"txt", "I've been going through the BlueTide computers and I think I'm onto something. This might actually be bigger than I first thought and goes way deeper than just Lee. BlueTide is controlled by someone called Mr Amanatides but there are no official records on him. Like he didn't exist!"},
		{"txt", "A lot of information is deleted from the computers, but I remember seeing satellite dishes on some of the buildings and got this idea to hack them and download the communication data directly. I know I said before there wouldn't be any more favors, but this really is the last one."},
		{"txt", "By the way.. seems they didn't appreciate our last visit because BlueTide just filed a security report for an armed guard helicopter. Be safe."},
		{"div", ""},
		PARISA_SIGNATURE,
	},
	mission="caveisland_dishes"
}


gMessages["lee_flooding"] = 
{
	from = "parisa",
	subject = "Flooding at Lee",
	body = 	
	{
		{"txt", "Sorry to contact you again. I was just going through the satellite data when I heard about the dam break at Lee."},
		{"txt", "I've been waiting for an opportunity to get a hold of Lee's accounting. It's the last missing piece in my Lee investigation. He has kept it hidden in various places, but right now the whole place is flooded due to some accident at the power plant and he moved everything upstairs. The site is completely empty at the moment so this is a golden opportunity to get a hold of those documents."},
		{"div", ""},
		PARISA_SIGNATURE,
	},
	mission="lee_flooding"
}

gMessages["frustrum_chase"] = 
{
	from = "parisa",
	subject = "Re: Flooding at Lee",
	body = 	
	{
		{"txt", "I just heard on the police radio that the chopper chased you down the river. ARE YOU OKAY?"},
		{"div", ""},
		PARISA_SIGNATURE,
	},
	mission="frustrum_chase"
}

------------------------------------------------------------------------------

gMessages["marina_demolish"] = 
{
	from = "gordon",
	subject = "Marina too small",
	body = 	
	{
		{"txt", "Thanks for helping me out with that building. The police was snooping around a little, but it seems to have cooled off now and we can finally start construction."},
		{"txt", "I actually have another job for you. See, I bought this yacht recently, but it's too large for the marina and the board says there is no space for a new dock."},
		{"img", "terminal/attachments/yacht.jpg"},
		{"txt", "Could you use your demolition skills again and remove one of the time share cabins? If the original documentation also disappeared then... tada! Like it was never there."},
	},
	mission="marina_demolish"
}


gMessages["marina_cars"] = 
{
	from = "gordon",
	subject = "Classic cars",
	body = 	
	{
		{"txt", "Fantastic work at the marina! Looks like it worked, because they just cleared a construction permit for the new dock."},
		{"txt", "Another thing came up. There was this classic car auction up in Black River the other day and one guy just kept overbidding me. Lawrence Lee Jr, that youngster who inherited the chemical plant a few years ago... absolutely no interest in cars, he's just looking for ways to rotate his dirty money."},
		{"img", "terminal/attachments/classic_cars.jpg"},
		{"txt", "It's a Gauss-Seidel B50, the one they used in Seal the Deal 2 and Colonel Wilson's personal Jacobi from Normandy. Lee is about to put those cars on a ship overseas any day now and they'll be out of the country for good. If that's not criminal I don't know what is. Can you help me acquire these two gems? I'll take good care of them."},
	},
	mission="marina_cars"
}


gMessages["marina_cars_reminder"] = 
{
	from = "gordon",
	subject = "Re: Classic cars",
	body = 	
	{
		{"txt", "Any update on the classic cars?"},
	}
}


gMessages["lee_tower"] = 
{
	from = "gordon",
	subject = "Water tower",
	body = 	
	{
		{"txt", "I still don't know how, but Lee found out about the cars and totally overreacted. I just saved the life of those poor cars and he goes completely mental and vandalizes my property. Can you believe that? Good thing I'm properly insured."},
		{"txt", "I've thought about ways to get back at him and finally nailed it. The iconic water tower at Lee Chemicals. His grandfather built it with his bare hands and it has since become a symbol for the entire Lee family. They even use it in their logotype."},
		{"txt", "Making that tower a little.. less tall would make a more suitable symbol for the small man he is."},
		{"img", "terminal/attachments/tower.jpg"},
	},
	mission="lee_tower"
}


gMessages["mansion_fraud"] = 
{
	from = "gordon",
	subject = "Insurance problem",
	body = 	
	{
		{"txt", "Not only did Lee steal some of our most beloved paintings, but the insurance company is causing me headaches too. I'm a premium customer, but I still haven't seen any money for those paintings. I'll deal with Lee later, but right now I need to take that insurance payout in my own hands."},
		{"txt", "I don't have a personal grudge with anyone at the company so I'd like to just poke them a bit where it hurts any respected company the most, their bank account."},
		{"txt", "I have a top notch policy on my cars, so if some of those were \"stolen\", they would need to cough up. I'll hook up a few cars to the alarm system to make it look legit. Please be gentle."},
	},
	mission="mansion_fraud"
}


gMessages["lee_powerplant"] = 
{
	from = "gordon",
	subject = "Full stop",
	body = 	
	{
		{"txt", "That little brat hit me again! You wouldn't believe the mess I came home to. It's gonna take weeks to clean up and the insurance company won't even pick up the phone."},
		{"txt:h2 red", "I've had it with Lee! It's time to show him not to mess with the big boys."},
		{"txt", "The chemical plant is Lee's life and I'm gonna put it out of operation. The power plant is the heart of the whole facility and I want it gone."},
		{"img", "terminal/attachments/turbines.jpg"},
		{"txt", "It's a sturdy beast, but I'll provide you with proper fire power to take out the main generator for good. Also take out all auxiliary power and the plant will be shut for a long, long time."},
	},
	mission="lee_powerplant"
}


gMessages["lee_powerplant_done"] = 
{
	from = "gordon",
	subject = "Re: Full stop",
	body = 	
	{
		{"txt", "Haha, I almost choked on my espresso when I turned on the news. Hilarious, I've been giggling all morning! Turns out that bomb worked even better than I planned. Great work!"},
		{"img", "terminal/attachments/dam_break.jpg"},
	},
}


------------------------------------------------------------------------------

LEE_SIGNATURE = {"txt gray", "Lawrence Lee Jr, CEO\nLee Chemicals - Bronze medal winner, Lockelle Business Innovation Prize 1984"}

gMessages["mansion_pool"] = 
{
	from = "lee",
	subject = "not really demolition but",
	body = 	
	{
		{"txt", "you don't know me, but i've had a series of break-ins recently. in the last one i lost two very rare, classic cars and guess what!? i know who did it! gordon woo, that absolute prick, is now bragging to everyone at the club about his two new fav possessions."},
		{"txt", "the break-ins caused me a lot of property damage and i'd like to let gordon taste some of his own medicine. since you're in the demolition industry i thought.. well..  i don't know if you do this sort of work, but let me know if it sounds interesting."},
		{"div", ""},
		LEE_SIGNATURE,
	},
	mission="mansion_pool"
}

gMessages["mansion_art"] = 
{
	from = "lee",
	subject = "that escalated quickly :-(",
	body = 	
	{
		{"txt", "gordon really took this one step too far. you probably heard it on the news, but he hit my tower. the LEE TOWER. my poor grandfather is probably turning in his grave right now. it'll cost me a fortune to rebuild that. i need to get back at gordon, but he's so loaded with money that whatever i do he can just pay someone to fix it."},
		{"txt", "the only way to get to him is to strike where his fat wallet can't protect him - his precious art collection. some of those paintings would also make a nice contribution to the restuaration fund for my new tower."},
		{"div", ""},
		LEE_SIGNATURE,
	},
	mission="mansion_art"
}

gMessages["marina_tools"] = 
{
	from = "lee",
	subject = "need tools",
	body = 	
	{
		{"txt", "by the way... there's some construction work going on at the marina. i've seen a lot of high-end tools laying around"},
		{"txt", "i could actually use some of them for rebuilding the tower. mind going there and pick em up?"},
		{"div", ""},
		LEE_SIGNATURE,
	},
	mission="marina_tools"
}

gMessages["mansion_race"] = 
{
	from = "lee",
	subject = "good at driving?",
	body = 	
	{
		{"txt", "hey, I just got this awesome idea for humiliating gordon.. you know that ridiculous, undersized race track he keeps in his back yard to pretend being a race driver. wouldn't it be funny if he came home to a new track record on that display? you a decent driver by any chance?"},
	{"txt", "by the way, those paintings you helped me with earlier.. they didn't make it through the thunderstorm. burned up, every single one. what are the odds... my only comfort is that at least gordon doesn't have them either"},
		{"div", ""},
		LEE_SIGNATURE,
	},
	mission="mansion_race"
}


------------------------------------------------------------------------------

GJK_SIGNATURE = {"txt gray", "Gillian Johnson, Claim Adjuster\nLockelle Branch, Keerthi Insurance Group Inc\n\nThis email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed."}

gMessages["marina_art_back"] = 
{
	from = "gjk",
	subject = "Missing artwork",
	body = 	
	{
		{"txt", "Good evening! I'm a claim adjuster at Keerthi Insurance Group, investigating an art incident that happened to Gordon Woo recently. Mr Woo claims to know who's responsible for the stolen paintings (A Mr Lawrence Lee Junior) but he is very keen to not involve the police."},
		{"txt", "Gordon's account has caused us some financial strain recently and it is in our interest to bring back the paintings as discreetly and swiftly as possible. According to our intelligence, the paintings are hidden at the Marina. I know Gordon has been working with you in the past. Maybe you can help me out?"},
		{"div", ""},
		GJK_SIGNATURE,
	},
	mission="marina_art_back"
}

gMessages["marina_art_back_done"] = 
{
	from = "gjk",
	subject = "Re: Missing artwork",
	body = 	
	{
		{"txt", "Nice job with the paintings! A little charred here and there, so I'll have to find someone to retouch them a bit before they are returned to Gordon. He won't know the difference."},
		{"img", "terminal/attachments/paintings.jpg"},
		{"txt", "Anyway, I heard about the thunderstorm. Glad you made it out safely.\nBest Regards,\nGillian"},
		{"div", ""},
		GJK_SIGNATURE,
	}
}

gMessages["mansion_safe"] = 
{
	from = "gjk",
	subject = "Insurance papers",
	body = 	
	{
		{"txt", "The claims from Gordon keep coming in. I'm not new to this game and suspect he's trying to pull a trick on us. I think the best solution would be if he took his problems elsewhere."},
		{"txt", "If I could just get rid of his insurance papers - poof, like that he'd be gone! He keeps the papers in one of his safes. Top-notch stuff, very sturdy and virtually unbreakable (trust me, he bought them on our recommendedation), but they have one weakness - not waterproof!"},
		{"txt", "Go to Gordon's place and dump his safes in water. That should smudge up the papers. Just one thing you should be aware of, the safes are equipped with moisture sensor alarms that will trigger when wet."},
		{"div", ""},
		GJK_SIGNATURE,
	},
	mission="mansion_safe"
}

gMessages["caveisland_propane"] = 
{
	from = "gjk",
	subject = "Motivational reminder",
	body = 	
	{
		{"txt", "I must say I'm very happy with our fruitful collaboration. I'd like to suggest we deepen our relationship with something we call \"motivational reminders\". It's a marketing technique that we sometimes employ for key customers."},
		{"txt", "I recently had a meeting with Mr Amanatides about the policy for BlueTide Inc. He's hesitating to include his propane tanks in the policy and I think a friendly reminder on why that is a good idea could nudge him in the right direction."},
		{"txt", "Since I don't run Gordon's account anymore an upsell to Mr Amanatides would look really pretty on my bonus check. Of course I'll make sure you are properly compensated and have all expenses covered."},
		{"div", ""},
		GJK_SIGNATURE,
	},
	mission="caveisland_propane"
}

gMessages["dev_thanks"] = 
{
	from = "tuxedolabs",
	subject = "Thank you",
	body = 	
	{
		{"txt", "Congratulations! You have finished part one of Teardown. We are currently working on part two and it will be released as a free update when ready."},
		{"txt", "Thank you for playing through the game and participating in the early access. We are eager to hear your feedback! If you have any questions, comments or suggestions, head over to the official discord server or reach out to us on twitter. You'll find links at the game homepage: teardowngame.com"},
		{"txt", "If you want to increase your score and rank, you can go back and replay some of the previous missions and try to complete more optional targets. If you haven't already, you can also try out the sandbox mode and play with unlimited resources, or build your own level in create mode."},
		{"div", ""},
		{"txt", "Sincerely,\nThe Teardown Developers"}
	}
}

