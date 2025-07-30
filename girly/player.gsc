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
#include scripts\zm\girly\girly;
#include scripts\zm\girly\commands;
#include scripts\zm\girly\func;
#include scripts\zm\girly\exo_suit;
#include scripts\zm\girly\match;
#include scripts\zm\girly\zombie;
#include scripts\zm\girly\powerups;
#include scripts\zm\girly\overflow_fix;
#include scripts\zm\girly\hud;
#include scripts\zm\girly\map;
#include scripts\zm\girly\menu;
#include scripts\zm\girly\weapons;

disable_player_quotes()
{
	create_dvar( "disable_player_quotes", 1 );
    
    self endon("disconnect");
    for(;;)
    {
		if ( getDvarInt( "disable_player_quotes" ) )
		{
			self.isspeaking = 1;
		}
		wait 0.5;
	}
}

render_create_shader(shader, width, height, color, alpha, sort)
{
    hud = newclienthudelem(self);

    hud.elemtype = "icon";
    hud.x = 0;
    hud.y = 0;
    hud.width = width;
    hud.height = height;
    hud.sort = sort;
    hud.color = color;
    hud.alpha = alpha;
    hud.stored_alpha = alpha;
    hud.children = [];
    hud.hidden = false;
    hud setparent(level.uiparent);
    hud setshader(shader, width, height);

    return hud;
}

render_server_timer(alignx, aligny, horzalign, vertalign)
{
    hud = createservertimer("default", 1);

    hud.alignx = alignx;
    hud.aligny = aligny;
    hud.horzalign = horzalign;
    hud.vertalign = vertalign;
    hud.foreground = true;

    return hud;
}

render_player_timer(alignx, aligny, horzalign, vertalign)
{
    hud = self createclienttimer("default", 1);

    hud.alignx = alignx;
    hud.aligny = aligny;
    hud.horzalign = horzalign;
    hud.vertalign = vertalign;
    hud.foreground = true;

    return hud;
}

render_hide_elem()
{
    if (self.hidden)
        return;

    foreach (child in self.children)
        child render_hide_elem();

    self hideelem();
}

render_show_elem()
{
    if (!self.hidden)
        return;

    foreach (child in self.children)
    {
        child render_show_elem();
        child.alpha = child.stored_alpha;
    }

    self showelem();
    self.alpha = self.stored_alpha;
}

render_destroy_elem()
{
    foreach (child in self.children)
        child render_destroy_elem();

    self destroyelem();
}


toggle_player_timer()
{
    if (self.player_timer.hidden)
        self.player_timer render_show_elem();
    else
        self.player_timer render_hide_elem();
}

player_timer()
{
    self endon("disconnect");

    self.player_timer = self render_player_timer("left", "top", "user_left", "user_top");
    self.player_timer render_hide_elem();
    self.player_timer settimerup(0);

    start_time = int(gettime() / 1000);
    level waittill("end_game");
    end_time = int(gettime() / 1000);

    for (;;)
    {
        self.player_timer settimer(end_time - start_time);

        wait 0.05;
    }
}



reduce_player_fall_damage()
{
	maps\mp\zombies\_zm::register_player_damage_callback(::player_damage_override);
}


player_damage_override( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime )
{
	if (smeansofdeath == "MOD_FALLING" && !self hasperk("specialty_flakjacket"))
	{
		// remove fall damage being based off max health
		ratio = self.maxhealth / 100;
		idamage = int(idamage / ratio);

		// increase fall damage beyond 110
		max_damage = 110;
		if (idamage >= max_damage)
		{
			velocity = abs(self.fall_velocity);
			min_velocity = getDvarInt("bg_fallDamageMinHeight") * 3.25;
			max_velocity = getDvarInt("bg_fallDamageMaxHeight") * 2.5;
			if (self.divetoprone)
			{
				min_velocity = getDvarInt("dtp_fall_damage_min_height") * 4.5;
				max_velocity = getDvarInt("dtp_fall_damage_max_height") * 2.75;
			}

			idamage = int(((velocity - min_velocity) / (max_velocity - min_velocity)) * max_damage);

			if (idamage < max_damage)
			{
				idamage = max_damage;
			}
		}
	}

	return idamage;
}

disable_player_move_states_override( forcestancechange ) //checked matches cerberus output
{
	self allowcrouch( 1 );
	self allowlean( 0 );
	self allowads( 0 );
	self allowsprint( 1 );
	self allowprone( 0 );
	self allowmelee( 0 );
	if ( isDefined( forcestancechange ) && forcestancechange == 1 )
	{
		if ( self getstance() == "prone" )
		{
			self setstance( "crouch" );
		}
	}
}

ammo_give_override( weapon ) //checked changed to match cerberus output
{
	give_ammo = 0;
	if ( !is_offhand_weapon( weapon ) )
	{
		weapon = get_weapon_with_attachments( weapon );
		if ( isDefined( weapon ) )
		{
			stockmax = 0;
			stockmax = weaponstartammo( weapon );
			clipcount = self getweaponammoclip( weapon );
			currstock = self getammocount( weapon );
			if ( ( currstock - clipcount ) >= stockmax )
			{
				give_ammo = 0;
			}
			else
			{
				give_ammo = 1;
			}
		}
	}
	else if ( self has_weapon_or_upgrade( weapon ) )
	{
		if ( self getammocount( weapon ) < weaponmaxammo( weapon ) )
		{
			give_ammo = 1;
		}
	}
	if ( give_ammo )
	{
		self play_sound_on_ent( "purchase" );
		self givemaxammo( weapon );
		alt_weap = weaponaltweaponname( weapon );
		if ( alt_weap != "none" )
		{
			self givemaxammo( alt_weap );
		}
		self setweaponammoclip( weapon, weaponclipsize( weapon ) );
	
		return 1;
	}
	if ( !give_ammo )
	{
		return 0;
	}
}


