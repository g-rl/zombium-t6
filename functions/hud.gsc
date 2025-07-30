// Imports
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
#include scripts\zm\functions\commands;
#include scripts\zm\functions\func;
#include scripts\zm\functions\exo_suit;
#include scripts\zm\functions\match;
#include scripts\zm\functions\player;
#include scripts\zm\functions\zombie;
#include scripts\zm\functions\powerups;
#include scripts\zm\functions\overflow_fix;
#include scripts\zm\functions\map;
#include scripts\zm\functions\menu;
#include scripts\zm\functions\weapons;

all_hud_watcher()
{	

	self endon("disconnect");
	level endon( "end_game" );

	create_dvar( "hud_all", 1 );

	while(1)
	{	
		while( getDvarInt( "hud_all" ) == 0 )
		{
			wait 0.1;
		}
		self setClientDvar( "hud_round_timer", 1 );
		self setClientDvar( "hud_remaining", 1 );
		self setClientDvar( "hud_zone", 1 );
		self setClientDvar( "hud_health_bar", 1 );
		self setClientDvar( "hud_trap_timer", 1 );

		while( getDvarInt( "hud_all" ) >= 1 )
		{
			wait 0.1;
		}
		self setClientDvar( "hud_round_timer", 0 );
		self setClientDvar( "hud_remaining", 0 );
		self setClientDvar( "hud_zones", 0 );
		self setClientDvar( "hud_health_bar", 0 );
		self setClientDvar( "hud_trap_timer", 0 );
	}
}

set_hud_offset()
{
	if (level.script == "zm_tomb" )
	{
		self.timer_hud_offset = 10;
	}
	else
	{
		self.timer_hud_offset = 0;	
	}
	self.zone_hud_offset = 15;
}

timer_hud()
{	

	self endon("disconnect");

	create_dvar( "hud_timer", 1 );

	x = 5;
	y = -105;
	if (level.script == "zm_buried")
	{
		y -= 25;
	}
	else if (level.script == "zm_tomb")
	{
		y -= 60;
	}

	self.timer_hud = newClientHudElem(self);
	self.timer_hud.alignx = "left";
	self.timer_hud.aligny = "middle";
	self.timer_hud.horzalign = "user_left";
	self.timer_hud.vertalign = "user_bottom";
	self.timer_hud.x = x;
	self.timer_hud.y = y;
	self.timer_hud.fontscale = 1;
	self.timer_hud.alpha = 0;
	self.timer_hud.color = self.mapcolor;
	self.timer_hud.hidewheninmenu = 1;

	self set_hud_offset();
	self thread timer_hud_watcher(y);
	//self thread round_timer_hud();

	flag_wait( "initial_blackscreen_passed" );
	self.timer_hud setTimerUp(0);

	// self thread tab_hud();
	// self thread waittill_player_pressed_scoreboard();

	level waittill( "end_game" );

	level.total_time -= .1; // need to set it below the number or it shows the next number
	while(1)
	{	
		self.timer_hud setTimer(level.total_time);
		self.timer_hud.alpha = 1;
		self.round_timer_hud.alpha = 0;
		wait 0.1;
	}
}

timer_hud_watcher(y)
{	
	self endon("disconnect");
	level endon( "end_game" );

	while(1)
	{	
		while( getDvarInt( "hud_timer" ) == 0 )
		{
			wait 0.1;
		}
		self.timer_hud.y = (y);
		self.timer_hud.alpha = 1;

		while( getDvarInt( "hud_timer" ) >= 1 )
		{
			wait 0.1;
		}
		self.timer_hud.alpha = 0;
	}
}

