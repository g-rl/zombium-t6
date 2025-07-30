// Imports
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm_utility;
#include scripts\zm\girly\func;
#include scripts\zm\girly\match;
#include scripts\zm\girly\player;
#include scripts\zm\girly\powerups;
#include scripts\zm\girly\hud;
#include scripts\zm\girly\girly;
#include scripts\zm\girly\commands;

m(lol)
{  
    if(lol == "buried")
    {
        return "zm_buried";

    } else if (lol == "motd" || lol == "mob") {
        
        return "zm_prison";

    } else if (lol == "dr" || lol == "dierise" || lol == "die rise" || lol == "rise") {

        return "zm_highrise";

    } else if (lol == "origins") {

        return "zm_tomb";
       
    } else if (lol == "bus" || lol == "tranzit" || lol == "transit") {

        return "zm_transit";
    }
}

mapToName()
{
    if(level.script == m("buried"))
    {
        return "buried";

    } else if(level.script == m("motd"))
    {
        return "mob of the dead";

    } else if (level.script == m("dr")) {

        return "die rise";

    } else if (level.script == m("origins")) {

        return "origins";
       
    } else if (level.script == m("tranzit")) {

        return "green run";
    }
}

mapToColor()
{
    if(level.script == m("buried"))
    {
        return "^6buried";

    } else if(level.script == m("motd"))
    {
        return "^1mob of the dead";

    } else if (level.script == m("dr")) {

        return "^3die rise";

    } else if (level.script == m("origins")) {

        return "^5origins";
       
    } else if (level.script == m("tranzit")) {

        return "^2green run";
    }
}


/*
mapscores3()
{
        if(level.script == m("buried") || level.script == m("dr") || level.script == m("bus"))
        { 

        self.mapscore_weapons = 4000;
        self thread getRandomWeapz(4000);

        } else if(level.script != m("buried") || level.script != ("dr") || level.script != ("bus")) {

        self.mapscore_weapons = 2250;
        self thread getRandomWeapz(2250);
        }                         
}
*/

mapscores2()    // Manage Random Perk by map
{
        if(level.script == m("buried") || level.script == m("dr") || level.script == m("bus"))
        { 

        self.mapscore_s = 7500;
        self thread mapSinglePerk(7500);

        } else if(level.script != m("buried") || level.script != ("dr") || level.script != ("bus")) {

        self.mapscore_s = 3750;
        self thread mapSinglePerk(3750);

        }                          // Maps with banks: $25K Perk Alls
                                   // Maps without banks: $10K Perk Alls
}

mapscores()    // Manage Random Perk by map
{
        if(level.script == m("buried") || level.script == m("dr") || level.script == m("bus"))
        { 

        self.mapscore = 25000;
        self thread mapPerks(25000);

        } else if(level.script != m("buried") || level.script != ("dr") || level.script != ("bus")) {

        self.mapscore = 10000;
        self thread mapPerks(10000);

        }                          // Maps with banks: $25K Perk Alls
                                   // Maps without banks: $10K Perk Alls
}

mapscores_a()   // Manage Max Ammo by map
{
        if(level.script == m("buried") || level.script == m("dr") || level.script == m("bus"))
        { 
        self.mapscore_ammo = 45000;
        self thread mapAmmo(45000);

        } else if(level.script != m("buried") || level.script != ("dr") || level.script != ("bus")) {

        self.mapscore_ammo = 15000;
        self thread mapAmmo(15000);

        }                        // Maps with banks: $45K Max Ammo
                                 // Maps without banks: $15K Max Ammo
}


// Random Weapon

/*
getRandomWeapz( var )
{

    	random_color = randomintrange( 1, 6 );
		colors = "^" + random_color;

        if(level.script == m("buried") || level.script == m("dr") || level.script == m("bus"))
        {


		if( self.score >= self.mapscore_weapons )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );
            self thread giverandomweap();
			
		//gpb("[" + self.clantag + "^7] " + self.clantag_color + player_name( self ) + " ^7has purchased a " + colors + "max ammo^7! (^2$45,000^7)");
		} else if( self.score < self.mapscore_weapons )

		{
		self thread imsg( "Insufficient funds!" );
		pr("^1* " + colors + "$4,000 ^7is required to buy a random weapon!");
		}
		wait 1;
		self.randomweaponz = undefined;

        } 
        else if(level.script != m("buried") || level.script != ("dr") || level.script != ("bus"))
        { 
		if( self.score >= self.mapscore_weapons )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );
            self thread giverandomweap();
			
		//gpb("[" + self.clantag + "^7] " + self.clantag_color + player_name( self ) + " ^7has purchased a " + colors + "max ammo^7! (^2$15,000^7)");
		} else if( self.score < self.mapscore_weapons )

		{
		self thread imsg( "Insufficient funds!" );
		pr("^1* " + colors + "$2,250 ^7is required to buy a random weapon!");
		}
		wait 1;
		self.randomweaponz = undefined;


        }

}
*/
//