add_to_player_score_override( points, add_to_total ) //checked matches cerberus output
{
	if ( !isDefined( add_to_total ) )
	{
		add_to_total = 1;
	}
	if ( !isDefined( points ) || level.intermission )
	{
		return;
	}
	self.score += points;
	if ( self.score > 500005 )
	{
		self.score = 500005;
	}
	self.pers[ "score" ] = self.score;
	if ( add_to_total )
	{
		self.score_total += points;
	}
	self incrementplayerstat( "score", points );
}


give_tomahwak()
{

	if (level.script == "zm_prison")
	{
	flag_wait( "initial_blackscreen_passed" );
	wait 60;

	if ( isDefined( self.current_tactical_grenade ) && !issubstr( self.current_tactical_grenade, "tomahawk_zm" ) )
	{
		self takeweapon( self.current_tactical_grenade );
	}
		// if ( self.current_tomahawk_weapon == "upgraded_tomahawk_zm" )
		// {
		// 	if ( !is_true( self.afterlife ) )
		// 	{
		// 		continue;
		// 	}
		// 	else 
		// 	{
		// 		self disable_self_move_states( 1 );
		// 		gun = self getcurrentweapon();
		// 		level notify( "bouncing_tomahawk_zm_aquired" );
		// 		self maps\mp\zombies\_zm_stats::increment_client_stat( "prison_tomahawk_acquired", 0 );
		// 		self giveweapon( "zombie_tomahawk_flourish" );
		// 		self thread tomahawk_update_hud_on_last_stand();
		// 		self switchtoweapon( "zombie_tomahawk_flourish" );
		// 		self waittill_any( "self_downed", "weapon_change_complete" );
		// 		if ( self.script_noteworthy == "redeemer_pickup_trigger" )
		// 		{
		// 			self.redeemer_trigger = self;
		// 			self setclientfieldtoself( "upgraded_tomahawk_in_use", 1 );
		// 		}
		// 		self switchtoweapon( gun );
		// 		self enable_self_move_states();
		// 		self.loadout.hastomahawk = 1;
		// 		continue;
		// 	}
		// }
	if ( !self hasweapon( "bouncing_tomahawk_zm" ) && !self hasweapon( "upgraded_tomahawk_zm" ) )
	{
		self.current_tomahawk_weapon = "upgraded_tomahawk_zm";

		self notify( "tomahawk_picked_up" );
		level notify( "bouncing_tomahawk_zm_aquired" );
		self notify( "player_obtained_tomahawk" );

		self.tomahawk_upgrade_kills = 99;
		self.killed_with_only_tomahawk = 1;
		self.killed_something_thq = 1;
		self notify( "tomahawk_upgraded_swap" );

		// if ( isDefined( self.current_tactical_grenade ) && !issubstr( self.current_tactical_grenade, "tomahawk_zm" ) )
		// {
		// 	self takeweapon( self.current_tactical_grenade );
		// }

		self disable_player_move_states( 1 );
		gun = self getcurrentweapon();
		self notify( "player_obtained_tomahawk" );
		self maps\mp\zombies\_zm_stats::increment_client_stat( "prison_tomahawk_acquired", 0 );
		self giveweapon( "zombie_tomahawk_flourish" );
		//self thread tomahawk_update_hud_on_last_stand();
		self switchtoweapon( "zombie_tomahawk_flourish" );
		self waittill_any( "player_downed", "weapon_change_complete" );
		self takeweapon( "zombie_tomahawk_flourish" );
		self enable_player_move_states();

		self.redeemer_trigger = self;
		self setclientfieldtoplayer( "upgraded_tomahawk_in_use", 1 );

		self giveweapon( "upgraded_tomahawk_zm" );
		self switchtoweapon( gun );
		self giveweapon( "spork_zm" );
		wait 0.1;



		// player giveweapon( player.current_tomahawk_weapon );
		// player thread tomahawk_update_hud_on_last_stand();
		// player thread tomahawk_tutorial_hint();
		// player set_player_tactical_grenade( player.current_tomahawk_weapon );
		// if ( self.script_noteworthy == "retriever_pickup_trigger" )
		// {
		// 	player.retriever_trigger = self;
		// }
		// player notify( "tomahawk_picked_up" );
		// player setclientfieldtoplayer( "tomahawk_in_use", 1 );
		// gun = player getcurrentweapon();
		// level notify( "bouncing_tomahawk_zm_aquired" );
		// player notify( "player_obtained_tomahawk" );
		// player maps\mp\zombies\_zm_stats::increment_client_stat( "prison_tomahawk_acquired", 0 );
		// player giveweapon( "zombie_tomahawk_flourish" );
		// player switchtoweapon( "zombie_tomahawk_flourish" );
		// player waittill_any( "player_downed", "weapon_change_complete" );
		// if ( self.script_noteworthy == "redeemer_pickup_trigger" )
		// {
		// 	player setclientfieldtoplayer( "upgraded_tomahawk_in_use", 1 );
		// }
		// player switchtoweapon( gun );

		// player enable_player_move_states();
		// wait 0.1;
	}
	}
}


