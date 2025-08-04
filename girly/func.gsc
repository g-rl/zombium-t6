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
#include scripts\zm\girly\exo_suit;
#include scripts\zm\girly\match;
#include scripts\zm\girly\player;
#include scripts\zm\girly\zombie;
#include scripts\zm\girly\powerups;
#include scripts\zm\girly\overflow_fix;
#include scripts\zm\girly\hud;
#include scripts\zm\girly\map;
#include scripts\zm\girly\menu;
#include scripts\zm\girly\weapons;

increase_powerup_limits()
{
	level endon("end_game");
	level endon("game_ended");
	for(;;)
	{
		level waittill("start_of_round");
		level.current_powerups = level.zombie_vars["zombie_powerup_drop_max_per_round"];
		switch(level.round_number)
		{
			case 5:
				level.zombie_vars["zombie_powerup_drop_max_per_round"] = 8;
				set_zombie_var("zombie_powerup_drop_max_per_round", 8);
				level.current_powerups = level.zombie_vars["zombie_powerup_drop_max_per_round"];
			case 10:
				level.zombie_vars["zombie_powerup_drop_max_per_round"] = 10;
				set_zombie_var("zombie_powerup_drop_max_per_round", 10);
				level.current_powerups = level.zombie_vars["zombie_powerup_drop_max_per_round"];
			case 15:
				level.zombie_vars["zombie_powerup_drop_max_per_round"] = 12;
				set_zombie_var("zombie_powerup_drop_max_per_round", 12);
				level.current_powerups = level.zombie_vars["zombie_powerup_drop_max_per_round"];
			case 20:
				level.zombie_vars["zombie_powerup_drop_max_per_round"] = 14;
				set_zombie_var("zombie_powerup_drop_max_per_round", 14);
				level.current_powerups = level.zombie_vars["zombie_powerup_drop_max_per_round"];
			case 25:
				level.zombie_vars["zombie_powerup_drop_max_per_round"] = 15;
				set_zombie_var("zombie_powerup_drop_max_per_round", 15);
				level.current_powerups = level.zombie_vars["zombie_powerup_drop_max_per_round"];
			case 30:
				level.zombie_vars["zombie_powerup_drop_max_per_round"] = 17;
				set_zombie_var("zombie_powerup_drop_max_per_round", 17);
				level.current_powerups = level.zombie_vars["zombie_powerup_drop_max_per_round"];
			default:
				level.zombie_vars["zombie_powerup_drop_max_per_round"] = level.current_powerups;
				set_zombie_var("zombie_powerup_drop_max_per_round", level.current_powerups);
		}
	}

}
on_player_downed()
{
	self endon("disconnect");
	level endon("end_game");
	level endon("game_ended");
	
	for(;;)
	{

		self waittill_any( "player_downed", "fake_death", "entering_last_stand");	
		self thread play_sound_at_pos( "music_chest", self.origin );
		self thread bleeding();
		self thread maps\mp\animscripts\zm_death::flame_death_fx();
		
		zone = self get_current_zone();
		zone_name = get_zone_display_name(zone);

		random_color = randomintrange( 2, 6 );
		colors = "^" + random_color;

		random_color_a = randomintrange( 5, 9 );
		colors_a = "^" + random_color_a;

		playfx( level._effect["fx_wisp_m"], self.origin );

		self.statusicon = "hud_status_dead"; // set dead icon on scoreboard

		if ( level.script != "zm_prison" )
		{
			iprintln("^7[" + self.clantag + "^7] ^3" + fixedNames() + " ^7is down at " + colors + zone_name + "^7! They will ^1bleedout^7 in " + self.msg_r);
		} 
		else 
		{
			iprintln("^7[" + self.clantag + "^7] ^3" + fixedNames() + " ^7has entered the ^5afterlife^7!" + " ^7(" + colors + zone_name + "^7)");
		}
		
	}

}

on_player_revived()
{
	self endon("disconnect");
	level endon("end_game");
	level endon("game_ended");
	
	for(;;)
	{
		self waittill( "player_revived" );
		map = getdvar("mapname");
		if (!self.sessionstate == "spectator")
		{
			self.statusicon = ""; // remove death icon from scoreboard
			if (!self hasperk("specialty_armorvest"))
			{
				self setnormalhealth(self.myhealth);
				self setmaxhealth(self.myhealth);
				self.health = self.myhealth;
			}

			self thread perk_setup();

			if (map != "zm_buried" || map != "zm_highrise" || map != "zm_prison" || getdvar("g_gametype") != "zstandard")
				self thread first_free_perks(); // give a perk or 2 back on maps with no perma perks
		}
	}
}

time_until_despawn() {}

revive_trigger_should_ignore_sight_checks( i )
{
    return 1;
}

first_free_perks()
{
	wait 1;
	self maps\mp\zombies\_zm_perks::give_random_perk();
	self notify("player_received_ghost_round_free_perk");
	self thread play_sound_at_pos("music_chest", self.origin);
	i = randomintrange(2, 6); // if greater than 3 give another perk

	if (i < 3) 
	{
		self maps\mp\zombies\_zm_perks::give_random_perk();
		self notify( "player_received_ghost_round_free_perk" );
		self thread maps\mp\animscripts\zm_death::flame_death_fx(); 
	}
}

randomize(a) 
{
	r = strTok(a, " ");
	random = RandomInt(r.size);
	final = r[random];
	return final;
}

tomb_give_one_punch(i)
{
	if (getdvar("mapname") != "zm_tomb")
		return;

    self endon( "death" );
    self endon( "disconnect" );
    x = self getcurrentweapon();
    self disable_player_move_states( 1 );
	self giveweapon( "zombie_one_inch_punch_upgrade_flourish" );
	self switchtoweapon( "zombie_one_inch_punch_upgrade_flourish" );
	self waittill_any( "player_downed", "weapon_change_complete" );
	self takeweapon( "zombie_one_inch_punch_upgrade_flourish" );
    self giveweapon( i );
    self set_player_melee_weapon( i );
    self switchtoweapon( x );
    self enable_player_move_states();
}