mapAmmo( var )
{

    	random_color = randomintrange( 1, 6 );
		colors = "^" + random_color;

        if(level.script == m("buried") || level.script == m("dr") || level.script == m("bus"))
        {
		if( self.score >= self.mapscore_ammo )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );
            self thread full_ammo_powerup_override();
			
		gpb("[" + self.clantag + "^7] " + self.clantag_color + player_name( self ) + " ^7has purchased a " + colors + "max ammo^7! (^2$45,000^7)");
		} else if( self.score < self.mapscore_ammo )

		{
		self thread imsg( "Insufficient funds!" );
		pr("^1* " + colors + "$45,000 ^7is required to buy a max ammo!");
		}
		wait 1;
		self.maxammos = undefined;

        } 
        else if(level.script != m("buried") || level.script != ("dr") || level.script != ("bus"))
        { 
		if( self.score >= self.mapscore_ammo )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );
            self thread full_ammo_powerup_override();
			
		gpb("[" + self.clantag + "^7] " + self.clantag_color + player_name( self ) + " ^7has purchased a " + colors + "max ammo^7! (^2$15,000^7)");
		} else if( self.score < self.mapscore_ammo )

		{
		self thread imsg( "Insufficient funds!" );
		pr("^1* " + colors + "$15,000 ^7is required to buy a max ammo!");
		}
		wait 1;
		self.maxammos = undefined;
        }

}

mapSinglePerk( var )
{

    	random_color = randomintrange( 1, 6 );
		colors = "^" + random_color;

        if(level.script == m("buried") || level.script == m("dr") || level.script == m("bus"))
        {

		if( self.score >= self.mapscore_s )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );
            self maps\mp\zombies\_zm_perks::give_random_perk();
		    self notify( "player_received_ghost_round_free_perk" );
      	    self thread play_sound_at_pos( "music_chest", self.origin );
			
		gpb("[" + self.clantag + "^7] " + self.clantag_color + player_name( self ) + " ^7has purchased a " + colors + "random perk^7! (^2$3,750^7)");
		} else if( self.score < self.mapscore_s )

		{
		self thread imsg( "Insufficient funds!" );
		pr("^1* " + colors + "$3,750 ^7is required to buy a random perk!");
		}
		wait 1;
		self.fercies = undefined;

        } 
        else if(level.script != m("buried") || level.script != ("dr") || level.script != ("bus"))
        { 
		if( self.score >= self.mapscore_s )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );
            self maps\mp\zombies\_zm_perks::give_random_perk();
		    self notify( "player_received_ghost_round_free_perk" );
      	    self thread play_sound_at_pos( "music_chest", self.origin );
			
		gpb("[" + self.clantag + "^7] " + self.clantag_color + player_name( self ) + " ^7has purchased a " + colors + "random perk^7! (^2$7,500^7)");
		} else if( self.score < self.mapscore_s )

		{
		self thread imsg( "Insufficient funds!" );
		pr("^1* " + colors + "$7,500 ^7is required to buy a random perk!");
		}
		wait 1;
		self.fercies = undefined;


        }

}

mapPerks( var )
{

    	random_color = randomintrange( 1, 6 );
		colors = "^" + random_color;

        if(level.script == m("buried") || level.script == m("dr") || level.script == m("bus"))
        {

		if( self.score >= self.mapscore )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );
			self thread free_perk_powerup_override();
			
		gpb("[" + self.clantag + "^7] " + self.clantag_color + player_name( self ) + " ^7has purchased a " + colors + "random perk^7! (^2$25,000^7)");
		} else if( self.score < self.mapscore )

		{
		self thread imsg( "Insufficient funds!" );
		pr("^1* " + colors + "$25,000 ^7is required to buy a random perk!");
		}
		wait 1;
		self.fercie = undefined;

        } 
        else if(level.script != m("buried") || level.script != ("dr") || level.script != ("bus"))
        { 
		if( self.score >= self.mapscore )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );
			self thread free_perk_powerup_override();
			
		gpb("[" + self.clantag + "^7] " + self.clantag_color + player_name( self ) + " ^7has purchased a " + colors + "random perk^7! (^2$10,000^7)");
		} else if( self.score < self.mapscore )

		{
		self thread imsg( "Insufficient funds!" );
		pr("^1* " + colors + "$10,000 ^7is required to buy a random perk!");
		}
		wait 1;
		self.fercie = undefined;


        }

}

