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
#include scripts\zm\girly\commands;
#include scripts\zm\girly\func;
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
/*

Button Codes:

if (self sprintbuttonpressed()) self iprintln("SPRINT");
if (self inventorybuttonpressed()) self iprintln("INVENTORY");
if (self secondaryoffhandbuttonpressed()) self iprintln("[{+smoke}]");
if (self fragbuttonpressed()) self iprintln("[{+frag}]");
if (self stancebuttonpressed()) self iprintln("[{+stance}]");
if (self jumpbuttonpressed()) self iprintln("[{+gostand}]");
if (self meleebuttonpressed()) self iprintln("[{+melee}]");
if (self adsbuttonpressed()) self iprintln("[{+speed_throw}]");
if (self actionslotfourbuttonpressed()) self iprintln("[{+actionslot 4}]");
if (self actionslotthreebuttonpressed()) self iprintln("[{+actionslot 3}]");
if (self actionslottwobuttonpressed()) self iprintln("[{+actionslot 2}]");
if (self actionslotonebuttonpressed()) self iprintln("[{+actionslot 1}]");
if (self attackbuttonpressed()) self iprintln("[{+attack}]");
if (self changeseatbuttonpressed()) self iprintln("[{+switchseat}]");
if (self usebuttonpressed()) self iprintln("[{+usereload}]");

Less than: <
Greater than: >
Less than or equal to: <=
Greater than or equal to: >=
Equal to: ==
Not equal to: !=

*/

/*
watch_active_shield()
{
    if (self maps\mp\zombies\_zm_equipment::is_equipment_active("tomb_shield_zm") == 1)
        self.has_riot = 1;
    else
        self.has_riot = 0;

    self thread watch_shield();
}

watch_shield()
{
    self endon("shield_broken");
    self endon("disconnect");
    for(;;)
    {
        if (self maps\mp\zombies\_zm_equipment::is_equipment_active("tomb_shield_zm") == false && self.has_riot == 0)
        {
            self.has_riot = 0;
            self iprintlnbold("your shield ^1broke");
            self notify("shield_broken");
        }
        wait 0.2;
    }
}

shield_check()
{
    self endon("disconnect");

    for(;;)
    {
        if (self maps\mp\zombies\_zm_equipment::is_equipment_active("tomb_shield_zm") == 1)
        {
            self.has_riot = 1;
            print("watching shield");
        }
        wait 0.5;
    }
}
*/

actor_killed_override(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime)
{
    thread [[level.callbackactorkilled_og]](einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime);
    attacker thread draw_killtext();
}

draw_killtext() //Rank Up System (Text) Made By ZECxR3ap3r & John Kramer (Project / Custom Map Nacht)
{
    if ( isdefined( self.xp_score ) )
    {
        self notify( "added_score" );
        self.xp_hint destroy();
        self.xp_score += 75;
    }
    else
        self.xp_score = 75;
    self endon( "added_score" );
    self.xptext = "+" + self.xp_score + " XP^7 ";
    self.xp_hint = newclienthudelem( self );
    self.xp_hint.x = 40;
    self.xp_hint.y = -25;    
    self.xp_hint.alignx = "left";
    self.xp_hint.aligny = "top";
    self.xp_hint.horzalign = "center";
    self.xp_hint.vertalign = "middle";
    self.xp_hint.archived = 0;
    self.xp_hint.foreground = 0;
    self.xp_hint.fontscale = 2;
    self.xp_hint.sort = 16;
    self.xp_hint.alpha = 0;
	self.xp_hint.glowColor = (0.275,0.271,0.255);
	self.xp_hint.glowAlpha = 0.03;
    self.xp_hint.color = ( self.mapcolor );
    self.xp_hint.hidewheninmenu = 1;
    self.xp_hint.hidewhendead = 1;
    self.xp_hint.font = "objective";
    self.xp_hint_text = self.xptext + "Zombie Elimination";
    self.xp_hint settext( self.xp_hint_text );
    self.xp_hint changefontscaleovertime( 0.25 );
    self.xp_hint fadeovertime( 0.25 );
    self.xp_hint.alpha = 1;
    self.xp_hint.fontscale = 1;
    wait 1.35;
    self.xp_hint fadeovertime( 0.25 );
    self.xp_hint.alpha = 0;
    wait .25;
    self.xp_hint destroy();
    self.xp_score destroy();
    self.xp_score = undefined;
}