tomb_give_shovel()
{
	if ( level.script != "zm_tomb" )
		return;
		
	i = self getentitynumber() + 1;
	level setclientfield( "shovel_player" + i, 2 );
	level setclientfield( "helmet_player" + i, 1 );
	self.dig_vars["has_upgraded_shovel"] = 1;
	self.dig_vars["has_helmet"] = 1;
	self.dig_vars["has_shovel"] = 1;
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


treasure_chest_canplayerreceiveweapon_override( player, weapon, pap_triggers ) //checked matches cerberus output
{
	if ( !get_is_in_box( weapon ) )
	{
		return 0;
	}
	if ( isDefined( player ) && player has_weapon_or_upgrade( weapon ) )
	{
		return 0;
	}
	if ( !limited_weapon_below_quota( weapon, player, pap_triggers ) )
	{
		return 0;
	}
	if ( !player player_can_use_content( weapon ) )
	{
		return 0;
	}
	if ( isDefined( level.custom_magic_box_selection_logic ) )
	{
		if ( !( [[ level.custom_magic_box_selection_logic ]]( weapon, player, pap_triggers ) ) )
		{
			return 0;
		}
	}
	if ( isDefined( player ) && isDefined( level.special_weapon_magicbox_check ) )
	{
		return player [[ level.special_weapon_magicbox_check ]]( weapon );
	}
	return 1;
}

is_setup_weapon( weapon )
{
	if ( weapon == "raygun_mark2_zm" || weapon == "ray_gun_zm" || weapon == "cymbal_monkey_zm" || weapon == "blundergat_zm" || weapon == "slowgun_zm" || weapon == "m32_zm" )
	{
		return 1;
	}
	return 0;
}


treasure_chest_weapon_spawn_override( chest, player, respin )
{
	if ( isDefined( level.using_locked_magicbox ) && level.using_locked_magicbox )
	{
		self.owner endon( "box_locked" );
		self thread maps\mp\zombies\_zm_magicbox_lock::clean_up_locked_box();
	}
	self endon( "box_hacked_respin" );
	self thread clean_up_hacked_box();
	self.weapon_string = undefined;
	modelname = undefined;
	rand = undefined;
	number_cycles = 40;
	if ( isDefined( chest.zbarrier ) )
	{
		if ( isDefined( level.custom_magic_box_do_weapon_rise ) )
		{
			chest.zbarrier thread [[ level.custom_magic_box_do_weapon_rise ]]();
		}
		else
		{
			chest.zbarrier thread magic_box_do_weapon_rise();
		}
	}
	i = 0;
	while ( i < number_cycles )
	{
		if ( i < 20 )
		{
			wait 0.05;
			i++;
			continue;
		}
		else if ( i < 30 )
		{
			wait 0.1;
			i++;
			continue;
		}
		else if ( i < 35 )
		{
			wait 0.2;
			i++;
			continue;
		}
		else
		{
			if ( i < 38 )
			{
				wait 0.3;
			}
		}
		i++;
	}
	if ( isDefined( level.custom_magic_box_weapon_wait ) )
	{
		[[ level.custom_magic_box_weapon_wait ]]();
	}
	if ( isDefined( player.pers_upgrades_awarded[ "box_weapon" ] ) && player.pers_upgrades_awarded[ "box_weapon" ] )
	{
		rand = pers_treasure_chest_choosespecialweapon( player );
	}
	else
	{
        
		rand = custom_treasure_chest_chooseweightedrandomweapon( player );
	}
    if (rand == "zombie_perk_bottle_revive")
    {
        rand = "zombie_perk_bottle_revive";
    }
	self.weapon_string = rand;
	wait 0.1;
	if ( isDefined( level.custom_magicbox_float_height ) )
	{
		v_float = anglesToUp( self.angles ) * level.custom_magicbox_float_height;
	}
	else
	{
		v_float = anglesToUp( self.angles ) * 40;
	}
	self.model_dw = undefined;
	self.weapon_model = spawn_weapon_model( rand, undefined, self.origin + v_float, self.angles + vectorScale( ( 0, 1, 0 ), 180 ) );
	if ( weapon_is_dual_wield( rand ) )
	{
		self.weapon_model_dw = spawn_weapon_model( rand, get_left_hand_weapon_model_name( rand ), self.weapon_model.origin - vectorScale( ( 0, 1, 0 ), 3 ), self.weapon_model.angles );
	}
    if ( getDvar( "magic_chest_movable" ) == "1" && !( isdefined( chest._box_opened_by_fire_sale ) && chest._box_opened_by_fire_sale ) && !( isdefined( level.zombie_vars["zombie_powerup_fire_sale_on"] ) && level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() ) )
	{
    	random = randomint( 100 );
		if ( !isDefined( level.chest_min_move_usage ) )
		{
			level.chest_min_move_usage = 4;
		}
		if ( level.chest_accessed < level.chest_min_move_usage )
		{
			chance_of_joker = -1;
		}
		else chance_of_joker = level.chest_accessed + 20;
		if ( level.chest_moves == 0 && level.chest_accessed >= 8 )
		{
			chance_of_joker = 100;
		}
		if ( level.chest_accessed >= 4 && level.chest_accessed < 8 )
		{
			if ( random < 15 )
			{
				chance_of_joker = 100;
			}
			else
			{
				chance_of_joker = -1;
			}
		}
		if ( level.chest_moves > 0 )
		{
			if ( level.chest_accessed >= 8 && level.chest_accessed < 13 )
			{
				if ( random < 30 )
				{
					chance_of_joker = 100;
				}
				else
				{
					chance_of_joker = -1;
				}
			}
			if ( level.chest_accessed >= 13 )
			{
				if ( random < 50 )
				{
					chance_of_joker = 100;
				}
				else
				{
					chance_of_joker = -1;
				}
			}
		}
		if ( isDefined( chest.no_fly_away ) )
		{
			chance_of_joker = -1;
		}
		if ( isDefined( level._zombiemode_chest_joker_chance_override_func ) )
		{
			chance_of_joker = [[ level._zombiemode_chest_joker_chance_override_func ]]( chance_of_joker );
		}
		if ( chance_of_joker > random )
		{
			self.weapon_string = undefined;
			self.weapon_model setmodel( level.chest_joker_model );
			self.weapon_model.angles = self.angles + vectorScale( ( 0, 1, 0 ), 90 );
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
				self.weapon_model_dw = undefined;
			}
			self.chest_moving = 1;
			flag_set( "moving_chest_now" );
			level.chest_accessed = 0;
			level.chest_moves++;
		}
	}
	self notify( "randomization_done" );
	if ( flag( "moving_chest_now" ) && !( level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() ) )
	{
		if ( isDefined( level.chest_joker_custom_movement ) )
		{
			self [[ level.chest_joker_custom_movement ]]();
		}
		else
		{
			wait 0.5;
			level notify( "weapon_fly_away_start" );
			wait 2;
			if ( isDefined( self.weapon_model ) )
			{
				v_fly_away = self.origin + ( anglesToUp( self.angles ) * 500 );
				self.weapon_model moveto( v_fly_away, 4, 3 );
			}
			if ( isDefined( self.weapon_model_dw ) )
			{
				v_fly_away = self.origin + ( anglesToUp( self.angles ) * 500 );
				self.weapon_model_dw moveto( v_fly_away, 4, 3 );
			}
			self.weapon_model waittill( "movedone" );
			self.weapon_model delete();
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
				self.weapon_model_dw = undefined;
			}
			self notify( "box_moving" );
			level notify( "weapon_fly_away_end" );
		}
	}
	else
	{
		acquire_weapon_toggle( rand, player );
		if ( rand == "tesla_gun_zm" || rand == "ray_gun_zm" )
		{
			if ( rand == "ray_gun_zm" )
			{
				level.pulls_since_last_ray_gun = 0;
			}
			if ( rand == "tesla_gun_zm" )
			{
				level.pulls_since_last_tesla_gun = 0;
				level.player_seen_tesla_gun = 1;
			}
		}
		if ( !isDefined( respin ) )
		{
			if ( isDefined( chest.box_hacks[ "respin" ] ) )
			{
				self [[ chest.box_hacks[ "respin" ] ]]( chest, player );
			}
		}
		else
		{
			if ( isDefined( chest.box_hacks[ "respin_respin" ] ) )
			{
				self [[ chest.box_hacks[ "respin_respin" ] ]]( chest, player );
			}
		}
		if ( isDefined( level.custom_magic_box_timer_til_despawn ) )
		{
			self.weapon_model thread [[ level.custom_magic_box_timer_til_despawn ]]( self );
		}
		else
		{
			self.weapon_model thread timer_til_despawn( v_float );
		}
		if ( isDefined( self.weapon_model_dw ) )
		{
			if ( isDefined( level.custom_magic_box_timer_til_despawn ) )
			{
				self.weapon_model_dw thread [[ level.custom_magic_box_timer_til_despawn ]]( self );
			}
			else
			{
				self.weapon_model_dw thread timer_til_despawn( v_float );
			}
		}
		self waittill( "weapon_grabbed" );
		if ( !chest.timedout )
		{
			if ( isDefined( self.weapon_model ) )
			{
				self.weapon_model delete();
			}
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
			}
		}
	}
	self.weapon_string = undefined;
	self notify( "box_spin_done" );
}