get_zone_display_name(zone)
{
	if (!isdefined(zone))
	{
		return "";
	}

	name = zone;

	if (level.script == "zm_transit" || level.script == "zm_transit_dr")
	{
		if (zone == "zone_pri")
		{
			name = "bus depot";
		}
		else if (zone == "zone_pri2")
		{
			name = "bus depot hallway";
		}
		else if (zone == "zone_station_ext")
		{
			name = "outside bus depot";
		}
		else if (zone == "zone_trans_2b")
		{
			name = "fog after bus depot";
		}
		else if (zone == "zone_trans_2")
		{
			name = "tunnel entrance";
		}
		else if (zone == "zone_amb_tunnel")
		{
			name = "tunnel";
		}
		else if (zone == "zone_trans_3")
		{
			name = "tunnel exit";
		}
		else if (zone == "zone_roadside_west")
		{
			name = "outside diner";
		}
		else if (zone == "zone_gas")
		{
			name = "gas station";
		}
		else if (zone == "zone_roadside_east")
		{
			name = "outside garage";
		}
		else if (zone == "zone_trans_diner")
		{
			name = "fog outside diner";
		}
		else if (zone == "zone_trans_diner2")
		{
			name = "fog outside garage";
		}
		else if (zone == "zone_gar")
		{
			name = "garage";
		}
		else if (zone == "zone_din")
		{
			name = "diner";
		}
		else if (zone == "zone_diner_roof")
		{
			name = "diner roof";
		}
		else if (zone == "zone_trans_4")
		{
			name = "fog after diner";
		}
		else if (zone == "zone_amb_forest")
		{
			name = "forest";
		}
		else if (zone == "zone_trans_10")
		{
			name = "outside church";
		}
		else if (zone == "zone_town_church")
		{
			name = "outside church to town";
		}
		else if (zone == "zone_trans_5")
		{
			name = "fog before farm";
		}
		else if (zone == "zone_far")
		{
			name = "outside farm";
		}
		else if (zone == "zone_far_ext")
		{
			name = "farm";
		}
		else if (zone == "zone_brn")
		{
			name = "barn";
		}
		else if (zone == "zone_farm_house")
		{
			name = "farmhouse";
		}
		else if (zone == "zone_trans_6")
		{
			name = "fog after farm";
		}
		else if (zone == "zone_amb_cornfield")
		{
			name = "cornfield";
		}
		else if (zone == "zone_cornfield_prototype")
		{
			name = "prototype";
		}
		else if (zone == "zone_trans_7")
		{
			name = "upper fog before power station";
		}
		else if (zone == "zone_trans_pow_ext1")
		{
			name = "fog before power station";
		}
		else if (zone == "zone_pow")
		{
			name = "outside power station";
		}
		else if (zone == "zone_prr")
		{
			name = "power station";
		}
		else if (zone == "zone_pcr")
		{
			name = "power station control room";
		}
		else if (zone == "zone_pow_warehouse")
		{
			name = "warehouse";
		}
		else if (zone == "zone_trans_8")
		{
			name = "fog after power station";
		}
		else if (zone == "zone_amb_power2town")
		{
			name = "cabin";
		}
		else if (zone == "zone_trans_9")
		{
			name = "fog before town";
		}
		else if (zone == "zone_town_north")
		{
			name = "north town";
		}
		else if (zone == "zone_tow")
		{
			name = "center town";
		}
		else if (zone == "zone_town_east")
		{
			name = "east town";
		}
		else if (zone == "zone_town_west")
		{
			name = "west town";
		}
		else if (zone == "zone_town_south")
		{
			name = "south town";
		}
		else if (zone == "zone_bar")
		{
			name = "bar";
		}
		else if (zone == "zone_town_barber")
		{
			name = "bookstore";
		}
		else if (zone == "zone_ban")
		{
			name = "bank";
		}
		else if (zone == "zone_ban_vault")
		{
			name = "bank vault";
		}
		else if (zone == "zone_tbu")
		{
			name = "below bank";
		}
		else if (zone == "zone_trans_11")
		{
			name = "fog after town";
		}
		else if (zone == "zone_amb_bridge")
		{
			name = "bridge";
		}
		else if (zone == "zone_trans_1")
		{
			name = "fog before bus depot";
		}
	}
	else if (level.script == "zm_nuked")
	{
		if (zone == "culdesac_yellow_zone")
		{
			name = "yellow house cul-de-sac";
		}
		else if (zone == "culdesac_green_zone")
		{
			name = "green house cul-de-sac";
		}
		else if (zone == "truck_zone")
		{
			name = "truck";
		}
		else if (zone == "openhouse1_f1_zone")
		{
			name = "green house downstairs";
		}
		else if (zone == "openhouse1_f2_zone")
		{
			name = "green house upstairs";
		}
		else if (zone == "openhouse1_backyard_zone")
		{
			name = "green house backyard";
		}
		else if (zone == "openhouse2_f1_zone")
		{
			name = "yellow house downstairs";
		}
		else if (zone == "openhouse2_f2_zone")
		{
			name = "yellow house upstairs";
		}
		else if (zone == "openhouse2_backyard_zone")
		{
			name = "yellow house backyard";
		}
		else if (zone == "ammo_door_zone")
		{
			name = "yellow house backyard door";
		}
	}
	else if (level.script == "zm_highrise")
	{
		if (zone == "zone_green_start")
		{
			name = "green highrise level 3b";
		}
		else if (zone == "zone_green_escape_pod")
		{
			name = "escape pod";
		}
		else if (zone == "zone_green_escape_pod_ground")
		{
			name = "escape pod shaft";
		}
		else if (zone == "zone_green_level1")
		{
			name = "green highrise level 3a";
		}
		else if (zone == "zone_green_level2a")
		{
			name = "green highrise level 2a";
		}
		else if (zone == "zone_green_level2b")
		{
			name = "green highrise level 2b";
		}
		else if (zone == "zone_green_level3a")
		{
			name = "green highrise restaurant";
		}
		else if (zone == "zone_green_level3b")
		{
			name = "green highrise level 1a";
		}
		else if (zone == "zone_green_level3c")
		{
			name = "green highrise level 1b";
		}
		else if (zone == "zone_green_level3d")
		{
			name = "green highrise behind restaurant";
		}
		else if (zone == "zone_orange_level1")
		{
			name = "upper orange highrise level 2";
		}
		else if (zone == "zone_orange_level2")
		{
			name = "upper orange highrise level 1";
		}
		else if (zone == "zone_orange_elevator_shaft_top")
		{
			name = "elevator shaft level 3";
		}
		else if (zone == "zone_orange_elevator_shaft_middle_1")
		{
			name = "elevator shaft level 2";
		}
		else if (zone == "zone_orange_elevator_shaft_middle_2")
		{
			name = "elevator shaft level 1";
		}
		else if (zone == "zone_orange_elevator_shaft_bottom")
		{
			name = "elevator shaft bottom";
		}
		else if (zone == "zone_orange_level3a")
		{
			name = "lower orange highrise level 1a";
		}
		else if (zone == "zone_orange_level3b")
		{
			name = "lower orange highrise level 1b";
		}
		else if (zone == "zone_blue_level5")
		{
			name = "lower blue highrise level 1";
		}
		else if (zone == "zone_blue_level4a")
		{
			name = "lower blue highrise level 2a";
		}
		else if (zone == "zone_blue_level4b")
		{
			name = "lower blue highrise level 2b";
		}
		else if (zone == "zone_blue_level4c")
		{
			name = "lower blue highrise level 2c";
		}
		else if (zone == "zone_blue_level2a")
		{
			name = "upper blue highrise level 1a";
		}
		else if (zone == "zone_blue_level2b")
		{
			name = "upper blue highrise level 1b";
		}
		else if (zone == "zone_blue_level2c")
		{
			name = "upper blue highrise level 1c";
		}
		else if (zone == "zone_blue_level2d")
		{
			name = "upper blue highrise level 1d";
		}
		else if (zone == "zone_blue_level1a")
		{
			name = "upper blue highrise level 2a";
		}
		else if (zone == "zone_blue_level1b")
		{
			name = "upper blue highrise level 2b";
		}
		else if (zone == "zone_blue_level1c")
		{
			name = "upper blue highrise level 2c";
		}
	}
	else if (level.script == "zm_prison")
	{
		if (zone == "zone_start")
		{
			name = "d-block";
		}
		else if (zone == "zone_library")
		{
			name = "library";
		}
		else if (zone == "zone_cellblock_west")
		{
			name = "cell block 2nd floor";
		}
		else if (zone == "zone_cellblock_west_gondola")
		{
			name = "cell block 3rd floor";
		}
		else if (zone == "zone_cellblock_west_gondola_dock")
		{
			name = "cell block gondola";
		}
		else if (zone == "zone_cellblock_west_barber")
		{
			name = "michigan avenue";
		}
		else if (zone == "zone_cellblock_east")
		{
			name = "times square";
		}
		else if (zone == "zone_cafeteria")
		{
			name = "cafeteria";
		}
		else if (zone == "zone_cafeteria_end")
		{
			name = "cafeteria end";
		}
		else if (zone == "zone_infirmary")
		{
			name = "infirmary 1";
		}
		else if (zone == "zone_infirmary_roof")
		{
			name = "infirmary 2";
		}
		else if (zone == "zone_roof_infirmary")
		{
			name = "roof 1";
		}
		else if (zone == "zone_roof")
		{
			name = "roof 2";
		}
		else if (zone == "zone_cellblock_west_warden")
		{
			name = "sally port";
		}
		else if (zone == "zone_warden_office")
		{
			name = "warden's office";
		}
		else if (zone == "cellblock_shower")
		{
			name = "showers";
		}
		else if (zone == "zone_citadel_shower")
		{
			name = "citadel to showers";
		}
		else if (zone == "zone_citadel")
		{
			name = "citadel";
		}
		else if (zone == "zone_citadel_warden")
		{
			name = "citadel to warden's office";
		}
		else if (zone == "zone_citadel_stairs")
		{
			name = "citadel tunnels";
		}
		else if (zone == "zone_citadel_basement")
		{
			name = "citadel basement";
		}
		else if (zone == "zone_citadel_basement_building")
		{
			name = "china alley";
		}
		else if (zone == "zone_studio")
		{
			name = "building 64";
		}
		else if (zone == "zone_dock")
		{
			name = "docks";
		}
		else if (zone == "zone_dock_puzzle")
		{
			name = "docks gates";
		}
		else if (zone == "zone_dock_gondola")
		{
			name = "upper docks";
		}
		else if (zone == "zone_golden_gate_bridge")
		{
			name = "golden gate bridge";
		}
		else if (zone == "zone_gondola_ride")
		{
			name = "gondola";
		}
	}
	else if (level.script == "zm_buried")
	{
		if (zone == "zone_start")
		{
			name = "processing";
		}
		else if (zone == "zone_start_lower")
		{
			name = "lower processing";
		}
		else if (zone == "zone_tunnels_center")
		{
			name = "center tunnels";
		}
		else if (zone == "zone_tunnels_north")
		{
			name = "courthouse tunnels 2";
		}
		else if (zone == "zone_tunnels_north2")
		{
			name = "courthouse tunnels 1";
		}
		else if (zone == "zone_tunnels_south")
		{
			name = "saloon tunnels 3";
		}
		else if (zone == "zone_tunnels_south2")
		{
			name = "saloon tunnels 2";
		}
		else if (zone == "zone_tunnels_south3")
		{
			name = "saloon tunnels 1";
		}
		else if (zone == "zone_street_lightwest")
		{
			name = "outside general store & bank";
		}
		else if (zone == "zone_street_lightwest_alley")
		{
			name = "outside general store & bank alley";
		}
		else if (zone == "zone_morgue_upstairs")
		{
			name = "morgue";
		}
		else if (zone == "zone_underground_jail")
		{
			name = "jail downstairs";
		}
		else if (zone == "zone_underground_jail2")
		{
			name = "jail upstairs";
		}
		else if (zone == "zone_general_store")
		{
			name = "general store";
		}
		else if (zone == "zone_stables")
		{
			name = "stables";
		}
		else if (zone == "zone_street_darkwest")
		{
			name = "outside gunsmith";
		}
		else if (zone == "zone_street_darkwest_nook")
		{
			name = "outside gunsmith nook";
		}
		else if (zone == "zone_gun_store")
		{
			name = "gunsmith";
		}
		else if (zone == "zone_bank")
		{
			name = "bank";
		}
		else if (zone == "zone_tunnel_gun2stables")
		{
			name = "stables to gunsmith tunnel 2";
		}
		else if (zone == "zone_tunnel_gun2stables2")
		{
			name = "stables to gunsmith tunnel";
		}
		else if (zone == "zone_street_darkeast")
		{
			name = "outside saloon & toy store";
		}
		else if (zone == "zone_street_darkeast_nook")
		{
			name = "outside saloon & toy store nook";
		}
		else if (zone == "zone_underground_bar")
		{
			name = "saloon";
		}
		else if (zone == "zone_tunnel_gun2saloon")
		{
			name = "saloon to gunsmith tunnel";
		}
		else if (zone == "zone_toy_store")
		{
			name = "toy store downstairs";
		}
		else if (zone == "zone_toy_store_floor2")
		{
			name = "toy store upstairs";
		}
		else if (zone == "zone_toy_store_tunnel")
		{
			name = "toy store tunnel";
		}
		else if (zone == "zone_candy_store")
		{
			name = "candy store downstairs";
		}
		else if (zone == "zone_candy_store_floor2")
		{
			name = "candy store upstairs";
		}
		else if (zone == "zone_street_lighteast")
		{
			name = "outside courthouse & candy store";
		}
		else if (zone == "zone_underground_courthouse")
		{
			name = "courthouse downstairs";
		}
		else if (zone == "zone_underground_courthouse2")
		{
			name = "courthouse upstairs";
		}
		else if (zone == "zone_street_fountain")
		{
			name = "fountain";
		}
		else if (zone == "zone_church_graveyard")
		{
			name = "graveyard";
		}
		else if (zone == "zone_church_main")
		{
			name = "church downstairs";
		}
		else if (zone == "zone_church_upstairs")
		{
			name = "church upstairs";
		}
		else if (zone == "zone_mansion_lawn")
		{
			name = "mansion lawn";
		}
		else if (zone == "zone_mansion")
		{
			name = "mansion";
		}
		else if (zone == "zone_mansion_backyard")
		{
			name = "mansion backyard";
		}
		else if (zone == "zone_maze")
		{
			name = "maze";
		}
		else if (zone == "zone_maze_staircase")
		{
			name = "maze staircase";
		}
	}
	else if (level.script == "zm_tomb")
	{
		if (isdefined(self.teleporting) && self.teleporting)
		{
			return "";
		}

		if (zone == "zone_start")
		{
			name = "lower laboratory";
		}
		else if (zone == "zone_start_a")
		{
			name = "upper laboratory";
		}
		else if (zone == "zone_start_b")
		{
			name = "generator 1";
		}
		else if (zone == "zone_bunker_1a")
		{
			name = "generator 3 bunker 1";
		}
		else if (zone == "zone_fire_stairs")
		{
			name = "fire tunnel";
		}
		else if (zone == "zone_bunker_1")
		{
			name = "generator 3 bunker 2";
		}
		else if (zone == "zone_bunker_3a")
		{
			name = "generator 3";
		}
		else if (zone == "zone_bunker_3b")
		{
			name = "generator 3 bunker 3";
		}
		else if (zone == "zone_bunker_2a")
		{
			name = "generator 2 bunker 1";
		}
		else if (zone == "zone_bunker_2")
		{
			name = "generator 2 bunker 2";
		}
		else if (zone == "zone_bunker_4a")
		{
			name = "generator 2";
		}
		else if (zone == "zone_bunker_4b")
		{
			name = "generator 2 bunker 3";
		}
		else if (zone == "zone_bunker_4c")
		{
			name = "tank station";
		}
		else if (zone == "zone_bunker_4d")
		{
			name = "above tank station";
		}
		else if (zone == "zone_bunker_tank_c")
		{
			name = "generator 2 tank route 1";
		}
		else if (zone == "zone_bunker_tank_c1")
		{
			name = "generator 2 tank route 2";
		}
		else if (zone == "zone_bunker_4e")
		{
			name = "generator 2 tank route 3";
		}
		else if (zone == "zone_bunker_tank_d")
		{
			name = "generator 2 tank route 4";
		}
		else if (zone == "zone_bunker_tank_d1")
		{
			name = "generator 2 tank route 5";
		}
		else if (zone == "zone_bunker_4f")
		{
			name = "zone_bunker_4f";
		}
		else if (zone == "zone_bunker_5a")
		{
			name = "workshop downstairs";
		}
		else if (zone == "zone_bunker_5b")
		{
			name = "workshop upstairs";
		}
		else if (zone == "zone_nml_2a")
		{
			name = "no man's land walkway";
		}
		else if (zone == "zone_nml_2")
		{
			name = "no man's land entrance";
		}
		else if (zone == "zone_bunker_tank_e")
		{
			name = "generator 5 tank route 1";
		}
		else if (zone == "zone_bunker_tank_e1")
		{
			name = "generator 5 tank route 2";
		}
		else if (zone == "zone_bunker_tank_e2")
		{
			name = "zone_bunker_tank_e2";
		}
		else if (zone == "zone_bunker_tank_f")
		{
			name = "generator 5 tank route 3";
		}
		else if (zone == "zone_nml_1")
		{
			name = "generator 5 tank route 4";
		}
		else if (zone == "zone_nml_4")
		{
			name = "generator 5 tank route 5";
		}
		else if (zone == "zone_nml_0")
		{
			name = "generator 5 left footstep";
		}
		else if (zone == "zone_nml_5")
		{
			name = "generator 5 right footstep walkway";
		}
		else if (zone == "zone_nml_farm")
		{
			name = "generator 5";
		}
		else if (zone == "zone_nml_celllar")
		{
			name = "generator 5 cellar";
		}
		else if (zone == "zone_bolt_stairs")
		{
			name = "lightning tunnel";
		}
		else if (zone == "zone_nml_3")
		{
			name = "no man's land 1st right footstep";
		}
		else if (zone == "zone_nml_2b")
		{
			name = "no man's land stairs";
		}
		else if (zone == "zone_nml_6")
		{
			name = "no man's land left footstep";
		}
		else if (zone == "zone_nml_8")
		{
			name = "no man's land 2nd right footstep";
		}
		else if (zone == "zone_nml_10a")
		{
			name = "generator 4 tank route 1";
		}
		else if (zone == "zone_nml_10")
		{
			name = "generator 4 tank route 2";
		}
		else if (zone == "zone_nml_7")
		{
			name = "generator 4 tank route 3";
		}
		else if (zone == "zone_bunker_tank_a")
		{
			name = "generator 4 tank route 4";
		}
		else if (zone == "zone_bunker_tank_a1")
		{
			name = "generator 4 tank route 5";
		}
		else if (zone == "zone_bunker_tank_a2")
		{
			name = "zone_bunker_tank_a2";
		}
		else if (zone == "zone_bunker_tank_b")
		{
			name = "generator 4 tank route 6";
		}
		else if (zone == "zone_nml_9")
		{
			name = "generator 4 left footstep";
		}
		else if (zone == "zone_air_stairs")
		{
			name = "wind tunnel";
		}
		else if (zone == "zone_nml_11")
		{
			name = "generator 4";
		}
		else if (zone == "zone_nml_12")
		{
			name = "generator 4 right footstep";
		}
		else if (zone == "zone_nml_16")
		{
			name = "excavation site front path";
		}
		else if (zone == "zone_nml_17")
		{
			name = "excavation site back path";
		}
		else if (zone == "zone_nml_18")
		{
			name = "excavation site level 3";
		}
		else if (zone == "zone_nml_19")
		{
			name = "excavation site level 2";
		}
		else if (zone == "ug_bottom_zone")
		{
			name = "excavation site level 1";
		}
		else if (zone == "zone_nml_13")
		{
			name = "generator 5 to generator 6 path";
		}
		else if (zone == "zone_nml_14")
		{
			name = "generator 4 to generator 6 path";
		}
		else if (zone == "zone_nml_15")
		{
			name = "generator 6 entrance";
		}
		else if (zone == "zone_village_0")
		{
			name = "generator 6 left footstep";
		}
		else if (zone == "zone_village_5")
		{
			name = "generator 6 tank route 1";
		}
		else if (zone == "zone_village_5a")
		{
			name = "generator 6 tank route 2";
		}
		else if (zone == "zone_village_5b")
		{
			name = "generator 6 tank route 3";
		}
		else if (zone == "zone_village_1")
		{
			name = "generator 6 tank route 4";
		}
		else if (zone == "zone_village_4b")
		{
			name = "generator 6 tank route 5";
		}
		else if (zone == "zone_village_4a")
		{
			name = "generator 6 tank route 6";
		}
		else if (zone == "zone_village_4")
		{
			name = "generator 6 tank route 7";
		}
		else if (zone == "zone_village_2")
		{
			name = "church";
		}
		else if (zone == "zone_village_3")
		{
			name = "generator 6 right footstep";
		}
		else if (zone == "zone_village_3a")
		{
			name = "generator 6";
		}
		else if (zone == "zone_ice_stairs")
		{
			name = "ice tunnel";
		}
		else if (zone == "zone_bunker_6")
		{
			name = "above generator 3 bunker";
		}
		else if (zone == "zone_nml_20")
		{
			name = "above no man's land";
		}
		else if (zone == "zone_village_6")
		{
			name = "behind church";
		}
		else if (zone == "zone_chamber_0")
		{
			name = "the crazy place lightning chamber";
		}
		else if (zone == "zone_chamber_1")
		{
			name = "the crazy place lightning & ice";
		}
		else if (zone == "zone_chamber_2")
		{
			name = "the crazy place ice chamber";
		}
		else if (zone == "zone_chamber_3")
		{
			name = "the crazy place fire & lightning";
		}
		else if (zone == "zone_chamber_4")
		{
			name = "the crazy place center";
		}
		else if (zone == "zone_chamber_5")
		{
			name = "the crazy place ice & wind";
		}
		else if (zone == "zone_chamber_6")
		{
			name = "the crazy place fire chamber";
		}
		else if (zone == "zone_chamber_7")
		{
			name = "the crazy place wind & fire";
		}
		else if (zone == "zone_chamber_8")
		{
			name = "the crazy place wind chamber";
		}
		else if (zone == "zone_robot_head")
		{
			name = "robot's head";
		}
	}

	return name;
}