tomb_upgrades()
{
    if (getdvar("mapname") != "zm_tomb")
        return;
        
    foreach (player in level.players)
    {
        i = player getentitynumber() + 1;
        level setclientfield( "shovel_player" + i, 2 );
        level setclientfield( "helmet_player" + i, 1 );
        player.dig_vars["has_upgraded_shovel"] = 1;
        player.dig_vars["has_helmet"] = 1;
        player.dig_vars["has_shovel"] = 1;
    }
}

zm_override()
{
	gametype = getDvar("g_gametype");
	location = getDvar("ui_zm_mapstartlocation");
    map = getDvar("mapname");

/*
	replacefunc(maps\mp\zombies\_zm_spawner::should_attack_player_thru_boards, ::should_attack_player_thru_boards);
	replaceFunc( maps\mp\zombies\_zm_powerups::full_ammo_powerup, ::full_ammo_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_weapons::ammo_give, ::ammo_give_override );
	replaceFunc( maps\mp\zombies\_zm_magicbox::treasure_chest_canplayerreceiveweapon, ::treasure_chest_canplayerreceiveweapon_override);
	replaceFunc( maps\mp\zombies\_zm_magicbox::treasure_chest_weapon_spawn, ::treasure_chest_weapon_spawn_override );
	replaceFunc( maps\mp\zombies\_zm_magicbox::treasure_chest_move, ::treasure_chest_move_override );
	replaceFunc( maps\mp\zombies\_zm_utility::set_run_speed, ::set_run_speed_override );
	replaceFunc( maps\mp\zombies\_zm_spawner::zombie_rise_death, ::zombie_rise_death_override );
	replaceFunc( maps\mp\zombies\_zm::round_think, ::round_think_override );
	replaceFunc( maps\mp\zombies\_zm::ai_calculate_health, ::ai_calculate_health_override );
	replacefunc(maps\mp\zombies\_zm::ai_calculate_health, ::ai_calculate_health);
	replacefunc(maps\mp\zombies\_zm_perks::use_solo_revive, ::use_solo_revive);
	replacefunc(maps\mp\zombies\_zm_utility::init_zombie_run_cycle, ::init_zombie_run_cycle);
	replaceFunc( maps\mp\zombies\_zm_powerups::nuke_powerup, ::nuke_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::double_points_powerup, ::double_points_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::insta_kill_powerup, ::insta_kill_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::insta_kill_on_hud, ::insta_kill_on_hud_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::powerup_drop, ::powerup_drop_override );
*/
    replacefunc(maps\mp\zombies\_zm_spawner::should_attack_player_thru_boards, ::should_attack_player_thru_boards);
	replaceFunc( maps\mp\zombies\_zm_powerups::free_perk_powerup, ::free_perk_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_weapons::get_pack_a_punch_weapon_options, ::get_pack_a_punch_weapon_options_override );
	replaceFunc( maps\mp\zombies\_zm_weapons::weapon_give, ::weapon_give_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::powerup_drop, ::powerup_drop_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::get_next_powerup, ::get_next_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::insta_kill_powerup, ::insta_kill_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::insta_kill_on_hud, ::insta_kill_on_hud_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::double_points_powerup, ::double_points_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::point_doubler_on_hud, ::point_doubler_on_hud_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::full_ammo_powerup, ::full_ammo_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::free_perk_powerup, ::free_perk_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_powerups::nuke_powerup, ::nuke_powerup_override );
	replaceFunc( maps\mp\zombies\_zm_utility::set_run_speed, ::set_run_speed_override );
	replaceFunc( maps\mp\zombies\_zm_spawner::zombie_rise_death, ::zombie_rise_death_override );
	replaceFunc( maps\mp\zombies\_zm::round_think, ::round_think_override );
	replaceFunc( maps\mp\zombies\_zm::ai_calculate_health, ::ai_calculate_health_override );
	//replaceFunc( maps\mp\zombies\_zm_pers_upgrades_functions::pers_nube_should_we_give_raygun, ::pers_nube_should_we_give_raygun_override );
	replaceFunc( maps\mp\zombies\_zm_utility::disable_player_move_states, ::disable_player_move_states_override );
	replaceFunc( maps\mp\zombies\_zm_weapons::ammo_give, ::ammo_give_override );
	replaceFunc( maps\mp\zombies\_zm_score::add_to_player_score, ::add_to_player_score_override );
	replaceFunc( maps\mp\zombies\_zm_magicbox::treasure_chest_canplayerreceiveweapon, ::treasure_chest_canplayerreceiveweapon_override);
	replaceFunc( maps\mp\zombies\_zm_magicbox::treasure_chest_weapon_spawn, ::treasure_chest_weapon_spawn_override );
	replaceFunc( maps\mp\zombies\_zm_magicbox::treasure_chest_move, ::treasure_chest_move_override );
    replaceFunc( maps\mp\zombies\_zm_utility::get_player_weapon_limit, ::get_player_weapon_limit_override );


	if (gametype == "zstandard" || gametype == "zgrief")
	{
		if (location == "farm" || location == "transit")
		{
            replaceFunc( common_scripts\utility::struct_class_init, ::struct_class_init_o );
            level thread turn_perks_on();
		}
	}
}

