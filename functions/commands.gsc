// Imports
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\gametypes_zm\_spawning;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\animscripts\zm_utility;
#include scripts\zm\functions\girly;
#include scripts\zm\functions\func;
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
	level thread on_say_player();	
	level thread sayMax();
	level thread sayTag();
	level thread sayPerk();

	// unused as of now :
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

			gp(colors + player_name( self ) + " ^7has changed their clantag to " + "[" + self.clantag + "^7]!" );

		}

		else
		
		self thread imsg( "Insufficient funds!" );
		
		wait 1;
		self.tag = undefined;
	
	}
}

on_say_player()
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
                    if( isSubStr( tolower( player_name( level.players[ i ] )), tolower(sayText[ 1 ] ) ))
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
			self iPrintLn("[" + player.clantag + "^7] ^3" + player_name( player ) + " ^7cannot accept this payment.");
		else if( var <= 0)
		{
			self thread imsg( "Enter a valid amount." );
		}
		else if( self.score >= var )
		{
			self maps\mp\zombies\_zm_score::minus_to_player_score( var, 1 );

			self iPrintLn( colors + "$" + var + "^7 has been sent to [" + player.clantag + "^7] ^3" + player_name( player ));
			player maps\mp\zombies\_zm_score::add_to_player_score( var, 1 );
			player iPrintLn( colors + "$" + var + " ^7was recieved from [" + self.clantag + "^7] ^3" + player_name( self ));
		}
		else
		self thread imsg( "Not enough points to do this!" );
		wait 1;
		self.giving_points = undefined;

	}
}

player_name( player )
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
                    if( isSubStr( tolower( player_name( level.players[ i ] )), tolower(sayText[ 1 ] ) ))
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
			iPrintLn("[" + self.clantag + "^7] ^3" + player_name( self ) + " ^7revived [" + player.clantag + "^7] ^3" + player_name( player ) + "^7! (^2$3,750^7)");
		}
		else
			self iPrintln("^1(!)^7 this player does not need to be ^1revived^7!");
	}

*/