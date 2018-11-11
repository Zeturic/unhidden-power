### Unhidden Power

This routine makes the game calculate and display the actual type of Hidden Power in battle and in status screens. If, for example, a Pokémon's Hidden Power type is Water, it will display as a Water-type move, just like Surf or any other Water-type move.

![](in-battle.png)
![](status-screen.png)

#### How do I insert this?

First, open `unhidden-power.asm` in a text editor to customize it. Tweak the definition of `rom` to fit your ROM's filename, and `free_space` should be where you want the code inserted. You'll need `180` bytes starting from a word aligned offset (read: an offset ending in `0`, `4`, `8`, or `C`). 

If the array of move data - in a vanilla game, located at `0x08250C04` - has been repointed, update the definition of `moves`.

This is optional and entirely aesthetic, but you can choose to have Hidden Power updated to be a `???`-type TM instead of a `Normal`-type TM by changing `change_hp_static_type` from `false` to `true`. There's no associated Pokémon, so the TM Case will retain whatever Hidden Power's "static type" happens to be.

You'll need to have [armips](https://github.com/Kingcom/armips).

Once you're ready, assemble with `armips unhidden-power.asm`. It'll insert the code directly into your ROM.