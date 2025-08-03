// includes
#include maps\mp\_utility;
#include common_scripts\utility;

// custom includes
#include scripts\zm\girly\girly;
#include scripts\zm\girly\match;
#include scripts\zm\girly\player;
#include scripts\zm\girly\func;
#include scripts\zm\girly\powerups;
#include scripts\zm\girly\overflow_fix;
#include scripts\zm\girly\zombie;
#include scripts\zm\girly\hud;
#include scripts\zm\girly\map;
#include scripts\zm\girly\weapons;
#include scripts\zm\girly\aat;
#include scripts\zm\girly\menu;
#include scripts\zm\girly\commands;
#include scripts\zm\girly\exo_suit;

/*
	survival refactor - 7/27/25
	code is super messy and i wanna work on this again
*/

main()
{	
	// disabled in motd because afterlife doesnt work with it 
	if(getdvar("mapname") != "zm_prison")
		maps\mp\zombies\_zm::register_player_damage_callback(::player_aat_damage_respond); // moved to main from init because of it not loading in origins

	maps\mp\zombies\_zm_spawner::register_zombie_damage_callback(::aat_zombie_damage_response);
}

init()
{
	level.last_update = "august 1st 2025";
	// aat settings
    maps\mp\zombies\_zm_utility::onplayerconnect_callback(::watch_weapon_changes); 
    thread new_pap_trigger(); 
	thread overflow_fix(); // hud updates a lot
	thread init_powerups(); // custom powerups
	level._poi_override = ::turned_zombie; // allow turned zombies
    
	// game settings & killtext stuff
    level.perk_purchase_limit = 20; // max perk limit
  	level.claymores_max_per_player = 35; // change claymore limit
    level.player_out_of_playable_area_monitor = false; // dont monitor oom
    level.player_too_many_weapons_monitor = false; // dont monitor weapon limit
	level.round_think_func = ::round_think;
    level.callbackactorkilled_og = level.callbackactorkilled;
    level.callbackactorkilled = ::actor_killed_override; 
	
	// sliquifer and staffs in box
	level.zombie_include_weapons["slipgun_zm"] = 1;
	level.zombie_include_weapons["staff_air_zm"] = 1;
	level.zombie_include_weapons["staff_fire_zm"] = 1;
	level.zombie_include_weapons["staff_lightning_zm"] = 1;
	level.zombie_include_weapons["staff_water_zm"] = 1;

	// remove shitty weapons
	level.zombie_include_weapons["saritch_zm"] = 0; // remove smr completely
	level.zombie_include_weapons["m32_zm"] = 0; // remove war machine completely
	level.zombie_include_weapons["usrpg_zm"] = 0; // remove rpg completely
	level.zombie_include_weapons["emp_grenade_zm"] = 0; // remove rpg completely

	// add these weapons to box
	level.zombie_weapons["slipgun_zm"].is_in_box = 1;
	level.zombie_weapons["staff_air_zm"].is_in_box = 1;
	level.zombie_weapons["staff_fire_zm"].is_in_box = 1;
	level.zombie_weapons["staff_lightning_zm"].is_in_box = 1;
	level.zombie_weapons["staff_water_zm"].is_in_box = 1;
	level.zombie_weapons["sticky_grenade_zm"].is_in_box = 1;
	level.zombie_weapons["bowie_knife_zm"].is_in_box = 1;
	level.zombie_weapons["knife_ballistic_bowie_zm"].is_in_box = 1;

	// remove shitty weapons from box
	level.zombie_weapons["saritch_zm"].is_in_box = 0; // remove smr from box
	level.zombie_weapons["m32_zm"].is_in_box = 0; // remove war machine from box
	level.zombie_weapons["usrpg_zm"].is_in_box = 0; // remove rpg from box
	level.zombie_weapons["emp_grenade_zm"].is_in_box = 0; // remove emps from box

	// zombies spawn right away
	level.zombie_vars["zombie_spawn_delay"] = 0;
	level.zombie_vars["zombie_between_round_time"] = 0;

	// prepatch sliquifer
	level.zombie_vars["slipgun_max_kill_round"] = undefined;
	level.zombie_vars["slipgun_reslip_rate"] = 0;

	// change jug max health
	level.zombie_vars["zombie_perk_juggernaut_health"] = 300;
	level.zombie_vars["zombie_use_failsafe"] = 0;

	// increase limit for powerup drops
	level.zombie_vars["zombie_powerup_drop_max_per_round"] = 12;

	set_zombie_var("zombie_use_failsafe", 0);
	set_zombie_var("zombie_powerup_drop_max_per_round", 12);
	
	level.limited_weapons = []; // everyone can get wonder weapons
	level._limited_equipment = []; // everyone can get equipment
	level.power_on = 1; // power is always on
	level.a_e_slow_areas = []; // no mud slowdown on origins
	// level.custom_magic_box_timer_til_despawn = ::time_until_despawn; // weapons dont disappear out of box
	level.revive_trigger_should_ignore_sight_checks = ::revive_trigger_should_ignore_sight_checks;
	level thread on_player_connect();
    level thread fake_hitmarkers();
	level thread cycle_box_price(); // cycle random box price
	level thread setup_commands(); // command system (prefix is .)
	level thread shared_box(); // allows for other people to pickup weapons
	level thread new_round_hud();
	level thread perk_machine_quarter_change(); // prone for perk points
	level thread turn_on_powerr(); // always turn on power
	level thread powerup_drop_override(); // higher chance to drop powerups
	level thread fake_reset(); // reset game after 12h
	level thread transit_power(); // remove lava pools & turn on power
	level thread eye_color_watcher(); // watch zombie eye colors
	if (getdvar("mapname") != "zm_buried") // dont init night mode on buried cause its way too dark
		level thread night_mode();

	// unused for now
	// level thread zombie_total(); // 24 zombies allowed to spawn at once
	// level thread coop_pause(); // allows pausing game with multiple people (doesnt work rn)

	// thread everything just in case cause shits trippin
    thread zm_override(); // override base game functions
    thread init_dvars(); // dvar settings
    thread init_wallbuy_changes(); // edit wallbuys
	thread wallbuy_dynamic_radius(); // change wallbuy radius
    thread phd_flopper_dmg_check(); // watch phd dive damage
	thread disable_high_round_walkers(); // self explanitory
	thread set_anim_pap_camo_dvars(); // motd camo on buried
	thread electric_trap_damage(); // increase electric trap damage

	// automatically build everything except for plane parts (motd)
	flag_wait( "start_zombie_round_logic" );
	wait 0.05;
	level thread buildbuildables();
	level thread buildcraftables();
}