name_status()
{

	level.mvp = array( "cmysx", "devandre", "girly182376", "TeenageRapist36", "pussyniggaswag", "qzs", "wtch", "tuil" );

    sp();

    /*
    arr = [];
    status = isinarray(arr, self.name);

    switch(status)
    {
        case level.mvp:
            self.mystatus = "mvp";
            self.mystatuscolor = "^6mvp";
            break;
        case level.vip:
            self.mystatus = "vip";
            self.mystatuscolor = "^2vip";
            break;
        case level.debugger:
            self.mystatus = "debugger";
            self.mystatuscolor = "^5debugger";
            break;
        default:
            self.mystatus = "player";
            self.mystatuscolor = "^3player";
            break;
    }
    
    */
	if ( IsInArray(level.mvp, self.name)) 
	{
        self.mystatus = "mvp";
        self.mystatustocolor = "^6mvp";
		
		pr("your status: " + self.mystatustocolor);

	} else if ( IsInArray(level.vip, self.name)) 
	{
        self.mystatus = "vip";
        self.mystatustocolor = "^2vip";
		
		pr("your status: " + self.mystatustocolor);	

	} else if ( IsInArray(level.debugger, self.name)) 
	{
        self.mystatus = "debugger";
        self.mystatustocolor = "^5debugger";
		
		pr("your status: " + self.mystatustocolor);


	} else { 
        
        self.mystatus = "player";
        self.mystatustocolor = "^3player";
		
		pr("your status: " + self.mystatustocolor);
	}

    idle(2);
}

sp()
{
    self iprintln(" ");
    self iprintln(" ");
    self iprintln(" ");
    self iprintln(" ");
    self iprintln(" ");
    self iprintln(" ");
}

button(convert)
{
    if (convert == "melee" || convert == "knife")
    {
        return "[{+melee}]";

    } else if (convert == "aim" || convert == "zoom" || convert == "ads") {

        return "[{+speed_throw}]";

    } else if (convert == "fire" || convert == "shoot") {

        return "[{+attack}]";

    } else if (convert == "reload" || convert == "use" || convert == "x") {

        return "[{+usereload}]";

    } else if (convert == "up") {

        return "[{+actionslot 1}]";

    } else if (convert == "down") {

        return "[{+actionslot 2}]";

    } else if (convert == "left") {

        return "[{+actionslot 3}]";

    } else if (convert == "right") {

        return "[{+actionslot 4}]";
    
    }
 
}