round_timer_hud()
{


	self endon("disconnect");

	create_dvar( "hud_round_timer", 1 );

	self.round_timer_hud = newClientHudElem(self);
	self.round_timer_hud.alignx = "left";
	self.round_timer_hud.aligny = "top";
	self.round_timer_hud.horzalign = "user_left";
	self.round_timer_hud.vertalign = "user_top";
	self.round_timer_hud.x += 4;
	self.round_timer_hud.y += (2 + (15 * getDvarInt("hud_timer") ) + self.timer_hud_offset );
	self.round_timer_hud.fontscale = 1;
	self.round_timer_hud.alpha = 0;
	self.round_timer_hud.color = self.mapcolor;
	self.round_timer_hud.hidewheninmenu = 1;

	flag_wait( "initial_blackscreen_passed" );

	self thread round_timer_hud_watcher();

	level.FADE_TIME = 0.2;

	while (1)
	{
		zombies_this_round = level.zombie_total + get_round_enemy_array().size;
		hordes = zombies_this_round / 24;
		dog_round = flag( "dog_round" );
		leaper_round = flag( "leaper_round" );

		self.round_timer_hud setTimerUp(0);
		start_time = int(getTime() / 1000);

		level waittill( "end_of_round" );

		end_time = int(getTime() / 1000);
		time = end_time - start_time;

		self display_round_time(time, hordes, dog_round, leaper_round);

		level waittill( "start_of_round" );

		if( getDvarInt( "hud_round_timer" ) >= 1 )
		{
			self.round_timer_hud FadeOverTime(level.FADE_TIME);
			self.round_timer_hud.alpha = 1;
		}
	}
}

display_round_time(time, hordes, dog_round, leaper_round)
{
	timer_for_hud = time - 0.1;

	sph_off = 1;
	if(level.round_number > 50 && !dog_round && !leaper_round)
	{
		sph_off = 0;
	}

	self.round_timer_hud FadeOverTime(level.FADE_TIME);
	self.round_timer_hud.alpha = 0;
	wait level.FADE_TIME * 2;

	self.round_timer_hud.label = &"Finished in: ";
	self.round_timer_hud FadeOverTime(level.FADE_TIME);
	self.round_timer_hud.alpha = 1;

	for ( i = 0; i < 100 + (100 * sph_off); i++ ) // wait 10s or 5s
	{
		self.round_timer_hud setTimer(timer_for_hud);
		wait 0.05;
	}

	self.round_timer_hud FadeOverTime(level.FADE_TIME);
	self.round_timer_hud.alpha = 0;
	wait level.FADE_TIME * 2;

	if(sph_off == 0)
	{
		self display_sph(time, hordes);
	}

	self.round_timer_hud.label = &"";
}

display_sph( time, hordes )
{
	sph = time / hordes;

	self.round_timer_hud FadeOverTime(level.FADE_TIME);
	self.round_timer_hud.alpha = 1;
	self.round_timer_hud.label = &"SPH: ";
	self.round_timer_hud setValue(sph);

	for ( i = 0; i < 5; i++ )
	{
		wait 1;
	}

	self.round_timer_hud FadeOverTime(level.FADE_TIME);
	self.round_timer_hud.alpha = 0;

	wait level.FADE_TIME;
}

round_timer_hud_watcher()
{	
	self endon("disconnect");
	level endon( "end_game" );

	while(1)
	{
		while( getDvarInt( "hud_round_timer" ) == 0 )
		{
			wait 0.1;
		}
		self.round_timer_hud.y = (2 + (15 * getDvarInt("hud_timer") ) + self.timer_hud_offset );
		self.round_timer_hud.alpha = 1;

		while( getDvarInt( "hud_round_timer" ) >= 1 )
		{
			wait 0.1;
		}
		self.round_timer_hud.alpha = 0;

	}
}

