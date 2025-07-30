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
#include scripts\zm\girly\player;
#include scripts\zm\girly\zombie;
#include scripts\zm\girly\powerups;
#include scripts\zm\girly\overflow_fix;
#include scripts\zm\girly\hud;
#include scripts\zm\girly\map;
#include scripts\zm\girly\menu;
#include scripts\zm\girly\weapons;

increase_trigger_radius()
{
	for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
	{
		if(isdefined(level._unitriggers.trigger_stubs[i].zombie_weapon_upgrade))
		{
			level._unitriggers.trigger_stubs[i].script_length = 96;
		}
	}
}

wallbuy_dynamic_radius()
{
	if(!(is_classic() && level.scr_zm_map_start_location == "processing"))
	{
		return;
	}

	while (!isdefined(level.built_wallbuys))
	{
		wait 0.5;
	}

	prev_built_wallbuys = 0;

	while (1)
	{
		if (level.built_wallbuys > prev_built_wallbuys)
		{
			prev_built_wallbuys = level.built_wallbuys;
			increase_trigger_radius();
		}

		if (level.built_wallbuys == -100)
		{
			increase_trigger_radius();
			return;
		}

		wait 0.5;
	}
}

electric_trap_damage()
{
	level.etrap_damage = maps\mp\zombies\_zm::ai_zombie_health( 255 );
}

better_nukes(points)
{
    self endon("disconnect");
    level endon("game_end");
    for(;;) {
        self waittill("nuke_triggered");
        points = ((get_round_enemy_array().size + level.zombie_total) * points);
        
        if (level.zombie_vars[self.team]["zombie_point_scalar"] != 1)
        {
        	points = points * 2;
        }
        
        for( i = 0; i < level.players.size; i++ )
        {
        	level.players[i].score += points;
        }
        wait 0.02;
    }
}

new_round_hud()
{
	level waittill("start_of_round");
	switch(level.round_number)
	{
		case 1:
			roundCounter destroyElem();
			roundCounter = createservericon("hud_chalk_1", 50, 50);
			break;
	
		case 2:
			roundCounter destroyElem();
			roundCounter = createservericon("hud_chalk_2", 50, 50);
			break;
	
		case 3:
			roundCounter destroyElem();
			roundCounter = createservericon("hud_chalk_3", 50, 50);
			break;

		case 4:
			roundCounter destroyElem();
			roundCounter = createservericon("hud_chalk_4", 50, 50);
			break;

		case 5:
			roundCounter destroyElem();
			roundCounter = createservericon("hud_chalk_5", 50, 50);
			break;	
		default:
			roundCounter destroyElem();
			roundCounter = createserverfontstring("default", 25);
			roundCounter SetValue(level.round_number);
			break;
	}
	roundCounter SetPoint("LEFT", "TOPLEFT", -33, 10);
	roundCounter.alpha = 0;
	roundCounter.color = (1,1,0.25);
	roundCounter FadeOverTime(1);
	roundCounter.color = (0.75,0,0);
	roundCounter.alpha = 1;
	roundCounter.hidewheninmenu = 1;
	while(1)
	{
		level waittill("end_of_round");
		roundCounter.color = (1,1,0.25);
		roundCounter FadeOverTime(0.5);
		roundCounter.alpha = 0;
		wait 1;
		switch(level.round_number){
			case 1:
				roundCounter SetShader("hud_chalk_1", 50, 50);
				break;
		
			case 2:
				roundCounter SetShader("hud_chalk_2", 50, 50);
				break;
		
			case 3:
				roundCounter SetShader("hud_chalk_3", 50, 50);
				break;

			case 4:
				roundCounter SetShader("hud_chalk_4", 50, 50);
				break;

			case 5:
				roundCounter SetShader("hud_chalk_5", 50, 50);
				break;	
			default:
				roundCounter destroyElem();
				roundCounter = createserverfontstring("default", 25);
				roundCounter SetPoint("LEFT", "TOPLEFT", -33, 10);
				roundCounter SetValue(level.round_number);
				roundCounter.color = (1,1,0.25);
				break;
		}
		roundCounter FadeOverTime(0.7);
		roundCounter.color = (0.75,0,0);
		roundCounter.alpha = 1;
		roundCounter.hidewheninmenu = 1;	
	}
	level waittill("between_round_over");
}

init_dvars()
{
	if (level.script == "zm_transit")
    {
		setdvar("scr_screecher_ignore_player", 1); // denizens do not spawn
    }

	setdvar("player_lastStandBleedoutTime", 170);
    setdvar("bg_prone_yawcap", "360" );
    setdvar("bg_ladder_yawcap", "360");
    setdvar("friendlyfire_enabled", 1);
    setdvar("g_friendlyfireDist", 0);
    setdvar("ui_friendlyfire", 1);
    setdvar("jump_slowdownEnable", 0);
    setdvar("perk_extendedmeleerange", 5000);
    setdvar("aim_automelee_enabled", 1);
    setdvar("aim_automelee_range", 195); 
    setdvar("aim_autoaim_lerp", 75);
    setdvar("bg_gravity", 785);   
	setdvar("g_useholdtime", 0);
	setdvar("g_useholdspawndelay", 0);
	setdvar("player_backSpeedScale", 1.3);
    setdvar("player_useRadius", 600);
	setdvar("dtp_exhaustion_window", 0);
	setdvar("player_meleeRange", 64);
	setdvar("player_breath_gasp_lerp", 0);
	setdvar("perk_weapRateEnhanced", 1);
	setdvar("sv_patch_zm_weapons", 0);
	setdvar("sv_fix_zm_weapons", 1);
	setdvar("sv_voice", 2);
	setdvar("sv_voiceQuality", 9);  

	// custom dvars 
	setdvar("rapid_fire", 1);
	setdvar("eye_color", 1);
	// buried is way too dark so lets not do it there
	if (getdvar("mapname") != "zm_buried")
		setdvar("night_mode", 1);
	else
		setdvar("night_mode", 0);
}

init_precache()
{

}

init_client_dvars()
{
    self setClientDvar("dtp_post_move_pause", 0);
	self setClientDvar("dtp_exhaustion_window", 0);
	self setClientDvar("dtp_startup_delay", 0);
    self setclientdvar("player_strafeSpeedScale", 1);
    self setclientdvar("player_sprintStrafeSpeedScale", 1);
	self setclientdvar("aim_automelee_enabled", 0);
	self setclientdvar("cg_drawBreathHint", 0);
	self setclientdvar("waypointOffscreenPointerDistance", 30);
	self setclientdvar("waypointOffscreenPadTop", 32);
	self setclientdvar("waypointOffscreenPadBottom", 32);
	self setclientdvar("waypointPlayerOffsetStand", 30);
	self setclientdvar("waypointPlayerOffsetCrouch", 30);
	self setclientdvar("r_fog", 0 );
	self setClientDvar("r_lodBiasRigid", -1000);
	self setClientDvar("r_lodBiasSkinned", -1000);
	self setClientDvar("cg_ufo_scaler", 1);
}

setting_perks()
{
	self setperk("specialty_unlimitedsprint");
    self setperk("specialty_movefaster");
    self setperk("specialty_sprintrecovery");    
    self setperk("specialty_earnmoremomentum");
	self setperk("specialty_fastmantle");
	self setperk("specialty_fastladderclimb");
    self setperk("specialty_extraammo");
    self setperk("specialty_bulletpenetration");
    self setperk("specialty_bulletaccuracy");
    self setperk("specialty_fasttoss");
    self setperk("specialty_fastladderclimb");
    self setperk("specialty_fastmantle");
    self setperk("specialty_fastequipmentuse"); 
}

zombie_total()
{
	for (;;)
	{
		level waittill("start_of_round");

		if(level.round_number > 5)
		{
			level.zombie_total = 55;
			// self waittill("spawned_player");
		}
	}
}

perk_points()
{
	self endon( "disconnect" );
	for(;;)
	{
		self waittill_any("perk_acquired");
		self thread give_perk_points();
	}
}

// Random Point System
// Redo values

randomPoints_t()
{
	death_num = randomintrange( 50, 450 );
	death = death_num;
	self.score += death;
	self thread imsg( "You found " + "$" + death + " on the ground!");
}

give_starting_points()
{
	spawn_num = randomintrange( 500, 5000 );
	point_s = spawn_num;
	//self thread imsg( "Discovered " + "$" + point_s + " on landing!");
	self.score += point_s;
	self.landingpoints = self.score;
}

give_perk_points()
{
	randomnum = randomintrange( 25, 1350 );
	point = randomnum;

	self.score += point;
	self thread imsg( "$" + point + " was found at this machine!" );
}

boxPrice()
{

	i = 0;
    while (i < level.chests.size)
    {
        level.chests[ i ].zombie_cost = 650;
        level.chests[ i ].old_cost = 500;
        i++;
    }
}

init_wallbuy_changes()
{
	flag_wait( "initial_blackscreen_passed" );

	low = strTok("250,350,500,550", ","); // May adjust later..
	l = RandomInt(low.size);
	r1 = low[l];

	high = strTok("850,1150,1250,1350,1500", ",");
	h = RandomInt(high.size);
	r2 = high[h];

    
	if (isdefined(level.zombie_weapons["beretta93r_zm"]))
	{
		cost = r1;
		level.zombie_weapons["beretta93r_zm"].cost = cost;
		level.zombie_weapons["beretta93r_zm"].ammo_cost = int(cost / 2);
	}

	if (isdefined(level.zombie_weapons["870mcs_zm"]))
	{
		cost = r1;
		level.zombie_weapons["870mcs_zm"].cost = cost;
		level.zombie_weapons["870mcs_zm"].ammo_cost = int(cost / 2);
	}

	if (isdefined(level.zombie_weapons["an94_zm"]))
	{
		cost = r2;
		level.zombie_weapons["an94_zm"].cost = cost;
		level.zombie_weapons["an94_zm"].ammo_cost = int(cost / 2);
	}
	if (isdefined(level.zombie_weapons["pdw57_zm"]))
	{
		cost = r1;
		level.zombie_weapons["pdw57_zm"].cost = cost;
		level.zombie_weapons["pdw57_zm"].ammo_cost = int(cost / 2);
	}
	if (isdefined(level.zombie_weapons["m14_zm"]))
	{
		cost = r1;
		level.zombie_weapons["m14_zm"].cost = cost;
		level.zombie_weapons["m14_zm"].ammo_cost = int(cost / 2);
	}
	if (isdefined(level.zombie_weapons["lsat_zm"]))
	{
		cost = r2;
		level.zombie_weapons["lsat_zm"].cost = cost;
		level.zombie_weapons["lsat_zm"].ammo_cost = int(cost / 2);
	}
	if (isdefined(level.zombie_weapons["rottweil72_zm"]))
	{
		cost = r1;
		level.zombie_weapons["rottweil72_zm"].cost = cost;
		level.zombie_weapons["rottweil72_zm"].ammo_cost = int(cost / 2);
	}
	if (isdefined(level.zombie_weapons["thompson_zm"]))
	{
		cost = r2;
		level.zombie_weapons["thompson_zm"].cost = cost;
		level.zombie_weapons["thompson_zm"].ammo_cost = int(cost / 2);
	}
}


