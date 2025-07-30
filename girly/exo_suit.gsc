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
#include scripts\zm\girly\match;
#include scripts\zm\girly\player;
#include scripts\zm\girly\zombie;
#include scripts\zm\girly\powerups;
#include scripts\zm\girly\overflow_fix;
#include scripts\zm\girly\hud;
#include scripts\zm\girly\map;
#include scripts\zm\girly\menu;
#include scripts\zm\girly\weapons;

toggle_exo()
{
	if(!isDefined(self.exosuits))
	{
		self.exosuits = true;
		self thread exo_suit();
		self thread imsg("exo suits ^6enabled");

	} else if(isDefined(self.exosuits))
	{

		self.exosuits = undefined;
		self thread imsg("exo suits ^6disabled");
		self notify("stop_exo");
	}
}



exo_suit()
{
	self endon("disconnect");
	level endon("end_game");

	self endon("stop_exo");
	self.sprint_boost = 0;
	self.jump_boost = 0;
	self.slam_boost = 0;
	self.exo_boost = 100;
	self thread monitor_exo_boost();
	while(1)
	{
		if( !self IsOnGround() )
		{
			if(self JumpButtonPressed() || self SprintButtonPressed())
			{
				wait_network_frame();
				continue;
			}
			self.sprint_boost = 0;
			self.jump_boost = 0;
			self.slam_boost = 0;
			while( !self IsOnGround() )
			{
				if( self JumpButtonPressed() && self.jump_boost < 1 && self.exo_boost >= 20 )
				{
					self.is_flying_jetpack = true;
					self.jump_boost++;
					angles = self getplayerangles();
					angles = (0,angles[1],0);
					
					self.loop_value = 2;
					
					if( IsDefined(self.loop_value))
					{
						Earthquake( 0.22, .9, self.origin, 850 );
						direction = AnglesToUp(angles) * 500;
						self thread land();
						for(l = 0; l < self.loop_value; l++)
						{
							self SetVelocity( (self GetVelocity()[0], self GetVelocity()[1], 0) + direction );
							wait_network_frame();
						}
					}
					self.exo_boost -= 20;
					self thread monitor_exo_boost();
				}
				if( self SprintButtonPressed() && self.sprint_boost < 1 && self.exo_boost >= 20 )
				{
					self.is_flying_jetpack = true;
					self.sprint_boost++;
					xvelo = self GetVelocity()[0];
					yvelo = self GetVelocity()[1];
					l = Length((xvelo, yvelo, 0));
					if(l < 10)
						continue;
					if(l < 190)
					{
						xvelo = int(xvelo * 190/l);
						yvelo = int(yvelo * 190/l);
					}

					Earthquake( 0.22, .9, self.origin, 850 );
					if(self.jump_boost == 1)
						boostAmount = 2.25;
					else
						boostAmount = 3;
					self thread land();
					self SetVelocity( (xvelo * boostAmount, yvelo * boostAmount, self GetVelocity()[2]) );
					self.exo_boost -= 20;
					self thread monitor_exo_boost();
					while( !self isOnGround() )
						wait .05;
				}
				if( self StanceButtonPressed() && self.jump_boost > 0 && self.slam_boost < 1 && self HasPerk("specialty_rof") && self.exo_boost >= 30)
				{
					self.slam_boost++;
					self SetVelocity((self GetVelocity()[0], self GetVelocity()[1], -200));
					self thread land();
					self.exo_boost -= 30;
					self thread monitor_exo_boost();
				}
				wait_network_frame();
			}
			if(self.slam_boost > 0)
			{
				self EnableInvulnerability();
				RadiusDamage( self.origin, 200, 3000, 500, self, "MOD_GRENADE_SPLASH" );
				self DisableInvulnerability();
				self PlaySound( "zmb_phdflop_explo" );
				fx = loadfx("explosions/fx_default_explosion");
				playfx( fx, self.origin );
			}
		}
		wait_network_frame();
	}
}

monitor_exo_boost()
{
	self endon("disconnect");
	self notify("boostMonitor");
	self endon("boostMonitor");
	while(1)
	{
		while(self.exo_boost >= 100)
		{
			wait_network_frame();
		}
		wait 3;
		while(self.exo_boost < 100)
		{
			self.exo_boost += 5;
			wait 0.25;
		}
	}
}

land()
{
	self endon("disconnect");
	while( !self IsOnGround() )
		wait_network_frame();
	self.is_flying_jetpack = false;
}
