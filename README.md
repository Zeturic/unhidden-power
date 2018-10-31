## Unhidden Power

This routine makes the game calculate and display the actual type of Hidden Power in battle and in status screens. If, for example, a Pokémon's Hidden Power type is Water, it will display as an Water-type move in the same way as Surf or any other Water-type move.

![](in-battle.png)
![](status-screen.png)

### How do I build this?

If the array of move data - in a vanilla game, located at `0x08250C04` - has been repointed, update the definition of `moves` in `constants.s`.

This is optional and entirely aesthetic, but you can choose to have Hidden Power updated to be a `???`-type TM instead of a `Normal`-type TM by uncommenting out the definition of `change_hp_static_type` in `constants.s`. There's no associated Pokémon, so the TM Case will retain whatever Hidden Power's "static type" happens to be.

You will need to set an `ARMIPS` environment variable pointing to your `armips.exe`. You also need a `DEVKITARM` environment pointing to devkitARM v45's installation directory (likely `C:\devkitPro\devkitARM`).

Python 3.6 or later is required.

Place your ROM in the project root directory and name it `rom.gba`. Run `python scripts/makinoa`. Your output is `test.gba`; `rom.gba` will be left unmodified.