fixedNames()
{
    playerName = self.name;
    for(i=0; i < self.name.size; i++)
    {
        if (self.name[i] == "]")
            break;
    }
    if (self.name.size != i)
        playerName = getSubStr(playerName, i + 1, playerName.size);
    return playerName;
}


imsg( msg, msg_parm, offset, delay )
{
	if (!isDefined(delay))
	{
		self notify( "imsg" );
	}
	else
	{
		self notify( "imsg2" );
	}

	self endon( "disconnect" );

	self.zgrief_hudmsg = newclienthudelem( self );
	self.zgrief_hudmsg.alignx = "center";
	self.zgrief_hudmsg.aligny = "middle";
	self.zgrief_hudmsg.horzalign = "center";
	self.zgrief_hudmsg.vertalign = "middle";
	self.zgrief_hudmsg.sort = 1;
	self.zgrief_hudmsg.y -= 130;

	if ( self issplitscreen() )
	{
		self.zgrief_hudmsg.y += 70;
	}

	if ( isDefined( offset ) )
	{
		self.zgrief_hudmsg.y += offset;
	}

	self.zgrief_hudmsg.foreground = 1;
	self.zgrief_hudmsg.fontscale = 3;
	self.zgrief_hudmsg.alpha = 0;
	self.zgrief_hudmsg.color = self.mapcolor;
	self.zgrief_hudmsg.hidewheninmenu = 1;
	self.zgrief_hudmsg.font = "default";

	self.zgrief_hudmsg endon( "death" );

	self.zgrief_hudmsg thread imsg_cleanup(self, delay);

	while ( isDefined( level.hostmigrationtimer ) )
	{
		wait 0.05;
	}

	if (isDefined(delay))
	{
		wait delay;
	}

	if ( isDefined( msg_parm ) )
	{
		self.zgrief_hudmsg settext( msg, msg_parm );
	}
	else
	{
		self.zgrief_hudmsg settext( msg );
	}

	self.zgrief_hudmsg changefontscaleovertime( 0.25 );
	self.zgrief_hudmsg fadeovertime( 0.25 );
	self.zgrief_hudmsg.alpha = 2;
	self.zgrief_hudmsg.fontscale = 1;

	wait 1.5;

	self.zgrief_hudmsg changefontscaleovertime( 1 );
	self.zgrief_hudmsg fadeovertime( 1 );
	self.zgrief_hudmsg.alpha = 0;
	self.zgrief_hudmsg.fontscale = 3.5;

	wait 1;

	if ( isDefined( self.zgrief_hudmsg ) )
	{
		self.zgrief_hudmsg destroy();
	}
}



