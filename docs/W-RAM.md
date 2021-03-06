W-RAM
=====

W-RAM (work RAM) is the SNES onboard memory. 128 kB (131072 bytes) big, it's clocked at 2.68 MHz and can be accessed though addresses`$7E:0000-$7F:FFFF`, as well on addresses`$0000-$1FFF`though banks`$00-$3F`/`$80-$BF`and though ports`$2180-$2183`on the address bus B. The SA-1 CPU can't access the W-RAM.

SA-1 Pack moves most of the W-RAM addresses to either I-RAM or BW-RAM to make the contents accessible and faster for the SA-1 system. Because of that, a good portion of the W-RAM is either left unused or modified for another cause which does not involve SA-1 CPU access.

### Code Memory
The patch places some routines on the W-RAM for several reasons, but the most important of them is to allow that SA-1 CPU will always access the ROM memory at 10.74 MHz when the SNES CPU is idle or busy doing a process that does not need ROM access.

### W-RAM Memory Map
Only modified W-RAM addresses are displayed on this document. For checking other SMW addresses, look for the SMW Central RAM map.

#### Bank $7E
Start  |  End  | Description
:-----:|:-----:|-------------
`$0000`|`$000F`| Scratch Memory. Some codes does not use the I-RAM at all for certain reasons, such as for executing code on the memory. FuSoYa's SA-1 version of LC_LZ2 and LC_LZ3 implementation are examples of that. The reason of that is ZSNES. See [Known Issues](known-issues.md) to understand why.
`$0010`|`$0FFF`| Empty. Not cleared.
`$1000`|`$1E7F`| Empty. Not cleared. **Reserved by SA-1 Pack for future expansion.**
`$1D00`|`-`| **IRQ-as-NMI system (`x------e`)** <ul><li>Bit 0 (e): When set, the V-Blank routine is moved to an IRQ and NMI is disabled.</li><li>Bit 7 (x): When set, the next IRQ will be the V-Blank routine. Used internally when`e`is set.</li></ul>
`$1D01`|`-`| Which scanline should the V-Blank run when`$1D00`is set.
`$1D02`|`-`| Custom IRQ handler flag. If set, all IRQs, with exception of IRQ-as-NMI handler will run on the pointer located at`$1D04-$1D06`instead of running on the regular SMW IRQ handelr.
`$1D03`|`-`| Copy of the register`$2224`. When setting`$2224`, make sure to set this address as well. This address is used to restore the`$2224`register value after an IRQ is executed.
`$1D04`|`$1D06`| Custom IRQ handler pointer. All IRQs will jump to this pointer when`$1D02`is set.
`$1D07`|`-`| Reserved for future use.
`$1D08`|`$1DFF`| This is where the IRQ controller is uploaded at game reset and is responsible for controlling all S-CPU IRQs received. Calling`$1D08`activates the IRQ-as-NMI system on the next IRQ call, if enabled.
`$1E00`|`$1E7F`| Empty. Not cleared. **Reserved by SA-1 Pack for future expansion.**
`$1E80`|`$1E8D`| SA-1 Execute Pointer. When called, the routine will invoke the SA-1 CPU to run a certain code and wait until the execution is finished.
`$1E8E`|`$1E95`| The game main loop. It waits for a NMI and then resumes executing.
`$1E96`|`$1EA6`| The wait for H-Blank routine. Waits until h-blank starts. When the emulator is ZSNES, this routine is replaced with a special version.
`$1EA7`|`$1EFF`| Empty. Not cleared. **Reserved by SA-1 Pack for future expansion.**
`$1F00`|`$1FFF`| Reserved for the SNES CPU stack.
`$2000`|`$C7FF`| Untouched by SA-1 Pack.
`$C800`|`$FFFF`| Empty. Not cleared. **Reserved by SA-1 Pack for future expansion.**

#### Bank $7F
Start  |  End  | Description
:-----:|:-----:|-------------
`$0000`|`$9A7A`| Untouched by SA-1 Pack.
`$9A7B`|`$9C7A`| Empty. Not cleared.
`$9C7B`|`$C7FF`| Untouched by SA-1 Pack.
`$C800`|`$FFFF`| Empty. Not cleared. **Reserved by SA-1 Pack for future expansion.**