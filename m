From: Robert Reif <reif@earthlink.net>
Date: Fri, 22 May 2009 02:07:31 +0000
Subject: sparc32 boot problem (SCSI?)
Message-Id: <4A1608E3.6040009@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc32 v2.6.29 boots and runs fine.
sparc32 v2.6.30-rc6 fails at root filesystem detection.

Looks like a SCSI issue?

Here are the relevant boot log differences:

v2.6.29:
Begin: Loading essential drivers... ...
[42949381.570000] SCSI subsystem initialized
[42949381.710000] esp: esp0, regs[fd407000:fd406000] irq[36]
[42949381.720000] esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
[42949384.740000] scsi0 : esp
[42949384.760000] esp: esp1, regs[fd409000:fd408000] irq[53]
[42949384.770000] esp: esp1 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[42949387.790000] scsi1 : esp
[42949387.830000] scsi 1:0:0:0: Direct-Access     SEAGATE  
ST39102LCSUN9.0G 0822
[42949387.840000]  target1:0:0: Beginning Domain Validation
[42949387.870000]  target1:0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, 
offset )
[42949387.900000]  target1:0:0: Domain Validation skipping write tests
[42949387.910000]  target1:0:0: Ending Domain Validation
Done.
Begin: Running /scripts/init-premount ...
[42949392.670000] Driver 'sd' needs updating - please use bus_type methods
[42949392.710000] sd 1:0:0:0: [sda] 17689267 512-byte hardware sectors: 
(9.05 G)
[42949392.720000] sd 1:0:0:0: [sda] Write Protect is off
[42949392.740000] sd 1:0:0:0: [sda] Write cache: disabled, read cache: 
enabled,A
[42949392.750000] sd 1:0:0:0: [sda] 17689267 512-byte hardware sectors: 
(9.05 G)
[42949392.760000] sd 1:0:0:0: [sda] Write Protect is off
[42949392.770000] sd 1:0:0:0: [sda] Write cache: disabled, read cache: 
enabled,A
[42949392.780000]  sda: sda1 sda2 sda3 sda4
[42949392.830000] sd 1:0:0:0: [sda] Attached SCSI disk
Done.
Begin: Mounting root file system... ...
Begin: Running /scripts/local-top ...
Done.
Begin: Running /scripts/local-premount ...
Done.

v2.6.30-rc6:
Begin: Loading essential drivers... ...
[    5.350000] SCSI subsystem initialized
[    5.490000] esp: esp0, regs[fd407000:fd406000] irq[36]
[    5.500000] esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
[    8.520000] scsi0 : esp
[    8.530000] esp: esp1, regs[fd409000:fd408000] irq[53]
[    8.540000] esp: esp1 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[   11.560000] scsi1 : esp
[   11.580000] scsi 1:0:0:0: Direct-Access     SEAGATE  ST39102LCSUN9.0G 
0828 P2
[   11.590000]  target1:0:0: Beginning Domain Validation
[   11.610000]  target1:0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, 
offset 15)
[   11.630000]  target1:0:0: Domain Validation skipping write tests
[   11.640000]  target1:0:0: Ending Domain Validation
Done.
Begin: Running /scripts/init-premount ...
[   16.060000] Driver 'sd' needs updating - please use bus_type methods
[   16.090000] sd 1:0:0:0: [sda] 17689267 512-byte hardware sectors: 
(9.05 GB/8)
[   16.100000] sd 1:0:0:0: [sda] Write Protect is off
[   16.110000] sd 1:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, suA
[   16.130000]  sda: sda1 sda2 sda3 sda4
[   16.190000] sd 1:0:0:0: [sda] Attached SCSI disk
Done.
Begin: Mounting root file system... ...
Begin: Running /scripts/local-top ...
Done.
Begin: Waiting for root file system... ...
Done.
Begin: Running /scripts/local-premount ...
Done.
mount: Mounting /dev/sda2 on /root failed: No such device
Begin: Running /scripts/local-bottom ...
Done.
Done.
Begin: Running /scripts/init-bottom ...
mount: Mounting /root/dev on /dev/.static/dev failed: No such file or 
directory
Done.
mount: Mounting /sys on /root/sys failed: No such file or directory
mount: Mounting /proc on /root/proc failed: No such file or directory
Target filesystem doesn't have /sbin/init