on_player_connect()
{
	level endon("game_ended");
    for(;;)
    {
		level waittill("connected", player);

		player thread on_player_spawned();
		player thread on_player_downed(); // watch downs
		player thread on_player_revived(); // watch revives
		player thread weapon_inspect_watcher(); // weapon inspects
		player thread phd_diving(); // custom phd diving
		// player thread exo_suit();
    }
}

on_player_spawned()
{
	level endon("game_ended");
	self endon("disconnect");

    self.first = true;

    for(;;)
    {
        self waittill("spawned_player");
        self thread player_setup();
		flag_wait("initial_blackscreen_passed");
        self thread perk_setup();
		self thread ammo_setup();
    }
}

player_setup()
{
	map = getdvar("mapname");

	self thread init_client_dvars();
	self thread disable_player_quotes(); // disable annoying voice lines
	self thread max_ammo_refill_clip(); // bo4 max ammo
	self thread map_colors(); // colors for hud
	self thread perk_points(); // give points when drinking perks
	self thread war_machine_explode_on_impact(); // better war machine
	self thread faster_grenades(); // faster grenade explosions
	self thread give_starting_points(); // random starting points
	self thread set_persistent_stats(); // give all perma perks
	self thread better_nukes(randomint(24,35)); // give more points from nukes
	// self thread rapid_fire(); // rapid fire for all guns
	// self thread bind_monitor(); // for location pinging / dropping weapons

	// set extra perks
	self thread speed_perks();
	self thread jugg_perks();
	self thread staminup_perks();

	// save & give back mule kick weapons
	self thread weapon_locker_give_ammo_after_rounds();
	self thread additionalprimaryweapon_save_weapons();
	self thread additionalprimaryweapon_restore_weapons();
	self thread additionalprimaryweapon_indicator();
	self thread additionalprimaryweapon_stowed_weapon_refill();

	if (isdefined(self.first) && self.first)
	{
		self thread dont_move_box();
		self thread startup_vars();
		self thread timer_hud(); // total game time timer
		self thread zombie_counter(); // zombie counter
		self thread graphic_tweaks();
		self thread night_mode();
		self thread rotate_skydome();
		self thread welcome_message();
	}
	self thread first_free_perks();
	self thread map_settings(map);
}