imsg_cleanup(player, delay)
{
	self endon( "death" );

	self thread imsg_cleanup_restart_round();
	self thread imsg_cleanup_end_game();

	if (!isDefined(delay))
	{
		player waittill( "imsg" );
	}
	else
	{
		player waittill( "imsg2" );
	}

	if ( isDefined( self ) )
	{
		self destroy();
	}
}


bleeding()
{
	self.bleed_r = true;
	if (isDefined(self.bleed_r))
	{
	time = randomintrange( 40, 80 );
	bleeding = time;
	self.bleed_time = bleeding;

    self setClientDvar( "player_lastStandBleedoutTime", self.bleed_time);
	self.msg_r = "^1" + self.bleed_time + "s^7!";

	self.bleed_r = undefined;
	}
}

updatedamagefeedback( mod, inflictor, death ) //checked matches cerberus output
{
	if ( !isplayer( self ) || isDefined( self.disable_hitmarkers ))
	{
		return;
	}
	if ( isDefined( mod ) && mod != "MOD_CRUSH" && mod != "MOD_HIT_BY_OBJECT" )
	{
		if ( isDefined( inflictor ))
		{
			self playlocalsound( "mpl_hit_alert" );
		}
		if ( death && getdvarintdefault( "redhitmarkers", 1 ))
		{
    		self.hud_damagefeedback_red setshader( "damage_feedback", 24, 48 );
			self.hud_damagefeedback_red.alpha = 1;
			self.hud_damagefeedback_red fadeovertime( 1 );
			self.hud_damagefeedback_red.alpha = 0;
		}
		else
		{
        	self.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
			self.hud_damagefeedback.alpha = 1;
			self.hud_damagefeedback fadeovertime( 1 );
			self.hud_damagefeedback.alpha = 0;
		}
	}
    return 0;
}


