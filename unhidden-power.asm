.include "config.s"
.include "labels.s"
.include "constants.s"

// -----------------------------------------------------------------------------

.gba
.thumb

.open input_rom, output_rom, 0x08000000

// -----------------------------------------------------------------------------

.org free_space
.align 2

MoveSelectionDisplayMoveType_hook:

@@main:                                 // r1 := move_id
    push {r3-r7}
    mov r7, lr

    lsl r0, r1, #2
    lsl r1, r1, #3
    add r0, r1                        // r0 := sizeof(move_t) * move_id
    ldr r1, =gBattleMovesPtr
    ldr r1, [r1]
    add r1, r0                        // [r1] := data for current move
    ldrb r0, [r1, #2]                // r0 := recorded type

    ldrb r2, [r1, #0]                // r2 := move effect id
    cmp r2, #EFFECT_HIDDEN_POWER
    bne @@return

    ldrb r0, [r5]                    // r0 := slot
    lsl r0, #1                        // r0 := slot << 1
    ldr r1, =gBattlerPartyIndexes
    add r0, r1
    ldrb r0, [r0]                    // r0 := index in party
    mov r1, #100
    mul r0, r1                        // r0 := offset from gPlayerParty
    ldr r1, =gPlayerParty
    add r0, r1                        // [r0] := pokemon

    bl hp_type_decode

@@return:
    mov lr, r7
    pop {r3-r7}
    ldr r1, =MoveSelectionDisplayMoveType_hook_return |1
    bx r1

// -----------------------------------------------------------------------------

sub_81367E8_hook:

@@main:                               // r2, r5 := move_id, moves
    push {r0, r3-r7}
    mov r7, lr

    lsl r0, r2, #2
    lsl r1, r2, #3
    add r0, r1                        // r0 := 12 * move_id
    add r0, r5                        // [r0] := data for current move

    ldrb r1, [r0, #2]                // r1 := type
    ldrb r2, [r0, #0]                // r2 := effect_id
    cmp r2, #EFFECT_HIDDEN_POWER
    bne @@return

    ldr r0, =sMonSummaryScreen
    ldr r0, [r0]
    ldr r1, =0x3290
    add r0, r1                        // [r0] := pokemon
    bl hp_type_decode
    mov r1, r0

@@return:
    mov lr, r7
    pop {r0, r3-r7}
    ldr r2, =sub_81367E8_hook_return |1
    bx r2

// -----------------------------------------------------------------------------

// u8 hp_type_decode(struct Pokemon *)
hp_type_decode:

@@main:
    push {r4-r7, lr}
    mov r6, r0                                    // [r6] := pokemon
    mov r4, #0                                    // r4 := type calculation
    mov r7, #0                                    // r7 := iv index
    ldr r5, =GetMonData |1

@@loop:
    mov r0, r6                                    // [r0] := pokemon
    mov r1, #0x27                                // GET_HP_IV
    add r1, r7
    bl @@call
    mov r1, #1
    and r0, r1                                  // r0 := LSB of IV
    lsl r0, r7
    orr r4, r0
    add r7, #1

@@test:
    cmp r7, #6
    bne @@loop

@@floor:
    mov r0, #15
    mul r0, r4
    mov r1, #63
    swi #0x6

@@decode:                        // add 2 if below 8, 1 otherwise
    cmp r0, #8
    blo @@L1
    add r0, #1

@@L1:
    add r0, #1
    pop {r4-r7, pc}

@@call:
    bx r5

.pool

// -----------------------------------------------------------------------------

.org 0x08030984
    ldr r0, =MoveSelectionDisplayMoveType_hook |1
    bx r0
    .pool

.org 0x081368CC
    ldr r1, =sub_81367E8_hook |1
    bx r1
    .pool

// -----------------------------------------------------------------------------

.if change_hp_static_type
    .org readu32(input_rom, gBattleMovesPtr & 0x1FFFFFF) + 0xED * 12 +2
    .byte 0x9
.endif

// -----------------------------------------------------------------------------

.close