map_colors(type)
{
    // zombie counter
    // game timer
    // round #
    // imsg txt
    // health bar
        self endon("disconnect");

        // origins : blue
        
        if(level.script == m("origins"))
        { 
        
        self.base_colors = "^5";

	    self.counter.color = ( 0, 0.616, 0.608 );
	    self.timer_hud.color = ( 0, 0.616, 0.608 );
        self.trap_timer_hud.color = ( 0, 0.616, 0.608 ); 
        self.health_bar_text.color = ( 0, 0.616, 0.608 );
        self.health_bar.color = ( 0, 0.616, 0.608 );
        self.health_bar.bar.color = ( 0, 0.616, 0.608 );
        level.round_hud.color = ( 0, 0.616, 0.608 );
        self.hud_damagefeedback_red.color = ( 0, 0.616, 0.608 );
        
        self.mapcolor = ( 0, 0.616, 0.608 );
        level.mapcolor = ( 0, 0.616, 0.608 );
        level.color_type = level.mapcolor;

        } else if(level.script == m("buried")) {


        self.base_colors = "^3";

        self.counter.color = ( 0.965, 0.737, 0.204 );
	    self.timer_hud.color = ( 0.965, 0.737, 0.204 );
        self.trap_timer_hud.color = ( 0.965, 0.737, 0.204 ); 
        self.timer_hud.color = ( 0.965, 0.737, 0.204 );
        self.health_bar_text.color = ( 0.965, 0.737, 0.204 );
        self.health_bar.color = ( 0.965, 0.737, 0.204 );
        self.health_bar.bar.color = ( 0.965, 0.737, 0.204 );
        level.round_hud.color = ( 0.965, 0.737, 0.204 );
        self.hud_damagefeedback_red.color = ( 0.965, 0.737, 0.204 );

        self.mapcolor = ( 0.965, 0.737, 0.204 );
        level.mapcolor = ( 0.965, 0.737, 0.204 );
        level.color_type = level.mapcolor;

        } else if(level.script == m("motd")) {


        self.base_colors = "^1";

        self.counter.color = ( 1, 0.067, 0.063 );
	    self.timer_hud.color = ( 1, 0.067, 0.063 );
        self.trap_timer_hud.color = ( 1, 0.067, 0.063 ); 
        self.timer_hud.color = ( 1, 0.067, 0.063 );
        self.health_bar_text.color = ( 1, 0.067, 0.063 );
        self.health_bar.color = ( 1, 0.067, 0.063 );
        self.health_bar.bar.color = ( 1, 0.067, 0.063 );
        level.round_hud.color = ( 1, 0.067, 0.063 );
        self.hud_damagefeedback_red.color = ( 1, 0.067, 0.063 );

        self.mapcolor = ( 1, 0.067, 0.063 );
        level.mapcolor = ( 1, 0.067, 0.063 );
        level.color_type = level.mapcolor;

        } else if(level.script != m("buried") || level.script != m("origins") || level.script != m("motd"))
        {
        

        self.base_colors = "^6";


        self.counter.color = ( 0.965, 0.737, 0.204 );
	    self.timer_hud.color = ( 0.965, 0.737, 0.204 );
        self.trap_timer_hud.color = ( 0.965, 0.737, 0.204 ); 
        self.timer_hud.color = ( 0.965, 0.737, 0.204 );
        self.health_bar_text.color = ( 0.965, 0.737, 0.204 );
        self.health_bar.color = ( 0.965, 0.737, 0.204 );
        self.health_bar.bar.color = ( 0.965, 0.737, 0.204 );
        level.round_hud.color = ( 0.965, 0.737, 0.204 );
        self.hud_damagefeedback_red.color = ( 0.965, 0.737, 0.204 );

        self.mapcolor = ( 0.965, 0.737, 0.204 );
        level.mapcolor = ( 0.965, 0.737, 0.204 );
        level.color_type = level.mapcolor;

        }

}