zombie_remaining_hud()
{

	self endon( "disconnect" );
	level endon( "end_game" );

	level waittill( "start_of_round" );

    self.zombie_counter_hud = maps\mp\gametypes_zm\_hud_util::createFontString( "hudsmall" , 1 );
    self.zombie_counter_hud maps\mp\gametypes_zm\_hud_util::setPoint( "CENTER", "CENTER", "CENTER", 190 );
    self.zombie_counter_hud.alpha = 0;
    self.zombie_counter_hud.label = &"Zombies: ^1";
	self thread zombie_remaining_hud_watcher();

    while( 1 )
    {
        self.zombie_counter_hud setValue( ( maps\mp\zombies\_zm_utility::get_round_enemy_array().size + level.zombie_total ) );
        
        wait 0.05; 
    }
}

zombie_remaining_hud_watcher()
{	

	self endon("disconnect");
	level endon( "end_game" );

	create_dvar( "hud_remaining", 1 );

	while(1)
	{
		while( getDvarInt( "hud_remaining" ) == 0 )
		{
			wait 0.1;
		}
		self.zombie_counter_hud.alpha = 1;

		while( getDvarInt( "hud_remaining" ) >= 1 )
		{
			wait 0.1;
		}
		self.zombie_counter_hud.alpha = 0;
	}
}

health_bar_hud()
{

	self endon("disconnect");

	create_dvar( "hud_health_bar", 1 );

	flag_wait( "initial_blackscreen_passed" );

	x = 63;
	y = 135;
	if (level.script == "zm_buried")
	{
		y -= 9;
	}
	else if (level.script == "zm_tomb")
	{
		y -= 66;
	}

	self.health_bar = self createbar(self.mapcolor, level.primaryprogressbarwidth - 9, level.primaryprogressbarheight - 1);
	self.health_bar setpoint_custom(undefined, "LEFT", x, y);
	self.health_bar.hidewheninmenu = 1;
	self.health_bar.bar.hidewheninmenu = 1;
	self.health_bar.barframe.hidewheninmenu = 1;

	self.health_bar_text = createfontstring("objective", 1);
	self.health_bar_text setpoint_custom(undefined, "LEFT", x + 67, y - 0.5);
	self.health_bar_text.hidewheninmenu = 1;

	while( 1 )
	{
		if( getDvarInt( "hud_health_bar" ) == 0)
		{	
			self.health_bar hideelem();
			self.health_bar_text hideelem();
		}
		else
		{
			if( isDefined(self.e_afterlife_corpse) || isDefined( self.waiting_to_revive ) && self.waiting_to_revive == 1 || self maps\mp\zombies\_zm_laststand::player_is_in_laststand() )
			{
				self.health_bar hideelem();
				self.health_bar_text hideelem();
			}
			else
			{
				self.health_bar showelem();
				self.health_bar_text showelem();
			}

			self.health_bar updatebar(self.health / self.maxhealth);
			self.health_bar_text setvalue(self.health);
		}

		wait 0.05;
	}
}

trap_timer_hud()
{
	if( level.script != "zm_prison" || isDefined( level.strat_tester ) && level.strat_tester )
		return;

	create_dvar( "hud_trap_timer", 0 );

	self endon( "disconnect" );

	self.trap_timer_hud = newclienthudelem( self );
	self.trap_timer_hud.alignx = "left";
	self.trap_timer_hud.aligny = "top";
	self.trap_timer_hud.horzalign = "user_left";
	self.trap_timer_hud.vertalign = "user_top";
	self.trap_timer_hud.x += 4;
	self.trap_timer_hud.y += (2 + (15 * (getDvarInt("hud_timer") + getDvarInt("hud_round_timer") ) ) + self.timer_hud_offset );
	self.trap_timer_hud.fontscale = 1;
	self.trap_timer_hud.alpha = 0;
	self.trap_timer_hud.color = self.mapcolor;
	self.trap_timer_hud.hidewheninmenu = 1;
	self.trap_timer_hud.hidden = 0;
	self.trap_timer_hud.label = &"";

	flag_wait( "afterlife_start_over" );
	while( 1 )
	{
		level waittill( "trap_activated" );
		
		if( !getDvarInt( "hud_trap_timer" ) )
			continue; 
	
		if( !level.trap_activated )
		{
			self.trap_timer_hud.y = (2 + (15 * (getDvarInt("hud_timer") + getDvarInt("hud_round_timer") ) ) + self.timer_hud_offset );
			self.trap_timer_hud.alpha = 1;
			self.trap_timer_hud settimer( 50 );
			wait 50;
			self.trap_timer_hud.alpha = 0;
		}
	}
}