treasure_chest_canplayerreceiveweapon_override( player, weapon, pap_triggers ) //checked matches cerberus output
{
	if ( !get_is_in_box( weapon ) )
	{
		return 0;
	}
	if (player hasperk(weapon)) // perk glitch fix?
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
	if( weapon == "raygun_mark2_zm" || weapon == "ray_gun_zm" || weapon == "cymbal_monkey_zm" || weapon == "blundergat_zm" || weapon == "slowgun_zm" || weapon == "m32_zm" )
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
    if(rand == "zombie_perk_bottle_revive")
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
    if ( getdvar( "magic_chest_movable" ) == "1" && !( isdefined( chest._box_opened_by_fire_sale ) && chest._box_opened_by_fire_sale ) && !( isdefined( level.zombie_vars["zombie_powerup_fire_sale_on"] ) && level.zombie_vars["zombie_powerup_fire_sale_on"] && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() ) )
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

		if( level.players.size > 1 ) // if coop double weapons needed
		{
			level.weapons_needed += 2;
		}
		if( level.default_start_location == "processing" || level.default_start_location == "tomb" ) // buried and origins add one for war machine and slowgun
		{
			level.weapons_needed += 1;
		}
		if( level.default_start_location == "prison" && level.players.size > 1 ) // mob add one for 2p and two for 3/4p for extra gats
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
			else if( treasure_chest_canplayerreceiveweapon( player, "ray_gun_zm", pap_triggers ) )
			{
				rand = "ray_gun_zm";
			}
			else if( treasure_chest_canplayerreceiveweapon( player, "cymbal_monkey_zm", pap_triggers ) && getdvar("mapname") != "zm_prison")
			{
				rand = "cymbal_monkey_zm";
			}
			else if( treasure_chest_canplayerreceiveweapon( player, "blundergat_zm", pap_triggers ) && getdvar("mapname") == "zm_prison")
			{
				rand = "blundergat_zm";
			}
			else if( treasure_chest_canplayerreceiveweapon( player, "slowgun_zm", pap_triggers ) && getdvar( "mapname" ) == "zm_buried")
			{
				rand = "slowgun_zm";
			}
			else if( treasure_chest_canplayerreceiveweapon( player, "emp_grenade_zm", pap_triggers ) && getdvar("mapname") == "zm_transit" && is_classic() )
			{
				rand = "emp_grenade_zm";
			}
			else if( treasure_chest_canplayerreceiveweapon( player, "m32_zm", pap_triggers ) && getdvar("mapname") == "zm_tomb")
			{
				rand = "m32_zm";
			}

			if( level.weapons_needed != 0 )
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
	if ( getdvar( "magic_chest_movable" ) == "1" && !is_true( chest._box_opened_by_fire_sale ) && !is_true( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() )
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


custom_treasure_chest_chooseweightedrandomweapon(player)
{
    level.box_perks = randomintrange(0, 5);
	zombie_perks = [];
    if(level.box_perks == 0 && player.num_perks < level.perk_purchase_limit && level.perks_in_box_enabled)
    {  
		if(!player hasperk("specialty_rof"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_doubletap";
		}
		if(!player hasperk("specialty_armorvest"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_jugg";
		}
		if(!player hasperk("specialty_fastreload"))
		{
        	zombie_perks[zombie_perks.size] = "zombie_perk_bottle_sleight";
		}
        if(getdvar("mapname") == "zm_transit")
        {
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if(!player hasperk("specialty_longersprint"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
            if(get_players().size > 1 && !player hasperk("specialty_scavenger") )
            {
		        zombie_perks[zombie_perks.size] = "zombie_perk_bottle_tombstone";
            }
        }
        if(getdvar("mapname") == "zm_prison")
        {
			if(!player hasperk("specialty_deadshot"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_deadshot";
			}
			if(!player hasperk("specialty_grenadepulldeath"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_cherry";
			}  
        }
        if(getdvar("mapname") == "zm_nuked")
        {
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
        }
        if(getdvar("mapname") == "zm_tomb")
        {
			if(!player hasperk("specialty_deadshot"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_deadshot";
			}
			if(!player hasperk("specialty_grenadepulldeath"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_cherry";
			}
			if(!player hasperk("specialty_flakjacket"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_nuke";
			}
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if(!player hasperk("specialty_longersprint"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
			if(!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
		}
        if(getdvar("mapname") == "zm_buried")
        {
			if(!player hasperk("specialty_nomotionsensor"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_vulture";
			}
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if(!player hasperk("specialty_longersprint"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_marathon";
			}
			if(!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
		}
        if(getdvar("mapname") == "zm_highrise")
        {
			if(!player hasperk("specialty_quickrevive"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_revive";
			}
			if(!player hasperk("specialty_additionalprimaryweapon"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_additionalprimaryweapon";
			}
			if(!player hasperk("specialty_finalstand"))
			{
				zombie_perks[zombie_perks.size] = "zombie_perk_bottle_whoswho";
			}
		}
    }
	if(zombie_perks.size > 0)
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
        if( zombie_perks.size > 0 )
        {
            if( treasure_chest_canplayerreceiveperk( player, keys[ i ] ) )
            {
                return keys[ i ];
            }
        }
        else
        {
            if( treasure_chest_canplayerreceiveweapon( player, keys[ i ], pap_triggers ) )
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
    
    if(weapon == "zombie_perk_bottle_sleight")
    {
        if(player hasperk("specialty_fastreload"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_revive")
    {
        if(player hasperk("specialty_quickrevive"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_doubletap")
    {
        if(player hasperk("specialty_rof"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_jugg")
    {
        if(player hasperk("specialty_armorvest"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_marathon")
    {
        if(player hasperk("specialty_longersprint"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_tombstone")
    {
        if(player hasperk("specialty_scavenger"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_deadshot")
    {
        if(player hasperk("specialty_deadshot"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_cherry")
    {
        if(player hasperk("specialty_grenadepulldeath"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_nuke")
    {
        if(player hasperk("specialty_flakjacket"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_additionalprimaryweapon")
    {
        if(player hasperk("specialty_additionalprimaryweapon"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_vulture")
    {
        if(player hasperk("specialty_nomotionsensor"))
        {
            return 0;
        }
    }
    if(weapon == "zombie_perk_bottle_whoswho")
    {
        if(player hasperk("specialty_finalstand"))
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


buildbuildables()
{
	// need a wait or else some buildables dont build
	wait 1;

	if(is_classic())
	{
		if(level.scr_zm_map_start_location == "transit")
		{
			buildbuildable( "turbine" );
			buildbuildable( "electric_trap" );
			buildbuildable( "turret" );
			buildbuildable( "riotshield_zm" );
			buildbuildable( "jetgun_zm" );
			buildbuildable( "powerswitch", 1 );
			buildbuildable( "pap", 1 );
			buildbuildable( "sq_common", 1 );
			buildbuildable( "dinerhatch", 1 );
			buildbuildable( "bushatch", 1 );
			buildbuildable( "busladder", 1 );
			// buildbuildable( "cattlecatcher", 1 );
			removebuildable( "dinerhatch" );
			removebuildable( "bushatch" );
			removebuildable( "busladder" );
			// removebuildable( "cattlecatcher" );

			getent( "powerswitch_p6_zm_buildable_pswitch_hand", "targetname" ) show();
			getent( "powerswitch_p6_zm_buildable_pswitch_body", "targetname" ) show();
			getent( "powerswitch_p6_zm_buildable_pswitch_lever", "targetname" ) show();
		}
		else if(level.scr_zm_map_start_location == "rooftop")
		{
			buildbuildable( "slipgun_zm" );
			buildbuildable( "springpad_zm" );
			buildbuildable( "sq_common", 1 );
			removebuildable( "keys_zm" );
		}
		else if(level.scr_zm_map_start_location == "processing")
		{
			// level waittill( "buildables_setup" ); // doesn't work on newer version of pluto for some reason...
			wait 2;
			level.buildables_available = array("subwoofer_zm", "springpad_zm", "headchopper_zm", "turbine");

			//removebuildable( "keys_zm" );
			buildbuildable( "turbine" );
			buildbuildable( "subwoofer_zm" );
			buildbuildable( "springpad_zm" );
			buildbuildable( "headchopper_zm" );
			buildbuildable( "sq_common", 1 );
		}
	}
}

buildbuildable( buildable, craft )
{
	if (!isDefined(craft))
	{
		craft = 0;
	}

	player = get_players()[ 0 ];
	foreach (stub in level.buildable_stubs)
	{
		if ( !isDefined( buildable ) || stub.equipname == buildable )
		{
			if ( isDefined( buildable ) || stub.persistent != 3 )
			{
				if (craft)
				{
					stub maps\mp\zombies\_zm_buildables::buildablestub_finish_build( player );
					stub maps\mp\zombies\_zm_buildables::buildablestub_remove();
					stub.model notsolid();
					stub.model show();
				}
				else
				{
					equipname = stub get_equipname();
					level.zombie_buildables[stub.equipname].hint = "Craft the " + equipname + "^7 using ^3[{+activate}]^7";
					stub.prompt_and_visibility_func = ::buildabletrigger_update_prompt;
				}

				i = 0;
				foreach (piece in stub.buildablezone.pieces)
				{
					piece maps\mp\zombies\_zm_buildables::piece_unspawn();
					if (!craft && i > 0)
					{
						stub.buildablezone maps\mp\zombies\_zm_buildables::buildable_set_piece_built(piece);
					}
					i++;
				}

				return;
			}
		}
	}
}

get_equipname()
{
	if (self.equipname == "turbine")
	{
		return "^3Turbine";
	}
	else if (self.equipname == "turret")
	{
		return "^5Turret";
	}
	else if (self.equipname == "electric_trap")
	{
		return "^5Electric Trap";
	}
	else if (self.equipname == "riotshield_zm")
	{
		return "^1Zombie Shield";
	}
	else if (self.equipname == "jetgun_zm")
	{
		return "^3Jet Gun";
	}
	else if (self.equipname == "slipgun_zm")
	{
		return "^6Sliquifier";
	}
	else if (self.equipname == "subwoofer_zm")
	{
		return "^3Subsurface Resonator";
	}
	else if (self.equipname == "springpad_zm")
	{
		return "^6Trample Steam";
	}
	else if (self.equipname == "headchopper_zm")
	{
		return "^1Head Chopper";
	}
}
buildabletrigger_update_prompt( player )
{
	can_use = 0;
	if (isDefined(level.buildablepools))
	{
		can_use = self.stub pooledbuildablestub_update_prompt( player, self );
	}
	else
	{
		can_use = self.stub buildablestub_update_prompt( player, self );
	}
	
	self sethintstring( self.stub.hint_string );
	if ( isDefined( self.stub.cursor_hint ) )
	{
		if ( self.stub.cursor_hint == "HINT_WEAPON" && isDefined( self.stub.cursor_hint_weapon ) )
		{
			self setcursorhint( self.stub.cursor_hint, self.stub.cursor_hint_weapon );
		}
		else
		{
			self setcursorhint( self.stub.cursor_hint );
		}
	}
	return can_use;
}

buildablestub_update_prompt( player, trigger )
{
	if ( !self maps\mp\zombies\_zm_buildables::anystub_update_prompt( player ) )
	{
		return 0;
	}

	if ( isDefined( self.buildablestub_reject_func ) )
	{
		rval = self [[ self.buildablestub_reject_func ]]( player );
		if ( rval )
		{
			return 0;
		}
	}

	if ( isDefined( self.custom_buildablestub_update_prompt ) && !( self [[ self.custom_buildablestub_update_prompt ]]( player ) ) )
	{
		return 0;
	}

	self.cursor_hint = "HINT_NOICON";
	self.cursor_hint_weapon = undefined;
	if ( isDefined( self.built ) && !self.built )
	{
		slot = self.buildablestruct.buildable_slot;
		piece = self.buildablezone.pieces[0];
		player maps\mp\zombies\_zm_buildables::player_set_buildable_piece(piece, slot);

		if ( !isDefined( player maps\mp\zombies\_zm_buildables::player_get_buildable_piece( slot ) ) )
		{
			if ( isDefined( level.zombie_buildables[ self.equipname ].hint_more ) )
			{
				self.hint_string = level.zombie_buildables[ self.equipname ].hint_more;
			}
			else
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
			}
			return 0;
		}
		else
		{
			if ( !self.buildablezone maps\mp\zombies\_zm_buildables::buildable_has_piece( player maps\mp\zombies\_zm_buildables::player_get_buildable_piece( slot ) ) )
			{
				if ( isDefined( level.zombie_buildables[ self.equipname ].hint_wrong ) )
				{
					self.hint_string = level.zombie_buildables[ self.equipname ].hint_wrong;
				}
				else
				{
					self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
				}
				return 0;
			}
			else
			{
				if ( isDefined( level.zombie_buildables[ self.equipname ].hint ) )
				{
					self.hint_string = level.zombie_buildables[ self.equipname ].hint;
				}
				else
				{
					self.hint_string = "Missing buildable hint";
				}
			}
		}
	}
	else
	{
		if ( self.persistent == 1 )
		{
			if ( maps\mp\zombies\_zm_equipment::is_limited_equipment( self.weaponname ) && maps\mp\zombies\_zm_equipment::limited_equipment_in_use( self.weaponname ) )
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_ONLY_ONE";
				return 0;
			}

			if ( player has_player_equipment( self.weaponname ) )
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_HAVE_ONE";
				return 0;
			}

			self.hint_string = self.trigger_hintstring;
		}
		else if ( self.persistent == 2 )
		{
			if ( !maps\mp\zombies\_zm_weapons::limited_weapon_below_quota( self.weaponname, undefined ) )
			{
				self.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
				return 0;
			}
			else
			{
				if ( isDefined( self.bought ) && self.bought )
				{
					self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
					return 0;
				}
			}
			self.hint_string = self.trigger_hintstring;
		}
		else
		{
			self.hint_string = "";
			return 0;
		}
	}
	return 1;
}

pooledbuildablestub_update_prompt( player, trigger )
{
	if ( !self maps\mp\zombies\_zm_buildables::anystub_update_prompt( player ) )
	{
		return 0;
	}

	if ( isDefined( self.custom_buildablestub_update_prompt ) && !( self [[ self.custom_buildablestub_update_prompt ]]( player ) ) )
	{
		return 0;
	}

	self.cursor_hint = "HINT_NOICON";
	self.cursor_hint_weapon = undefined;
	if ( isDefined( self.built ) && !self.built )
	{
		trigger thread buildablestub_build_succeed();

		if (level.buildables_available.size > 1)
		{
			self thread choose_open_buildable(player);
		}

		slot = self.buildablestruct.buildable_slot;

		if (self.buildables_available_index >= level.buildables_available.size)
		{
			self.buildables_available_index = 0;
		}

		foreach (stub in level.buildable_stubs)
		{
			if (stub.buildablezone.buildable_name == level.buildables_available[self.buildables_available_index])
			{
				piece = stub.buildablezone.pieces[0];
				break;
			}
		}

		player maps\mp\zombies\_zm_buildables::player_set_buildable_piece(piece, slot);

		piece = player maps\mp\zombies\_zm_buildables::player_get_buildable_piece(slot);

		if ( !isDefined( piece ) )
		{
			if ( isDefined( level.zombie_buildables[ self.equipname ].hint_more ) )
			{
				self.hint_string = level.zombie_buildables[ self.equipname ].hint_more;
			}
			else
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
			}

			if ( isDefined( level.custom_buildable_need_part_vo ) )
			{
				player thread [[ level.custom_buildable_need_part_vo ]]();
			}
			return 0;
		}
		else
		{
			if ( isDefined( self.bound_to_buildable ) && !self.bound_to_buildable.buildablezone maps\mp\zombies\_zm_buildables::buildable_has_piece( piece ) )
			{
				if ( isDefined( level.zombie_buildables[ self.bound_to_buildable.equipname ].hint_wrong ) )
				{
					self.hint_string = level.zombie_buildables[ self.bound_to_buildable.equipname ].hint_wrong;
				}
				else
				{
					self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
				}

				if ( isDefined( level.custom_buildable_wrong_part_vo ) )
				{
					player thread [[ level.custom_buildable_wrong_part_vo ]]();
				}
				return 0;
			}
			else
			{
				if ( !isDefined( self.bound_to_buildable ) && !self.buildable_pool pooledbuildable_has_piece( piece ) )
				{
					if ( isDefined( level.zombie_buildables[ self.equipname ].hint_wrong ) )
					{
						self.hint_string = level.zombie_buildables[ self.equipname ].hint_wrong;
					}
					else
					{
						self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
					}
					return 0;
				}
				else
				{
					if ( isDefined( self.bound_to_buildable ) )
					{
						if ( isDefined( level.zombie_buildables[ piece.buildablename ].hint ) )
						{
							self.hint_string = level.zombie_buildables[ piece.buildablename ].hint;
						}
						else
						{
							self.hint_string = "Missing buildable hint";
						}
					}
					
					if ( isDefined( level.zombie_buildables[ piece.buildablename ].hint ) )
					{
						self.hint_string = level.zombie_buildables[ piece.buildablename ].hint;
					}
					else
					{
						self.hint_string = "Missing buildable hint";
					}
				}
			}
		}
	}
	else
	{
		return trigger [[ self.original_prompt_and_visibility_func ]]( player );
	}
	return 1;
}

pooledbuildable_has_piece( piece )
{
	return isDefined( self pooledbuildable_stub_for_piece( piece ) );
}

pooledbuildable_stub_for_piece( piece )
{
	foreach (stub in self.stubs)
	{
		if ( !isDefined( stub.bound_to_buildable ) )
		{
			if ( stub.buildablezone maps\mp\zombies\_zm_buildables::buildable_has_piece( piece ) )
			{
				return stub;
			}
		}
	}

	return undefined;
}

choose_open_buildable( player )
{
	self endon( "kill_choose_open_buildable" );

	n_playernum = player getentitynumber();
	b_got_input = 1;
	hinttexthudelem = newclienthudelem( player );
	hinttexthudelem.alignx = "center";
	hinttexthudelem.aligny = "middle";
	hinttexthudelem.horzalign = "center";
	hinttexthudelem.vertalign = "bottom";
	hinttexthudelem.y = -100;
	hinttexthudelem.foreground = 1;
	hinttexthudelem.font = "default";
	hinttexthudelem.fontscale = 1;
	hinttexthudelem.alpha = 1;
	hinttexthudelem.color = self.mapcolor;
	hinttexthudelem settext( "Press [{+actionslot 1}] or [{+actionslot 2}] to change item" );

	if (!isDefined(self.buildables_available_index))
	{
		self.buildables_available_index = 0;
	}

	while ( isDefined( self.playertrigger[ n_playernum ] ) && !self.built )
	{
		if (!player isTouching(self.playertrigger[n_playernum]))
		{
			hinttexthudelem.alpha = 0;
			wait 0.05;
			continue;
		}

		hinttexthudelem.alpha = 1;

		if ( player actionslotonebuttonpressed() )
		{
			self.buildables_available_index++;
			b_got_input = 1;
		}
		else
		{
			if ( player actionslottwobuttonpressed() )
			{
				self.buildables_available_index--;

				b_got_input = 1;
			}
		}

		if ( self.buildables_available_index >= level.buildables_available.size )
		{
			self.buildables_available_index = 0;
		}
		else
		{
			if ( self.buildables_available_index < 0 )
			{
				self.buildables_available_index = level.buildables_available.size - 1;
			}
		}

		if ( b_got_input )
		{
			piece = undefined;
			foreach (stub in level.buildable_stubs)
			{
				if (stub.buildablezone.buildable_name == level.buildables_available[self.buildables_available_index])
				{
					piece = stub.buildablezone.pieces[0];
					break;
				}
			}
			slot = self.buildablestruct.buildable_slot;
			player maps\mp\zombies\_zm_buildables::player_set_buildable_piece(piece, slot);

			self.equipname = level.buildables_available[self.buildables_available_index];
			self.hint_string = level.zombie_buildables[self.equipname].hint;
			self.playertrigger[n_playernum] sethintstring(self.hint_string);
			b_got_input = 0;
		}

		if ( player is_player_looking_at( self.playertrigger[n_playernum].origin, 0.76 ) )
		{
			hinttexthudelem.alpha = 1;
		}
		else
		{
			hinttexthudelem.alpha = 0;
		}

		wait 0.05;
	}

	hinttexthudelem destroy();
}

buildablestub_build_succeed()
{
	self notify("buildablestub_build_succeed");
	self endon("buildablestub_build_succeed");

	self waittill( "build_succeed" );

	self.stub maps\mp\zombies\_zm_buildables::buildablestub_remove();
	arrayremovevalue(level.buildables_available, self.stub.buildablezone.buildable_name);
	if (level.buildables_available.size == 0)
	{
		foreach (stub in level.buildable_stubs)
		{
			switch(stub.equipname)
			{
				case "turbine":
				case "subwoofer_zm":
				case "springpad_zm":
				case "headchopper_zm":
					maps\mp\zombies\_zm_unitrigger::unregister_unitrigger(stub);
					break;
			}
		}
	}
}

removebuildable( buildable, after_built )
{
	if (!isDefined(after_built))
	{
		after_built = 0;
	}

	if (after_built)
	{
		foreach (stub in level._unitriggers.trigger_stubs)
		{
			if(IsDefined(stub.equipname) && stub.equipname == buildable)
			{
				stub.model hide();
				maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( stub );
				return;
			}
		}
	}
	else
	{
		foreach (stub in level.buildable_stubs)
		{
			if ( !isDefined( buildable ) || stub.equipname == buildable )
			{
				if ( isDefined( buildable ) || stub.persistent != 3 )
				{
					stub maps\mp\zombies\_zm_buildables::buildablestub_remove();
					foreach (piece in stub.buildablezone.pieces)
					{
						piece maps\mp\zombies\_zm_buildables::piece_unspawn();
					}
					maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( stub );
					return;
				}
			}
		}
	}
}




buildable_piece_remove_on_last_stand()
{
	self endon( "disconnect" );

	self thread buildable_get_last_piece();

	while (1)
	{
		self waittill("entering_last_stand");

		if (isDefined(self.last_piece))
		{
			self.last_piece maps\mp\zombies\_zm_buildables::piece_unspawn();
		}
	}
}

buildable_get_last_piece()
{
	self endon( "disconnect" );

	while (1)
	{
		if (!self maps\mp\zombies\_zm_laststand::player_is_in_laststand())
		{
			self.last_piece = maps\mp\zombies\_zm_buildables::player_get_buildable_piece(0);
		}

		wait 0.05;
	}
}


/*
* *****************************************************
*	
* ********** MOTD/Origins style buildables ************
*
* *****************************************************
*/

buildcraftables()
{
	// need a wait or else some buildables dont build
	wait 3;

	if(is_classic())
	{
		if(level.scr_zm_map_start_location == "prison")
		{
			buildcraftable( "alcatraz_shield_zm" );
			buildcraftable( "packasplat" );
			//buildcraftable( "plane" );
			changecraftableoption( 0 );
		}
		else if(level.scr_zm_map_start_location == "tomb")
		{
			buildcraftable( "tomb_shield_zm" );
			buildcraftable( "equip_dieseldrone_zm" );
			takecraftableparts( "gramophone" );
			//buildcraftable( "elemental_staff_water" );
		}
	}
}

changecraftableoption( index )
{
	foreach (craftable in level.a_uts_craftables)
	{
		if (craftable.equipname == "open_table")
		{
			craftable thread setcraftableoption( index );
		}
	}
}

setcraftableoption( index )
{
	self endon("death");

	while (self.a_uts_open_craftables_available.size <= 0)
	{
		wait 0.05;
	}

	if (self.a_uts_open_craftables_available.size > 1)
	{
		self.n_open_craftable_choice = index;
		self.equipname = self.a_uts_open_craftables_available[self.n_open_craftable_choice].equipname;
		self.hint_string = self.a_uts_open_craftables_available[self.n_open_craftable_choice].hint_string;
		foreach (trig in self.playertrigger)
		{
			trig sethintstring( self.hint_string );
		}
	}
}

takecraftableparts( buildable )
{
	player = get_players()[ 0 ];
	foreach (stub in level.zombie_include_craftables)
	{
		if ( stub.name == buildable )
		{
			foreach (piece in stub.a_piecestubs)
			{
				piecespawn = piece.piecespawn;
				if ( isDefined( piecespawn ) )
				{
					player player_take_piece_gramophone( piecespawn );
				}
			}

			return;
		}
	}
}

buildcraftable( buildable )
{
	player = get_players()[ 0 ];
	foreach (stub in level.a_uts_craftables)
	{
		if ( stub.craftablestub.name == buildable )
		{
			foreach (piece in stub.craftablespawn.a_piecespawns)
			{
				piecespawn = get_craftable_piece( stub.craftablestub.name, piece.piecename );
				if ( isDefined( piecespawn ) )
				{
					player player_take_piece( piecespawn );
				}
			}

			return;
		}
	}
}

get_craftable_piece( str_craftable, str_piece )
{
	foreach (uts_craftable in level.a_uts_craftables)
	{
		if ( uts_craftable.craftablestub.name == str_craftable )
		{
			foreach (piecespawn in uts_craftable.craftablespawn.a_piecespawns)
			{
				if ( piecespawn.piecename == str_piece )
				{
					return piecespawn;
				}
			}
		}
	}
	return undefined;
}

player_take_piece_gramophone( piecespawn )
{
	piecestub = piecespawn.piecestub;
	damage = piecespawn.damage;

	if ( isDefined( piecestub.onpickup ) )
	{
		piecespawn [[ piecestub.onpickup ]]( self );
	}

	// if ( isDefined( piecestub.is_shared ) && piecestub.is_shared )
	// {
	// 	if ( isDefined( piecestub.client_field_id ) )
	// 	{
	// 		level setclientfield( piecestub.client_field_id, 1 );
	// 	}
	// }
	// else
	// {
	// 	if ( isDefined( piecestub.client_field_state ) )
	// 	{
	// 		self setclientfieldtoplayer( "craftable", piecestub.client_field_state );
	// 	}
	// }

	piecespawn piece_unspawn();
	piecespawn notify( "pickup" );

	if ( isDefined( piecestub.is_shared ) && piecestub.is_shared )
	{
		piecespawn.in_shared_inventory = 1;
	}

	self adddstat( "buildables", piecespawn.craftablename, "pieces_pickedup", 1 );
}

player_take_piece( piecespawn )
{
	piecestub = piecespawn.piecestub;
	damage = piecespawn.damage;

	if ( isDefined( piecestub.onpickup ) )
	{
		piecespawn [[ piecestub.onpickup ]]( self );
	}

	if ( isDefined( piecestub.is_shared ) && piecestub.is_shared )
	{
		if ( isDefined( piecestub.client_field_id ) )
		{
			level setclientfield( piecestub.client_field_id, 1 );
		}
	}
	else
	{
		if ( isDefined( piecestub.client_field_state ) )
		{
			self setclientfieldtoplayer( "craftable", piecestub.client_field_state );
		}
	}

	piecespawn piece_unspawn();
	piecespawn notify( "pickup" );

	if ( isDefined( piecestub.is_shared ) && piecestub.is_shared )
	{
		piecespawn.in_shared_inventory = 1;
	}

	self adddstat( "buildables", piecespawn.craftablename, "pieces_pickedup", 1 );
}

piece_unspawn()
{
	if ( isDefined( self.model ) )
	{
		self.model delete();
	}
	self.model = undefined;
	if ( isDefined( self.unitrigger ) )
	{
		thread maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( self.unitrigger );
	}
	self.unitrigger = undefined;
}

remove_buildable_pieces( buildable_name )
{
	foreach (buildable in level.zombie_include_buildables)
	{
		if(IsDefined(buildable.name) && buildable.name == buildable_name)
		{
			pieces = buildable.buildablepieces;
			for(i = 0; i < pieces.size; i++)
			{
				pieces[i] maps\mp\zombies\_zm_buildables::piece_unspawn();
			}
			return;
		}
	}
}

add_struct( s_struct )
{
	if ( isDefined( s_struct.targetname ) )
	{
		if ( !isDefined( level.struct_class_names[ "targetname" ][ s_struct.targetname ] ) )
		{
			level.struct_class_names[ "targetname" ][ s_struct.targetname ] = [];
		}
		size = level.struct_class_names[ "targetname" ][ s_struct.targetname ].size;
		level.struct_class_names[ "targetname" ][ s_struct.targetname ][ size ] = s_struct;
	}
	if ( isDefined( s_struct.script_noteworthy ) )
	{
		if ( !isDefined( level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ] ) )
		{
			level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ] = [];
		}
		size = level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ].size;
		level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ][ size ] = s_struct;
	}
	if ( isDefined( s_struct.target ) )
	{
		if ( !isDefined( level.struct_class_names[ "target" ][ s_struct.target ] ) )
		{
			level.struct_class_names[ "target" ][ s_struct.target ] = [];
		}
		size = level.struct_class_names[ "target" ][ s_struct.target ].size;
		level.struct_class_names[ "target" ][ s_struct.target ][ size ] = s_struct;
	}
	if ( isDefined( s_struct.script_linkname ) )
	{
		level.struct_class_names[ "script_linkname" ][ s_struct.script_linkname ][ 0 ] = s_struct;
	}
	if ( isDefined( s_struct.script_unitrigger_type ) )
	{
		if ( !isDefined( level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ] ) )
		{
			level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ] = [];
		}
		size = level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ].size;
		level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ][ size ] = s_struct;
	}
}


set_visionset()
{
	self useservervisionset(1);
	self setvisionsetforplayer(getdvar( "mapname" ), 1.0 );
	// visionSetNaked( getdvar( "mapname" ), 1.0 );
	// self setvisionsetforplayer("", 0 );
}

graphic_tweaks()
{
	if( level.script != "zm_tomb")
		self setclientdvar("r_fog", 0.3);

	self setclientdvar("r_dof_enable", 0);
	self setclientdvar("r_lodBiasRigid", -1000); // casues error when nocliping
	self setclientdvar("r_lodBiasSkinned", -1000);
	self setClientDvar("r_lodScaleRigid", 1);
	self setClientDvar("r_lodScaleSkinned", 1);
	self setclientdvar("sm_sunquality", 2);
	self setclientdvar("r_enablePlayerShadow", 1);
	self setclientdvar( "vc_fbm", "0 0 0 0" );
	self setclientdvar( "vc_fsm", "1 1 1 1" );
	self setclientdvar( "vc_fgm", "1 1 1 1" );
	// self setclientdvar( "r_skyColorTemp", 25000 );
}

night_mode()
{
	if ( !isDefined( self.night_mode ) )
	{
		self.night_mode = true;
	}
	else
	{
		return;
	}

	flag_wait( "start_zombie_round_logic" );
	wait 0.05;	

	self thread night_mode_watcher();
}

night_mode_watcher()
{	
	if( getdvar( "night_mode") == "" )
		setDvar( "night_mode", 0 );

	wait 1;

	while(1)
	{
		while( !getdvarint( "night_mode" ) )
		{
			wait 0.1;
		}
		self thread enable_night_mode();
		self thread visual_fix();

		while( getdvarint( "night_mode" ) )
		{
			wait 0.1;
		}
		self thread disable_night_mode();
	}
}

enable_night_mode()
{
	if( !isDefined( level.default_r_exposureValue ) )
		level.default_r_exposureValue = getdvar( "r_exposureValue" );
	if( !isDefined( level.default_r_lightTweakSunLight ) )
		level.default_r_lightTweakSunLight = getdvar( "r_lightTweakSunLight" );
	if( !isDefined( level.default_r_sky_intensity_factor0 ) )
		level.default_r_sky_intensity_factor0 = getdvar( "r_sky_intensity_factor0" );
	// if( !isDefined( level.default_r_sky_intensity_factor0 ) )
	// 	level.default_r_lightTweakSunColor = getdvar( "r_lightTweakSunColor" );

	//self setclientdvar( "r_fog", 0 );
	self setclientdvar( "r_filmUseTweaks", 1 );
	self setclientdvar( "r_bloomTweaks", 1 );
	self setclientdvar( "r_exposureTweak", 1 );
	self setclientdvar( "vc_rgbh", "0.07 0 0.25 0" );
	self setclientdvar( "vc_yl", "0 0 0.25 0" );
	self setclientdvar( "vc_yh", "0.015 0 0.07 0" );
	self setclientdvar( "vc_rgbl", "0.015 0 0.07 0" );
	self setclientdvar( "vc_rgbh", "0.015 0 0.07 0" );
	self setclientdvar( "r_exposureValue", 3.9 );
	self setclientdvar( "r_lightTweakSunLight", 16 );
	self setclientdvar( "r_sky_intensity_factor0", 3 );
	//self setclientdvar( "r_lightTweakSunColor", ( 0.015, 0, 0.07 ) );
	if( level.script == "zm_buried" )
	{
		self setclientdvar( "r_exposureValue", 4 );
	}
	else if( level.script == "zm_tomb" )
	{
		self setclientdvar( "r_exposureValue", 4 );
	}
	else if( level.script == "zm_nuked" )
	{
		self setclientdvar( "r_exposureValue", 5.6 );
	}
	else if( level.script == "zm_highrise" )
	{
		self setclientdvar( "r_exposureValue", 3 );
	}
}

disable_night_mode()
{
	self notify( "disable_nightmode" );
	//self setclientdvar( "r_fog", 1 );
	self setclientdvar( "r_filmUseTweaks", 0 );
	self setclientdvar( "r_bloomTweaks", 0 );
	self setclientdvar( "r_exposureTweak", 0 );
	self setclientdvar( "vc_rgbh", "0 0 0 0" );
	self setclientdvar( "vc_yl", "0 0 0 0" );
	self setclientdvar( "vc_yh", "0 0 0 0" );
	self setclientdvar( "vc_rgbl", "0 0 0 0" );
	self setclientdvar( "r_exposureValue", int( level.default_r_exposureValue ) );
	self setclientdvar( "r_lightTweakSunLight", int( level.default_r_lightTweakSunLight ) );
	self setclientdvar( "r_sky_intensity_factor0", int( level.default_r_sky_intensity_factor0 ) );
	//self setclientdvar( "r_lightTweakSunColor", level.default_r_lightTweakSunColor );
}

visual_fix()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "disable_nightmode" );
	if( level.script == "zm_buried" )
	{
		while( getdvar( "r_sky_intensity_factor0" ) != 0 )
		{	
			self setclientdvar( "r_lightTweakSunLight", 1 );
			self setclientdvar( "r_sky_intensity_factor0", 0 );
			wait 0.05;
		}
	}
	else if( level.script == "zm_prison" || level.script == "zm_tomb" )
	{
		while( getdvar( "r_lightTweakSunLight" ) != 0 )
		{
			for( i = getdvar( "r_lightTweakSunLight" ); i >= 0; i = ( i - 0.05 ) )
			{
				self setclientdvar( "r_lightTweakSunLight", i );
				wait 0.05;
			}
			wait 0.05;
		}
	}
	else return;
}

rotate_skydome()
{
	if ( level.script == "zm_tomb" )
	{
		return;
	}
	
	x = 360;
	
	self endon("disconnect");
	for(;;)
	{
		x -= 0.025;
		if ( x < 0 )
		{
			x += 360;
		}
		self setclientdvar( "r_skyRotation", x );
		wait 0.1;
	}
}

change_skydome()
{
	x = 6500;
	
	self endon("disconnect");
	for(;;)
	{
		x += 1.626;
		if ( x > 25000 )
		{
			x -= 23350;
		}
		self setclientdvar( "r_skyColorTemp", x );
		wait 0.1;
	}
}

eye_color_watcher()
{	
	if( getdvar( "eye_color") == "" )
		setDvar( "eye_color", 0 );

	wait 1;

	while(1)
	{
		while( !getdvarint( "eye_color" ) )
		{
			wait 0.1;
		}
		level setclientfield( "zombie_eye_change", 1 );
    	sndswitchannouncervox( "richtofen" );

		while( getdvarint( "eye_color" ) )
		{
			wait 0.1;
		}
		level setclientfield( "zombie_eye_change", 0 );
		sndswitchannouncervox( "sam" );
	}
}


zombie_counter()
{
	self endon("disconnect");

	x = 5;
	y = -119;

	if (level.script == "zm_buried")
	{
		y -= 25;
	}
	else if (level.script == "zm_tomb")
	{
		y -= 60;
	}

	counter = newclienthudelem(self);
	counter.alignx = "left";
	counter.aligny = "middle";
	counter.horzalign = "user_left";
	counter.vertalign = "user_bottom";
	counter.x += x;
	counter.y += y;
	counter.fontscale = 1;
	counter.alpha = 0;
	counter.color = self.mapcolor;
	counter.hidewheninmenu = 1;
	counter.foreground = 1;

	counter thread destroy_on_intermission();

	flag_wait( "initial_blackscreen_passed" );

	while (1)
	{
		level endon("stop_updating_counter");
		zombie_count = get_current_zombie_count();
		if(zombie_count > 0)
		{
			counter setText(zombie_count + " zombies left");
			counter.alpha = 1;
		} 
		else 
		{
			counter setText("waiting for zombies..");
			wait_for_counter_change("stop_updating_counter");
			counter.alpha = 1;
    	}

		counter fadeovertime(4);
		counter.alpha = 0;
		wait 4;
		continue;		
	}
}

wait_for_counter_change(endonNotification)
{ 
    level endon(endonNotification);
    old_zombie_count = get_current_zombie_count();
    while(true)
	{
        new_zombie_count = get_current_zombie_count();
        if(old_zombie_count != new_zombie_count)
		{
            return;
        }
        wait 0.05;
    }
}

destroy_on_intermission()
{
	self endon("death");

	level waittill("intermission");

	if(isDefined(self.elemtype) && self.elemtype == "bar")
	{
		self.bar destroy();
		self.barframe destroy();
	}

	self destroy();
}

shared_box()
{
	level.shared_box = 0;
    add_zombie_hint( "default_shared_box", "Hold ^3&&1^7 for weapon");

	flag_wait( "initial_blackscreen_passed" );
    if( getdvar( "mapname" ) == "zm_nuked" )
    {
        wait 10;
    }
    for(i = 0; i < level.chests.size; i++)
    {
        level.chests[ i ] thread reset_box();
		if(level.chests[ i ].hidden)
    	{
			level.chests[ i ] get_chest_pieces();
    	}
		if(!level.chests[ i ].hidden)
		{
			level.chests[ i ].unitrigger_stub.prompt_and_visibility_func = ::boxtrigger_update_prompt;
		}
	}
}

reset_box()
{
	self notify("kill_chest_think");
    wait .1;
	if(!self.hidden)
    {
		self.grab_weapon_hint = 0;
		self thread maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
    	self.unitrigger_stub run_visibility_function_for_all_triggers();
	}
	self thread custom_treasure_chest_think();
}

get_chest_pieces()
{
	self.chest_box = getent( self.script_noteworthy + "_zbarrier", "script_noteworthy" );
	self.chest_rubble = [];
	rubble = getentarray( self.script_noteworthy + "_rubble", "script_noteworthy" );
	i = 0;
	while ( i < rubble.size )
	{
		if ( distancesquared( self.origin, rubble[ i ].origin ) < 10000 )
		{
			self.chest_rubble[ self.chest_rubble.size ] = rubble[ i ];
		}
		i++;
	}
	self.zbarrier = getent( self.script_noteworthy + "_zbarrier", "script_noteworthy" );
	if ( isDefined( self.zbarrier ) )
	{
		self.zbarrier zbarrierpieceuseboxriselogic( 3 );
		self.zbarrier zbarrierpieceuseboxriselogic( 4 );
	}
	self.unitrigger_stub = spawnstruct();
	self.unitrigger_stub.origin = self.origin + ( anglesToRight( self.angles ) * -22.5 );
	self.unitrigger_stub.angles = self.angles;
	self.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	self.unitrigger_stub.script_width = 104;
	self.unitrigger_stub.script_height = 50;
	self.unitrigger_stub.script_length = 45;
	self.unitrigger_stub.trigger_target = self;
	unitrigger_force_per_player_triggers( self.unitrigger_stub, 1 );
	self.unitrigger_stub.prompt_and_visibility_func = ::boxtrigger_update_prompt;
	self.zbarrier.owner = self;
}

boxtrigger_update_prompt( player )
{
	can_use = self custom_boxstub_update_prompt( player );
	if ( isDefined( self.hint_string ) )
	{
		if ( isDefined( self.hint_parm1 ) )
		{
			self sethintstring( self.hint_string, self.hint_parm1 );
		}
		else
		{
			self sethintstring( self.hint_string );
		}
	}
	return can_use;
}

custom_boxstub_update_prompt( player )
{
    self setcursorhint( "HINT_NOICON" );
    if(!self trigger_visible_to_player( player ))
    {
        if(level.shared_box)
        {
            self setvisibletoplayer( player );
            self.hint_string = get_hint_string( self, "default_shared_box" );
            return 1;
        }
        return 0;
    }
    self.hint_parm1 = undefined;
    if ( isDefined( self.stub.trigger_target.grab_weapon_hint ) && self.stub.trigger_target.grab_weapon_hint )
    {
        if(level.shared_box)
        {
            self.hint_string = get_hint_string( self, "default_shared_box" );
        }    
        else
        {
			if (level.players.size == 1)
			{
				if (isDefined( level.magic_box_check_equipment ) && [[ level.magic_box_check_equipment ]]( self.stub.trigger_target.grab_weapon_name ) )
				{
					self.hint_string = "Hold ^3&&1^7 for Equipment";
				}
				else
				{
					self.hint_string = "Hold ^3&&1^7 for Weapon";
				}
			}
			else
			{
				if (isDefined( level.magic_box_check_equipment ) && [[ level.magic_box_check_equipment ]]( self.stub.trigger_target.grab_weapon_name ) )
				{
					self.hint_string = "Hold ^3&&1^7 for Equipment ^5or ^7Press ^3[{+melee}]^7 to let teammates pick it up";
				}
				else
				{
					self.hint_string = "Hold ^3&&1^7 for Weapon ^5or ^7Press ^3[{+melee}]^7 to let teammates pick it up";
				}
			}
        }
    }
    else
    {
        if ( isDefined( level.using_locked_magicbox ) && level.using_locked_magicbox && isDefined( self.stub.trigger_target.is_locked ) && self.stub.trigger_target.is_locked )
        {
            self.hint_string = get_hint_string( self, "locked_magic_box_cost" );
        }
        else
        {
            self.hint_parm1 = self.stub.trigger_target.zombie_cost;
            self.hint_string = get_hint_string( self, "default_treasure_chest" );
        }
    }
    return 1;
}


custom_treasure_chest_think()
{
    if(!isdefined(level.perk_pick))
    {
        level.perk_pick = 0;
    }
	self endon( "kill_chest_think" );
	user = undefined;
	user_cost = undefined;
	self.box_rerespun = undefined;
	self.weapon_out = undefined;
	self thread unregister_unitrigger_on_kill_think();
	while ( 1 )
	{
		if ( !isdefined( self.forced_user ) )
		{
			self waittill( "trigger", user );
			if ( user == level )
			{
				wait 0.1;
				continue;
			}
		}
		else
		{
			user = self.forced_user;
		}
		if ( user in_revive_trigger() )
		{
			wait 0.1;
			continue;
		}
		if ( user.is_drinking > 0 )
		{
			wait 0.1;
			continue;
		}
		if ( isdefined( self.disabled ) && self.disabled )
		{
			wait 0.1;
			continue;
		}
		if ( user getcurrentweapon() == "none" )
		{
			wait 0.1;
			continue;
		}
		reduced_cost = undefined;
		if ( is_player_valid( user ) && user maps\mp\zombies\_zm_pers_upgrades_functions::is_pers_double_points_active() )
		{
			reduced_cost = int( self.zombie_cost / 2 );
		}
		if ( isdefined( level.using_locked_magicbox ) && level.using_locked_magicbox && isdefined( self.is_locked ) && self.is_locked ) 
		{
			if ( user.score >= level.locked_magic_box_cost )
			{
				user maps\mp\zombies\_zm_score::minus_to_player_score( level.locked_magic_box_cost );
				self.zbarrier set_magic_box_zbarrier_state( "unlocking" );
				self.unitrigger_stub run_visibility_function_for_all_triggers();
			}
			else
			{
				user maps\mp\zombies\_zm_audio::create_and_play_dialog( "general", "no_money_box" );
			}
			wait 0.1 ;
			continue;
		}
		else if ( isdefined( self.auto_open ) && is_player_valid( user ) )
		{
			if ( !isdefined( self.no_charge ) )
			{
				user maps\mp\zombies\_zm_score::minus_to_player_score( self.zombie_cost );
				user_cost = self.zombie_cost;
			}
			else
			{
				user_cost = 0;
			}
			self.chest_user = user;
			break;
		}
		else if ( is_player_valid( user ) && user.score >= self.zombie_cost )
		{
			user maps\mp\zombies\_zm_score::minus_to_player_score( self.zombie_cost );
			user_cost = self.zombie_cost;
			self.chest_user = user;
			break;
		}
		else if ( isdefined( reduced_cost ) && user.score >= reduced_cost )
		{
			user maps\mp\zombies\_zm_score::minus_to_player_score( reduced_cost );
			user_cost = reduced_cost;
			self.chest_user = user;
			break;
		}
		else if ( user.score < self.zombie_cost )
		{
			play_sound_at_pos( "no_purchase", self.origin );
			user maps\mp\zombies\_zm_audio::create_and_play_dialog( "general", "no_money_box" );
			wait 0.1;
			continue;
		}
		wait 0.05;
	}
	flag_set( "chest_has_been_used" );
	maps\mp\_demo::bookmark( "zm_player_use_magicbox", getTime(), user );
	user maps\mp\zombies\_zm_stats::increment_client_stat( "use_magicbox" );
	user maps\mp\zombies\_zm_stats::increment_player_stat( "use_magicbox" );
	if ( isDefined( level._magic_box_used_vo ) )
	{
		user thread [[ level._magic_box_used_vo ]]();
	}
	self thread watch_for_emp_close();
	if ( isDefined( level.using_locked_magicbox ) && level.using_locked_magicbox )
	{
		self thread maps\mp\zombies\_zm_magicbox_lock::watch_for_lock();
	}
	self._box_open = 1;
	level.box_open = 1;
	self._box_opened_by_fire_sale = 0;
	if ( isDefined( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] && !isDefined( self.auto_open ) && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() )
	{
		self._box_opened_by_fire_sale = 1;
	}
	if ( isDefined( self.chest_lid ) )
	{
		self.chest_lid thread treasure_chest_lid_open();
	}
	if ( isDefined( self.zbarrier ) )
	{
		play_sound_at_pos( "open_chest", self.origin );
		play_sound_at_pos( "music_chest", self.origin );
		self.zbarrier set_magic_box_zbarrier_state( "open" );
	}
	self.timedout = 0;
	self.weapon_out = 1;
	self.zbarrier thread treasure_chest_weapon_spawn( self, user );
	self.zbarrier thread treasure_chest_glowfx();
	thread maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( self.unitrigger_stub );
	self.zbarrier waittill_any( "randomization_done", "box_hacked_respin" );
	if ( flag( "moving_chest_now" ) && !self._box_opened_by_fire_sale && isDefined( user_cost ) )
	{
		user maps\mp\zombies\_zm_score::add_to_player_score( user_cost, 0 );
	}
	if ( flag( "moving_chest_now" ) && !level.zombie_vars[ "zombie_powerup_fire_sale_on" ] && !self._box_opened_by_fire_sale )
	{
		self thread treasure_chest_move( self.chest_user );
	}
	else
	{
		self.grab_weapon_hint = 1;
		self.grab_weapon_name = self.zbarrier.weapon_string;
		self.chest_user = user;
		thread maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
		if ( isDefined( self.zbarrier ) && !is_true( self.zbarrier.closed_by_emp ) )
		{
			self thread treasure_chest_timeout();
		}
		timeout_time = 105;
		grabber = user;
		for( i=0;i<105;i++ )
		{
			if(user meleeButtonPressed() && isplayer( user ) && distance(self.origin, user.origin) <= 100)
			{
				fx_obj = spawn( "script_model", self.origin + (0,0,35) );
    			fx_obj setmodel( "tag_origin" );
				Fx_box = loadfx("maps/zombie/fx_zmb_race_trail_grief");
				fx = PlayFXOnTag(Fx_box, fx_obj, "TAG_ORIGIN");
				level.magic_box_grab_by_anyone = 1;
				level.shared_box = 1;
				self.unitrigger_stub run_visibility_function_for_all_triggers();
				for( a=i;a<105;a++ )
				{
					foreach(player in level.players)
					{
						if(player usebuttonpressed() && distance(self.origin, player.origin) <= 100 && isDefined( player.is_drinking ) && !player.is_drinking)
						{
							if(level.box_perks == 0 && level.perk_pick == 1)
                            {
                                player playsound( "zmb_cha_ching" );
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_revive" )
                                {
                                    player thread add_perk("specialty_quickrevive");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_sleight")
                                {
                                    player thread add_perk("specialty_fastreload");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_doubletap" )
                                {
                                    player thread add_perk("specialty_rof");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_jugg")
                                {
                                    player thread add_perk("specialty_armorvest");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_marathon" )
                                {
                                    player thread add_perk("specialty_longersprint");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_tombstone")
                                {
                                    player thread add_perk("specialty_scavenger");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_deadshot" )
                                {
                                    player thread add_perk("specialty_deadshot");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_cherry")
                                {
                                    player thread add_perk("specialty_grenadepulldeath");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_nuke" )
                                {
                                    player thread add_perk("specialty_flakjacket");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_additionalprimaryweapon")
                                {
                                    player thread add_perk("specialty_additionalprimaryweapon");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_vulture" )
                                {
                                    player thread add_perk("specialty_nomotionsensor");
                                }
                                if(self.zbarrier.weapon_string == "zombie_perk_bottle_whoswho")
                                {
                                    player thread add_perk("specialty_finalstand");
                                }
                            }
                            else
                            {
                                player thread treasure_chest_give_weapon( self.zbarrier.weapon_string );
                            }
                            a = 105;
							break;
						}
					}
					wait 0.1;
				}
				break;
			}
			if(grabber usebuttonpressed() && isplayer( grabber ) && user == grabber && distance(self.origin, grabber.origin) <= 100 && isDefined( grabber.is_drinking ) && !grabber.is_drinking)
			{
                if(level.box_perks == 0 && level.perk_pick == 1)
                {
                    grabber playsound( "zmb_cha_ching" );
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_revive" )
                    {
                        grabber thread add_perk("specialty_quickrevive");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_sleight")
                    {
                        grabber thread add_perk("specialty_fastreload");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_doubletap" )
                    {
                        grabber thread add_perk("specialty_rof");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_jugg")
                    {
                        grabber thread add_perk("specialty_armorvest");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_marathon" )
                    {
                        grabber thread add_perk("specialty_longersprint");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_tombstone")
                    {
                        grabber thread add_perk("specialty_scavenger");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_deadshot" )
                    {
                        grabber thread add_perk("specialty_deadshot");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_cherry")
                    {
                        grabber thread add_perk("specialty_grenadepulldeath");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_nuke" )
                    {
                        grabber thread add_perk("specialty_flakjacket");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_additionalprimaryweapon")
                    {
                        grabber thread add_perk("specialty_additionalprimaryweapon");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_vulture" )
                    {
                        grabber thread add_perk("specialty_nomotionsensor");
                    }
                    if(self.zbarrier.weapon_string == "zombie_perk_bottle_whoswho")
                    {
                        grabber thread add_perk("specialty_finalstand");
                    }
                }
				else
                {
                    grabber thread treasure_chest_give_weapon( self.zbarrier.weapon_string );
                }
                break;
			}
			wait 0.1;
		}
		fx_obj delete();
		fx Delete();
		self.weapon_out = undefined;
		self notify( "user_grabbed_weapon" );
		user notify( "user_grabbed_weapon" );
		self.grab_weapon_hint = 0;
		self.zbarrier notify( "weapon_grabbed" );
		if ( isDefined( self._box_opened_by_fire_sale ) && !self._box_opened_by_fire_sale )
		{
			level.chest_accessed += 1;
		}
		if ( level.chest_moves > 0 && isDefined( level.pulls_since_last_ray_gun ) )
		{
			level.pulls_since_last_ray_gun += 1;
		}
		thread maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( self.unitrigger_stub );
		if ( isDefined( self.chest_lid ) )
		{
			self.chest_lid thread treasure_chest_lid_close( self.timedout );
		}
		if ( isDefined( self.zbarrier ) )
		{
			self.zbarrier set_magic_box_zbarrier_state( "close" );
			play_sound_at_pos( "close_chest", self.origin );
			self.zbarrier waittill( "closed" );
			wait 1;
		}
		else
		{
			wait 3;
		}
		if ( isDefined( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] || self [[ level._zombiemode_check_firesale_loc_valid_func ]]() || self == level.chests[ level.chest_index ] )
		{
			thread maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
		}
	}
    level.perk_pick = 0;
	self._box_open = 0;
	level.box_open = 0;
	level.shared_box = 0;
	level.magic_box_grab_by_anyone = 0;
	self._box_opened_by_fire_sale = 0;
	self.chest_user = undefined;
	self notify( "chest_accessed" );
	self thread custom_treasure_chest_think();
}


custom_treasure_chest_think_a()
{
	self endon( "kill_chest_think" );
	user = undefined;
	user_cost = undefined;
	self.box_rerespun = undefined;
	self.weapon_out = undefined;
	self thread unregister_unitrigger_on_kill_think();
	while ( 1 )
	{
		if ( !isdefined( self.forced_user ) )
		{
			self waittill( "trigger", user );
			if ( user == level )
			{
				wait 0.1;
				continue;
			}
		}
		else
		{
			user = self.forced_user;
		}
		if ( user in_revive_trigger() )
		{
			wait 0.1;
			continue;
		}
		if ( user.is_drinking > 0 )
		{
			wait 0.1;
			continue;
		}
		if ( isdefined( self.disabled ) && self.disabled )
		{
			wait 0.1;
			continue;
		}
		if ( user getcurrentweapon() == "none" )
		{
			wait 0.1;
			continue;
		}
		reduced_cost = undefined;
		if ( is_player_valid( user ) && user maps\mp\zombies\_zm_pers_upgrades_functions::is_pers_double_points_active() )
		{
			reduced_cost = int( self.zombie_cost / 2 );
		}
		if ( isdefined( level.using_locked_magicbox ) && level.using_locked_magicbox && isdefined( self.is_locked ) && self.is_locked ) 
		{
			if ( user.score >= level.locked_magic_box_cost )
			{
				user maps\mp\zombies\_zm_score::minus_to_player_score( level.locked_magic_box_cost );
				self.zbarrier set_magic_box_zbarrier_state( "unlocking" );
				self.unitrigger_stub run_visibility_function_for_all_triggers();
			}
			else
			{
				user maps\mp\zombies\_zm_audio::create_and_play_dialog( "general", "no_money_box" );
			}
			wait 0.1 ;
			continue;
		}
		else if ( isdefined( self.auto_open ) && is_player_valid( user ) )
		{
			if ( !isdefined( self.no_charge ) )
			{
				user maps\mp\zombies\_zm_score::minus_to_player_score( self.zombie_cost );
				user_cost = self.zombie_cost;
			}
			else
			{
				user_cost = 0;
			}
			self.chest_user = user;
			break;
		}
		else if ( is_player_valid( user ) && user.score >= self.zombie_cost )
		{
			user maps\mp\zombies\_zm_score::minus_to_player_score( self.zombie_cost );
			user_cost = self.zombie_cost;
			self.chest_user = user;
			break;
		}
		else if ( isdefined( reduced_cost ) && user.score >= reduced_cost )
		{
			user maps\mp\zombies\_zm_score::minus_to_player_score( reduced_cost );
			user_cost = reduced_cost;
			self.chest_user = user;
			break;
		}
		else if ( user.score < self.zombie_cost )
		{
			play_sound_at_pos( "no_purchase", self.origin );
			user maps\mp\zombies\_zm_audio::create_and_play_dialog( "general", "no_money_box" );
			wait 0.1;
			continue;
		}
		wait 0.05;
	}
	flag_set( "chest_has_been_used" );
	maps\mp\_demo::bookmark( "zm_player_use_magicbox", getTime(), user );
	user maps\mp\zombies\_zm_stats::increment_client_stat( "use_magicbox" );
	user maps\mp\zombies\_zm_stats::increment_player_stat( "use_magicbox" );
	if ( isDefined( level._magic_box_used_vo ) )
	{
		user thread [[ level._magic_box_used_vo ]]();
	}
	self thread watch_for_emp_close();
	if ( isDefined( level.using_locked_magicbox ) && level.using_locked_magicbox )
	{
		self thread custom_watch_for_lock();
	}
	self._box_open = 1;
	level.box_open = 1;
	self._box_opened_by_fire_sale = 0;
	if ( isDefined( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] && !isDefined( self.auto_open ) && self [[ level._zombiemode_check_firesale_loc_valid_func ]]() )
	{
		self._box_opened_by_fire_sale = 1;
	}
	if ( isDefined( self.chest_lid ) )
	{
		self.chest_lid thread treasure_chest_lid_open();
	}
	if ( isDefined( self.zbarrier ) )
	{
		play_sound_at_pos( "open_chest", self.origin );
		play_sound_at_pos( "music_chest", self.origin );
		self.zbarrier set_magic_box_zbarrier_state( "open" );
	}
	self.timedout = 0;
	self.weapon_out = 1;
	self.zbarrier thread treasure_chest_weapon_spawn( self, user );
	self.zbarrier thread treasure_chest_glowfx();
	thread maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( self.unitrigger_stub );
	self.zbarrier waittill_any( "randomization_done", "box_hacked_respin" );
	if ( flag( "moving_chest_now" ) && !self._box_opened_by_fire_sale && isDefined( user_cost ) )
	{
		user maps\mp\zombies\_zm_score::add_to_player_score( user_cost, 0 );
	}
	if ( flag( "moving_chest_now" ) && !level.zombie_vars[ "zombie_powerup_fire_sale_on" ] && !self._box_opened_by_fire_sale )
	{
		self thread treasure_chest_move( self.chest_user );
	}
	else
	{
		self.grab_weapon_hint = 1;
		self.grab_weapon_name = self.zbarrier.weapon_string;
		self.chest_user = user;
		thread maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
		if ( isDefined( self.zbarrier ) && !is_true( self.zbarrier.closed_by_emp ) )
		{
			self thread treasure_chest_timeout();
		}
		timeout_time = 105;
		grabber = user;
		for( i=0;i<105;i++ )
		{
			if(user meleeButtonPressed() && isplayer( user ) && distance(self.origin, user.origin) <= 100)
			{
				level.magic_box_grab_by_anyone = 1;
				level.shared_box = 1;
				self.unitrigger_stub run_visibility_function_for_all_triggers();
				for( a=i;a<105;a++ )
				{
					foreach(player in level.players)
					{
						if(player usebuttonpressed() && distance(self.origin, player.origin) <= 100 && isDefined( player.is_drinking ) && !player.is_drinking)
						{
						
							player thread treasure_chest_give_weapon( self.zbarrier.weapon_string );
							a = 105;
							break;
						}
					}
					wait 0.1;
				}
				break;
			}
			if(grabber usebuttonpressed() && isplayer( grabber ) && user == grabber && distance(self.origin, grabber.origin) <= 100 && isDefined( grabber.is_drinking ) && !grabber.is_drinking)
			{
				grabber thread treasure_chest_give_weapon( self.zbarrier.weapon_string );
				break;
			}
			wait 0.1;
		}
		self.weapon_out = undefined;
		self notify( "user_grabbed_weapon" );
		user notify( "user_grabbed_weapon" );
		self.grab_weapon_hint = 0;
		self.zbarrier notify( "weapon_grabbed" );
		if ( isDefined( self._box_opened_by_fire_sale ) && !self._box_opened_by_fire_sale )
		{
			level.chest_accessed += 1;
		}
		if ( level.chest_moves > 0 && isDefined( level.pulls_since_last_ray_gun ) )
		{
			level.pulls_since_last_ray_gun += 1;
		}
		thread maps\mp\zombies\_zm_unitrigger::unregister_unitrigger( self.unitrigger_stub );
		if ( isDefined( self.chest_lid ) )
		{
			self.chest_lid thread treasure_chest_lid_close( self.timedout );
		}
		if ( isDefined( self.zbarrier ) )
		{
			self.zbarrier set_magic_box_zbarrier_state( "close" );
			play_sound_at_pos( "close_chest", self.origin );
			self.zbarrier waittill( "closed" );
			wait 1;
		}
		else
		{
			wait 3;
		}
		if ( isDefined( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] || self [[ level._zombiemode_check_firesale_loc_valid_func ]]() || self == level.chests[ level.chest_index ] )
		{
			thread maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
		}
	}
	self._box_open = 0;
	level.box_open = 0;
	level.shared_box = 0;
	level.magic_box_grab_by_anyone = 0;
	self._box_opened_by_fire_sale = 0;
	self.chest_user = undefined;
	self notify( "chest_accessed" );
	self thread custom_treasure_chest_think();
}

custom_watch_for_lock()
{
    self endon( "user_grabbed_weapon" );
    self endon( "chest_accessed" );
    self waittill( "box_locked" );
    self notify( "kill_chest_think" );
    self.grab_weapon_hint = 0;
    wait 0.1;
    self thread maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( self.unitrigger_stub, ::magicbox_unitrigger_think );
    self.unitrigger_stub run_visibility_function_for_all_triggers();
    self thread custom_treasure_chest_think();
}


change_pap_price()
{
    precachestring(&"ZOMBIE_PERK_PACKAPUNCH");
    precachestring(&"ZOMBIE_PERK_PACKAPUNCH_ATT");
    level waittill( "Pack_A_Punch_on" );

    pap_triggers = getentarray( "specialty_weapupgrade", "script_noteworthy" );
    pap_trigger = pap_triggers[0];
    pap_trigger.cost = 3500;
    pap_trigger sethintstring( &"ZOMBIE_PERK_PACKAPUNCH", pap_trigger.cost ); 
    pap_trigger.attachment_cost = 1750;
    pap_trigger sethintstring( &"ZOMBIE_PERK_PACKAPUNCH", pap_trigger.attatchment_cost ); 
}


change_box_price() //mystery box price
{
	i = 0;
    while (i < level.chests.size)
    {
        level.chests[ i ].zombie_cost = 650;
        level.chests[ i ].old_cost = 650;
        i++;
    }
}

randomintlist(a) 
{
	r = strTok(a, " ");
	random = RandomInt(r.size);
	final = r[random];
	i = int(final);
	return i;
}

cycle_box_price() 
{
	level endon("game_ended");
	level thread new_box_price(750); // init box price before anything 
	level notify("box_fixed");
	for(;;) 
	{
		level waittill("start_of_round");
		prices = randomintlist("250 400 500 550 575 600 650 675 700 750 775 800 825 850 875 885 900 925 950 1000 1250 10000");
		level thread new_box_price(prices);
		level notify("box_fixed");
		wait 1;
	}
}

new_box_price(price)
{
	level endon("box_fixed");
	i = 0;
    while (i < level.chests.size)
    {
        level.chests[ i ].zombie_cost = price;
        level.chests[ i ].old_cost = price;
        i++;
    }
}

disable_high_round_walkers()
{
	level.speed_change_round = undefined;
}

set_anim_pap_camo_dvars()
{
	create_dvar("anim_pap_camo_mob", 1);
	create_dvar("anim_pap_camo_buried", 1);
	create_dvar("anim_pap_camo_origins", 0);
}

perk_machine_quarter_change()
{
	
	if(level.script == "zm_tomb")
		return;
		
	a_triggers = getentarray( "audio_bump_trigger", "targetname" );
	_a43 = a_triggers;
	_k43 = getFirstArrayKey( _a43 );
	while ( isDefined( _k43 ) )
	{
		trigger = _a43[ _k43 ];
		if ( isDefined( trigger.script_sound ) && trigger.script_sound == "zmb_perks_bump_bottle" )
		{
			trigger thread check_for_change();
		}
		_k43 = getNextArrayKey( _a43, _k43 );
	}
}

struct_class_init_o()
{
	level.struct_class_names = [];
	level.struct_class_names[ "target" ] = [];
	level.struct_class_names[ "targetname" ] = [];
	level.struct_class_names[ "script_noteworthy" ] = [];
	level.struct_class_names[ "script_linkname" ] = [];
	level.struct_class_names[ "script_unitrigger_type" ] = [];
	foreach ( s_struct in level.struct )
	{
		if ( isDefined( s_struct.targetname ) )
		{
			if ( !isDefined( level.struct_class_names[ "targetname" ][ s_struct.targetname ] ) )
			{
				level.struct_class_names[ "targetname" ][ s_struct.targetname ] = [];
			}
			size = level.struct_class_names[ "targetname" ][ s_struct.targetname ].size;
			level.struct_class_names[ "targetname" ][ s_struct.targetname ][ size ] = s_struct;
		}
		if ( isDefined( s_struct.target ) )
		{
			if ( !isDefined( level.struct_class_names[ "target" ][ s_struct.target ] ) )
			{
				level.struct_class_names[ "target" ][ s_struct.target ] = [];
			}
			size = level.struct_class_names[ "target" ][ s_struct.target ].size;
			level.struct_class_names[ "target" ][ s_struct.target ][ size ] = s_struct;
		}
		if ( isDefined( s_struct.script_noteworthy ) )
		{
			if ( !isDefined( level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ] ) )
			{
				level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ] = [];
			}
			size = level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ].size;
			level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ][ size ] = s_struct;
		}
		if ( isDefined( s_struct.script_linkname ) )
		{
			level.struct_class_names[ "script_linkname" ][ s_struct.script_linkname ][ 0 ] = s_struct;
		}
		if ( isDefined( s_struct.script_unitrigger_type ) )
		{
			if ( !isDefined( level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ] ) )
			{
				level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ] = [];
			}
			size = level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ].size;
			level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ][ size ] = s_struct;
		}
	}
	location = getdvar( "ui_zm_mapstartlocation" );
	if ( location == "farm" )
	{
		register_perk_struct( "specialty_weapupgrade", "p6_anim_zm_buildable_pap_on", ( 0, 120, 0 ), ( 7764, -6322, 117 ) );
		register_perk_struct( "specialty_scavenger", "zombie_vending_tombstone", ( 0, 3, 0 ), ( 8517, -5599, 50 ) );
		register_perk_struct( "specialty_longersprint", "zombie_vending_marathon", ( 0, 38, 0 ), ( 7057, -5631, -48 ) );
	}
	else if ( location == "transit" )
	{
		register_perk_struct( "specialty_armorvest", "zombie_vending_jugg", ( 0, 180, 0 ), ( -6663, 4592, -55 ) );
		register_perk_struct( "specialty_rof", "zombie_vending_doubletap2", ( 0, 227, 0 ), ( -6026, 4188, -41 ) );
		register_perk_struct( "specialty_longersprint", "zombie_vending_marathon", ( 0, 175, 0 ), ( -7426, 4147, -63 ) );
		register_perk_struct( "specialty_scavenger", "zombie_vending_tombstone", ( 0, 136, 0 ), ( -8098, 4467, -48 ) );
		register_perk_struct( "specialty_weapupgrade", "p6_anim_zm_buildable_pap_on", ( 0, 213, 0), ( 9960, -1288, -217 ) );
		register_perk_struct( "specialty_quickrevive", "zombie_vending_quickrevive", ( 0, 175, 0 ), ( -6719, 4996, -55 ) );
		register_perk_struct( "specialty_fastreload", "zombie_vending_sleight", ( 0, 85, 0 ), ( -6304, 5470, -55 ) );
	}
}

register_perk_struct( perk_name, perk_model, perk_angles, perk_coordinates )
{
	if ( getdvar( "g_gametype" ) == "zgrief" && perk_name == "specialty_scavenger" )
	{
		return;
	}
	perk_struct = spawnStruct();
	perk_struct.script_noteworthy = perk_name;
	perk_struct.model = perk_model;
	perk_struct.angles = perk_angles;
	perk_struct.origin = perk_coordinates;
	perk_struct.targetname = "zm_perk_machine";
	add_struct( perk_struct );
}

get_pack_a_punch_weapon_options_override( weapon ) //checked changed to match cerberus output
{
	if ( !isDefined( self.pack_a_punch_weapon_options ) )
	{
		self.pack_a_punch_weapon_options = [];
	}
	if ( !is_weapon_upgraded( weapon ) )
	{
		return self calcweaponoptions( 0, 0, 0, 0, 0 );
	}
	if ( isDefined( self.pack_a_punch_weapon_options[ weapon ] ) )
	{
		return self.pack_a_punch_weapon_options[ weapon ];
	}
	smiley_face_reticle_index = 1;
	base = get_base_name( weapon );
	camo_index = 39;
	if ( level.script == "zm_prison" && getdvarint("anim_pap_camo_mob") )
	{
		camo_index = 40;
	}
	else if ( level.script == "zm_buried" && getdvarint("anim_pap_camo_buried") )
	{
		camo_index = 40;
	}
	else if ( level.script == "zm_tomb" )
	{
		if( getdvarint("anim_pap_camo_origins") == 1 )
			camo_index = 40;
		if( getdvarint("anim_pap_camo_origins") == 2 )
			camo_index = 39;
		else
			camo_index = 45;
	}
	lens_index = randomintrange( 0, 6 );
	reticle_index = randomintrange( 0, 16 );
	reticle_color_index = randomintrange( 0, 6 );
	plain_reticle_index = 16;
	r = randomint( 10 );
	use_plain = r < 3;
	if ( base == "saritch_upgraded_zm" )
	{
		reticle_index = smiley_face_reticle_index;
	}
	else if ( use_plain )
	{
		reticle_index = plain_reticle_index;
	}
	scary_eyes_reticle_index = 8;
	purple_reticle_color_index = 3;
	if ( reticle_index == scary_eyes_reticle_index )
	{
		reticle_color_index = purple_reticle_color_index;
	}
	letter_a_reticle_index = 2;
	pink_reticle_color_index = 6;
	if ( reticle_index == letter_a_reticle_index )
	{
		reticle_color_index = pink_reticle_color_index;
	}
	letter_e_reticle_index = 7;
	green_reticle_color_index = 1;
	if ( reticle_index == letter_e_reticle_index )
	{
		reticle_color_index = green_reticle_color_index;
	}
	self.pack_a_punch_weapon_options[ weapon ] = self calcweaponoptions( camo_index, lens_index, reticle_index, reticle_color_index );
	return self.pack_a_punch_weapon_options[ weapon ];
}

weapon_give_override( weapon, is_upgrade, magic_box, nosound ) //checked changed to match cerberus output
{
	primaryweapons = self getweaponslistprimaries();
	current_weapon = self getcurrentweapon();
	current_weapon = self maps\mp\zombies\_zm_weapons::switch_from_alt_weapon( current_weapon );
	if ( !isDefined( is_upgrade ) )
	{
		is_upgrade = 0;
	}
	weapon_limit = get_player_weapon_limit( self );
	if ( is_equipment( weapon ) )
	{
		self maps\mp\zombies\_zm_equipment::equipment_give( weapon );
	}
	if ( weapon == "riotshield_zm" )
	{
		if ( isDefined( self.player_shield_reset_health ) )
		{
			self [[ self.player_shield_reset_health ]]();
		}
	}
	if ( self hasweapon( weapon ) )
	{
		if ( issubstr( weapon, "knife_ballistic_" ) )
		{
			self notify( "zmb_lost_knife" );
		}
		self givestartammo( weapon );
		if ( !is_offhand_weapon( weapon ) )
		{
			self switchtoweapon( weapon );
		}
		return;
	}
	if ( is_melee_weapon( weapon ) )
	{
		current_weapon = maps\mp\zombies\_zm_melee_weapon::change_melee_weapon( weapon, current_weapon );
	}
	else if ( is_lethal_grenade( weapon ) )
	{
		old_lethal = self get_player_lethal_grenade();
		if ( isDefined( old_lethal ) && old_lethal != "" )
		{
			self takeweapon( old_lethal );
			unacquire_weapon_toggle( old_lethal );
		}
		self set_player_lethal_grenade( weapon );
	}
	else if ( is_tactical_grenade( weapon ) )
	{
		old_tactical = self get_player_tactical_grenade();
		if ( isDefined( old_tactical ) && old_tactical != "" )
		{
			self takeweapon( old_tactical );
			unacquire_weapon_toggle( old_tactical );
		}
		self set_player_tactical_grenade( weapon );
	}
	else if ( is_placeable_mine( weapon ) )
	{
		old_mine = self get_player_placeable_mine();
		if ( isDefined( old_mine ) )
		{
			self takeweapon( old_mine );
			unacquire_weapon_toggle( old_mine );
		}
		self set_player_placeable_mine( weapon );
	}
	if ( !is_offhand_weapon( weapon ) )
	{
		self maps\mp\zombies\_zm_weapons::take_fallback_weapon();
	}
	if ( primaryweapons.size >= weapon_limit )
	{
		if ( is_placeable_mine( current_weapon ) || is_equipment( current_weapon ) )
		{
			current_weapon = undefined;
		}
		if ( isDefined( current_weapon ) )
		{
			if ( !is_offhand_weapon( weapon ) )
			{
				if ( current_weapon == "tesla_gun_zm" )
				{
					level.player_drops_tesla_gun = 1;
				}
				if ( issubstr( current_weapon, "knife_ballistic_" ) )
				{
					self notify( "zmb_lost_knife" );
				}
				self takeweapon( current_weapon );
				unacquire_weapon_toggle( current_weapon );
			}
		}
	}
	if ( isDefined( level.zombiemode_offhand_weapon_give_override ) )
	{
		if ( self [[ level.zombiemode_offhand_weapon_give_override ]]( weapon ) )
		{
			return;
		}
	}
	if ( weapon == "cymbal_monkey_zm" )
	{
		self maps\mp\zombies\_zm_weap_cymbal_monkey::player_give_cymbal_monkey();
		self play_weapon_vo( weapon, magic_box );
		return;
	}
	else if ( issubstr( weapon, "knife_ballistic_" ) )
	{
		weapon = self maps\mp\zombies\_zm_melee_weapon::give_ballistic_knife( weapon, issubstr( weapon, "upgraded" ) );
	}
	else if ( weapon == "claymore_zm" )
	{
		self thread maps\mp\zombies\_zm_weap_claymore::claymore_setup();
		self play_weapon_vo( weapon, magic_box );
		return;
	}
	if ( isDefined( level.zombie_weapons_callbacks ) && isDefined( level.zombie_weapons_callbacks[ weapon ] ) )
	{
		self thread [[ level.zombie_weapons_callbacks[ weapon ] ]]();
		play_weapon_vo( weapon, magic_box );
		return;
	}
	if ( !is_true( nosound ) )
	{
		self play_sound_on_ent( "purchase" );
	}
	if ( weapon == "ray_gun_zm" )
	{
		playsoundatposition( "mus_raygun_stinger", ( 0, 0, 0 ) );
	}
	if ( !is_weapon_upgraded( weapon ) )
	{
		self giveweapon( weapon );
	}
	else
	{
		self giveweapon( weapon, 0, self get_pack_a_punch_weapon_options( weapon ) );
	}
	acquire_weapon_toggle( weapon, self );
	self givestartammo( weapon );
	if ( !is_offhand_weapon( weapon ) )
	{
		if ( !is_melee_weapon( weapon ) )
		{
			self switchtoweapon( weapon );
		}
		else
		{
			self switchtoweapon( current_weapon );
		}
	}
	if( weapon == "blundersplat_upgraded_zm" )
	{
		self setweaponammostock( "blundersplat_upgraded_zm", 100 );
	}
	else if( weapon == "blundersplat_zm" )
	{
		self setweaponammostock( "blundersplat_zm", 100 );
	}

	if ( self hasweapon( "blundergat_upgraded_zm" ) )
	{
		self setweaponammostock( "blundergat_upgraded_zm", 80 );
	}
	else if ( self hasweapon( "blundergat_zm" ) )
	{
		self setweaponammostock( "blundergat_zm", 80 );
	}

	self play_weapon_vo( weapon, magic_box );
}

check_for_change()
{
	while ( 1 )
	{
		self waittill( "trigger", e_player );
		if ( e_player getstance() == "prone" )
		{

			check = randomintrange( 150, 700 );
			change = check;	
			e_player maps\mp\zombies\_zm_score::add_to_player_score( change );
			e_player thread imsg( "Discovered " + "$" + change + " on the ground!");
			play_sound_at_pos( "purchase", e_player.origin );
			return;
		}
		else
		{
			wait 0.1;
		}
	}
}

check_for_change_o()
{
	while ( 1 )
	{
		self waittill( "trigger", e_player );
		if ( e_player getstance() == "prone" )
		{
			check = randomintrange( 150, 700 );
			change = check;	
			e_player maps\mp\zombies\_zm_score::add_to_player_score( change );
			e_player thread imsg( "Discovered " + "$" + change + " on the ground!");
			play_sound_at_pos( "purchase", e_player.origin );
			return;
		}
		else
		{
			wait 0.1;
		}
	}
}


turn_perks_on()
{
	flag_wait( "start_zombie_round_logic" );
	wait 1;
	level notify( "revive_on" );
	wait_network_frame();
	level notify( "doubletap_on" );
	wait_network_frame();
	level notify( "marathon_on" );
	wait_network_frame();
	level notify( "juggernog_on" );
	wait_network_frame();
	level notify( "sleight_on" );
	wait_network_frame();
	level notify( "tombstone_on" );
	wait_network_frame();
	level notify( "Pack_A_Punch_on" );
}
