// Imports
#include maps\mp\zombies\_zm_weap_staff_water;
#include maps\mp\zombies\_zm_weap_staff_fire;
#include maps\mp\zombies\_zm_weap_staff_air;
#include maps\mp\zombies\_zm_weap_staff_lightning;
#include maps\mp\zombies\_zm_challenges;
#include maps\mp\zm_tomb_challenges;
#include maps\mp\zm_tomb_dig;
#include maps\mp\zombies\_zm_ai_quadrotor;
#include maps\mp\zombies\_zm_craftables;
#include maps\mp\gametypes_zm\_rank;
#include maps\mp\gametypes_zm\_globallogic_player;
#include maps\mp\gametypes_zm\_persistence;
#include maps\mp\zombies\_zm_stats;
#include maps\mp\zombies\_zm_equip_springpad;
#include maps\mp\zombies\_zm_weap_claymore;
#include maps\mp\zombies\_zm_pers_upgrades_system;
#include maps\mp\gametypes_zm\_spawnlogic;
#include maps\mp\animscripts\traverse\shared;
#include maps\mp\animscripts\utility;
#include maps\mp\zombies\_load;
#include maps\mp\_createfx;
#include maps\mp\_music;
#include maps\mp\_busing;
#include maps\mp\_script_gen;
#include maps\mp\gametypes_zm\_globallogic_audio;
#include maps\mp\gametypes_zm\_tweakables;
#include maps\mp\_challenges;
#include maps\mp\_demo;
#include maps\mp\gametypes_zm\_globallogic_utils;
#include maps\mp\gametypes_zm\_spectating;
#include maps\mp\gametypes_zm\_globallogic_spawn;
#include maps\mp\gametypes_zm\_globallogic_ui;
#include maps\mp\gametypes_zm\_hostmigration;
#include maps\mp\gametypes_zm\_globallogic_score;
#include maps\mp\gametypes_zm\_globallogic;
#include maps\mp\zombies\_zm_ai_faller;
#include maps\mp\zombies\_zm_pers_upgrades_functions;
#include maps\mp\zombies\_zm_pers_upgrades;
#include maps\mp\animscripts\zm_run;
#include maps\mp\animscripts\zm_death;
#include maps\mp\zombies\_zm_blockers;
#include maps\mp\animscripts\zm_shared;
#include maps\mp\zombies\_zm_ai_basic;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\zombies\_zm_net;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\gametypes_zm\_zm_gametype;
#include maps\mp\_visionset_mgr;
#include maps\mp\zombies\_zm_equipment;
#include maps\mp\zombies\_zm_server_throttle;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\zombies\_zm_melee_weapon;
#include maps\mp\zombies\_zm_audio_announcer;
#include maps\mp\zombies\_zm_ai_dogs;
#include maps\mp\zombies\_zm_game_module;
#include codescripts\character;
#include maps\mp\zombies\_zm_weap_riotshield;
#include maps\mp\zombies\_zm_weap_riotshield_tomb;
#include maps\mp\zombies\_zm_weap_riotshield_prison;
#include maps\mp\zm_transit_bus;
#include maps\mp\zm_transit_utility;
#include maps\mp\zombies\_zm_equip_turret;
#include maps\mp\zombies\_zm_mgturret;
#include maps\mp\zombies\_zm_weap_jetgun;
#include maps\mp\zombies\_zm_ai_sloth;
#include maps\mp\zombies\_zm_ai_sloth_ffotd;
#include maps\mp\zombies\_zm_ai_sloth_utility;
#include maps\mp\zombies\_zm_ai_sloth_magicbox;
#include maps\mp\zombies\_zm_ai_sloth_crawler;
#include maps\mp\zombies\_zm_ai_sloth_buildables;
#include maps\mp\zombies\_zm_tombstone;
#include maps\mp\zombies\_zm_chugabud;
#include maps\mp\zm_nuked_perks;
#include codescripts\struct;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\zombies\_zm_buildables;
#include maps\mp\zombies\_zm_score;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\gametypes_zm\_spawning;
#include maps\mp\zombies\_zm_unitrigger;
#include maps\mp\zombies\_zm_spawner;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_zonemgr;
#include maps\mp\zombies\_zm_magicbox;
#include maps\mp\zombies\_zm_power;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\animscripts\zm_utility;
#include scripts\zm\functions\girly;
#include scripts\zm\functions\func;
#include scripts\zm\functions\exo_suit;
#include scripts\zm\functions\match;
#include scripts\zm\functions\player;
#include scripts\zm\functions\zombie;
#include scripts\zm\functions\powerups;
#include scripts\zm\functions\overflow_fix;
#include scripts\zm\functions\hud;
#include scripts\zm\functions\map;
#include scripts\zm\functions\menu;
#include scripts\zm\functions\weapons;
setup_commands()
{
	level thread onsayPlayer();	
	level thread sayMax();
	level thread sayTag();

//   unused as of now :
	level thread sayPerk();
	//level thread sayRound();
	//level thread sayBots();
	//level thread help();
	//level thread sayPerkaholic();
	//level thread sDebugger();
	//level thread sayRevive();
	//level thread profiler();
}