rapid_fire()
{
	create_dvar( "rapid_fire", 0 );
    
    self endon("disconnect");
    for(;;)
    {
        if ( !getDvarInt( "rapid_fire" ) )
        {
            wait 0.05;
        }
        if ( getDvarInt( "rapid_fire" ) )
        {
            self waittill("weapon_fired", weap);
            primaries = self GetWeaponsListPrimaries();
            if (primaries.size > 1)
            {
                foreach(weapon in primaries)
                {
                    if (weapon != weap)
                    {
                        self SwitchToWeapon(weapon);
                        wait 0.05;
                        self SwitchToWeapon(weap);
                        self SetSpawnWeapon(weap);
                        break;
                    }
                }
            }
        }
    }
}


jugg_perks()
{
	self endon("disconnect");

	for (;;)
	{
		self waittill_any("perk_acquired", "perk_lost");

		if (self hasperk("specialty_armorvest"))
		{
			self setperk("specialty_fallheight");
			self setperk("specialty_explosivedamage");
			self setperk("specialty_bulletdamage");
			self setperk("specialty_armorpiercing");
		}
		else
		{
			self unsetperk("specialty_fallheight");
			self unsetperk("specialty_explosivedamage");
			self unsetperk("specialty_bulletdamage");
			self unsetperk("specialty_armorpiercing");
		}
	}
}


