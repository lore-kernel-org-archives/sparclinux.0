From: Marc Zyngier <maz@misterjones.org>
Date: Sun, 16 Jul 2006 15:44:37 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <wrpbqrpftay.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "David" = David Miller <davem@davemloft.net> writes:

David> Please reboot with of_debug=3 and send the logs here.  It's
David> almost certainly a bug in the psycho bus IRQ translater in
David> arch/sparc64/kernel/prom.c:psycho_irq_build()/psycho_irq_trans_init().
David> A good debugging log will give some clues.

Ok, back from wandering around a nice lake in Britanny... :)

Here's the log with of_debug=3:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.18-rc1 (maz@positive) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #5 SMP Fri Jul 14 11:43:38 CEST 2006
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:d8:e4:6d
Remapping the kernel... done.
[    0.000000] PROM: Built device tree with 75588 bytes of memory.
Booting Linux...
[    0.000000] Built 1 zonelists.  Total pages: 260721
[    0.000000] Kernel command line: root=/dev/sda2 ro -p of_debug=3
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   17.140306] Console: colour dummy device 80x25
[    0.022800] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[    0.116660] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.320438] Memory: 2066520k available (2544k kernel code, 832k data, 168k init) [fffff80000000000,000000007fecc000]
[    0.523177] Calibrating delay using timer specific routine.. 800.45 BogoMIPS (lpj00918)
[    0.620652] Security Framework v1.0.0 initialized
[    0.676646] SELinux:  Disabled at boot.
[    0.722518] Mount-cache hash table entries: 512
[    0.777520] CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
[    0.889181] Using max_cache_size of 2MB
[    1.027179] Calibrating delay using timer specific routine.. 800.05 BogoMIPS (lpj00116)
[    1.027328] CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
[    1.028063] CPU 1: synchronized TICK with master CPU (last diff -21 cycles,maxerr 712 cycles)
[    1.028082] Brought up 2 CPUs
[    1.028100] Total of 2 processors activated (1600.51 BogoMIPS).
[    3.137988] migration_costA911
[    3.175435] checking if image is initramfs... it is
[    5.999753] Freeing initrd memory: 5983k freed
[    6.053334] NET: Registered protocol family 16
[    6.107077] /memory reg[0] -> 0
[    6.143205] /memory reg[1] -> 20000000
[    6.187689] /memory reg[2] -> 40000000
[    6.232477] /memory reg[3] -> 60000000
[    6.278490] /pci@1f,4000 reg[0] -> 1fe00004000
[    6.330467] /pci@1f,4000 reg[1] -> 1fe01000000
[    6.383523] /pci@1f,4000 reg[2] -> 1fe00000000
[    6.436637] /pci@1f,4000: direct translate 7f1 --> 1
[    6.496013] /pci@1f,4000: direct translate 7ee --> 2
[    6.555384] /pci@1f,4000: direct translate 7ef --> 3
[    6.614750] /pci@1f,4000: direct translate 7e5 --> 4
[    6.674127] /pci@1f,4000: direct translate 7e8 --> 5
[    6.733495] /pci@1f,4000: direct translate 7f2 --> 6
[    6.793316] /pci@1f,4000/ebus@1/auxio@14,726000 reg[0] -> 1fff1726000
[    6.869959] /pci@1f,4000/ebus@1/auxio@14,726000 reg[1] -> 1fff1728000
[    6.947056] /pci@1f,4000/ebus@1/auxio@14,726000 reg[2] -> 1fff172a000
[    7.024136] /pci@1f,4000/ebus@1/auxio@14,726000 reg[3] -> 1fff172c000
[    7.101208] /pci@1f,4000/ebus@1/auxio@14,726000 reg[4] -> 1fff172f000
[    7.178466] /pci@1f,4000/ebus@1/power@14,724000 reg[0] -> 1fff1724000
[    7.255560] /pci@1f,4000/ebus@1/SUNW,pll@14,504000 reg[0] -> 1fff1504000
[    7.335766] /pci@1f,4000/ebus@1/sc@14,500000 reg[0] -> 1fff1500000
[    7.409692] /pci@1f,4000/ebus@1/se@14,400000 reg[0] -> 1fff1400000
[    7.483478] /pci@1f,4000/ebus@1/se@14,400000: Apply [/pci@1f,4000:2b] imap --> [NULL:2b]
[    7.580549] /pci@1f,4000/ebus@1/se@14,200000 reg[0] -> 1fff1200000
[    7.654269] /pci@1f,4000/ebus@1/se@14,200000: Apply [/pci@1f,4000:23] imap --> [NULL:23]
[    7.751383] /pci@1f,4000/ebus@1/su@14,3083f8 reg[0] -> 1fff13083f8
[    7.825091] /pci@1f,4000/ebus@1/su@14,3083f8: Apply [/pci@1f,4000:29] imap --> [NULL:29]
[    7.922208] /pci@1f,4000/ebus@1/su@14,3062f8 reg[0] -> 1fff13062f8
[    7.995915] /pci@1f,4000/ebus@1/su@14,3062f8: Apply [/pci@1f,4000:2a] imap --> [NULL:2a]
[    8.093035] /pci@1f,4000/ebus@1/ecpp@14,3043bc reg[0] -> 1fff13043bc
[    8.168823] /pci@1f,4000/ebus@1/ecpp@14,3043bc reg[1] -> 1fff1300398
[    8.244880] /pci@1f,4000/ebus@1/ecpp@14,3043bc reg[2] -> 1fff1700000
[    8.320911] /pci@1f,4000/ebus@1/ecpp@14,3043bc: Apply [/pci@1f,4000:22] imap --> [NULL:22]
[    8.420080] /pci@1f,4000/ebus@1/eeprom@14,0 reg[0] -> 1fff1000000
[    8.492948] /pci@1f,4000/ebus@1/flashprom@10,0 reg[0] -> 1fff0000000
[    8.568815] /pci@1f,4000/ebus@1/flashprom@10,0 reg[1] -> 1fff0000000
[    8.645035] /pci@1f,4000/ebus@1/SUNW,envctrltwo@14,600000 reg[0] -> 1fff1600000
[    8.732331] /pci@1f,4000/ebus@1/SUNW,envctrltwo@14,600000: Apply [/pci@1f,4000:28] imap --> [NULL:28]
[    8.842788] /pci@1f,4000/ebus@1/SUNW,envctrltwo@14,600000: Apply [/pci@1f,4000:25] imap --> [NULL:25]
[    8.953419] /pci@1f,4000/network@1,1 reg[0] -> 1ff84100000
[    9.018745] /pci@1f,4000/network@1,1: Apply [/pci@1f,4000:21] imap --> [NULL:21]
[    9.107524] /pci@1f,4000/scsi@3 reg[0] -> 1fe02012000
[    9.167691] /pci@1f,4000/scsi@3 reg[1] -> 1ff84108000
[    9.228118] /pci@1f,4000/scsi@3 reg[2] -> 1ff8410a000
[    9.288525] /pci@1f,4000/scsi@3: Apply [/pci@1f,4000:20] imap --> [NULL:20]
[    9.372460] /pci@1f,4000/scsi@3,1 reg[0] -> 1fe02012400
[    9.434337] /pci@1f,4000/scsi@3,1 reg[1] -> 1ff8410c000
[    9.496854] /pci@1f,4000/scsi@3,1 reg[2] -> 1ff8410e000
[    9.559343] /pci@1f,4000/scsi@3,1: Apply [/pci@1f,4000:26] imap --> [NULL:26]
[    9.645518] /pci@1f,4000/pci@5/SUNW,hme@0,1 reg[0] -> 0
[    9.707232] /pci@1f,4000/pci@5/SUNW,hme@0,1 reg[1] -> 0
[    9.769741] /pci@1f,4000/pci@5/SUNW,hme@0,1: PCI swizzle [/pci@1f,4000/pci@5] 2 --> 2
[    9.863531] /pci@1f,4000/pci@5/SUNW,hme@0,1: Apply [/pci@1f,4000:2] imap --> [/pci@1f,4000:1d]
[    9.966648] /pci@1f,4000/pci@5/SUNW,hme@0,1: Apply IRQ trans [/pci@1f,4000] 2 --> 7
[   10.058487] /pci@1f,4000/pci@5/SUNW,isptwo@4 reg[0] -> 0
[   10.121785] /pci@1f,4000/pci@5/SUNW,isptwo@4 reg[1] -> 0
[   10.185339] /pci@1f,4000/pci@5/SUNW,isptwo@4 reg[2] -> 0
[   10.248873] /pci@1f,4000/pci@5/SUNW,isptwo@4 reg[3] -> 0
[   10.312410] /pci@1f,4000/pci@5/SUNW,isptwo@4: PCI swizzle [/pci@1f,4000/pci@5] 1 --> 1
[   10.407242] /pci@1f,4000/pci@5/SUNW,isptwo@4: Apply [/pci@1f,4000:1] imap --> [/pci@1f,4000:1c]
[   10.511405] /pci@1f,4000/pci@5/SUNW,isptwo@4: Apply IRQ trans [/pci@1f,4000] 1 --> 8
[   10.604676] /pci@1f,2000 reg[0] -> 1fe00002000
[   10.657153] /pci@1f,2000 reg[1] -> 1fe01800000
[   10.710287] /pci@1f,2000 reg[2] -> 1fe00000000
[   10.763408] /pci@1f,2000: direct translate 7f0 --> 9
[   10.822778] /pci@1f,2000: direct translate 7ee --> 2
[   10.882153] /pci@1f,2000: direct translate 7ef --> 3
[   10.941524] /pci@1f,2000: direct translate 7e5 --> 4
[   11.000895] /pci@1f,2000: direct translate 7e8 --> 5
[   11.060266] /pci@1f,2000: direct translate 7f2 --> 6
[   11.119841] /counter-timer reg[0] -> 1fe00001c00
[   11.174825] /counter-timer reg[1] -> 1fe00001860
[   11.230048] /counter-timer reg[2] -> 1fe00001060
[   11.285251] /counter-timer: Apply [/:7ec] imap --> [NULL:7ec]
[   11.354009] /counter-timer: Apply [/:7ed] imap --> [NULL:7ed]
[   11.423129] /mc reg[0] -> 1c000000000
[   11.466653] /mc/bank@0,0 reg[0] -> 0
[   11.509360] /mc/bank@0,0/dimm@0,0 reg[0] -> 0
[   11.561437] /mc/bank@0,0/dimm@0,1 reg[0] -> 1
[   11.613534] /mc/bank@0,0/dimm@0,2 reg[0] -> 2
[   11.665604] /mc/bank@0,0/dimm@0,3 reg[0] -> 3
[   11.717696] /mc/bank@0,20000000 reg[0] -> 20000000
[   11.774975] /mc/bank@0,20000000/dimm@0,0 reg[0] -> 0
[   11.834350] /mc/bank@0,20000000/dimm@0,1 reg[0] -> 1
[   11.893710] /mc/bank@0,20000000/dimm@0,2 reg[0] -> 2
[   11.953093] /mc/bank@0,20000000/dimm@0,3 reg[0] -> 3
[   12.012472] /mc/bank@0,40000000 reg[0] -> 40000000
[   12.069755] /mc/bank@0,40000000/dimm@0,0 reg[0] -> 0
[   12.129108] /mc/bank@0,40000000/dimm@0,1 reg[0] -> 1
[   12.188500] /mc/bank@0,40000000/dimm@0,2 reg[0] -> 2
[   12.247845] /mc/bank@0,40000000/dimm@0,3 reg[0] -> 3
[   12.307247] /mc/bank@0,60000000 reg[0] -> 60000000
[   12.364534] /mc/bank@0,60000000/dimm@0,0 reg[0] -> 0
[   12.423882] /mc/bank@0,60000000/dimm@0,1 reg[0] -> 1
[   12.483257] /mc/bank@0,60000000/dimm@0,2 reg[0] -> 2
[   12.542629] /mc/bank@0,60000000/dimm@0,3 reg[0] -> 3
[   12.602005] /SUNW,UltraSPARC-II@0,0 reg[0] -> 1c000000000
[   12.666613] /SUNW,UltraSPARC-II@1,0 reg[0] -> 1c200000000
[   12.731815] PCI: Probing for controllers.