treasure_chest_weapon_spawn_overridee( chest, player, respin ) //checked changed to match cerberus output
{
	if ( is_true( level.using_locked_magicbox ) )
	{
		self.owner endon( "box_locked" );
		self thread maps\mp\zombies\_zm_magicbox_lock::clean_up_locked_box();
	}
	self endon( "box_hacked_respin" );
	self thread clean_up_hacked_box();
	/*
/#
	assert( isDefined( player ) );
#/
	*/
	self.weapon_string = undefined;
	modelname = undefined;
	rand = undefined;
	number_cycles = 40;
	if ( isDefined( chest.zbarrier ) )
	{
		if ( isDefined( level.custom_magic_box_do_weapon_rise ) )
		{
			chest.zbarrier thread [[ level.custom_magic_box_do_weapon_rise ]]();
		}
		else
		{
			chest.zbarrier thread magic_box_do_weapon_rise();
		}
	}
	for ( i = 0; i < number_cycles; i++ )
	{

		if ( i < 20 )
		{
			wait 0.05 ; 
		}
		else if ( i < 30 )
		{
			wait 0.1 ; 
		}
		else if ( i < 35 )
		{
			wait 0.2 ; 
		}
		else if ( i < 38 )
		{
			wait 0.3 ; 
		}
	}

	// first box level vars
	if ( !isDefined(level.chest_max_move_usage) )
	{
		level.chest_max_move_usage = 8;
	}
	if ( !isDefined(level.weapons_needed) )
	{	
		level.weapons_needed = 2; // raygun + monkeys on most maps

		if ( level.players.size > 1 ) // if coop double weapons needed
		{
			level.weapons_needed += 2;
		}
		if ( level.default_start_location == "processing" || level.default_start_location == "tomb" ) // buried and origins add one for war machine and slowgun
		{
			level.weapons_needed += 1;
		}
		if ( level.default_start_location == "prison" && level.players.size > 1 ) // mob add one for 2p and two for 3/4p for extra gats
		{
			level.weapons_needed += level.players.size / 2;
		}
	}

	if ( isDefined( level.custom_magic_box_weapon_wait ) )
	{
		[[ level.custom_magic_box_weapon_wait ]]();
	}

	rand = treasure_chest_chooseweightedrandomweapon( player );

	// iPrintLn("weapon: " + rand);

	// first box
	if ( level.chest_moves == 0 )
	{
		ran = randomInt( (level.chest_max_move_usage - level.weapons_needed) - level.chest_accessed );
		if ( ran == 0 && level.chest_accessed <= level.chest_max_move_usage && level.weapons_needed > 0)
		{	
			pap_triggers = getentarray( "specialty_weapupgrade", "script_noteworthy" );

			if ( treasure_chest_canplayerreceiveweapon( player, "raygun_mark2_zm", pap_triggers ) )
			{
				rand = "raygun_mark2_zm";
			}
			else if ( treasure_chest_canplayerreceiveweapon( player, "ray_gun_zm", pap_triggers ) )
			{
				rand = "ray_gun_zm";
			}
			else if ( treasure_chest_canplayerreceiveweapon( player, "cymbal_monkey_zm", pap_triggers ) && getDvar("mapname") != "zm_prison")
			{
				rand = "cymbal_monkey_zm";
			}
			else if ( treasure_chest_canplayerreceiveweapon( player, "blundergat_zm", pap_triggers ) && getDvar("mapname") == "zm_prison")
			{
				rand = "blundergat_zm";
			}
			else if ( treasure_chest_canplayerreceiveweapon( player, "slowgun_zm", pap_triggers ) && getDvar( "mapname" ) == "zm_buried")
			{
				rand = "slowgun_zm";
			}
			else if ( treasure_chest_canplayerreceiveweapon( player, "emp_grenade_zm", pap_triggers ) && getDvar("mapname") == "zm_transit" && is_classic() )
			{
				rand = "emp_grenade_zm";
			}
			else if ( treasure_chest_canplayerreceiveweapon( player, "m32_zm", pap_triggers ) && getDvar("mapname") == "zm_tomb")
			{
				rand = "m32_zm";
			}

			if ( level.weapons_needed != 0 )
			{
				level.weapons_needed--;
			}
			// iprintln("ran modified: " + rand);
		}
	}

	// iprintln("weapons needed: " + level.weapons_needed);
	// iprintln("ran: " + ran);
	
	self.weapon_string = rand;
	wait 0.1;
	if ( isDefined( level.custom_magicbox_float_height ) )
	{
		v_float = anglesToUp( self.angles ) * level.custom_magicbox_float_height;
	}
	else
	{
		v_float = anglesToUp( self.angles ) * 40;
	}
	self.model_dw = undefined;
	self.weapon_model = spawn_weapon_model( rand, undefined, self.origin + v_float, self.angles + vectorScale( ( 0, 1, 0 ), 180 ) );
	if ( weapon_is_dual_wield( rand ) )
	{
		self.weapon_model_dw = spawn_weapon_model( rand, get_left_hand_weapon_model_name( rand ), self.weapon_model.origin - vectorScale( ( 0, 1, 0 ), 3 ), self.weapon_model.angles );
	}
	if ( getDvar( "magic_chest_movable" ) == "1" && !is_true( chest._box_opened_by_fire_sale ) && !is_true( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() )
	{
		random = randomint( 100 );
		if ( !isDefined(level.chest_max_move_usage) )
		{
			level.chest_max_move_usage = 8;
		}
		if ( !isDefined( level.chest_min_move_usage ) )
		{
			level.chest_min_move_usage = 4;
		}
		if ( level.chest_accessed < level.chest_min_move_usage )
		{
			chance_of_joker = -1;
		}
		else
		{
			chance_of_joker = level.chest_accessed + 20;
			if ( level.chest_moves == 0 && level.chest_accessed >= level.chest_max_move_usage )
			{
				chance_of_joker = 100;
			}
			if ( level.chest_accessed >= 4 && level.chest_accessed < 8 )
			{
				if ( random < 15 && !is_setup_weapon( rand ) ) // always get setup before the box moves
				{
					chance_of_joker = 100;
				}
				else
				{
					chance_of_joker = -1;
				}
			}
			if ( level.chest_moves > 0 )
			{
				if ( level.chest_accessed >= 8 && level.chest_accessed < 13 )
				{
					if ( random < 30 )
					{
						chance_of_joker = 100;
					}
					else
					{
						chance_of_joker = -1;
					}
				}
				if ( level.chest_accessed >= 13 )
				{
					if ( random < 50 )
					{
						chance_of_joker = 100;
					}
					else
					{
						chance_of_joker = -1;
					}
				}
			}
		}
		if ( isDefined( chest.no_fly_away ) )
		{
			chance_of_joker = -1;
		}
		if ( isDefined( level._zombiemode_chest_joker_chance_override_func ) )
		{
			chance_of_joker = [[ level._zombiemode_chest_joker_chance_override_func ]]( chance_of_joker );
		}
		if ( chance_of_joker > random )
		{
			self.weapon_string = undefined;
			self.weapon_model setmodel( level.chest_joker_model );
			self.weapon_model.angles = self.angles + vectorScale( ( 0, 1, 0 ), 90 );
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
				self.weapon_model_dw = undefined;
			}
			self.chest_moving = 1;
			flag_set( "moving_chest_now" );
			level.chest_accessed = 0;
			level.chest_moves++;
		}
	}
	self notify( "randomization_done" );
	if ( flag( "moving_chest_now" ) && !level.zombie_vars[ "zombie_powerup_fire_sale_on" ] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() )
	{
		if ( isDefined( level.chest_joker_custom_movement ) )
		{
			self [[ level.chest_joker_custom_movement ]]();
		}
		else
		{
			wait 0.5;
			level notify( "weapon_fly_away_start" );
			wait 2;
			if ( isDefined( self.weapon_model ) )
			{
				v_fly_away = self.origin + ( anglesToUp( self.angles ) * 500 );
				self.weapon_model moveto( v_fly_away, 4, 3 );
			}
			if ( isDefined( self.weapon_model_dw ) )
			{
				v_fly_away = self.origin + ( anglesToUp( self.angles ) * 500 );
				self.weapon_model_dw moveto( v_fly_away, 4, 3 );
			}
			self.weapon_model waittill( "movedone" );
			self.weapon_model delete();
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
				self.weapon_model_dw = undefined;
			}
			self notify( "box_moving" );
			level notify( "weapon_fly_away_end" );
		}
	}
	else
	{
		acquire_weapon_toggle( rand, player );
		if ( rand == "tesla_gun_zm" || rand == "ray_gun_zm" )
		{
			if ( rand == "ray_gun_zm" )
			{
				level.pulls_since_last_ray_gun = 0;
			}
			if ( rand == "tesla_gun_zm" )
			{
				level.pulls_since_last_tesla_gun = 0;
				level.player_seen_tesla_gun = 1;
			}
		}
		if ( !isDefined( respin ) )
		{
			if ( isDefined( chest.box_hacks[ "respin" ] ) )
			{
				self [[ chest.box_hacks[ "respin" ] ]]( chest, player );
			}
		}
		else
		{
			if ( isDefined( chest.box_hacks[ "respin_respin" ] ) )
			{
				self [[ chest.box_hacks[ "respin_respin" ] ]]( chest, player );
			}
		}
		if ( isDefined( level.custom_magic_box_timer_til_despawn ) )
		{
			self.weapon_model thread [[ level.custom_magic_box_timer_til_despawn ]]( self );
		}
		else
		{
			self.weapon_model thread timer_til_despawn( v_float );
		}
		if ( isDefined( self.weapon_model_dw ) )
		{
			if ( isDefined( level.custom_magic_box_timer_til_despawn ) )
			{
				self.weapon_model_dw thread [[ level.custom_magic_box_timer_til_despawn ]]( self );
			}
			else
			{
				self.weapon_model_dw thread timer_til_despawn( v_float );
			}
		}
		self waittill( "weapon_grabbed" );
		if ( !chest.timedout )
		{
			if ( isDefined( self.weapon_model ) )
			{
				self.weapon_model delete();
			}
			if ( isDefined( self.weapon_model_dw ) )
			{
				self.weapon_model_dw delete();
			}
		}
	}
	self.weapon_string = undefined;
	self notify( "box_spin_done" );
}