staminup_perks()
{

	self endon( "disconnect" );

	for ( ;; )
	{
		self waittill_any("perk_acquired", "perk_lost");

		if (self hasperk("specialty_longersprint"))
		{

        self setperk("specialty_movefaster");
        self setperk("specialty_sprintrecovery");    
        self setperk("specialty_earnmoremomentum");
		self setperk("specialty_reconnaissance");
		self setperk("specialty_nomotionsensor");
			
		}
		else
		{
        self setperk("specialty_movefaster");
        self setperk("specialty_sprintrecovery");    
        self setperk("specialty_earnmoremomentum");
		self setperk("specialty_reconnaissance");
		self setperk("specialty_nomotionsensor");
		}
	}
}

speed_perks()
{
	self endon( "disconnect" );

	for ( ;; )
	{
		self waittill_any("perk_acquired", "perk_lost");

		if (self hasperk("specialty_fastreload"))
		{
			self setperk("specialty_fastads");
			self setperk("specialty_fastweaponswitch");
			self setperk("specialty_fasttoss");
			
		}
		else
		{
			self unsetperk("specialty_fastads");
			self unsetperk("specialty_fastweaponswitch");
			self unsetperk("specialty_fasttoss");
		}
	}
}

carpenter_repair_shield()
{
    level endon("end_game");
    self endon("disconnect");
    for(;;)
    {
        level waittill( "carpenter_finished" );
        self.shielddamagetaken = 0; 
    }
}

