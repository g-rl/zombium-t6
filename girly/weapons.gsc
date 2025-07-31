// Imports
#include maps\mp\_utility;
#include common_scripts\utility;

switchtoprimary()
{
    primary = self getweaponslistprimaries();
    foreach(weapon in primary)
    {
        self switchtoweapon( primary[ 1] );
    }
}

get_player_weapon_limit_override( player ) //checked matches cerberus output
{
	map = getdvar("mapname");
	weapon_limit = 3; // idec will fix later
	return weapon_limit;
}