mapHudtoCycle()
{
        if( self.colorcycles == 1 )
        {
        self.colorcycles = 2;
        pr("color changed to ^5blue");
        self thread mapHudtoType("blue");

    } else {
        if( self.colorcycles == 2 )
        {
        self.colorcycles = 3;
        pr("color changed to ^6purple");
        self thread mapHudtoType("purple");
    } else {
        if( self.colorcycles == 3 )
        {
        self.colorcycles = 4;
        pr("color changed to ^1red");
        self thread mapHudtoType("red");
    } else {
        if( self.colorcycles == 4 )
        {
        self.colorcycles = 1;
        pr("color changed to ^5default");
        self thread mapHudtoType("normal");
        }
    }

}
    }
}

mapHudtoType(type)
{
    // zombie counter
    // game timer
    // round #
    // imsg txt
    // health bar
        self endon("disconnect");

        // origins : blue
        
        if(type == "blue")
        { 

        self.base_colors = "^5";

	    self.counter.color = ( 0, 0.616, 0.608 );
	    self.timer_hud.color = ( 0, 0.616, 0.608 );
        self.trap_timer_hud.color = ( 0, 0.616, 0.608 ); 
        self.health_bar_text.color = ( 0, 0.616, 0.608 );
        self.health_bar.color = ( 0, 0.616, 0.608 );
        self.health_bar.bar.color = ( 0, 0.616, 0.608 );
        level.round_hud.color = ( 0, 0.616, 0.608 );
        self.hud_damagefeedback_red.color = ( 0, 0.616, 0.608 );
        
        self.mapcolor = ( 0, 0.616, 0.608 );
        level.mapcolor = ( 0, 0.616, 0.608 );
        level.color_type = level.mapcolor;

        } else if(type == "purple") {

        self.base_colors = "^6";

        self.counter.color = ( 0.965, 0.737, 0.204 );
	    self.timer_hud.color = ( 0.965, 0.737, 0.204 );
        self.trap_timer_hud.color = ( 0.965, 0.737, 0.204 ); 
        self.timer_hud.color = ( 0.965, 0.737, 0.204 );
        self.health_bar_text.color = ( 0.965, 0.737, 0.204 );
        self.health_bar.color = ( 0.965, 0.737, 0.204 );
        self.health_bar.bar.color = ( 0.965, 0.737, 0.204 );
        level.round_hud.color = ( 0.965, 0.737, 0.204 );
        self.hud_damagefeedback_red.color = ( 0.965, 0.737, 0.204 );

        self.mapcolor = ( 0.965, 0.737, 0.204 );
        level.mapcolor = ( 0.965, 0.737, 0.204 );
        level.color_type = level.mapcolor;

        } else if(type == "red") {

        self.base_colors = "^1";

        self.counter.color = ( 1, 0.067, 0.063 );
	    self.timer_hud.color = ( 1, 0.067, 0.063 );
        self.trap_timer_hud.color = ( 1, 0.067, 0.063 ); 
        self.timer_hud.color = ( 1, 0.067, 0.063 );
        self.health_bar_text.color = ( 1, 0.067, 0.063 );
        self.health_bar.color = ( 1, 0.067, 0.063 );
        self.health_bar.bar.color = ( 1, 0.067, 0.063 );
        level.round_hud.color = ( 1, 0.067, 0.063 );
        self.hud_damagefeedback_red.color = ( 1, 0.067, 0.063 );

        self.mapcolor = ( 1, 0.067, 0.063 );
        level.mapcolor = ( 1, 0.067, 0.063 );
        level.color_type = level.mapcolor;

        } else if(type == "normal")
        {
        
        self.base_colors = "^6";

        self.counter.color = ( 0.965, 0.737, 0.204 );
	    self.timer_hud.color = ( 0.965, 0.737, 0.204 );
        self.trap_timer_hud.color = ( 0.965, 0.737, 0.204 ); 
        self.timer_hud.color = ( 0.965, 0.737, 0.204 );
        self.health_bar_text.color = ( 0.965, 0.737, 0.204 );
        self.health_bar.color = ( 0.965, 0.737, 0.204 );
        self.health_bar.bar.color = ( 0.965, 0.737, 0.204 );
        level.round_hud.color = ( 0.965, 0.737, 0.204 );
        self.hud_damagefeedback_red.color = ( 0.965, 0.737, 0.204 );

        self.mapcolor = ( 0.965, 0.737, 0.204 );
        level.mapcolor = ( 0.965, 0.737, 0.204 );
        level.color_type = level.mapcolor;

        }

}