color_hud_watcher()
{
	self endon("disconnect");

	create_dvar( "hud_color", "1 1 1" );
	color = getDvar( "hud_color" );
	prev_color = "1 1 1";

	while( 1 )
	{
		while( color == prev_color )
		{
			color = getDvar( "hud_color" );
			wait 0.1;
		}

		colors = strTok( color, " ");
		if( colors.size != 3 )
			continue;

		prev_color = color;
		
		self.timer_hud.color = ( string_to_float(colors[0]), string_to_float(colors[1]), string_to_float(colors[2]) );
		self.round_timer_hud.color = ( string_to_float(colors[0]), string_to_float(colors[1]), string_to_float(colors[2]) );
		self.health_bar_text.color = ( string_to_float(colors[0]), string_to_float(colors[1]), string_to_float(colors[2]) );
		self.zone_hud.color = ( string_to_float(colors[0]), string_to_float(colors[1]), string_to_float(colors[2]) );
		self.trap_timer_hud.color = ( string_to_float(colors[0]), string_to_float(colors[1]), string_to_float(colors[2]) );
		// self.zombie_counter_hud.color = ( string_to_float(colors[0]), string_to_float(colors[1]), string_to_float(colors[2]) );
	}
}

color_health_bar_watcher()
{
	self endon("disconnect");

	create_dvar( "hud_color_health", "1 1 1" );
	color = getDvar( "hud_color_health" );
	prev_color = "1 1 1";

	while( 1 )
	{
		while( color == prev_color )
		{
			color = getDvar( "hud_color_health" );
			wait 0.1;
		}

		colors = strTok( color, " ");
		if( colors.size != 3 )
			continue;

		prev_color = color;

		self.health_bar.bar.color = ( string_to_float(colors[0]), string_to_float(colors[1]), string_to_float(colors[2]) );
	}
}

tab_hud()
{
	while(1)
	{
		if(self buttonPressed( "TAB" ))
		{
			// self notify("player_pressed_scoreboard_button");
			self notifyonplayercommand("player_pressed_scoreboard_button", "+scores");
			// iPrintLn("working");
		}
		wait 0.05;
	}
}

waittill_player_pressed_scoreboard()
{
	while(1)
	{
		self waittill("player_pressed_scoreboard_button");
		self.timer_hud.alpha = 0;
		iPrintLn("?");
	}
}

/*
* *****************************************************
*	
* ********************* Utility ***********************
*
* *****************************************************
*/

