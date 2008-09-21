From: Meelis Roos <mroos@linux.ee>
Date: Sun, 21 Sep 2008 19:06:58 +0000
Subject: Re: [PATCH]: Fix disappearing PCI devices (was Re: psycho_irq_build:
Message-Id: <Pine.SOC.4.64.0809212204350.16701@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20080920.220442.07327164.davem@davemloft.net>
In-Reply-To: <20080920.220442.07327164.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Anyways, this patch below should fix the bug.  Let me know if it works.

Unfortunately it does not work. Here is "of_debug=3 debug" dmesg:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.2.30 2002/10/25 14:03'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Linux version 2.6.27-rc6 (mroos@korvits) (gcc version 4.3.2 (Debian 4.3.2-1) ) #304 SMP Sun Sep 21 18:50:26 EEST 2008
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:b6:ee:e2
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /central@1f,0/fhc@0,f8800000/zs@0,902000:a
[    0.000000] PROM: Built device tree with 97707 bytes of memory.
[    0.000000] Top of RAM: 0x4fcfa000, Total RAM: 0x4f8d6000
[    0.000000] Memory hole size: 4MB
[    0.000000] [0000000200000000-fffff80000c00000] page_structs1072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80001000000] page_structs1072 node=0 entry=1/0
[    0.000000] [0000000200800000-fffff80001400000] page_structs1072 node=0 entry=2/0
[    0.000000] [0000000200800000-fffff80001800000] page_structs1072 node=0 entry=3/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00027e7d
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00027bef
[    0.000000]     0: 0x00027e00 -> 0x00027e72
[    0.000000]     0: 0x00027e73 -> 0x00027e7d
[    0.000000] On node 0 totalpages: 162923
[    0.000000]   Normal zone: 161646 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CENTRAL: Detected 5 slot Enterprise system. cfreg[68] cver[78]
[    0.000000] FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
[    0.000000] FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
[    0.000000] FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
[    0.000000] FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 161646
[    0.000000] Kernel command line: root=/dev/sda2 ro of_debug=3 debug
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[28000] shift[16]
[    0.000000] clockevent: mult[66666666] shift[32]
[  136.171889] Console: colour dummy device 80x25
[  136.224965] console handover: boot [earlyprom0] -> real [tty0]
[  136.306044] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[  136.315038] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[  136.378199] Memory: 1278400k available (2680k kernel code, 1024k data, 152k init) [fffff80000000000,000000004fcfa000]
[  136.378481] SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[  136.525006] Calibrating delay using timer specific routine.. 801.82 BogoMIPS (lpj@09106)
[  136.525356] Mount-cache hash table entries: 512
[  136.530978] CPU 7: synchronized TICK with master CPU (last diff -2 cycles, maxerr 681 cycles)
[  136.531043] Brought up 2 CPUs
[  136.532847] net_namespace: 1504 bytes
[  136.534105] NET: Registered protocol family 16
[  136.538950] /memory reg[0] -> 0
[  136.538980] /memory reg[1] -> 40000000
[  136.539638] /central reg[0] -> 1ff00000000
[  136.539992] /central/fhc@0,f8800000 reg[0] -> 1fff8800000
[  136.540042] /central/fhc@0,f8800000 reg[1] -> 1fff8802000
[  136.540089] /central/fhc@0,f8800000 reg[2] -> 1fff8804000
[  136.540137] /central/fhc@0,f8800000 reg[3] -> 1fff8806000
[  136.540184] /central/fhc@0,f8800000 reg[4] -> 1fff8808000
[  136.540232] /central/fhc@0,f8800000 reg[5] -> 1fff880a000
[  136.540616] /central/fhc@0,f8800000/eeprom@0,908000 reg[0] -> 1fff8908000
[  136.540698] /central/fhc@0,f8800000/eeprom@0,908000: Apply IRQ trans [/central/fhc@0,f8800000] 3a --> 1
[  136.541108] /central/fhc@0,f8800000/zs@0,902000 reg[0] -> 1fff8902000
[  136.541188] /central/fhc@0,f8800000/zs@0,902000: Apply IRQ trans [/central/fhc@0,f8800000] 39 --> 2
[  136.541594] /central/fhc@0,f8800000/zs@0,904000 reg[0] -> 1fff8904000
[  136.541672] /central/fhc@0,f8800000/zs@0,904000: Apply IRQ trans [/central/fhc@0,f8800000] 39 --> 2
[  136.542091] /central/fhc@0,f8800000/clock-board@0,900000 reg[0] -> 1fff8900000
[  136.542176] /central/fhc@0,f8800000/clock-board@0,900000 reg[1] -> 1fff8906000
[  136.542259] /central/fhc@0,f8800000/clock-board@0,900000 reg[2] -> 1fff890c000
[  136.542353] /central/fhc@0,f8800000/clock-board@0,900000: Apply IRQ trans [/central/fhc@0,f8800000] 38 --> 3
[  136.542765] /fhc reg[0] -> 1ccf8800000
[  136.542809] /fhc reg[1] -> 1ccf8802000
[  136.542851] /fhc reg[2] -> 1ccf8804000
[  136.542892] /fhc reg[3] -> 1ccf8806000
[  136.542934] /fhc reg[4] -> 1ccf8808000
[  136.542976] /fhc reg[5] -> 1ccf880a000
[  136.543342] /fhc/ac@0,1000000 reg[0] -> 1ccf9000000
[  136.543401] /fhc/ac@0,1000000 reg[1] -> 1ccfa000000
[  136.543767] /fhc/simm-status@0,600000 reg[0] -> 1ccf8600000
[  136.544140] /fhc/environment@0,400000 reg[0] -> 1ccf8400000
[  136.544584] /fhc/sram@0,200000 reg[0] -> 1ccf8200000
[  136.544643] /fhc/sram@0,200000 reg[1] -> 1ccf8280000
[  136.545013] /fhc/flashprom@0,0 reg[0] -> 1ccf8000000
[  136.545419] /SUNW,UltraSPARC-II@6,0 reg[0] -> 1cc00000000
[  136.545797] /SUNW,UltraSPARC-II@7,0 reg[0] -> 1ce00000000
[  136.546176] /sbus@2,0 reg[0] -> 1c400000000
[  136.546227] /sbus@2,0: direct translate b4 --> 4
[  136.546276] /sbus@2,0: direct translate b5 --> 5
[  136.546325] /sbus@2,0: direct translate b6 --> 6
[  136.546374] /sbus@2,0: direct translate a5 --> 7
[  136.546423] /sbus@2,0: direct translate aa --> 8
[  136.546472] /sbus@2,0: direct translate b7 --> 9
[  136.546849] /sbus@2,0/SUNW,socal@d,10000 reg[0] -> 1c5d0010000
[  136.546915] /sbus@2,0/SUNW,socal@d,10000: Apply IRQ trans [/sbus@2,0] 22 --> a
[  136.547331] /sbus@2,0/SUNW,socal@d,10000/sf@0,0 reg[0] -> 1c5d0010240
[  136.548079] /sbus@2,0/SUNW,socal@d,10000/sf@1,0 reg[0] -> ffffffffffffffff
[  136.548793] /sbus@2,0/SUNW,qfe@1,8c00000 reg[0] -> 1c518c00000
[  136.548855] /sbus@2,0/SUNW,qfe@1,8c00000 reg[1] -> 1c518c02000
[  136.548915] /sbus@2,0/SUNW,qfe@1,8c00000 reg[2] -> 1c518c04000
[  136.548976] /sbus@2,0/SUNW,qfe@1,8c00000 reg[3] -> 1c518c06000
[  136.549036] /sbus@2,0/SUNW,qfe@1,8c00000 reg[4] -> 1c518c07000
[  136.549100] /sbus@2,0/SUNW,qfe@1,8c00000: Apply IRQ trans [/sbus@2,0] 4 --> b
[  136.549487] /sbus@2,0/SUNW,qfe@1,8c10000 reg[0] -> 1c518c10000
[  136.549548] /sbus@2,0/SUNW,qfe@1,8c10000 reg[1] -> 1c518c12000
[  136.549609] /sbus@2,0/SUNW,qfe@1,8c10000 reg[2] -> 1c518c14000
[  136.549668] /sbus@2,0/SUNW,qfe@1,8c10000 reg[3] -> 1c518c16000
[  136.549728] /sbus@2,0/SUNW,qfe@1,8c10000 reg[4] -> 1c518c17000
[  136.549789] /sbus@2,0/SUNW,qfe@1,8c10000: Apply IRQ trans [/sbus@2,0] 4 --> b
[  136.550176] /sbus@2,0/SUNW,qfe@1,8c20000 reg[0] -> 1c518c20000
[  136.550239] /sbus@2,0/SUNW,qfe@1,8c20000 reg[1] -> 1c518c22000
[  136.550299] /sbus@2,0/SUNW,qfe@1,8c20000 reg[2] -> 1c518c24000
[  136.550360] /sbus@2,0/SUNW,qfe@1,8c20000 reg[3] -> 1c518c26000
[  136.550419] /sbus@2,0/SUNW,qfe@1,8c20000 reg[4] -> 1c518c27000
[  136.550480] /sbus@2,0/SUNW,qfe@1,8c20000: Apply IRQ trans [/sbus@2,0] 4 --> b
[  136.550869] /sbus@2,0/SUNW,qfe@1,8c30000 reg[0] -> 1c518c30000
[  136.550931] /sbus@2,0/SUNW,qfe@1,8c30000 reg[1] -> 1c518c32000
[  136.550992] /sbus@2,0/SUNW,qfe@1,8c30000 reg[2] -> 1c518c34000
[  136.551052] /sbus@2,0/SUNW,qfe@1,8c30000 reg[3] -> 1c518c36000
[  136.551112] /sbus@2,0/SUNW,qfe@1,8c30000 reg[4] -> 1c518c37000
[  136.551172] /sbus@2,0/SUNW,qfe@1,8c30000: Apply IRQ trans [/sbus@2,0] 4 --> b
[  136.551590] /fhc reg[0] -> 1c4f8800000
[  136.551634] /fhc reg[1] -> 1c4f8802000
[  136.551675] /fhc reg[2] -> 1c4f8804000
[  136.551717] /fhc reg[3] -> 1c4f8806000
[  136.551758] /fhc reg[4] -> 1c4f8808000
[  136.551800] /fhc reg[5] -> 1c4f880a000
[  136.552205] /fhc/ac@0,1000000 reg[0] -> 1c4f9000000
[  136.552264] /fhc/ac@0,1000000 reg[1] -> 1c4fa000000
[  136.552638] /fhc/environment@0,400000 reg[0] -> 1c4f8400000
[  136.553040] /fhc/flashprom@0,0 reg[0] -> 1c4f8000000
[  136.553418] /fhc/eeprom@0,300000 reg[0] -> 1c4f8300000
[  136.553815] /fhc/sbus-speed@0,500000 reg[0] -> 1c4f8500000
[  136.554189] /counter-timer reg[0] -> 1c400003c00
[  136.554237] /counter-timer reg[1] -> 1c400003860
[  136.554282] /counter-timer reg[2] -> 1c400003060
[  136.554668] /sbus@3,0 reg[0] -> 1c600000000
[  136.554718] /sbus@3,0: direct translate f4 --> c
[  136.554767] /sbus@3,0: direct translate f5 --> d
[  136.554816] /sbus@3,0: direct translate f6 --> e
[  136.554865] /sbus@3,0: direct translate e5 --> f
[  136.554914] /sbus@3,0: direct translate ea --> 10
[  136.554963] /sbus@3,0: direct translate f7 --> 11
[  136.555429] /sbus@3,0/SUNW,hme@3,8c00000 reg[0] -> 1c738c00000
[  136.555491] /sbus@3,0/SUNW,hme@3,8c00000 reg[1] -> 1c738c02000
[  136.555552] /sbus@3,0/SUNW,hme@3,8c00000 reg[2] -> 1c738c04000
[  136.555612] /sbus@3,0/SUNW,hme@3,8c00000 reg[3] -> 1c738c06000
[  136.555672] /sbus@3,0/SUNW,hme@3,8c00000 reg[4] -> 1c738c07000
[  136.555737] /sbus@3,0/SUNW,hme@3,8c00000: Apply IRQ trans [/sbus@3,0] 4 --> 12
[  136.556141] /sbus@3,0/SUNW,fas@3,8800000 reg[0] -> 1c738800000
[  136.556203] /sbus@3,0/SUNW,fas@3,8800000 reg[1] -> 1c738810000
[  136.556268] /sbus@3,0/SUNW,fas@3,8800000: Apply IRQ trans [/sbus@3,0] 3 --> 13
[  136.557358] /sbus@3,0/SUNW,qfe@0,8c00000 reg[0] -> 1c708c00000
[  136.557421] /sbus@3,0/SUNW,qfe@0,8c00000 reg[1] -> 1c708c02000
[  136.557481] /sbus@3,0/SUNW,qfe@0,8c00000 reg[2] -> 1c708c04000
[  136.557541] /sbus@3,0/SUNW,qfe@0,8c00000 reg[3] -> 1c708c06000
[  136.557601] /sbus@3,0/SUNW,qfe@0,8c00000 reg[4] -> 1c708c07000
[  136.557664] /sbus@3,0/SUNW,qfe@0,8c00000: Apply IRQ trans [/sbus@3,0] 4 --> 14
[  136.558068] /sbus@3,0/SUNW,qfe@0,8c10000 reg[0] -> 1c708c10000
[  136.558131] /sbus@3,0/SUNW,qfe@0,8c10000 reg[1] -> 1c708c12000
[  136.558190] /sbus@3,0/SUNW,qfe@0,8c10000 reg[2] -> 1c708c14000
[  136.558250] /sbus@3,0/SUNW,qfe@0,8c10000 reg[3] -> 1c708c16000
[  136.558310] /sbus@3,0/SUNW,qfe@0,8c10000 reg[4] -> 1c708c17000
[  136.558370] /sbus@3,0/SUNW,qfe@0,8c10000: Apply IRQ trans [/sbus@3,0] 4 --> 14
[  136.558772] /sbus@3,0/SUNW,qfe@0,8c20000 reg[0] -> 1c708c20000
[  136.558834] /sbus@3,0/SUNW,qfe@0,8c20000 reg[1] -> 1c708c22000
[  136.558894] /sbus@3,0/SUNW,qfe@0,8c20000 reg[2] -> 1c708c24000
[  136.558954] /sbus@3,0/SUNW,qfe@0,8c20000 reg[3] -> 1c708c26000
[  136.559014] /sbus@3,0/SUNW,qfe@0,8c20000 reg[4] -> 1c708c27000
[  136.559074] /sbus@3,0/SUNW,qfe@0,8c20000: Apply IRQ trans [/sbus@3,0] 4 --> 14
[  136.559478] /sbus@3,0/SUNW,qfe@0,8c30000 reg[0] -> 1c708c30000
[  136.559540] /sbus@3,0/SUNW,qfe@0,8c30000 reg[1] -> 1c708c32000
[  136.559600] /sbus@3,0/SUNW,qfe@0,8c30000 reg[2] -> 1c708c34000
[  136.559661] /sbus@3,0/SUNW,qfe@0,8c30000 reg[3] -> 1c708c36000
[  136.559720] /sbus@3,0/SUNW,qfe@0,8c30000 reg[4] -> 1c708c37000
[  136.559781] /sbus@3,0/SUNW,qfe@0,8c30000: Apply IRQ trans [/sbus@3,0] 4 --> 14
[  136.560208] /counter-timer reg[0] -> 1c600003c00
[  136.560256] /counter-timer reg[1] -> 1c600003860
[  136.560301] /counter-timer reg[2] -> 1c600003060
[  136.560688] /pci@a,4000 reg[0] -> 1d400004000
[  136.560735] /pci@a,4000 reg[1] -> 1d401000000
[  136.560780] /pci@a,4000 reg[2] -> 1d400000000
[  136.560828] /pci@a,4000: direct translate 2b1 --> 15
[  136.560878] /pci@a,4000: direct translate 2ae --> 16
[  136.560926] /pci@a,4000: direct translate 2af --> 17
[  136.560974] /pci@a,4000: direct translate 2a5 --> 18
[  136.561024] /pci@a,4000: direct translate 2a8 --> 19
[  136.561072] /pci@a,4000: direct translate 2b2 --> 1a
[  136.561466] /pci@a,4000/pci108e,1000@1 reg[0] -> 1d581000000
[  136.561530] /pci@a,4000/pci108e,1000@1 reg[1] -> 1d582000000
[  136.561591] /pci@a,4000/pci108e,1000@1: PCI swizzle [/pci@a,4000] 1 --> fffffffc
[  136.561663] /pci@a,4000/pci108e,1000@1: Apply IRQ trans [/pci@a,4000] 1 --> 1b
[  136.562081] /pci@a,4000/SUNW,hme@1,1 reg[0] -> 1d582800000
[  136.562139] /pci@a,4000/SUNW,hme@1,1: PCI swizzle [/pci@a,4000] 2a1 --> 2a1
[  136.562197] /pci@a,4000/SUNW,hme@1,1: Apply IRQ trans [/pci@a,4000] 2a1 --> 1c
[  136.562594] /pci@a,2000 reg[0] -> 1d400002000
[  136.562641] /pci@a,2000 reg[1] -> 1d401800000
[  136.562685] /pci@a,2000 reg[2] -> 1d400000000
[  136.562732] /pci@a,2000: direct translate 2b0 --> 1d
[  136.562777] /pci@a,2000: direct translate 2ae --> 16
[  136.562821] /pci@a,2000: direct translate 2af --> 17
[  136.562866] /pci@a,2000: direct translate 2a5 --> 18
[  136.562910] /pci@a,2000: direct translate 2a8 --> 19
[  136.562954] /pci@a,2000: direct translate 2b2 --> 1a
[  136.563697] /pci@a,2000/pci@2/pci108e,1000@810000,0 reg[0] -> 1d501000000
[  136.563778] /pci@a,2000/pci@2/pci108e,1000@810000,0 reg[1] -> 1d502000000
[  136.563840] /pci@a,2000/pci@2/pci108e,1000@810000,0: PCI swizzle [/pci@a,2000/pci@2] 1 --> 1
[  136.563922] /pci@a,2000/pci@2/pci108e,1000@810000,0: PCI swizzle [/pci@a,2000] 1 --> 4
[  136.563996] /pci@a,2000/pci@2/pci108e,1000@810000,0: Apply IRQ trans [/pci@a,2000] 1 --> 1e
[  136.564462] /pci@a,2000/pci@2/SUNW,qfe@810100,0 reg[0] -> 1d502800000
[  136.564525] /pci@a,2000/pci@2/SUNW,qfe@810100,0: PCI swizzle [/pci@a,2000/pci@2] 2 --> 2
[  136.564605] /pci@a,2000/pci@2/SUNW,qfe@810100,0: PCI swizzle [/pci@a,2000] 2 --> 5
[  136.564678] /pci@a,2000/pci@2/SUNW,qfe@810100,0: Apply IRQ trans [/pci@a,2000] 2 --> 1f
[  136.565133] /pci@a,2000/pci@2/pci108e,1000@810800,0 reg[0] -> 1d503000000
[  136.565212] /pci@a,2000/pci@2/pci108e,1000@810800,0 reg[1] -> 1d504000000
[  136.565273] /pci@a,2000/pci@2/pci108e,1000@810800,0: PCI swizzle [/pci@a,2000/pci@2] 1 --> 2
[  136.565354] /pci@a,2000/pci@2/pci108e,1000@810800,0: PCI swizzle [/pci@a,2000] 2 --> 5
[  136.565424] /pci@a,2000/pci@2/pci108e,1000@810800,0: Apply IRQ trans [/pci@a,2000] 1 --> 1f
[  136.565875] /pci@a,2000/pci@2/SUNW,qfe@810900,0 reg[0] -> 1d504800000
[  136.565937] /pci@a,2000/pci@2/SUNW,qfe@810900,0: PCI swizzle [/pci@a,2000/pci@2] 2 --> 3
[  136.566017] /pci@a,2000/pci@2/SUNW,qfe@810900,0: PCI swizzle [/pci@a,2000] 3 --> 6
[  136.566089] /pci@a,2000/pci@2/SUNW,qfe@810900,0: Apply IRQ trans [/pci@a,2000] 2 --> 20
[  136.566546] /pci@a,2000/pci@2/pci108e,1000@811000,0 reg[0] -> 1d505000000
[  136.566625] /pci@a,2000/pci@2/pci108e,1000@811000,0 reg[1] -> 1d506000000
[  136.566687] /pci@a,2000/pci@2/pci108e,1000@811000,0: PCI swizzle [/pci@a,2000/pci@2] 1 --> 3
[  136.566768] /pci@a,2000/pci@2/pci108e,1000@811000,0: PCI swizzle [/pci@a,2000] 3 --> 6
[  136.566838] /pci@a,2000/pci@2/pci108e,1000@811000,0: Apply IRQ trans [/pci@a,2000] 1 --> 20
[  136.567282] /pci@a,2000/pci@2/SUNW,qfe@811100,0 reg[0] -> 1d506800000
[  136.567345] /pci@a,2000/pci@2/SUNW,qfe@811100,0: PCI swizzle [/pci@a,2000/pci@2] 2 --> 4
[  136.567425] /pci@a,2000/pci@2/SUNW,qfe@811100,0: PCI swizzle [/pci@a,2000] 4 --> 7
[  136.567500] /pci@a,2000/pci@2/SUNW,qfe@811100,0: Apply IRQ trans [/pci@a,2000] 2 --> 21
[  136.567940] /pci@a,2000/pci@2/pci108e,1000@811800,0 reg[0] -> 1d507000000
[  136.568019] /pci@a,2000/pci@2/pci108e,1000@811800,0 reg[1] -> 1d508000000
[  136.568080] /pci@a,2000/pci@2/pci108e,1000@811800,0: PCI swizzle [/pci@a,2000/pci@2] 1 --> 4
[  136.568161] /pci@a,2000/pci@2/pci108e,1000@811800,0: PCI swizzle [/pci@a,2000] 4 --> 7
[  136.568231] /pci@a,2000/pci@2/pci108e,1000@811800,0: Apply IRQ trans [/pci@a,2000] 1 --> 21
[  136.568687] /pci@a,2000/pci@2/SUNW,qfe@811900,0 reg[0] -> 1d508800000
[  136.568750] /pci@a,2000/pci@2/SUNW,qfe@811900,0: PCI swizzle [/pci@a,2000/pci@2] 2 --> 1
[  136.568829] /pci@a,2000/pci@2/SUNW,qfe@811900,0: PCI swizzle [/pci@a,2000] 1 --> 4
[  136.568898] /pci@a,2000/pci@2/SUNW,qfe@811900,0: Apply IRQ trans [/pci@a,2000] 2 --> 1e
[  136.569334] /fhc reg[0] -> 1d4f8800000
[  136.569379] /fhc reg[1] -> 1d4f8802000
[  136.569420] /fhc reg[2] -> 1d4f8804000
[  136.569461] /fhc reg[3] -> 1d4f8806000
[  136.569503] /fhc reg[4] -> 1d4f8808000
[  136.569544] /fhc reg[5] -> 1d4f880a000
[  136.569923] /fhc/ac@0,1000000 reg[0] -> 1d4f9000000
[  136.569982] /fhc/ac@0,1000000 reg[1] -> 1d4fa000000
[  136.570373] /fhc/environment@0,400000 reg[0] -> 1d4f8400000
[  136.570807] /fhc/flashprom@0,0 reg[0] -> 1d4f8000000
[  136.571237] /fhc/eeprom@0,300000 reg[0] -> 1d4f8300000
[  136.571671] /fhc/sbus-speed@0,500000 reg[0] -> 1d4f8500000
[  136.572101] /counter-timer reg[0] -> 1d400001c00
[  136.572149] /counter-timer reg[1] -> 1d400001860
[  136.572194] /counter-timer reg[2] -> 1d400001060
[  136.572630] /pci@b,4000 reg[0] -> 1d600004000
[  136.572676] /pci@b,4000 reg[1] -> 1d601000000
[  136.572721] /pci@b,4000 reg[2] -> 1d600000000
[  136.572768] /pci@b,4000: direct translate 2f1 --> 22
[  136.572816] /pci@b,4000: direct translate 2ee --> 23
[  136.572864] /pci@b,4000: direct translate 2ef --> 24
[  136.572912] /pci@b,4000: direct translate 2e5 --> 25
[  136.572960] /pci@b,4000: direct translate 2e8 --> 26
[  136.573008] /pci@b,4000: direct translate 2f2 --> 27
[  136.573461] /pci@b,4000/SUNW,isptwo@3 reg[0] -> 1d602010400
[  136.573525] /pci@b,4000/SUNW,isptwo@3 reg[1] -> 1d780002000
[  136.573587] /pci@b,4000/SUNW,isptwo@3 reg[2] -> 1d780010000
[  136.573644] /pci@b,4000/SUNW,isptwo@3: PCI swizzle [/pci@b,4000] 2e0 --> 2e0
[  136.573703] /pci@b,4000/SUNW,isptwo@3: Apply IRQ trans [/pci@b,4000] 2e0 --> 28
[  136.574950] /pci@b,2000 reg[0] -> 1d600002000
[  136.574996] /pci@b,2000 reg[1] -> 1d601800000
[  136.575041] /pci@b,2000 reg[2] -> 1d600000000
[  136.575087] /pci@b,2000: direct translate 2f0 --> 29
[  136.575154] /pci@b,2000: direct translate 2ee --> 23
[  136.575199] /pci@b,2000: direct translate 2ef --> 24
[  136.575242] /pci@b,2000: direct translate 2e5 --> 25
[  136.575286] /pci@b,2000: direct translate 2e8 --> 26
[  136.575329] /pci@b,2000: direct translate 2f2 --> 27
[  136.575789] /pci@b,2000/fddi@2 reg[0] -> 1d700002000
[  136.575851] /pci@b,2000/fddi@2 reg[1] -> 1d602000400
[  136.575908] /pci@b,2000/fddi@2: PCI swizzle [/pci@b,2000] 1 --> 4
[  136.575963] /pci@b,2000/fddi@2: Apply IRQ trans [/pci@b,2000] 1 --> 2a
[  136.576391] /counter-timer reg[0] -> 1d600001c00
[  136.576439] /counter-timer reg[1] -> 1d600001860
[  136.576484] /counter-timer reg[2] -> 1d600001060
[  136.579557] PCI: Probing for controllers.
[  136.586798] /pci@a,4000: PSYCHO PCI Bus Module ver[4:0]
[  136.586857] /pci@a,4000: PCI IO[1d402010000] MEM[1d580000000]
[  136.586944] /pci@a,2000: PSYCHO PCI Bus Module ver[4:0]
[  136.586994] /pci@a,2000: PCI IO[1d402000000] MEM[1d500000000]
[  136.594205] /pci@b,4000: PSYCHO PCI Bus Module ver[4:0]
[  136.594272] /pci@b,4000: PCI IO[1d602010000] MEM[1d780000000]
[  136.594360] /pci@b,2000: PSYCHO PCI Bus Module ver[4:0]
[  136.594408] /pci@b,2000: PCI IO[1d602000000] MEM[1d700000000]
[  136.594474] PCI: Scanning PBM /pci@b,2000
[  136.595798] PCI: Scanning PBM /pci@b,4000
[  136.596770] PCI: Scanning PBM /pci@a,2000
[  136.597823] PCI: Scanning PBM /pci@a,4000
[  136.599279] ebus: No EBus's found.
[  136.606147] SCSI subsystem initialized
[  136.606230] SYSIO: UPA portID 2, at 000001c400000000
[  136.613459] sbus0: Clock 25.0 MHz
[  136.617087] SYSIO: UPA portID 3, at 000001c600000000
[  136.624367] sbus1: Clock 25.0 MHz
[  136.627582] dma0: HME DVMA gate array 
[  136.676229] /central/fhc@0,f8800000/eeprom@0,908000: Clock regs at 000001fff8908000
[  136.681443] NET: Registered protocol family 2
[  136.685367] Switched to high resolution mode on CPU 6
[  136.690493] Switched to high resolution mode on CPU 7
[  136.780755] IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
[  136.785380] TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
[  136.805659] TCP bind hash table entries: 65536 (order: 8, 2097152 bytes)
[  136.815690] TCP: Hash tables configured (established 262144 bind 65536)
[  136.815747] TCP reno registered
[  136.840961] NET: Registered protocol family 1
[  136.841183] Mini RTC Driver
[  136.853658] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[  136.887366] msgmni has been set to 2498
[  136.889221] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[  136.889303] io scheduler noop registered
[  136.889348] io scheduler anticipatory registered
[  136.889397] io scheduler deadline registered
[  136.889557] io scheduler cfq registered (default)
[  137.123881] f005de3c: ttyS0 at MMIO 0x1fff8902000 (irq = 2) is a zs (ESCC)
[  137.123945] Console: ttyS0 (SunZilog zs0)
[  137.124289] console [ttyS0] enabled
[  158.756644] f005de3c: ttyS1 at MMIO 0x1fff8902004 (irq = 2) is a zs (ESCC)
[  159.045888] f005df14: Keyboard at MMIO 0x1fff8904000 (irq = 2) is a zs
[  159.121940] f005df14: Mouse at MMIO 0x1fff8904004 (irq = 2) is a zs
[  159.200059] sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
[  159.287369] eth0: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:08
[  159.378931] eth1: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:09
[  159.471002] eth2: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0a
[  159.562855] eth3: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:9d:77:0b
[  159.654787] eth4: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:b6:ee:e2
[  159.738642] eth5: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:94
[  159.831015] eth6: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:95
[  159.923443] eth7: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:96
[  160.015950] eth8: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 08:00:20:93:79:97
[  160.104964] PCI: Enabling device: (0000:00:01.1), cmd 2
[  160.171044] eth9: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:b6:ee:e2
[  160.259470] qla1280: QLA1040 found on PCI bus 0, dev 3
[  160.320124] PCI: Enabling device: (0002:00:03.0), cmd 7
[  161.156675] scsi(0:0): Resetting SCSI BUS
[  164.215387] scsi0 : QLogic QLA1040 PCI to SCSI Host Adapter
[  164.215399]        Firmware version:  7.65.06, Driver version 3.26
[  164.691729] scsi 0:0:2:0: Direct-Access     IBM      DDYS-T18350M     S96H PQ: 0 ANSI: 3
[  164.787350] scsi(0:0:2:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  164.884274] scsi 0:0:3:0: Direct-Access     IBM      DDYS-T18350M     S93E PQ: 0 ANSI: 3
[  164.979894] scsi(0:0:3:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  165.083413] scsi 0:0:4:0: Direct-Access     HP       9.10GB A 80-6331      PQ: 0 ANSI: 2
[  165.178993] scsi(0:0:4:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  165.280739] scsi 0:0:5:0: Direct-Access     IBM      DDRS-34560D      DC1B PQ: 0 ANSI: 2
[  165.376316] scsi(0:0:5:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  165.654391] scsi 0:0:8:0: Direct-Access     HP       4.26GB A 80-0430 0430 PQ: 0 ANSI: 2
[  165.750002] scsi(0:0:8:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  165.864231] scsi 0:0:9:0: Direct-Access     HP       2.13GB A 80-0430 0430 PQ: 0 ANSI: 2
[  165.959820] scsi(0:0:9:0): Sync: period 10, offset 12, Wide, Tagged queuing: depth 31
[  167.065831] esp: esp0, regs[1c738810000:1c738800000] irq[19]
[  167.131565] esp: esp0 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[  170.205369] scsi1 : esp
[  171.642452] scsi 1:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
[  171.737451] scsi target1:0:6: Beginning Domain Validation
[  171.803569] scsi target1:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[  171.886233] scsi target1:0:6: Domain Validation skipping write tests
[  171.961362] scsi target1:0:6: Ending Domain Validation
[  173.898260] Driver 'sd' needs updating - please use bus_type methods
[  173.975469] sd 0:0:2:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[  174.057961] sd 0:0:2:0: [sda] Write Protect is off
[  174.114094] sd 0:0:2:0: [sda] Mode Sense: cb 00 00 08
[  174.176172] sd 0:0:2:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  174.285516] sd 0:0:2:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
[  174.368430] sd 0:0:2:0: [sda] Write Protect is off
[  174.424546] sd 0:0:2:0: [sda] Mode Sense: cb 00 00 08
[  174.486698] sd 0:0:2:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  174.594429]  sda: sda1 sda2 sda3 sda4
[  174.651311] sd 0:0:2:0: [sda] Attached SCSI disk
[  174.707465] sd 0:0:3:0: [sdb] 35843670 512-byte hardware sectors (18352 MB)
[  174.789954] sd 0:0:3:0: [sdb] Write Protect is off
[  174.846093] sd 0:0:3:0: [sdb] Mode Sense: cb 00 00 08
[  174.908082] sd 0:0:3:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  175.017412] sd 0:0:3:0: [sdb] 35843670 512-byte hardware sectors (18352 MB)
[  175.100431] sd 0:0:3:0: [sdb] Write Protect is off
[  175.156569] sd 0:0:3:0: [sdb] Mode Sense: cb 00 00 08
[  175.218568] sd 0:0:3:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  175.326420]  sdb: unknown partition table
[  175.384796] sd 0:0:3:0: [sdb] Attached SCSI disk
[  175.442550] sd 0:0:4:0: [sdc] 17773524 512-byte hardware sectors (9100 MB)
[  175.524880] sd 0:0:4:0: [sdc] Write Protect is off
[  175.580196] sd 0:0:4:0: [sdc] Mode Sense: 9f 00 10 08
[  175.642941] sd 0:0:4:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  175.745767] sd 0:0:4:0: [sdc] 17773524 512-byte hardware sectors (9100 MB)
[  175.828492] sd 0:0:4:0: [sdc] Write Protect is off
[  175.883793] sd 0:0:4:0: [sdc] Mode Sense: 9f 00 10 08
[  175.946528] sd 0:0:4:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  176.047705]  sdc: unknown partition table
[  176.108854] sd 0:0:4:0: [sdc] Attached SCSI disk
[  176.203235] sd 0:0:5:0: [sdd] 8925000 512-byte hardware sectors (4570 MB)
[  176.328453] sd 0:0:5:0: [sdd] Write Protect is off
[  176.383693] sd 0:0:5:0: [sdd] Mode Sense: b9 00 00 08
[  176.477130] sd 0:0:5:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  176.618252] sd 0:0:5:0: [sdd] 8925000 512-byte hardware sectors (4570 MB)
[  176.743498] sd 0:0:5:0: [sdd] Write Protect is off
[  176.798767] sd 0:0:5:0: [sdd] Mode Sense: b9 00 00 08
[  176.892181] sd 0:0:5:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  176.998531]  sdd: unknown partition table
[  177.055806] sd 0:0:5:0: [sdd] Attached SCSI disk
[  177.116060] sd 0:0:8:0: [sde] 8330543 512-byte hardware sectors (4265 MB)
[  177.199233] sd 0:0:8:0: [sde] Write Protect is off
[  177.254502] sd 0:0:8:0: [sde] Mode Sense: 9f 00 10 08
[  177.319080] sd 0:0:8:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  177.423021] sd 0:0:8:0: [sde] 8330543 512-byte hardware sectors (4265 MB)
[  177.506195] sd 0:0:8:0: [sde] Write Protect is off
[  177.561421] sd 0:0:8:0: [sde] Mode Sense: 9f 00 10 08
[  177.626031] sd 0:0:8:0: [sde] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  177.727217]  sde: unknown partition table
[  177.796088] sd 0:0:8:0: [sde] Attached SCSI disk
[  177.856629] sd 0:0:9:0: [sdf] 4165272 512-byte hardware sectors (2133 MB)
[  177.939956] sd 0:0:9:0: [sdf] Write Protect is off
[  177.995253] sd 0:0:9:0: [sdf] Mode Sense: 9f 00 10 08
[  178.060036] sd 0:0:9:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  178.164091] sd 0:0:9:0: [sdf] 4165272 512-byte hardware sectors (2133 MB)
[  178.247414] sd 0:0:9:0: [sdf] Write Protect is off
[  178.302728] sd 0:0:9:0: [sdf] Mode Sense: 9f 00 10 08
[  178.367566] sd 0:0:9:0: [sdf] Write cache: disabled, read cache: enabled, supports DPO and FUA
[  178.468703]  sdf: unknown partition table
[  178.534034] sd 0:0:9:0: [sdf] Attached SCSI disk
[  178.589125] mice: PS/2 mouse device common for all mice
[  179.653186] TCP cubic registered
[  179.689647] NET: Registered protocol family 17
[  179.743922] registered taskstats version 1
[  179.792141] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[  179.886443] kjournald starting.  Commit interval 5 seconds
[  179.949977] EXT3-fs: mounted filesystem with ordered data mode.
[  179.950052] VFS: Mounted root (ext3 filesystem) readonly.
[  182.814264] SysKonnect FDDI PCI Adapter driver v2.07 for
[  182.814277]   SK-55xx/SK-58xx adapters (SK-NET FDDI-FP/UP/LP)
[  182.944955] PCI: Enabling device: (0003:80:02.0), cmd 3
[  183.011283] fddi0: SysKonnect FDDI PCI adapter found (SK-5821)
[  184.077292] Driver 'sr' needs updating - please use bus_type methods
[  184.162885] sr0: scsi-1 drive
[  184.196321] Uniform CD-ROM driver Revision: 3.20
[  184.251993] sr 1:0:6:0: Attached scsi CD-ROM sr0
[  184.391848] sd 0:0:2:0: Attached scsi generic sg0 type 0
[  184.453582] sd 0:0:3:0: Attached scsi generic sg1 type 0
[  184.517242] sd 0:0:4:0: Attached scsi generic sg2 type 0
[  184.580982] sd 0:0:5:0: Attached scsi generic sg3 type 0
[  184.644533] sd 0:0:8:0: Attached scsi generic sg4 type 0
[  184.708085] sd 0:0:9:0: Attached scsi generic sg5 type 0
[  184.771521] sr 1:0:6:0: Attached scsi generic sg6 type 5
[  186.652405] Adding 787168k swap on /dev/sda4.  Priority:-1 extents:1 across:787168k
[  187.111659] EXT3 FS on sda2, internal journal
[  188.104643] device-mapper: uevent: version 1.0.3
[  188.158656] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[  188.998514] kjournald starting.  Commit interval 5 seconds
[  189.067451] EXT3 FS on sda1, internal journal
[  189.117517] EXT3-fs: mounted filesystem with ordered data mode.
[  194.135414] eth9: Link is up using internal transceiver at 100Mb/s, Full Duplex.
[  196.573131] NET: Registered protocol family 10
[  196.630951] lo: Disabled Privacy Extensions
[  207.055354] eth9: no IPv6 routers present

-- 
Meelis Roos (mroos@linux.ee)