sayTag()
{
    level endon("game_ended");    
    for(;;)
    {
        level waittill( "say", message, player );
        sayText = strtok(tolower(message), " ");        
        if(sayText[0]==".changetag" || sayText[0]==".clan" || sayText[0]==".tag" || sayText[0]==".clantag") //GivePoints
        {
                	player changeTag(250);
				}           
        }       
}


changeTag( var )
{
	if( !isDefined( self.tag ) )
	{
		self.tag = true;

		if( self.score >= 250 )
		{

			self maps\mp\zombies\_zm_score::minus_to_player_score( 250, 1 );

			random_color = randomintrange( 1, 6 );
			colors = "^" + random_color;

			clantag_msg = strTok("xd  34  1c  k2  swag  zZz  yo  zombie  ai  3arc  bot  mama  gg  xo  papa  baka", "  ");
			clantag_randomize = RandomInt(clantag_msg.size);
			clantag_a = colors + clantag_msg[clantag_randomize];

			self.clantag_color = "^" + colors;
			self.clantag = clantag_a;

			gp(colors + getPlayerName( self ) + " ^7has changed their clantag to " + "[" + self.clantag + "^7]!" );

		}

		else
		
		self thread imsg( "Insufficient funds!" );
		
		wait 1;
		self.tag = undefined;
	
	}
}

onsayPlayer()
{
    level endon("game_ended");    
    for(;;)
    {
        level waittill( "say", message, player );
        sayText = strtok(tolower(message), " ");        
        if(sayText[0]==".pay" || sayText[0]==".p" || sayText[0]==".give") //GivePoints
        {
            if(sayText.size>1)
            {
                for( i = 0; i < level.players.size; i++ )
                {
                    if( isSubStr( tolower( getPlayerName( level.players[ i ] )), tolower(sayText[ 1 ] ) ))
                    {
                        value = int( sayText[ ( sayText.size - 1 ) ] );
                        if( value < 0 )
                            value = ( value * -1 );
                        player give_points( level.players[ i ], int( value ));
                    }                    
                }
            }else
                player iPrintLn("^1* ^7Usage: ^3.pay ^7player ^2amount");
            }
        }       
}


give_points( player, var )
{
	if( !isDefined( self.giving_points ) )
	{

		random_color = randomintrange( 2, 3 );
		colors = "^" + random_color;

		self.giving_points = true;
		if ( player.score == 1000000 )
			self iPrintLn("[" + player.clantag + "^7] ^3" + getPlayerName( player ) + " ^7cannot accept this payment.");
		else if( var <= 0)
		{
			self thread imsg( "Enter a valid amount." );
		}
		else if( self.score >= var )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );

			self iPrintLn( colors + "$" + var + "^7 has been sent to [" + player.clantag + "^7] ^3" + getPlayerName( player ));
			player maps\mp\zombies\_zm_score::add_to_player_score( var, 1 );
			player iPrintLn( colors + "$" + var + " ^7was recieved from [" + self.clantag + "^7] ^3" + getPlayerName( self ));
		}
		else
		self thread imsg( "Not enough points to do this!" );
		wait 1;
		self.giving_points = undefined;

	}
}