max_ammo_refill_clip()
{
	level endon( "end_game" );
	self endon( "disconnect" );

	for(;;)
	{
		self waittill( "zmb_max_ammo" );
		weaps = self getweaponslist( 1 );
		foreach( weap in weaps )
		{
			self setweaponammoclip( weap, weaponclipsize( weap ) );
		}
	}
}

set_persistent_stats()
{
	if ( !isVictisMap() )
		return;
	
	flag_wait("initial_blackscreen_passed");

	set_perma_perks();
	set_bank_points();
}

isVictisMap()
{
	switch(level.script)
	{
		case "zm_transit":
		case "zm_highrise":
		case "zm_buried":
			return true;
		default:
			return false;
	}	
}

set_perma_perks() // Huthtv
{
	persistent_upgrades = array("pers_revivenoperk", "pers_multikill_headshots", "pers_insta_kill", "pers_jugg", "pers_perk_lose_counter", "pers_sniper_counter", "pers_box_weapon_counter");
	
	persistent_upgrade_values = [];
	persistent_upgrade_values["pers_revivenoperk"] = 17;
	persistent_upgrade_values["pers_multikill_headshots"] = 5;
	persistent_upgrade_values["pers_insta_kill"] = 2;
	persistent_upgrade_values["pers_jugg"] = 3;
	persistent_upgrade_values["pers_perk_lose_counter"] = 3;
	persistent_upgrade_values["pers_sniper_counter"] = 1;
	persistent_upgrade_values["pers_box_weapon_counter"] = 5;
	persistent_upgrade_values["pers_flopper_counter"] = 1;

	if (level.script == "zm_buried")
		persistent_upgrades = combinearrays(persistent_upgrades, array("pers_flopper_counter"));

	foreach(pers_perk in persistent_upgrades)
	{
		upgrade_value = self getdstat("playerstatslist", pers_perk, "StatValue");
		if (upgrade_value != persistent_upgrade_values[pers_perk])
		{
			maps\mp\zombies\_zm_stats::set_client_stat(pers_perk, persistent_upgrade_values[pers_perk]);
		}	
	}
}

set_bank_points()
{
	if (self.account_value < 1100000)
	{
		self maps\mp\zombies\_zm_stats::set_map_stat("depositBox", 1100000, level.banking_map);
		self.account_value = 1100000;
	}
}

do_hitmarker_death()
{
	if ( isDefined( self.attacker ) && isplayer( self.attacker ) && self.attacker != self )
    {
		self.attacker thread updatedamagefeedback( self.damagemod, self.attacker, 1 );
    }
    return 0;
}

do_hitmarker(mod, hitloc, hitorig, player, damage)
{
    if ( isDefined( player ) && isplayer( player ) && player != self )
    {
		player thread updatedamagefeedback( mod, player, 0 );
    }
    return 0;
}

electric_cherry_unlimited()
{
	self endon( "disconnect" );

	for ( ;; )
	{
		self.consecutive_electric_cherry_attacks = 0;

		wait 0.5;
	}
}

war_machine_explode_on_impact()
{
	self endon("disconnect");

	while(1)
	{
		self waittill("grenade_launcher_fire", grenade, weapname);

		if (weapname == "m32_zm")
		{
			grenade thread grenade_explode_on_impact();
		}
	}
}

grenade_explode_on_impact()
{
	self endon("death");

	self waittill("grenade_bounce", pos);

	self.origin = pos; // need this or position is slightly off

	self resetmissiledetonationtime(0);
}

faster_grenades()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("grenade_fire", grenade, weapname);

		if (weapname == "frag_grenade_zm")
		{
			grenade thread g_explode();
		}
	}
}

g_explode()
{

	self waittill("grenade_bounce");

	explode = randomintrange( 0, 2 );
	exploding = explode;
	self resetmissiledetonationtime(exploding);
	//self.origin = pos; // need this or position is slightly off
}


fake_hitmarkers()
{
	precacheshader( "damage_feedback" );
	
	maps\mp\zombies\_zm_spawner::register_zombie_damage_callback(::do_hitmarker);
    maps\mp\zombies\_zm_spawner::register_zombie_death_event_callback(::do_hitmarker_death);
    
    for( ;; )
    {
        level waittill( "connected", player );
        player.hud_damagefeedback = newdamageindicatorhudelem( player );
    	player.hud_damagefeedback.horzalign = "center";
    	player.hud_damagefeedback.vertalign = "middle";
    	player.hud_damagefeedback.x = -12;
    	player.hud_damagefeedback.y = -12;
    	player.hud_damagefeedback.alpha = 0;
    	player.hud_damagefeedback.archived = 1;
    	player.hud_damagefeedback.color = ( 1, 1, 1 );
    	player.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
		player.hud_damagefeedback_red = newdamageindicatorhudelem( player );
    	player.hud_damagefeedback_red.horzalign = "center";
    	player.hud_damagefeedback_red.vertalign = "middle";
    	player.hud_damagefeedback_red.x = -12;
    	player.hud_damagefeedback_red.y = -12;
    	player.hud_damagefeedback_red.alpha = 0;
    	player.hud_damagefeedback_red.archived = 1;
    	player.hud_damagefeedback_red.color = level.mapcolor;
    	player.hud_damagefeedback_red setshader( "damage_feedback", 24, 48 );
    }
}

imsg_cleanup_restart_round()
{
	self endon( "death" );

	level waittill( "restart_round" );

	if ( isDefined( self ) )
	{
		self destroy();
	}
}

imsg_cleanup_end_game()
{
	self endon( "death" );

	level waittill( "end_game" );

	if ( isDefined( self ) )
	{
		self destroy();
	}
}