status(boo)
{   

    if (boo == 1)
    {
        return " ^2enabled";

    } else if (boo == 2) {

        return " ^6disabled";

    } else if (boo == 3) {

        return " is now ^6enabled";

    } else if (boo == 4) {

        return " is now ^6disabled";

    } else if (boo == 5) {

        return " is ^1unable^7 to be used right now";
        
    } else if (boo == 6) {

        return " ^6complete";
    }

}

waitframe()
{
	wait 0.05;
}

pressed(button)
{
    if (button == "ADS")
    {
        ads = self adsbuttonpressed();
        return ads;
    } 
    
    else if (button == "UP")
    {
        up = self actionslotonebuttonpressed();
        return up;
    }
    else if (button == "DOWN")
    {
        down = self actionslottwobuttonpressed();
        return down;
    }
    else if (button == "LEFT")
    {
        left = self actionslotthreebuttonpressed();
        return left; 
    }
    else if (button == "RIGHT")
    {
        right = self actionslotfourbuttonpressed();
        return right;
    }
    else if (button == "X")
    {
        x = self usebuttonpressed();
        return x;
    }
    else if (button == "SHOOT" || button == "FIRE")
    {
        shoot = self attackbuttonpressed();
        return shoot;
    }
}

/*

singleMonitor() {
    self endon("disconnect");
    self endon("game_ended");
    self endon("death");

    for(;;) {
        if (self getStance() == "prone") {
            if (pressed("UP")) {                                                         Was using this on MP, keep incase.
                self thread refillammo();
                self playsound("wpn_weap_pickup_plr");
                wait 0.25;
            }
        
        }

        wait .01;
    }
}

*/


bind_monitor() {
    self endon("disconnect");
    self endon("game_ended");
    self endon("death");

    for(;;) {
        if (self getStance() == "crouch") {
            if (pressed("UP")) { 

                self thread locationfinder();
                idle(2);
            }
            else if (pressed("DOWN")) { 
                self thread drop_weapons();
                idle(2);
            }
            else if (pressed("LEFT")) { 
                self thread toggle_exo();
                idle(2);
            }
            else if (pressed("RIGHT")) { 
             //   self iprintln(button("right") + " test" + status(6));
            }
        
        }

        wait .01;
    }
}

d(aw,bg)
{
	setdvar(aw,bg);
}

idle(seconds)
{
    wait seconds;
}


//                                       Not really sure if this is setting up correctly.
//                                       * It was - 3/30/23



pr(talking)
{
    self iPrintLn("[^3zombium^7] " + talking);
}

gp(talking)
{
    iprintln(talking);
}

gpb(talking)
{
    iprintlnbold(talking);
}

pb(talking)
{
    self iprintlnbold(talking);
}

create_dvar( dvar, set )
{
    if ( getDvar( dvar ) == "" )
		setDvar( dvar, set );
}

//




menu_init(title, width)
{

	self endon("death");
    
    menu = spawnstruct();

    menu.open = true;
    menu.user = self;
    menu.width = width;
    menu.items = [];
    menu.base = menu menu_init_item(title, 0);
    menu.selected = 0;


	self.colorlist = strTok(
        "amethyst default green violet pink neon bleeding bubblegum coolblue maroon treegreen army", 
        " ");
    
	self.colorand = RandomInt(self.colorlist.size);
	self.colors = self.colorlist[self.colorand];
	
	if (self.colors == "amethyst")
	{

    menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.729, 0.506, 0.835);

	} else if (self.colors == "default")
	{
    
    // misty color
    menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.702, 0.302, 0.322);

	} else if (self.colors == "green")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.392, 0.753, 0.659);
	} else if (self.colors == "violet")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.365, 0.196, 0.471);
	} else if (self.colors == "pink")
	{
	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.906, 0.196, 0.471);
	} else if (self.colors == "neon")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.384, 1, 0.471);
	} else if (self.colors == "bleeding")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.667, 0, 0.216);
	} else if (self.colors == "bubblegum")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (1, 0.69, 0.855);

	} else if (self.colors == "coolblue")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0, 0.392, 0.608);
	} else if (self.colors == "yellow")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (1, 1, 0);
	} else if (self.colors == "maroon")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.557, 0.278, 0.325);
	} else if (self.colors == "treegreen")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.114, 0.8, 0.325);

	} else if (self.colors == "army")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (0.114, 0.392, 0.337);
    
	} else if (self.colors == "lemonade")
	{

	menu.inactive_color = (0, 0, 0);
    menu.active_color = (1, 1, 0.537);
}
    

    menu thread closeMenuOnDeath();
    menu thread menu_control();
    menu thread menu_monitor_openclose();
    menu thread menu_monitor_destroy();

    return menu;
}

