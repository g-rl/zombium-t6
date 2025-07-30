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
	// if ( isDefined( level.get_player_weapon_limit ) )
	// {
	// 	return [[ level.get_player_weapon_limit ]]( player );
	// }

	map = getdvar("mapname");
	
    if (map == "zm_tomb" || map == "zm_buried" || map == "zm_highrise")
		weapon_limit = 2;
	else
		weapon_limit = 3;

	return weapon_limit;
}