setpoint_custom( point, relativepoint, xoffset, yoffset ) //checked matches cerberus output
{

	element = self getparent();

	if ( !isDefined( xoffset ) )
	{
		xoffset = 0;
	}
	self.xoffset = xoffset;
	if ( !isDefined( yoffset ) )
	{
		yoffset = 0;
	}
	self.yoffset = yoffset;
	self.point = point;
	self.alignx = "center";
	self.aligny = "middle";
	switch( point )
	{
		case "CENTER":
			break;
		case "TOP":
			self.aligny = "top";
			break;
		case "BOTTOM":
			self.aligny = "bottom";
			break;
		case "LEFT":
			self.alignx = "left";
			break;
		case "RIGHT":
			self.alignx = "right";
			break;
		case "TOPRIGHT":
		case "TOP_RIGHT":
			self.aligny = "top";
			self.alignx = "right";
			break;
		case "TOPLEFT":
		case "TOP_LEFT":
			self.aligny = "top";
			self.alignx = "left";
			break;
		case "TOPCENTER":
			self.aligny = "top";
			self.alignx = "center";
			break;
		case "BOTTOM RIGHT":
		case "BOTTOM_RIGHT":
			self.aligny = "bottom";
			self.alignx = "right";
			break;
		case "BOTTOM LEFT":
		case "BOTTOM_LEFT":
			self.aligny = "bottom";
			self.alignx = "left";
			break;
		default:
			break;
	}
	if ( !isDefined( relativepoint ) )
	{
		relativepoint = point;
	}
	self.relativepoint = relativepoint;
	relativex = "center";
	relativey = "middle";
	switch( relativepoint )
	{
		case "CENTER":
			break;
		case "TOP":
			relativey = "top";
			break;
		case "BOTTOM":
			relativey = "bottom";
			break;
		case "LEFT":
			relativex = "user_left";
			break;
		case "RIGHT":
			relativex = "user_right";
			break;
		case "TOPRIGHT":
		case "TOP_RIGHT":
			relativey = "top";
			relativex = "user_right";
			break;
		case "TOPLEFT":
		case "TOP_LEFT":
			relativey = "top";
			relativex = "user_left";
			break;
		case "TOPCENTER":
			relativey = "top";
			relativex = "center";
			break;
		case "BOTTOM RIGHT":
		case "BOTTOM_RIGHT":
			relativey = "bottom";
			relativex = "user_right";
			break;
		case "BOTTOM LEFT":
		case "BOTTOM_LEFT":
			relativey = "bottom";
			relativex = "user_left";
			break;
		default:
			break;
	}
	if ( element == level.uiparent )
	{
		self.horzalign = relativex;
		self.vertalign = relativey;
	}
	else
	{
		self.horzalign = element.horzalign;
		self.vertalign = element.vertalign;
	}
	if ( relativex == element.alignx )
	{
		offsetx = 0;
		xfactor = 0;
	}
	else if ( relativex == "center" || element.alignx == "center" )
	{
		offsetx = int( element.width / 2 );
		if ( relativex == "left" || element.alignx == "right" )
		{
			xfactor = -1;
		}
		else
		{
			xfactor = 1;
		}
	}
	else
	{
		offsetx = element.width;
		if ( relativex == "left" )
		{
			xfactor = -1;
		}
		else
		{
			xfactor = 1;
		}
	}
	self.x = element.x + ( offsetx * xfactor );
	if ( relativey == element.aligny )
	{
		offsety = 0;
		yfactor = 0;
	}
	else if ( relativey == "middle" || element.aligny == "middle" )
	{
		offsety = int( element.height / 2 );
		if ( relativey == "top" || element.aligny == "bottom" )
		{
			yfactor = -1;
		}
		else
		{
			yfactor = 1;
		}
	}
	else
	{
		offsety = element.height;
		if ( relativey == "top" )
		{
			yfactor = -1;
		}
		else
		{
			yfactor = 1;
		}
	}
	self.y = element.y + ( offsety * yfactor );
	self.x += self.xoffset;
	self.y += self.yoffset;
	switch( self.elemtype )
	{
		case "bar":
			setpointbar( point, relativepoint, xoffset, yoffset );
			self.barframe setparent( self getparent() );
			self.barframe setpoint_custom( point, relativepoint, xoffset, yoffset );
			break;
	}
	self updatechildren();
}

hud_setter( hud, x, y )
{
	create_dvar( "x", x );
	create_dvar( "y", y );

	while( 1 )
	{
		x = getDvarInt( "x" );
		y = getDvarInt( "y" );
		hud setpoint_custom(undefined, "LEFT", x, y);
		wait 0.1;
	}
}

hud_setter2( hud, x, y )
{
	create_dvar( "x2", x );
	create_dvar( "y2", y );

	while( 1 )
	{
		x = getDvarInt( "x2" );
		y = getDvarInt( "y2" );
		hud setpoint_custom(undefined, "LEFT", x, y);
		wait 0.1;
	}
}