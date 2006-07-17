From: Marc Zyngier <maz@misterjones.org>
Date: Mon, 17 Jul 2006 07:26:01 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <wrpy7usd75i.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "David" = David Miller <davem@davemloft.net> writes:

David> This should do it.  I sanity booted this on my ultra60 just to
David> make sure. :-)

While it obviously looks better (no more NULL translators), the
machine hangs before probing the SCSI controllers. And the serial
console is painfully slow as soon as the console is switched from PROM
to SAB.

Looks like this E250 is an odd beast...

Thanks again for your help Dave.

	M.

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.18-rc2 (maz@positive) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #13 SMP Mon Jul 17 08:46:08 CEST 2006
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:d8:e4:6d
[    0.000000] PROM: Built device tree with 75588 bytes of memory.
[    0.000000] Built 1 zonelists.  Total pages: 260720
[    0.000000] Kernel command line: root=/dev/sda2 ro -p of_debug=3
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   10.845929] Console: colour dummy device 80x25
[   10.908294] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[   11.002152] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[   11.205399] Memory: 2066520k available (2544k kernel code, 832k data, 168k init) [fffff80000000000,000000007fecc000]
[   11.408670] Calibrating delay using timer specific routine.. 800.45 BogoMIPS (lpj00908)
[   11.506149] Security Framework v1.0.0 initialized
[   11.562140] SELinux:  Disabled at boot.
[   11.608013] Mount-cache hash table entries: 512
[   11.663014] CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
[   11.774676] Using max_cache_size of 2MB
[   11.912672] Calibrating delay using timer specific routine.. 800.05 BogoMIPS (lpj00112)
[   11.912818] CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
[   11.913514] CPU 1: synchronized TICK with master CPU (last diff -22 cycles,maxerr 713 cycles)
[   11.913534] Brought up 2 CPUs
[   11.913552] Total of 2 processors activated (1600.51 BogoMIPS).
[   14.022513] migration_costA881
[   14.059977] checking if image is initramfs... it is
[   16.884598] Freeing initrd memory: 5984k freed
[   16.938255] NET: Registered protocol family 16
[   16.991920] /memory reg[0] -> 0
[   17.028076] /memory reg[1] -> 20000000
[   17.072565] /memory reg[2] -> 40000000
[   17.117357] /memory reg[3] -> 60000000
[   17.163357] /pci@1f,4000 reg[0] -> 1fe00004000
[    0.035471] /pci@1f,4000 reg[1] -> 1fe01000000
[    0.088525] /pci@1f,4000 reg[2] -> 1fe00000000
[    0.141648] /pci@1f,4000: direct translate 7f1 --> 1
[    0.201019] /pci@1f,4000: direct translate 7ee --> 2
[    0.260384] /pci@1f,4000: direct translate 7ef --> 3
[    0.319760] /pci@1f,4000: direct translate 7e5 --> 4
[    0.379131] /pci@1f,4000: direct translate 7e8 --> 5
[    0.438503] /pci@1f,4000: direct translate 7f2 --> 6
[    0.498343] /pci@1f,4000/ebus@1/auxio@14,726000 reg[0] -> 1fff1726000
[    0.574968] /pci@1f,4000/ebus@1/auxio@14,726000 reg[1] -> 1fff1728000
[    0.652064] /pci@1f,4000/ebus@1/auxio@14,726000 reg[2] -> 1fff172a000
[    0.729144] /pci@1f,4000/ebus@1/auxio@14,726000 reg[3] -> 1fff172c000
[    0.806215] /pci@1f,4000/ebus@1/auxio@14,726000 reg[4] -> 1fff172f000
[    0.883478] /pci@1f,4000/ebus@1/power@14,724000 reg[0] -> 1fff1724000
[    0.960569] /pci@1f,4000/ebus@1/SUNW,pll@14,504000 reg[0] -> 1fff1504000
[    1.040771] /pci@1f,4000/ebus@1/sc@14,500000 reg[0] -> 1fff1500000
[    1.114700] /pci@1f,4000/ebus@1/se@14,400000 reg[0] -> 1fff1400000
[    1.188481] /pci@1f,4000/ebus@1/se@14,400000: Apply [/pci@1f,4000:2b] imap --> [/pci@1f,4000:2b]
[    1.293707] /pci@1f,4000/ebus@1/se@14,400000: Apply IRQ trans [/pci@1f,4000] 2b --> 7
[    1.387626] /pci@1f,4000/ebus@1/se@14,200000 reg[0] -> 1fff1200000
[    1.461357] /pci@1f,4000/ebus@1/se@14,200000: Apply [/pci@1f,4000:23] imap --> [/pci@1f,4000:23]
[    1.566604] /pci@1f,4000/ebus@1/se@14,200000: Apply IRQ trans [/pci@1f,4000] 23 --> 8
[    1.660533] /pci@1f,4000/ebus@1/su@14,3083f8 reg[0] -> 1fff13083f8
[    1.734256] /pci@1f,4000/ebus@1/su@14,3083f8: Apply [/pci@1f,4000:29] imap --> [/pci@1f,4000:29]
[    1.839499] /pci@1f,4000/ebus@1/su@14,3083f8: Apply IRQ trans [/pci@1f,4000] 29 --> 9
[    1.933431] /pci@1f,4000/ebus@1/su@14,3062f8 reg[0] -> 1fff13062f8
[    2.007154] /pci@1f,4000/ebus@1/su@14,3062f8: Apply [/pci@1f,4000:2a] imap --> [/pci@1f,4000:2a]
[    2.112400] /pci@1f,4000/ebus@1/su@14,3062f8: Apply IRQ trans [/pci@1f,4000] 2a --> a
[    2.206342] /pci@1f,4000/ebus@1/ecpp@14,3043bc reg[0] -> 1fff13043bc
[    2.282135] /pci@1f,4000/ebus@1/ecpp@14,3043bc reg[1] -> 1fff1300398
[    2.358190] /pci@1f,4000/ebus@1/ecpp@14,3043bc reg[2] -> 1fff1700000
[    2.434220] /pci@1f,4000/ebus@1/ecpp@14,3043bc: Apply [/pci@1f,4000:22] imap --> [/pci@1f,4000:22]
[    2.541536] /pci@1f,4000/ebus@1/ecpp@14,3043bc: Apply IRQ trans [/pci@1f,4000] 22 --> b
[    2.637544] /pci@1f,4000/ebus@1/eeprom@14,0 reg[0] -> 1fff1000000
[    2.710411] /pci@1f,4000/ebus@1/flashprom@10,0 reg[0] -> 1fff0000000
[    2.786287] /pci@1f,4000/ebus@1/flashprom@10,0 reg[1] -> 1fff0000000
[    2.862510] /pci@1f,4000/ebus@1/SUNW,envctrltwo@14,600000 reg[0] -> 1fff1600000
[    2.949807] /pci@1f,4000/ebus@1/SUNW,envctrltwo@14,600000: Apply [/pci@1f,4000:28] imap --> [/pci@1f,4000:28]
[    3.068600] /pci@1f,4000/ebus@1/SUNW,envctrltwo@14,600000: Apply IRQ trans [/pci@1f,4000] 28 --> 5
[    3.175875] /pci@1f,4000/ebus@1/SUNW,envctrltwo@14,600000: Apply [/pci@1f,4000:25] imap --> [/pci@1f,4000:25]
[    3.294621] /pci@1f,4000/ebus@1/SUNW,envctrltwo@14,600000: Apply IRQ trans [/pci@1f,4000] 25 --> 4
[    3.402116] /pci@1f,4000/network@1,1 reg[0] -> 1ff84100000
[    3.467452] /pci@1f,4000/network@1,1: Apply [/pci@1f,4000:21] imap --> [/pci@1f,4000:21]
[    3.564369] /pci@1f,4000/network@1,1: Apply IRQ trans [/pci@1f,4000] 21 --> c
[    3.649962] /pci@1f,4000/scsi@3 reg[0] -> 1fe02012000
[    3.710145] /pci@1f,4000/scsi@3 reg[1] -> 1ff84108000
[    3.770569] /pci@1f,4000/scsi@3 reg[2] -> 1ff8410a000
[    3.830975] /pci@1f,4000/scsi@3: Apply [/pci@1f,4000:20] imap --> [/pci@1f,4000:20]
[    3.922668] /pci@1f,4000/scsi@3: Apply IRQ trans [/pci@1f,4000] 20 --> d
[    4.003419] /pci@1f,4000/scsi@3,1 reg[0] -> 1fe02012400
[    4.065332] /pci@1f,4000/scsi@3,1 reg[1] -> 1ff8410c000
[    4.127835] /pci@1f,4000/scsi@3,1 reg[2] -> 1ff8410e000
[    4.190332] /pci@1f,4000/scsi@3,1: Apply [/pci@1f,4000:26] imap --> [/pci@1f,4000:26]
[    4.284098] /pci@1f,4000/scsi@3,1: Apply IRQ trans [/pci@1f,4000] 26 --> e
[    4.367152] /pci@1f,4000/pci@5/SUNW,hme@0,1 reg[0] -> 0
[    4.428836] /pci@1f,4000/pci@5/SUNW,hme@0,1 reg[1] -> 0
[    4.491348] /pci@1f,4000/pci@5/SUNW,hme@0,1: PCI swizzle [/pci@1f,4000/pci@5] 2 --> 2
[    4.585136] /pci@1f,4000/pci@5/SUNW,hme@0,1: Apply [/pci@1f,4000:2] imap --> [/pci@1f,4000:1d]
[    4.688249] /pci@1f,4000/pci@5/SUNW,hme@0,1: Apply IRQ trans [/pci@1f,4000] 2 --> f
[    4.780090] /pci@1f,4000/pci@5/SUNW,isptwo@4 reg[0] -> 0
[    4.843389] /pci@1f,4000/pci@5/SUNW,isptwo@4 reg[1] -> 0
[    4.906945] /pci@1f,4000/pci@5/SUNW,isptwo@4 reg[2] -> 0
[    4.970478] /pci@1f,4000/pci@5/SUNW,isptwo@4 reg[3] -> 0
[    5.034017] /pci@1f,4000/pci@5/SUNW,isptwo@4: PCI swizzle [/pci@1f,4000/pci@5] 1 --> 1
[    5.128848] /pci@1f,4000/pci@5/SUNW,isptwo@4: Apply [/pci@1f,4000:1] imap --> [/pci@1f,4000:1c]
[    5.233009] /pci@1f,4000/pci@5/SUNW,isptwo@4: Apply IRQ trans [/pci@1f,4000] 1 --> 10
[    5.327306] /pci@1f,2000 reg[0] -> 1fe00002000
[    5.379801] /pci@1f,2000 reg[1] -> 1fe01800000
[    5.432940] /pci@1f,2000 reg[2] -> 1fe00000000
[    5.486051] /pci@1f,2000: direct translate 7f0 --> 11
[    5.546471] /pci@1f,2000: direct translate 7ee --> 2
[    5.605841] /pci@1f,2000: direct translate 7ef --> 3
[    5.665213] /pci@1f,2000: direct translate 7e5 --> 4
[    5.724578] /pci@1f,2000: direct translate 7e8 --> 5
[    5.783953] /pci@1f,2000: direct translate 7f2 --> 6
[    5.843531] /counter-timer reg[0] -> 1fe00001c00
[    5.898518] /counter-timer reg[1] -> 1fe00001860
[    5.953738] /counter-timer reg[2] -> 1fe00001060
[    6.008941] /counter-timer: Apply [/:7ec] imap --> [NULL:7ec]
[    6.077699] /counter-timer: Apply [/:7ed] imap --> [NULL:7ed]
[    6.146811] /mc reg[0] -> 1c000000000
[    6.190346] /mc/bank@0,0 reg[0] -> 0
[    6.233054] /mc/bank@0,0/dimm@0,0 reg[0] -> 0
[    6.285135] /mc/bank@0,0/dimm@0,1 reg[0] -> 1
[    6.337229] /mc/bank@0,0/dimm@0,2 reg[0] -> 2
[    6.389303] /mc/bank@0,0/dimm@0,3 reg[0] -> 3
[    6.441398] /mc/bank@0,20000000 reg[0] -> 20000000
[    6.498675] /mc/bank@0,20000000/dimm@0,0 reg[0] -> 0
[    6.558052] /mc/bank@0,20000000/dimm@0,1 reg[0] -> 1
[    6.617415] /mc/bank@0,20000000/dimm@0,2 reg[0] -> 2
[    6.676786] /mc/bank@0,20000000/dimm@0,3 reg[0] -> 3
[    6.736177] /mc/bank@0,40000000 reg[0] -> 40000000
[    6.793465] /mc/bank@0,40000000/dimm@0,0 reg[0] -> 0
[    6.852818] /mc/bank@0,40000000/dimm@0,1 reg[0] -> 1
[    6.912214] /mc/bank@0,40000000/dimm@0,2 reg[0] -> 2
[    6.971546] /mc/bank@0,40000000/dimm@0,3 reg[0] -> 3
[    7.030940] /mc/bank@0,60000000 reg[0] -> 60000000
[    7.088224] /mc/bank@0,60000000/dimm@0,0 reg[0] -> 0
[    7.147598] /mc/bank@0,60000000/dimm@0,1 reg[0] -> 1
[    7.206954] /mc/bank@0,60000000/dimm@0,2 reg[0] -> 2
[    7.266338] /mc/bank@0,60000000/dimm@0,3 reg[0] -> 3
[    7.325705] /SUNW,UltraSPARC-II@0,0 reg[0] -> 1c000000000
[    7.390323] /SUNW,UltraSPARC-II@1,0 reg[0] -> 1c200000000
[    7.455477] PCI: Probing for controllers.
[    7.507602] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[    7.569511] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[    7.637443] PCI0(PBMB): Bus running at 33MHz
[    7.687691] PCI0(PBMA): Bus running at 66MHz
[    7.738003] ebus0: [auxio] [power] [SUNW,pll] [sc] [se] [se] [su] [su] [ecpp] [eeprom] [flashprom] [SUNW,envctrltwo]
[    7.864037] power: Control reg at 1fff1724000 ... not using powerd.
[    7.940029] usbcore: registered new driver usbfs
[    7.994305] usbcore: registered new driver hub
[    8.048221] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[    8.125645] /pci@1f,4000/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
[    8.210584] NET: Registered protocol family 2
[    8.305608] IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
[    8.392733] TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
[    8.500716] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[    8.584300] TCP: Hash tables configured (established 262144 bind 65536)
[    8.661904] TCP reno registered
[    8.704767] audit: initializing netlink socket (disabled)
[    8.767771] audit(1153120449.744:1): initialized
[    8.823266] Total HugeTLB memory allocated, 0
[    8.875744] VFS: Disk quotas dquot_6.5.1
[    8.922003] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[    9.000369] Initializing Cryptographic API
[    9.048949] io scheduler noop registered
[    9.095760] io scheduler anticipatory registered (default)
[    9.161395] io scheduler deadline registered
[    9.212477] io scheduler cfq registered
[   13.511816] Console: switching to mono PROM 80x34
[    0.755841] rtc_init: no PC rtc found
[    0.797963] [drm] Initialized drm 1.0.1 20051102
[    0.853922] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
[    0.942869] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
[    1.030823] se@14,400000: ttyS0 at MMIO 0x1fff1400040 (irq = 7) is a SAB82532 V3.2
[    1.121209] Console: ttyS0 (SAB82532)
[    7.233578] se@14,400000: ttyS1 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
[    7.413825] se@14,200000: ttyS2 at MMIO 0x1fff1200040 (irq = 8) is a SAB82532 V3.2
[    7.597584] se@14,200000: ttyS3 at MMIO 0x1fff1200000 (irq = 8) is a SAB82532 V3.2
[    8.177657] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[    8.505947] loop: loaded (max 8 devices)
[    8.709533] sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
[    8.889462] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:d8:e4:6d 
[    9.073726] eth1: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:d8:e4:6d 
[    9.297645] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    9.447146] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    9.657685] rtc_sun_init: Registered Mostek RTC driver.
[    9.780093] usbmon: debugfs is not available
[    9.929730] usbcore: registered new driver usbhid
[   10.038546] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   10.245720] mice: PS/2 mouse device common for all mice
[   10.371931] TCP bic registered
[   10.442232] NET: Registered protocol family 1
[   10.543795] NET: Registered protocol family 17
[   11.380060] input: Sun Mouse as /class/input/input0

-- 
And if you don't know where you're going, any road will take you there...