startup_vars()
{
	// main vars
	// exo suit stuff (unused for now)
	// self.sprint_boost = 0;
	// self.jump_boost = 0;
	// self.slam_boost = 0;
	// self.exo_boost = 100;
	// self.exosuits = true; 
	self.hasPHD = true;
	self.colorcycles = 1;
	self.statusicon = "";
	self.ignore_lava_damage = 1; // dont do lava damage

	// setup clantags and health stuff
	random_color = randomintrange( 2, 6 );
	colors = random_color;
	clantags = strTok("bdnK  zmb  kta  #wdn  buford  xd  34  1c  k2  swag  zZz  yo  zombie  ai  3arc  bot  mama  gg  xo  papa  baka  wdn  bdn  2", "  "); // Rewrite later 
	choice = randomint(clantags.size);
	clantag = "^" + colors + clantags[choice];
	self.clantag = clantag;
	self.clantag_color = "^" + colors;

	// health settings
	starting_health = randomintrange(125, 180);
	health = starting_health;
	self.myhealth = health;
	self.first = false;
	self setnormalhealth(health);
	self setmaxhealth(health);
	self.health = health;

	self iprintln(self.clantag_color + "@nyli2b");
	self iprintln("last update: " + self.clantag_color + level.last_update);

	if (self ishost())
		self thread start_custom_powerups();
}

map_settings(map)
{
	self thread name_status(); // check status
	switch(map)
	{
		case "zm_tomb": // origins
			self thread carpenter_repair_shield(); // carpenter repairs shield
			self thread tomb_give_shovel(); // auto give golden shovel and helmet
			self thread electric_cherry_unlimited(); // electric cherry on every reload
			self iprintln("[^3zombium^7] loaded 3 settings for ^5origins");
			break;
		case "zm_prison": // motd
			self thread give_tomahwak(); // auto give hells redeemer after 20ish seconds
			self thread electric_cherry_unlimited(); // electric cherry on every reload
			self thread afterlife(); // afterlife hand model at all times
			self iprintln("[^3zombium^7] loaded 3 settings for ^1motd");
			break;
		case "zm_buried":
			self iprintln("[^3zombium^7] no special settings loaded for ^3buried");
			break;
		case "zm_highrise":
			self iprintln("[^3zombium^7] no special settings loaded for ^2die rise");
			break;
		default:
			break;
	}
}

ammo_setup()
{
	weaps = self getweaponslist(1);
	foreach(weap in weaps)
	{
		self givemaxammo(weap);
	}
}

dont_move_box()
{
	self endon("disconnect");
	level endon("game_ended");
	level endon("end_game");

	for(;;)
	{
		// dont move box
		self.chest_moving = 0;
		self.chest_moves = 0;
		self.zbarrier.chest_moving = 0;
		wait 0.5;
	}
}