getPlayerName( player )
{
    playerName = getSubStr( player.name, 0, player.name.size );
    for( i = 0; i < playerName.size; i++ )
    {
		if( playerName[ i ] == "]" )
			break;
    }
    if( playerName.size != i )
		playerName = getSubStr( playerName, i + 1, playerName.size );
		
    return playerName;
}

/*
randomWeaponz()
{
	if( !isDefined( self.randomweaponz ) )
	{
		self.randomweaponz = true;
		self thread mapscores3();
	}
}
*/

buySingle()
{
	if( !isDefined( self.fercies ) )
	{
		self.fercies = true;
		self thread mapscores2();
	}
}

buyPerk()
{
	if( !isDefined( self.fercie ) )
	{
		self.fercie = true;
		self thread mapscores();
	}
}

sayPerk()
{
    level endon("game_ended");    
    for(;;)
    {
        level waittill( "say", message, player );
        sayText = strtok(tolower(message), " ");        
        if(sayText[0]==".perk" || sayText[0]==".perkall" || sayText[0]==".ferc" || sayText[0]==".random" || sayText[0]==".gamble")  //GivePoints
        {
        	player buyPerk();
		}
		}          
}


buyMax()
{
	if( !isDefined( self.maxammos ) )
	{
		self.maxammos = true;
		self thread mapscores_a();
	}
}

sayMax()
{
    level endon("game_ended");    
    for(;;)
    {
        level waittill( "say", message, player );
        sayText = strtok(tolower(message), " ");        
        if(sayText[0]==".ammo" || sayText[0]==".maxammo" || sayText[0]==".max") //GivePoints
        {
                	player buyMax();
				}           
        }       
}



/*
sayRevive()
{
    level endon("game_ended");    
    for(;;)
    {
        level waittill( "say", message, player );
        sayText = strtok(tolower(message), " ");        
        if(sayText[0]==".r" || sayText[0]==".revive" || sayText[0]==".respawn") //GivePoints
        {
            if(sayText.size>1)
            {
                for( i = 0; i < level.players.size; i++ )
                {
                    if( isSubStr( tolower( getPlayerName( level.players[ i ] )), tolower(sayText[ 1 ] ) ))
                    {
						
                        value = string( sayText[ ( sayText.size - 1 ) ] );
                        if( value < 0 )
                            value = ( value * -1 );
							
                        player thread doRevival( level.players[ i ], string( value ) );
						player.hello = level.players[ i ];
                    }                    
                }
            }else
                player iPrintLn("^1* ^7Usage: ^3.revive <player>");
		}
        }       
}


doRevival( player, var)
{
	if( !isDefined( self.reviving_p ) )
	{

		random_color = randomintrange( 2, 3 );
		colors = "^" + random_color;

		self.reviving_p = true;

		if( var != player.hello)
		{
			self thread imsg( "Enter a valid player." );
		}
		
		else if( var == player.hello && self.score >= 3750 )
		{
			player thread reviveFunc(var);
		}

		else
		self thread imsg( "Not enough points to do this!" );

	}
		wait 0.35;
		self.reviving_p = undefined;
}




reviveFunc(player)
{
		if(isDefined(player.reviveTrigger))
		{
			player notify("player_revived");
			player reviveplayer();
			player.revivetrigger delete();
			player.revivetrigger=undefined;
			player.ignoreme=false;
			player allowjump(1);
			player.laststand=undefined;
			iPrintLn("[" + self.clantag + "^7] ^3" + getPlayerName( self ) + " ^7revived [" + player.clantag + "^7] ^3" + getPlayerName( player ) + "^7! (^2$3,750^7)");
		}
		else
			self iPrintln("^1(!)^7 this player does not need to be ^1revived^7!");
	}

*/