closeMenuOnDeath()
{
	self endon("disconnect");
	level endon("game_ended");
	for (;;)
	{
		self waittill("death");
        self notify("destroy_menu");
	}
}

menu_close()
{
    self notify("close_menu");
}

menu_destroy()
{
    self notify("destroy_menu");
}

menu_init_item(name, offset)
{
    text = self.user createfontstring("objective", 1);
    text setpoint("TOPCENTER", "TOPCENTER", 0, 0);
    text settext(name);
    shader = self.user render_create_shader("white", self.width, text.height, self.inactive_color, 0.28, -1);
    shader setpoint("TOPCENTER", "TOPCENTER", 0, offset);

    text setparent(shader);
    if (!self.open)
        shader render_hide_elem();

    return shader;
}

option(name, func, use_player)
{
    idx = self.items.size;

    self.items[idx] = spawnstruct();

    self.items[idx].item = self menu_init_item(name, (idx + 1) * self.base.height);
    self.items[idx].item setparent(self.base);

    if (idx == self.selected)
        self.items[idx].item.color = self.active_color;

    self.items[idx].func = func;
    self.items[idx].use_player = use_player;
}

addpage(name, func)
{
    self option(name, func);

    self.items[self.items.size - 1].is_menu = true;
}

menu_control()
{
    self endon("destroy_menu");
    self.user endon("disconnect");

    for (;;)
    {
        wait 0.05;

        self menu_control_open();
        
        if (!self.open)
            continue;

        self menu_control_close();
        self menu_control_scroll();
        self menu_control_item();
    }
}

menu_control_open()
{
    if (!self.open && self.user adsbuttonpressed() && self.user meleebuttonpressed())
        self notify("open_menu");
}

menu_control_close()
{
    if (self.open && self.user meleebuttonpressed())
        self notify("close_menu");
}

menu_control_scroll()
{
    up = self.user actionslotonebuttonpressed();
    down = self.user actionslottwobuttonpressed();
    if (up || down)
    {
        self.items[self.selected].item.color = self.inactive_color;

        if (down)
        {
            self.selected += 1;
            if (self.selected >= self.items.size)
                self.selected = 0;
        }
        else
        {
            self.selected -= 1;
            if (self.selected < 0)
                self.selected = self.items.size - 1;
        }

        self.items[self.selected].item.color = self.active_color;
    }
}

menu_control_item()
{
    if (!self.user usebuttonpressed())
        return;

    // not the best solution but meh
    while (self.user usebuttonpressed())
        wait 0.05;

    item = self.items[self.selected];
    if (!isdefined(item.is_menu))
    {
        if (!isdefined(item.use_player))
            self thread [[item.func]]();
        else
            self.user thread [[item.func]]();
    }
    else
    {
        self.user thread [[item.func]]();
        self menu_destroy();
    }
}

menu_monitor_openclose()
{
    self endon("destroy_menu");
    self.user endon("disconnect");

    for (;;)
    {
        if (!self.open)
        {
            self waittill("open_menu");
            self.base render_show_elem();
            self.open = true;
        }

        self waittill("close_menu");
        self.base render_hide_elem();
        self.open = false;
    }
}

menu_monitor_destroy()
{
    self.user endon("disconnect");

    self waittill("destroy_menu");
    self.base render_destroy_elem();
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
    hud = createservertimer("objective", 1);

    hud.alignx = alignx;
    hud.aligny = aligny;
    hud.horzalign = horzalign;
    hud.vertalign = vertalign;
    hud.foreground = true;

    return hud;
}

render_player_timer(alignx, aligny, horzalign, vertalign)
{
    hud = self createclienttimer("objective", 1);

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