custom_treasure_chest_chooseweightedrandomweapon( player )
{
    level.box_perks = randomintrange(0,5);
	zombie_perks = [];
    if (level.box_perks == 0 && player.num_perks < level.perk_purchase_limit && level.perks_in_box_enabled)
    {  
		if (!player hasperk("specialty_rof"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_doubletap";
		}
		if (!player hasperk("specialty_armorvest"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_jugg";
		}
		if (!player hasperk("specialty_fastreload"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_sleight";
		}
        if (getdvar("mapname") == "zm_transit")
        {
			if (!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if (!player hasperk("specialty_longersprint"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
            if (get_players().size > 1 && !player hasperk("specialty_scavenger") )
            {
		        zombie_perks[zombie_perks.size] = "zombie_perk_bottle_tombstone";
            }
        }
        if (getdvar("mapname") == "zm_prison")
        {
			if (!player hasperk("specialty_deadshot"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_deadshot";
			}
			if (!player hasperk("specialty_grenadepulldeath"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_cherry";
			}  
        }
        if (getdvar("mapname") == "zm_nuked")
        {
			if (!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
        }
        if (getdvar("mapname") == "zm_tomb")
        {
			if (!player hasperk("specialty_deadshot"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_deadshot";
			}
			if (!player hasperk("specialty_grenadepulldeath"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_cherry";
			}
			if (!player hasperk("specialty_flakjacket"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_nuke";
			}
			if (!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if (!player hasperk("specialty_longersprint"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
			if (!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
		}
        if (getdvar("mapname") == "zm_buried")
        {
			if (!player hasperk("specialty_nomotionsensor"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_vulture";
			}
			if (!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if (!player hasperk("specialty_deadshot"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
			if (!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
		}
        if (getdvar("mapname") == "zm_highrise")
        {
			if (!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if (!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
			if (!player hasperk("specialty_finalstand"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_whoswho";
			}
		}
    }
	if (zombie_perks.size > 0)
	{
		keys = array_randomize( zombie_perks );
	}
    else
    {
    	keys = array_randomize( getarraykeys( level.zombie_weapons ) );
    }
	if ( isDefined( level.customrandomweaponweights ) )
	{
		keys = player [[ level.customrandomweaponweights ]]( keys );
	}
	pap_triggers = getentarray( "specialty_weapupgrade", "script_noteworthy" );
	i = 0;
	while ( i < keys.size )
	{
        if ( zombie_perks.size > 0 )
        {
            if ( treasure_chest_canplayerreceiveperk( player, keys[ i ] ) )
            {
                return keys[ i ];
            }
        }
        else
        {
            if ( treasure_chest_canplayerreceiveweapon( player, keys[ i ], pap_triggers ) )
            {
                return keys[ i ];
            }
        }
		i++;
	}
	return keys[ 0 ];
}


treasure_chest_canplayerreceiveperk( player, weapon )
{
    
    if (weapon == "zombie_perk_bottle_sleight")
    {
        if (player hasperk("specialty_fastreload"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_revive")
    {
        if (player hasperk("specialty_quickrevive"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_doubletap")
    {
        if (player hasperk("specialty_rof"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_jugg")
    {
        if (player hasperk("specialty_armorvest"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_marathon")
    {
        if (player hasperk("specialty_longersprint"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_tombstone")
    {
        if (player hasperk("specialty_scavenger"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_deadshot")
    {
        if (player hasperk("specialty_deadshot"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_cherry")
    {
        if (player hasperk("specialty_grenadepulldeath"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_nuke")
    {
        if (player hasperk("specialty_flakjacket"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_additionalprimaryweapon")
    {
        if (player hasperk("specialty_additionalprimaryweapon"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_vulture")
    {
        if (player hasperk("specialty_nomotionsensor"))
        {
            return 0;
        }
    }
    if (weapon == "zombie_perk_bottle_whoswho")
    {
        if (player hasperk("specialty_finalstand"))
        {
            return 0;
        }
    }
    level.perk_pick = 1;
    return 1;
}

add_perk(perk)
{
    self endon("disconnect");
    self endon("death");
    level endon("game_ended");
    self endon("perk_abort_drinking");
    if (!(self hasperk(perk) || (self maps\mp\zombies\_zm_perks::has_perk_paused(perk))))
    {
        gun = self maps\mp\zombies\_zm_perks::perk_give_bottle_begin(perk);
        evt = self waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete");
        if (evt == "weapon_change_complete")
            self thread maps\mp\zombies\_zm_perks::wait_give_perk(perk, 1);
        self maps\mp\zombies\_zm_perks::perk_give_bottle_end(gun, perk);
        if (self maps\mp\zombies\_zm_laststand::player_is_in_laststand() || isDefined(self.intermission) && self.intermission)
            return;
        self notify("burp");
    }
}

afterlife()
{
	if ( level.script == "zm_prison" )
{
		self thread changeHandModel();
		level.is_forever_solo_game = true;
	}
}

changeHandModel()
{

		self setViewModel("c_zom_ghost_viewhands");
		wait 8;
		self setViewModel("c_zom_ghost_viewhands");
}


afterlife_weapon_limit_check( limited_weapon )
{
	while ( isDefined( self.afterlife ) && self.afterlife )
	{
		if ( limited_weapon == "blundergat_zm" )
		{
			_a1577 = self.loadout;
			_k1577 = getFirstArrayKey( _a1577 );
			while ( isDefined( _k1577 ) )
			{
				weapon = _a1577[ _k1577 ];
				if ( weapon != "blundergat_zm" && weapon != "blundergat_upgraded_zm" || weapon == "blundersplat_zm" && weapon == "blundersplat_upgraded_zm" )
				{
					return 1;
				}
				_k1577 = getNextArrayKey( _a1577, _k1577 );
			}
		}
		else while ( limited_weapon == "minigun_alcatraz_zm" )
		{
			_a1587 = self.loadout;
			_k1587 = getFirstArrayKey( _a1587 );
			while ( isDefined( _k1587 ) )
			{
				weapon = _a1587[ _k1587 ];
				if ( weapon == "minigun_alcatraz_zm" || weapon == "minigun_alcatraz_upgraded_zm" )
				{
					return 1;
				}
				_k1587 = getNextArrayKey( _a1587, _k1587 );
			}
		}
	}
	return 0;
}

treasure_chest_move_override( player_vox )
{
	level waittill( "weapon_fly_away_start" );
	players = get_players();
	array_thread( players, maps\mp\zombies\_zm_magicbox::play_crazi_sound );
	if ( isDefined( player_vox ) )
	{
		player_vox delay_thread( randomintrange( 2, 7 ), maps\mp\zombies\_zm_audio::create_and_play_dialog, "general", "box_move" );
	}
	level waittill( "weapon_fly_away_end" );
	if ( isDefined( self.zbarrier ) )
	{
		self maps\mp\zombies\_zm_magicbox::hide_chest( 1 );
	}
	wait 0.1;
	if ( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] == 1 && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() )
	{
		current_sale_time = level.zombie_vars[ "zombie_powerup_fire_sale_time" ];
		wait_network_frame();
		self thread maps\mp\zombies\_zm_magicbox::fire_sale_fix();
		level.zombie_vars[ "zombie_powerup_fire_sale_time" ] = current_sale_time;
		while ( level.zombie_vars[ "zombie_powerup_fire_sale_time" ] > 0 )
		{
			wait 0.1;
		}
	}
	level.verify_chest = 0;
	if ( isDefined( level._zombiemode_custom_box_move_logic ) )
	{
		[[ level._zombiemode_custom_box_move_logic ]]();
	}
	else
	{
		maps\mp\zombies\_zm_magicbox::default_box_move_logic();
	}
	if ( isDefined( level.chests[ level.chest_index ].box_hacks[ "summon_box" ] ) )
	{
		level.chests[ level.chest_index ] [[ level.chests[ level.chest_index ].box_hacks[ "summon_box" ] ]]( 0 );
	}
	playfx( level._effect[ "poltergeist" ], level.chests[ level.chest_index ].zbarrier.origin );
	level.chests[ level.chest_index ] maps\mp\zombies\_zm_magicbox::show_chest();
	flag_clear( "moving_chest_now" );
	self.zbarrier.chest_moving = 0;
}

drop_weapons()
{
	level endon( "end_game" );
	self endon( "disconnect" );

	while(1)
	{

		zone = self get_current_zone();
		zone_name = get_zone_display_name(zone);

		random_color = randomintrange( 2, 3 );
		colors = "^" + random_color;

		random_color_a = randomintrange( 5, 9 );
		colors_a = "^" + random_color_a;

		wait 0.05;

		if (self isSwitchingWeapons())
		{
			continue;
		}

		curr_weps = self getCurrentWeapon();

		is_primary = 0;
		foreach(wep in self getWeaponsListPrimaries())
		{
			if (wep == curr_weps)
			{
				is_primary = 1;
				break;
			}
		}

		if (!is_primary)
		{
			continue;
		}

		if (self actionSlotFourButtonPressed() && self GetStance() == "crouch" && self getWeaponAmmoClip(curr_weps) != 0)
		{
			
			// war machine not on motd ?? lol
			
			self dropItem(curr_weps);

			iprintln("^7[" + self.clantag + "^7] " + fixedNames() + " dropped a " + colors_a + curr_weps + " ^7(" + colors + zone_name + "^7)");
			
		}
	}
}


locationfinder()
{


		zone = self get_current_zone();
		zone_name = get_zone_display_name(zone);

		random_color = randomintrange( 2, 3 );
		colors = "^" + random_color;
		iprintln("^7[" + self.clantag + "^7] " + self.clantag_color + fixedNames() + "^7 is around " + colors + zone_name + " ^7right now");
        wait 7; 
        
    } 



createrectangle( align, relative, x, y, width, height, color, shader, sort, alpha, server )
{
    if ( IsDefined( server ) )
    {
        boxelem = newhudelem();
    }
    else
    {
        boxelem = newclienthudelem( self );
    }
    boxelem.elemtype = "icon";
    boxelem.color = color;
    if ( !(level.splitscreen) )
    {
        boxelem.x = -2;
        boxelem.y = -2;
    }
    boxelem.hidewheninmenu = 1;
    boxelem.archived = 0;
    boxelem.width = width;
    boxelem.height = height;
    boxelem.align = align;
    boxelem.relative = relative;
    boxelem.xoffset = 0;
    boxelem.yoffset = 0;
    boxelem.children = [];
    boxelem.sort = sort;
    boxelem.alpha = alpha;
    boxelem.shader = shader;
    boxelem setparent( level.uiparent );
    boxelem setshader( shader, width, height );
    boxelem.hidden = 0;
    boxelem setpoint( align, relative, x, y );
    self thread destroyOnDeath(boxElem);
    return boxelem;

}

destroyOnDeath(elem)
{
    self waittill_any("death", "disconnect");
    if (isDefined(elem.bar))
        elem destroyElem();
    else
        elem destroy();
    if (isDefined(elem.model))
        elem delete();
}


/*
weapon_watcher()
{
	self endon("disconnect");
	self.dropped = true;

	while (1)
	{
		if (isDefined(self.dropped))
		{
			primaries = self.savedweapon;
			if (self IsDroppingWeapon(primaries))
			{
				weapon = primaries[primaries.size - 1];
				self.a_saved_weapon = maps\mp\zombies\_zm_weapons::get_player_weapondata(self, weapon);
			}
			else
			{
				self.a_saved_weapon = undefined;
			}
		}

		wait 0.05;
	}
}
*/

welcome_message()
{
    //font, fontscale, align, relative, x, y, sort, alpha, text, color, watchtext, islevel
    playname = self.name;
	playtag = self.clantag;

	playernames = "^7[" + playtag + "^7] " + playname;
	startingpoints = self.landingpoints;
	playing_version = "playing version: " + level.version;


    self freezecontrols( 1 );
	self enableInvulnerability();
    self endon( "DoneWelcome" );
    self.emenu["HUDS"]["Welcome_Background"] = self createrectangle( "TOP", "CENTER", 0, -139.5, 270, 92, ( 0, 0, 0 ), "white", 1, 0 );
    self.emenu[ "HUDS"][ "Welcome_Background"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_TopBar"] = self createrectangle( "CENTER", "CENTER", 0, -139.5, 272, 1, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_TopBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_BottomBar"] = self createrectangle( "CENTER", "CENTER", 0, -47, 272, 1, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_BottomBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_LeftBar"] = self createrectangle( "TOP", "CENTER", 135, -139.5, 1, 92, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_LeftBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_RightBar"] = self createrectangle( "TOP", "CENTER", -135, -139.5, 1, 92, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_RightBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_Menuname"] = self createothertext( "default", 1, "CENTER", "CENTER", 0, -129, 11, 0, "zombium^7 by girly", ( 1, 1, 1 ) );
    self.emenu[ "HUDS"][ "Welcome_Menuname"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_Creator"] = self createothertext( "small", 1, "LEFT", "CENTER", -130, -113, 11, 0, "\n  welcome back, ^6" + ( playernames + " \n  ^7playing version ^51.7" ) + ( " \n  ^7landed with: ^5" + startingpoints + " ^7points ^7[" + self.myhealth + "^5 hp^7]" ) + ( " \n  map id: ^5" + mapToName() ), ( 1, 1, 1 ) );
    self.emenu[ "HUDS"][ "Welcome_Creator"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_MiddleBar"] = self createrectangle( "CENTER", "CENTER", 0, -119, 250, 1, self.mapcolor, "white", 2, 0 );
    self.emenu[ "HUDS"][ "Welcome_MiddleBar"] thread hudfade( 0.6, 0.3 );
    self.emenu["HUDS"]["Welcome_Close"] = self createothertext( "small", 1, "LEFT", "CENTER", 90, -57, 11, 0, "close ^3[{+gostand}]", self.mapcolor );
    self.emenu[ "HUDS"][ "Welcome_Close"] thread hudfade( 0.6, 0.3 );
    while( 1 )
    {
        if ( self jumpbuttonpressed() )
        {
            self thread destroy1();
            self thread destroy2();
            self thread destroy3();
            self thread destroy4();
            self thread destroy5();
            self thread destroy6();
            self thread destroy8();
            self thread destroy7();
            self.emenu[ "HUDS"][ "Welcome_RightBar"] hudfade( 0, 0.35 );
            self.emenu[ "HUDS"][ "Welcome_Close"] destroy();
            self.emenu[ "HUDS"][ "Welcome_MiddleBar"] destroy();
            self.emenu[ "HUDS"][ "Welcome_Creator"] destroy();
            self.emenu[ "HUDS"][ "Welcome_Menuname"] destroy();
            self.emenu[ "HUDS"][ "Welcome_Background"] destroy();
            self.emenu[ "HUDS"][ "Welcome_TopBar"] destroy();
            self.emenu[ "HUDS"][ "Welcome_BottomBar"] destroy();
            self.emenu[ "HUDS"][ "Welcome_LeftBar"] destroy();
            self.emenu[ "HUDS"][ "Welcome_RightBar"] destroy();

			flag_wait( "initial_blackscreen_passed" );
            self freezecontrols( 0 );
			self disableInvulnerability();
			
            self notify( "DoneWelcome" );
        }
        wait 0.05;
    }

}

destroy8()
{
    self.emenu[ "HUDS"][ "Welcome_LeftBar"] hudfade( 0, 0.35 );

}

destroy7()
{
    self.emenu[ "HUDS"][ "Welcome_BottomBar"] hudfade( 0, 0.35 );

}

destroy6()
{
    self.emenu[ "HUDS"][ "Welcome_TopBar"] hudfade( 0, 0.35 );

}

destroy5()
{
    self.emenu[ "HUDS"][ "Welcome_Background"] hudfade( 0, 0.35 );

}

destroy4()
{
    self.emenu[ "HUDS"][ "Welcome_Menuname"] hudfade( 0, 0.35 );

}

destroy3()
{
    self.emenu[ "HUDS"][ "Welcome_Creator"] hudfade( 0, 0.35 );

}

destroy2()
{
    self.emenu[ "HUDS"][ "Welcome_MiddleBar"] hudfade( 0, 0.35 );

}

destroy1()
{
    self.emenu[ "HUDS"][ "Welcome_Close"] hudfade( 0, 0.35 );

}

hudfade( alpha, time )
{
    self fadeovertime( time );
    self.alpha = alpha;
    wait time;

}

createothertext( font, fontscale, align, relative, x, y, sort, alpha, text, color, watchtext, islevel )
{
    if ( IsDefined( islevel ) )
    {
        textelem = level createserverfontstring( font, fontscale );
    }
    else
    {
        textelem = self createfontstring( font, fontscale );
    }
    textelem setpoint( align, relative, x, y );
    textelem.hidewheninmenu = 1;
    textelem.archived = 0;
    textelem.sort = sort;
    textelem.alpha = alpha;
    textelem.color = color;
    self addtostringarray( text );
    if ( IsDefined( watchtext ) )
    {
        textelem thread watchforoverflow( text );
    }
    else
    {
        textelem settext( text );
    }
    return textelem;

}


additionalprimaryweapon_save_weapons()
{
	self endon("disconnect");

	while (1)
	{
		if (!self hasPerk("specialty_additionalprimaryweapon"))
		{
			self waittill("perk_acquired");
			wait 0.05;
		}

		if (self hasPerk("specialty_additionalprimaryweapon"))
		{
			primaries = self getweaponslistprimaries();
			if (primaries.size >= 3)
			{
				weapon = primaries[primaries.size - 1];
				self.a_saved_weapon = maps\mp\zombies\_zm_weapons::get_player_weapondata(self, weapon);
			}
			else
			{
				self.a_saved_weapon = undefined;
			}
		}

		wait 0.05;
	}
}

additionalprimaryweapon_restore_weapons()
{
	self endon("disconnect");

	while (1)
	{
		self waittill("perk_acquired");

		if (isDefined(self.a_saved_weapon) && self hasPerk("specialty_additionalprimaryweapon"))
		{
			pap_triggers = getentarray( "specialty_weapupgrade", "script_noteworthy" );

			give_wep = 1;
			if ( isDefined( self ) && self maps\mp\zombies\_zm_weapons::has_weapon_or_upgrade( self.a_saved_weapon["name"] ) )
			{
				give_wep = 0;
			}
			else if ( !maps\mp\zombies\_zm_weapons::limited_weapon_below_quota( self.a_saved_weapon["name"], self, pap_triggers ) )
			{
				give_wep = 0;
			}
			else if ( !self maps\mp\zombies\_zm_weapons::player_can_use_content( self.a_saved_weapon["name"] ) )
			{
				give_wep = 0;
			}
			else if ( isDefined( level.custom_magic_box_selection_logic ) )
			{
				if ( !( [[ level.custom_magic_box_selection_logic ]]( self.a_saved_weapon["name"], self, pap_triggers ) ) )
				{
					give_wep = 0;
				}
			}
			else if ( isDefined( self ) && isDefined( level.special_weapon_magicbox_check ) )
			{
				give_wep = self [[ level.special_weapon_magicbox_check ]]( self.a_saved_weapon["name"] );
			}

			if (give_wep)
			{
				current_wep = self getCurrentWeapon();
				self maps\mp\zombies\_zm_weapons::weapondata_give(self.a_saved_weapon);
				self switchToWeapon(current_wep);
			}

			self.a_saved_weapon = undefined;
		}
	}
}

additionalprimaryweapon_indicator()
{
	self endon("disconnect");

	if (!is_true(level.zombiemode_using_additionalprimaryweapon_perk))
	{
		return;
	}

	additionalprimaryweapon_indicator_hud = newClientHudElem(self);
	additionalprimaryweapon_indicator_hud.alignx = "right";
	additionalprimaryweapon_indicator_hud.aligny = "bottom";
	additionalprimaryweapon_indicator_hud.horzalign = "user_right";
	additionalprimaryweapon_indicator_hud.vertalign = "user_bottom";
	if (level.script == "zm_highrise")
	{
		additionalprimaryweapon_indicator_hud.x -= 100;
		additionalprimaryweapon_indicator_hud.y -= 80;
	}
	else if (level.script == "zm_tomb")
	{
		additionalprimaryweapon_indicator_hud.x -= 75;
		additionalprimaryweapon_indicator_hud.y -= 60;
	}
	else
	{
		additionalprimaryweapon_indicator_hud.x -= 75;
		additionalprimaryweapon_indicator_hud.y -= 80;
	}
	additionalprimaryweapon_indicator_hud.alpha = 0;
	additionalprimaryweapon_indicator_hud.color = ( 0.847, 0.553, 0.741 );
	additionalprimaryweapon_indicator_hud.hidewheninmenu = 1;
	additionalprimaryweapon_indicator_hud setShader("specialty_additionalprimaryweapon_zombies", 24, 24);

	while (1)
	{
		self waittill_any("weapon_change", "specialty_additionalprimaryweapon_stop", "spawned_player");

		if (self hasPerk("specialty_additionalprimaryweapon") && isDefined(self.a_saved_weapon) && self getCurrentWeapon() == self.a_saved_weapon["name"])
		{
			additionalprimaryweapon_indicator_hud fadeOverTime(0.5);
			additionalprimaryweapon_indicator_hud.alpha = 1;
		}
		else
		{
			additionalprimaryweapon_indicator_hud fadeOverTime(0.5);
			additionalprimaryweapon_indicator_hud.alpha = 0;
		}
	}
}


refill_after_time(primary)
{
	self endon(primary + "_reload_stop");
	self endon("specialty_additionalprimaryweapon_stop");
	self endon("spawned_player");

	reload_time = weaponReloadTime(primary);
	reload_amount = undefined;

	if (primary == "m32_zm" || primary == "python_zm" || maps\mp\zombies\_zm_weapons::get_base_weapon_name(primary, 1) == "judge_zm" || maps\mp\zombies\_zm_weapons::get_base_weapon_name(primary, 1) == "870mcs_zm" || maps\mp\zombies\_zm_weapons::get_base_weapon_name(primary, 1) == "ksg_zm")
	{
		reload_amount = 1;

		if (maps\mp\zombies\_zm_weapons::get_base_weapon_name(primary, 1) == "ksg_zm" && maps\mp\zombies\_zm_weapons::is_weapon_upgraded(primary))
		{
			reload_amount = 2;
		}
	}

	if (!isDefined(reload_amount) && reload_time < 1)
	{
		reload_time = 1;
	}

	if (self hasPerk("specialty_fastreload"))
	{
		reload_time *= getDvarFloat("perk_weapReloadMultiplier");
	}

	wait reload_time;

	ammo_clip = self getWeaponAmmoClip(primary);
	ammo_stock = self getWeaponAmmoStock(primary);
	missing_clip = weaponClipSize(primary) - ammo_clip;

	if (missing_clip > ammo_stock)
	{
		missing_clip = ammo_stock;
	}

	if (isDefined(reload_amount) && missing_clip > reload_amount)
	{
		missing_clip = reload_amount;
	}

	self setWeaponAmmoClip(primary, ammo_clip + missing_clip);
	self setWeaponAmmoStock(primary, ammo_stock - missing_clip);

	dw_primary = weaponDualWieldWeaponName(primary);
	if (dw_primary != "none")
	{
		ammo_clip = self getWeaponAmmoClip(dw_primary);
		ammo_stock = self getWeaponAmmoStock(dw_primary);
		missing_clip = weaponClipSize(dw_primary) - ammo_clip;

		if (missing_clip > ammo_stock)
		{
			missing_clip = ammo_stock;
		}

		self setWeaponAmmoClip(dw_primary, ammo_clip + missing_clip);
		self setWeaponAmmoStock(dw_primary, ammo_stock - missing_clip);
	}

	alt_primary = weaponAltWeaponName(primary);
	if (alt_primary != "none")
	{
		ammo_clip = self getWeaponAmmoClip(alt_primary);
		ammo_stock = self getWeaponAmmoStock(alt_primary);
		missing_clip = weaponClipSize(alt_primary) - ammo_clip;

		if (missing_clip > ammo_stock)
		{
			missing_clip = ammo_stock;
		}

		self setWeaponAmmoClip(alt_primary, ammo_clip + missing_clip);
		self setWeaponAmmoStock(alt_primary, ammo_stock - missing_clip);
	}

	if (isDefined(reload_amount) && self getWeaponAmmoStock(primary) > 0 && self getWeaponAmmoClip(primary) < weaponClipSize(primary))
	{
		self refill_after_time(primary);
	}
}

turn_on_powerr() //by xepixtvx
{	

	flag_wait( "initial_blackscreen_passed" );
	wait 5;
	trig = getEnt( "use_elec_switch", "targetname" );
	powerSwitch = getEnt( "elec_switch", "targetname" );
	powerSwitch notSolid();
	trig setHintString( &"ZOMBIE_ELECTRIC_SWITCH" );
	trig setVisibleToAll();
	trig notify( "trigger", self );
	trig setInvisibleToAll();
	powerSwitch rotateRoll( -90, 0, 3 );
	level thread maps\mp\zombies\_zm_perks::perk_unpause_all_perks();
	powerSwitch waittill( "rotatedone" );
	flag_set( "power_on" );
	level setClientField( "zombie_power_on", 1 ); 
}


toggle_night()
{
	if (!isDefined(self.nightmodes))
	{
		self.nightmodes = true;
		self thread enable_night_mode();

	} else if (isDefined(self.nightmodes))
	{

		self.nightmodes = undefined;
		self thread disable_night_mode();

	}
}

night_mode()
{
	for( ;; )
	{
		level waittill( "connected", player );
		player setclientdvar( "r_dof_enable", 0 );
		player setclientdvar( "r_lodBiasRigid", -1000 );
		player setclientdvar( "r_lodBiasSkinned", -1000 );
		player setclientdvar( "r_enablePlayerShadow", 1 );
		player setclientdvar( "r_skyTransition", 1 );
		player setclientdvar( "sm_sunquality", 2 );
		player setclientdvar( "vc_fbm", "0 0 0 0" );
		player setclientdvar( "vc_fsm", "1 1 1 1" );
		player thread visual_fix();
		player thread enable_night_mode();
	}
}



weapon_locker_give_ammo_after_rounds()
{
	self endon("disconnect");

	while(1)
	{
		level waittill("end_of_round");

		if (isDefined(self.stored_weapon_data))
		{
			if (self.stored_weapon_data["name"] != "none")
			{
				self.stored_weapon_data["clip"] = weaponClipSize(self.stored_weapon_data["name"]);
				self.stored_weapon_data["stock"] = weaponMaxAmmo(self.stored_weapon_data["name"]);
			}

			if (self.stored_weapon_data["dw_name"] != "none")
			{
				self.stored_weapon_data["lh_clip"] = weaponClipSize(self.stored_weapon_data["dw_name"]);
			}

			if (self.stored_weapon_data["alt_name"] != "none")
			{
				self.stored_weapon_data["alt_clip"] = weaponClipSize(self.stored_weapon_data["alt_name"]);
				self.stored_weapon_data["alt_stock"] = weaponMaxAmmo(self.stored_weapon_data["alt_name"]);
			}
		}
	}
}


additionalprimaryweapon_stowed_weapon_refill()
{
	self endon("disconnect");

	while (1)
	{
		string = self waittill_any_return("weapon_change", "weapon_change_complete", "specialty_additionalprimaryweapon_stop", "spawned_player");

		if (self hasPerk("specialty_additionalprimaryweapon"))
		{
			curr_wep = self getCurrentWeapon();
			if (curr_wep == "none")
			{
				continue;
			}

			primaries = self getWeaponsListPrimaries();
			foreach(primary in primaries)
			{
				if (primary != maps\mp\zombies\_zm_weapons::get_nonalternate_weapon(curr_wep))
				{
					if (string != "weapon_change")
					{
						self thread refill_after_time(primary);
					}
				}
				else
				{
					self notify(primary + "_reload_stop");
				}
			}
		}
	}
}


addtostringarray( text )
{
    if ( !(isinarray( level.strings, text )) )
    {
        level.strings[level.strings.size] = text;
        level notify( "CHECK_OVERFLOW" );
    }

}

watchforoverflow( text )
{
    self endon( "stop_TextMonitor" );
    while( IsDefined( self ) )
    {
        if ( IsDefined( text.size ) )
        {
            self settext( text );
        }
        else
        {
            self settext( undefined );
            self.label = text;
        }
        level waittill( "FIX_OVERFLOW" );
    }

}

weapon_inspect_watcher()
{
	level endon( "end_game" );
	self endon( "disconnect" );

	while(1)
	{
		wait 0.05;

		if (self isSwitchingWeapons())
		{
			continue;
		}

		curr_wep = self getCurrentWeapon();

		is_primary = 0;
		foreach(wep in self getWeaponsListPrimaries())
		{
			if (wep == curr_wep)
			{
				is_primary = 1;
				break;
			}
		}

		if (!is_primary)
		{
			continue;
		}

		if (self actionSlotThreeButtonPressed() && self getWeaponAmmoClip(curr_wep) != 0)
		{
			self initialWeaponRaise(curr_wep);
		}
	}
}

phd_diving() //credit to extinct. just edited to add self.hasPHD variable
{
	self endon("disconnect");
	level endon("end_game");
	level endon("game_ended");
	
	for(;;)
	{
		if (isDefined(self.divetoprone) && self.divetoprone)
		{
			if (self isOnGround() && isDefined(self.hasPHD))
			{
				if (level.script == "zm_tomb" || level.script == "zm_buried")	
					explosionfx = level._effect["divetonuke_groundhit"];
				else
					explosionfx = loadfx("explosions/fx_default_explosion");
				self playSound("zmb_phdflop_explo");
				playfx(explosionfx, self.origin);
				self damageZombiesInRange(310, self, "kill");
				wait 5;
			}
		}
		wait .05;
	}
}

damageZombiesInRange(range, what, amount) //damage zombies for phd flopper
{
	enemy = getAiArray(level.zombie_team);
	foreach(zombie in enemy)
	{
		if (distance(zombie.origin, what.origin) < range)
		{
			if (amount == "kill")
				zombie doDamage(zombie.health * 2, zombie.origin, self);
			else
				zombie doDamage(amount, zombie.origin, self);
		}
	}
}

phd_flopper_dmg_check( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, boneindex ) //phdflopdmgchecker lmao
{
	if ( smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" )
	{
		if (isDefined(self.hasPHD)) //if player has phd flopper, dont damage the player
			return;
	}
	[[ level.playerDamageStub ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, boneindex );
}




ai_calculate_health( round_number )
{
	level.zombie_health = level.zombie_vars[ "zombie_health_start" ];
	i = 2;
	while ( i <= round_number )
	{
		if ( i >= 10 )
		{
			level.zombie_health += int( level.zombie_health * level.zombie_vars[ "zombie_health_increase_multiplier" ] );
			i++;
			continue;
		}
		level.zombie_health = int( level.zombie_health + level.zombie_vars[ "zombie_health_increase" ] );
		i++;
	}
	if ( level.zombie_health < 0 )
	{
		level.zombie_health = level.zombie_vars[ "zombie_health_start" ];
	}
	if (level.zombie_health > ai_zombie_health(155))
	{
		level.zombie_health = ai_zombie_health(155);
	}
}

use_solo_revive()
{
	return 0;
}

should_attack_player_thru_boards()
{
	return 0;
}

init_zombie_run_cycle()
{
	self set_zombie_run_cycle();
}

round_think( restart )
{
	if ( !isDefined( restart ) )
	{
		restart = 0;
	}
	level endon( "end_round_think" );
	if ( !is_true( restart ) )
	{
		if ( isDefined( level.initial_round_wait_func ) )
		{
			[[ level.initial_round_wait_func ]]();
		}
		players = get_players();
		foreach ( player in players )
		{
			if ( is_true( player.hostmigrationcontrolsfrozen ) ) 
			{
				player freezecontrols( 0 );
			}
			player maps\mp\zombies\_zm_stats::set_global_stat( "rounds", level.round_number );
		}
	}
	for ( ;; )
	{
		maxreward = 50 * level.round_number;
		if ( maxreward > 500 )
		{
			maxreward = 500;
		}
		level.zombie_vars[ "rebuild_barrier_cap_per_round" ] = maxreward;
		level.pro_tips_start_time = getTime();
		level.zombie_last_run_time = getTime();
		if ( isDefined( level.zombie_round_change_custom ) )
		{
			[[ level.zombie_round_change_custom ]]();
		}
		else
		{
			level thread maps\mp\zombies\_zm_audio::change_zombie_music( "round_start" );
			round_one_up();
		}
		maps\mp\zombies\_zm_powerups::powerup_round_start();
		players = get_players();
		array_thread( players, ::rebuild_barrier_reward_reset );
		if ( !is_true( level.headshots_only ) && !restart )
		{
			level thread award_grenades_for_survivors();
		}
		level.round_start_time = getTime();
		while ( level.zombie_spawn_locations.size <= 0 )
		{
			wait 0.1;
		}
		level thread [[ level.round_spawn_func ]]();
		level notify( "start_of_round" );
		recordzombieroundstart();
		players = getplayers();
		for ( index = 0; index < players.size; index++  )
		{
			zonename = players[ index ] get_current_zone();
			if ( isDefined( zonename ) )
			{
				players[ index ] recordzombiezone( "startingZone", zonename );
			}
		}
		if ( isDefined( level.round_start_custom_func ) )
		{
			[[ level.round_start_custom_func ]]();
		}
		[[ level.round_wait_func ]]();
		level.first_round = 0;
		level notify( "end_of_round" );
		level thread maps\mp\zombies\_zm_audio::change_zombie_music( "round_end" );
		uploadstats();
		if ( isDefined( level.round_end_custom_logic ) )
		{
			[[ level.round_end_custom_logic ]]();
		}
		players = get_players();
		if ( is_true( level.no_end_game_check ) )
		{
			level thread last_stand_revive();
			level thread spectators_respawn();
		}
		else if ( players.size != 1 )
		{
			level thread spectators_respawn();
		}
		players = get_players();
		array_thread( players, ::round_end );
		timer = level.zombie_vars[ "zombie_spawn_delay" ];
		if ( timer > 0.08 )
		{
			level.zombie_vars[ "zombie_spawn_delay" ] = timer * 0.95;
		}
		else if ( timer < 0.08 )
		{
			level.zombie_vars[ "zombie_spawn_delay" ] = 0.08;
		}
		if ( level.gamedifficulty == 0 )
		{
			level.zombie_move_speed = level.round_number * level.zombie_vars[ "zombie_move_speed_multiplier_easy" ];
		}
		else
		{
			level.zombie_move_speed = level.round_number * level.zombie_vars[ "zombie_move_speed_multiplier" ];
		}
		level.round_number++;
		matchutctime = getutc();
		players = get_players();
		foreach ( player in players )
		{
			if ( level.curr_gametype_affects_rank && level.round_number > 3 + level.start_round )
			{
				player maps\mp\zombies\_zm_stats::add_client_stat( "weighted_rounds_played", level.round_number );
			}
			player maps\mp\zombies\_zm_stats::set_global_stat( "rounds", level.round_number );
			player maps\mp\zombies\_zm_stats::update_playing_utc_time( matchutctime );
		}
		check_quickrevive_for_hotjoin();
		level round_over();
		level notify( "between_round_over" );
		restart = 0;
	}
}

reset_bank_locker()
{
	flag_wait("initial_blackscreen_passed");
	self.account_value = 0;
	self setdstat( "PlayerStatsByMap", "zm_transit", "weaponLocker", "name", "" );
}


fake_reset()
{
    level endon("disconnect");
	level endon("end_game");

    level.win_game = false;
	level.total_time = 0;
	level.paused_time = 0;

	flag_wait( "initial_blackscreen_passed" );

	start_time = int(getTime() / 1000);

    while(1)
    {
        current_time = int(getTime() / 1000);
		level.total_time = (current_time - level.paused_time) - start_time;
		
        if (level.total_time >= 43200) // 12h reset
        {
			map_restart( false );
			//exitlevel( 0 );
			players = Get_Players();	
			for(i=0;i<players.size;i++)
			{
				players[i] FreezeControls( true );
			}
            level.win_game = true;
            level notify( "end_game" );
			break;
        }

        wait 0.05;
    }
}

coop_pause()
{	
	level endon("disconnect");
	level endon("end_game");

	setDvar( "coop_pause", 0 );

	paused_time = 0;
	paused_start_time = 0;
	paused = false;

	start_time = int(getTime() / 1000);

	players = get_players();

	while(players.size > 1)
	{
		if ( getDvarInt( "coop_pause" ) == 1 )
		{	
			if (get_round_enemy_array().size + level.zombie_total != 0 || flag( "dog_round" ) || flag( "leaper_round" ))
			{
				iprintln("All players will be paused at the start of the next round");
				level waittill( "end_of_round" );
			}

			players[0] SetClientDvar( "ai_disableSpawn", "1" );

			level waittill( "start_of_round" );

			black_hud = newhudelem();
			black_hud.horzAlign = "fullscreen";
			black_hud.vertAlign = "fullscreen";
			black_hud SetShader( "black", 640, 480 );
			black_hud.alpha = 0;

			black_hud FadeOverTime( 1.0 );
			black_hud.alpha = 0.7;

			paused_hud = newhudelem();
			paused_hud.horzAlign = "center";
			paused_hud.vertAlign = "middle";
			paused_hud setText("GAME PAUSED");
			paused_hud.foreground = true;
			paused_hud.fontScale = 2.3;
			paused_hud.x -= 63;
			paused_hud.y -= 20;
			paused_hud.alpha = 0;
			paused_hud.color = ( 1.0, 1.0, 1.0 );

			paused_hud FadeOverTime( 1.0 );
			paused_hud.alpha = 0.85;
			
			players = get_players();
			for(i = 0; players.size > i; i++)
			{
				players[i] freezecontrols(true);
			}

			paused = true;
			paused_start_time = int(getTime() / 1000);
			total_time = 0 - (paused_start_time - level.paused_time) - (start_time - 0.05);
			previous_paused_time = level.paused_time;

			while(paused)
			{	
				players = get_players();
				for(i = 0; players.size > i; i++)
				{
					players[i].timer_hud SetTimerUp(total_time);
				}
				
				wait 0.2;

				current_time = int(getTime() / 1000);
				current_paused_time = current_time - paused_start_time;
				level.paused_time = previous_paused_time + current_paused_time;

				if ( getDvarInt( "coop_pause" ) == 0 )
				{
					paused = false;

					for(i = 0; players.size > i; i++)
					{
						players[i] freezecontrols(false);
					}

					players[0] SetClientDvar( "ai_disableSpawn", "0");

					paused_hud FadeOverTime( 0.5 );
					paused_hud.alpha = 0;
					black_hud FadeOverTime( 0.5 );
					black_hud.alpha = 0;
					wait 0.5;
					black_hud destroy();
					paused_hud destroy();
				}
			}
		}
		wait 0.05;
	}
}

transit_power()
{
//	replaceFunc( maps\mp\_zm_transit_utility::solo_tombstone_removal, ::solo_tombstone_removal_override );
	level thread transit_power_local_electric_doors_globally();
	
	foreach( lava_pool in getentarray( "lava_damage", "targetname" ) )
		lava_pool delete();
}


transit_power_local_electric_doors_globally()
{
	if ( !(is_classic() && level.scr_zm_map_start_location == "transit") )
	{
		return;	
	}

	local_power = [];

	for ( ;; )
	{
		flag_wait( "power_on" );

		zombie_doors = getentarray( "zombie_door", "targetname" );
		for ( i = 0; i < zombie_doors.size; i++ )
		{
			if ( isDefined( zombie_doors[i].script_noteworthy ) && zombie_doors[i].script_noteworthy == "local_electric_door" )
			{
				local_power[local_power.size] = maps\mp\zombies\_zm_power::add_local_power( zombie_doors[i].origin, 16 );
			}
		}

		flag_waitopen( "power_on" );

		for (i = 0; i < local_power.size; i++)
		{
			maps\mp\zombies\_zm_power::end_local_power( local_power[i] );
			local_power[i] = undefined;
		}
		local_power = [];
	}
}