What I can tell so far, after trying to put quite a few printk here
and there, is that prom.c:psycho_irq_build() doesnt't get called for
devices directly hanging off the psycho controler.

That's because of_device.c:apply_interrupt_map() can't match the
requested interrupt into the interrupt map, and returns NULL. Now, the
logic inside apply_interrupt_map() is beyond my understanding of OF.

For reference (and debugging), I'm including both interrupt-map and
interrupt-map-mask, just in case it might be usefull.

root@positive:/proc/openprom/pci@1f,4000# cat interrupt-map
00000800.00000000.00000000.00000002.f006d1b0.00000021.00001000.00000000.00000000.00000001.f006d1b0.00000010.00001000.00000000.00000000.00000002.f006d1b0.00000011.00001000.00000000.00000000.00000003.f006d1b0.00000012.00001000.00000000.00000000.00000004.f006d1b0.00000013.00001800.00000000.00000000.00000001.f006d1b0.00000020.00001900.00000000.00000000.00000001.f006d1b0.00000026.00002000.00000000.00000000.00000001.f006d1b0.00000018.00002000.00000000.00000000.00000002.f006d1b0.00000019.00002000.00000000.00000000.00000003.f006d1b0.0000001a.00002000.00000000.00000000.00000004.f006d1b0.0000001b.00002800.00000000.00000000.00000001.f006d1b0.0000001c.00002800.00000000.00000000.00000002.f006d1b0.0000001d.00002800.00000000.00000000.00000003.f006d1b0.0000001e.00002800.00000000.00000000.00000004.f006d1b0.0000001f
root@positive:/proc/openprom/pci@1f,4000# cat interrupt-map-mask 
00fff800.00000000.00000000.00000007

As usual, I'll be happy to test any idea you may have to solve this
problem.

Cheers,

	M.
-- 
And if you don't know where you're going, any road will take you there...
