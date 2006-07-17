From: Marc Zyngier <maz@misterjones.org>
Date: Mon, 17 Jul 2006 12:33:59 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <wrpodvocsw8.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "David" = David Miller <davem@davemloft.net> writes:

David> Please turn off CONFIG_PROM_CONSOLE if you have that thing
David> enabled, just as a test.

Just did it, but it doesn't change anything. I'm afraid we're facing
multiple issues here, so I tried to narrow things down a bit.

I compiled a minimal kernel with SCSI build-in, and booted it. Didn't
see anything, serial console stayed silent. Booted it again with '-p',
and discovered quite a few things :

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.18-rc2 (maz@positive) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #15 SMP Mon Jul 17 11:44:17 CEST 2006
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:d8:e4:6d
Remapping the kernel... done.
[    0.000000] PROM: Built device tree with 75588 bytes of memory.
Booting Linux...
[    0.000000] Built 1 zonelists.  Total pages: 261515
[    0.000000] Kernel command line: root=/dev/sda2 ro -p
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    1.768082] Console: colour dummy device 80x25
[    1.830464] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[    1.924328] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    2.133255] Memory: 2072816k available (2336k kernel code, 768k data, 160k init) [fffff80000000000,000000007fecc000]
[    2.334845] Calibrating delay using timer specific routine.. 800.45 BogoMIPS (lpj00910)
[    2.432463] Mount-cache hash table entries: 512
[    2.487169] CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
[    2.598827] Using max_cache_size of 2MB
[    2.734847] Calibrating delay using timer specific routine.. 800.05 BogoMIPS (lpj00113)
[    2.734987] CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
[    2.735669] CPU 1: synchronized TICK with master CPU (last diff 1 cycles,maxerr 670 cycles)
[    2.735688] Brought up 2 CPUs
[    2.735707] Total of 2 processors activated (1600.51 BogoMIPS).
[    4.821092] migration_cost@125
[    4.860133] NET: Registered protocol family 16
[    4.925643] PCI: Probing for controllers.
[    4.980633] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[    5.042506] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[    5.110741] PCI0(PBMB): Bus running at 33MHz
[    5.161031] PCI0(PBMA): Bus running at 66MHz
[    5.211222] ebus0: [auxio] [power] [SUNW,pll] [sc] [se] [se] [su] [su] [ecpp] [eeprom] [flashprom] [SUNW,envctrltwo]
[    5.337246] power: Control reg at 1fff1724000 ... not using powerd.
[    5.413586] SCSI subsystem initialized
[    5.457801] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[    5.535585] /pci@1f,4000/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
[    5.620335] NET: Registered protocol family 2
[    5.715112] IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
[    5.802151] TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
[    5.910219] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[    5.994188] TCP: Hash tables configured (established 262144 bind 65536)
[    6.071662] TCP reno registered
[    6.113577] audit: initializing netlink socket (disabled)
[    6.176488] audit(1153136985.744:1): initialized
[    6.231980] Total HugeTLB memory allocated, 0
[    6.285168] Initializing Cryptographic API
[    6.332892] io scheduler noop registered
[    6.379724] io scheduler anticipatory registered (default)
[    6.445331] io scheduler deadline registered
[    6.496446] io scheduler cfq registered
[    6.702611] rtc_init: no PC rtc found
[    6.745455] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
[    6.834564] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
[    6.922385] se@14,400000: ttyS0 at MMIO 0x1fff1400040 (irq = 7) is a SAB82532 V3.2
[    7.012992] Console: ttyS0 (SAB82532)
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.18-rc2 (maz@positive) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #15 SMP Mon Jul 17 11:44:17 CEST 2006
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:d8:e4:6d
[    0.000000] PROM: Built device tree with 75588 bytes of memory.
[    0.000000] Built 1 zonelists.  Total pages: 261515
[    0.000000] Kernel command line: root=/dev/sda2 ro -p
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    1.768082] Console: colour dummy device 80x25
[    1.830464] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[    1.924328] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    2.133255] Memory: 2072816k available (2336k kernel code, 768k data, 160k init) [fffff80000000000,000000007fecc000]
[    2.334845] Calibrating delay using timer specific routine.. 800.45 BogoMIPS (lpj00910)
[    2.432463] Mount-cache hash table entries: 512
[    2.487169] CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
[    2.598827] Using max_cache_size of 2MB
[    2.734847] Calibrating delay using timer specific routine.. 800.05 BogoMIPS (lpj00113)
[    2.734987] CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)] E[sz(2097152):line_sz(64)]
[    2.735669] CPU 1: synchronized TICK with master CPU (last diff 1 cycles,maxerr 670 cycles)
[    2.735688] Brought up 2 CPUs
[    2.735707] Total of 2 processors activated (1600.51 BogoMIPS).
[    4.821092] migration_cost@125
[    4.860133] NET: Registered protocol family 16
[    4.925643] PCI: Probing for controllers.
[    4.980633] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[    5.042506] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[    5.110741] PCI0(PBMB): Bus running at 33MHz
[    5.161031] PCI0(PBMA): Bus running at 66MHz
[    5.211222] ebus0: [auxio] [power] [SUNW,pll] [sc] [se] [se] [su] [su] [ecpp] [eeprom] [flashprom] [SUNW,envctrltwo]
[    5.337246] power: Control reg at 1fff1724000 ... not using powerd.
[    5.413586] SCSI subsystem initialized
[    5.457801] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[    5.535585] /pci@1f,4000/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
[    5.620335] NET: Registered protocol family 2
[    5.715112] IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
[    5.802151] TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
[    5.910219] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[    5.994188] TCP: Hash tables configured (established 262144 bind 65536)
[    6.071662] TCP reno registered
[    6.113577] audit: initializing netlink socket (disabled)
[    6.176488] audit(1153136985.744:1): initialized
[    6.231980] Total HugeTLB memory allocated, 0
[    6.285168] Initializing Cryptographic API
[    6.332892] io scheduler noop registered
[    6.379724] io scheduler anticipatory registered (default)
[    6.445331] io scheduler deadline registered
[    6.496446] io scheduler cfq registered
[    6.702611] rtc_init: no PC rtc found
[    6.745455] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
[    6.834564] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
[    6.922385] se@14,400000: ttyS0 at MMIO 0x1fff1400040 (irq = 7) is a SAB82532 V3.2
[    7.012992] Console: ttyS0 (SAB82532)
[   14.336491] se@14,400000: ttyS1 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
[   14.521423] se@14,200000: ttyS2 at MMIO 0x1fff1200040 (irq = 8) is a SAB82532 V3.2
[   14.700346] se@14,200000: ttyS3 at MMIO 0x1fff1200000 (irq = 8) is a SAB82532 V3.2
[   14.883155] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   15.063393] loop: loaded (max 8 devices)
[   15.154829] sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
[   15.326396] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:d8:e4:6d 
[   15.487428] eth1: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:d8:e4:6d 
[   15.648382] sym0: <875> rev 0x14 at pci 0001:00:03.0 irq 13
[   15.866066] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   16.010457] sym0: SCSI BUS has been reset.
[   16.104719] scsi0 : sym-2.2.3
[    1.957508]   Vendor: SEAGATE   Model: ST32171W SUN2.1G  Rev: 7462
[    2.066401]   Type:   Direct-Access                      ANSI SCSI revision: 02
[    2.234826]  target0:0:0: tagged command queuing enabled, command queue depth 16.
[    2.412770]  target0:0:0: Beginning Domain Validation
[    2.532142]  target0:0:0: asynchronous
[    2.637839]  target0:0:0: wide asynchronous
[    2.742849]  target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
[    2.917316]  target0:0:0: Domain Validation skipping write tests
[    3.058940]  target0:0:0: Ending Domain Validation
[    4.407074]   Vendor: HP        Model: C1537A            Rev: L706
[    4.516051]   Type:   Sequential-Access                  ANSI SCSI revision: 02
[    4.684657]  target0:0:5: Beginning Domain Validation
[    4.804890]  target0:0:5: asynchronous
[    4.909228]  target0:0:5: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
[    5.077111]  target0:0:5: Domain Validation skipping write tests
[    5.218782]  target0:0:5: Ending Domain Validation
[    5.353655]   Vendor: TOSHIBA   Model: XM6201TASUN32XCD  Rev: 1103
[    5.462607]   Type:   CD-ROM                             ANSI SCSI revision: 02
[    5.631071]  target0:0:6: Beginning Domain Validation
[    5.750068]  target0:0:6: asynchronous
[    5.840347]  target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
[    5.997596]  target0:0:6: Domain Validation skipping write tests
[    6.139255]  target0:0:6: Ending Domain Validation
[    8.603938] sym1: <875> rev 0x14 at pci 0001:00:03.1 irq 14
[    8.823119] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[    8.970624] sym1: SCSI BUS has been reset.
[    9.066495] scsi1 : sym-2.2.3
[   11.976523]   Vendor: FUJITSU   Model: MAB3045S SUN4.2G  Rev: 2107
[   12.085147]   Type:   Direct-Access                      ANSI SCSI revision: 02
[   12.252863]  target1:0:0: tagged command queuing enabled, command queue depth 16.
[   12.429503]  target1:0:0: Beginning Domain Validation
[   12.548063]  target1:0:0: asynchronous
[   12.638502]  target1:0:0: wide asynchronous
[   12.737156]  target1:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
[   12.902699]  target1:0:0: Domain Validation skipping write tests
[   13.043851]  target1:0:0: Ending Domain Validation
[    0.088326] SCSI device sda: 4157201 512-byte hdwr sectors (2128 MB)
[    0.243839] sda: Write Protect is off
[    0.334634] SCSI device sda: drive cache: write through w/ FUA
[    0.477664] SCSI device sda: 4157201 512-byte hdwr sectors (2128 MB)
[    0.633037] sda: Write Protect is off
[    0.723869] SCSI device sda: drive cache: write through w/ FUA
[    0.861390]  sda: sda1 sda2 sda3 sda4
[    0.962079] sd 0:0:0:0: Attached scsi disk sda
[    1.070488] SCSI device sdb: 8385121 512-byte hdwr sectors (4293 MB)
[    1.222523] sdb: Write Protect is off
[    1.308145] SCSI device sdb: drive cache: write through
[    1.431608] SCSI device sdb: 8385121 512-byte hdwr sectors (4293 MB)
[    1.583307] sdb: Write Protect is off
[    1.669874] SCSI device sdb: drive cache: write through
[    1.792189]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7 sdb8
[    1.911027] sd 1:0:0:0: Attached scsi disk sdb
[    2.014949] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.139608] scsi 0:0:5:0: Attached scsi generic sg1 type 1
[    2.267420] scsi 0:0:6:0: Attached scsi generic sg2 type 5
[    2.395262] sd 1:0:0:0: Attached scsi generic sg3 type 0
[    2.520118] rtc_sun_init: Registered Mostek RTC driver.
[    2.643201] mice: PS/2 mouse device common for all mice
[    2.766680] TCP bic registered
[    2.837032] NET: Registered protocol family 1
[    2.938572] NET: Registered protocol family 17
[    3.065107] EXT3-fs: INFO: recovery required on readonly filesystem.
[    3.215155] EXT3-fs: write access will be enabled during recovery.
[    3.764644] input: Sun Mouse as /class/input/input0
[    3.917323] kjournald starting.  Commit interval 5 seconds
[    3.981288] EXT3-fs: recovery complete.
[    3.993637] EXT3-fs: mounted filesystem with ordered data mode.
[    4.274657] VFS: Mounted root (ext3 filesystem) readonly.

First, SCSI was correctly probed and root fs mounted, so we know that
at least some PCI devices have their interrupt correctly configured
thanks to your latest patch.

Then, we still have a problem with sunsab, as ports are registered in
a different order from what we had in 2.6.15 :

[    7.949257] ttyS0 at MMIO 0x1fff1400000 (irq = 7790816) is a SAB82532 V3.2
[    7.949508] Console: ttyS0 (SAB82532)
[   11.662182] ttyS1 at MMIO 0x1fff1400040 (irq = 7790816) is a SAB82532 V3.2
[   11.743901] ttyS2 at MMIO 0x1fff1200000 (irq = 7790560) is a SAB82532 V3.2
[   11.826468] ttyS3 at MMIO 0x1fff1200040 (irq = 7790560) is a SAB82532 V3.2

Would have to swap between 0x1fff1400000 and 0x1fff1400040. I'll try
to come up with a patch if I can spare some time tonight.

Finally, it looks like the box silently hangs as soon as it reaches
user-mode. Irk...

	M.
-- 
And if you don't know where you're going, any road will take you there...
