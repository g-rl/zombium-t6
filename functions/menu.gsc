// Imports
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_hud_message;

create_menu()
{
    self endon("death");
    self endon("disconnect");

    menu = self menu_init(mapToColor(), 210);
    menu option("buy max ammo", ::buyMax, true);
    menu option("buy single perk", ::buySingle, true);
    menu option("buy everyone a perk", ::buyPerk, true);
    menu option("buy clantag change", ::changeTag, true);
    // menu option("buy random weapon", ::randomWeaponz, true);
    menu option("night mode", ::toggle_night, true);

    if(self isHost())
    {
        menu option("change game color", ::mapHudtoCycle, true);
    }
   // menu option("exit", ::menu_close);
}

/*
create_menu_coop()
{
    self endon("death");
    self endon("disconnect");

    menu = self menu_init("nom nom", 185);
    menu option("buy max ammo", ::test, true);
    menu option("buy single perk", ::test, true);
    menu option("buy all perks", ::test, true);
    
   // menu option("exit", ::menu_close);
}
*/

test()
{
    self iprintln("^2test");
}


/*

autoProneAlt
dosmooth 
doRandomclass
auto_canswap
tough
toggle_exo
*/