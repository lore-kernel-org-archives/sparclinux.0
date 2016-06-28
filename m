From: Meelis Roos <mroos@linux.ee>
Date: Tue, 28 Jun 2016 10:27:36 +0000
Subject: Re: [PATCH] sparc64: sparc64_defconfig: convert to use libata PATA drivers
Message-Id: <alpine.LRH.2.20.1606281318080.8814@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <1467030232-10027-1-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1467030232-10027-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The Ultra 5 uses a CMD64x controller.
> 
> That said, last time I tried to get that machine working, I couldn't
> partition the disk due to bugs in that driver.

Yes, Ultra 5 uses CMD64x. This has worked well for me on U5 for ages. 
The debug messages have also been there as long as I remember. The 
controller is limited to 128GiB disks in DMA mode so I have used up to 
120G disks only and have not tried any bigger ones.

[    0.000000] Linux version 4.7.0-rc4-dirty (mroos@u5) (gcc version 4.9.3 (Debian 4.9.3-2) ) #44 Mon Jun 20 23:34:30 EEST 2016

[...]

[  120.758330] scsi host0: pata_cmd64x
[  120.792553] scsi host1: pata_cmd64x
[  120.823204] ata1: PATA max MWDMA2 cmd 0x1fe02c00000 ctl 0x1fe02c00008 bmdma 0x1fe02c00020 irq 14
[  120.921890] ata2: PATA max MWDMA2 cmd 0x1fe02c00010 ctl 0x1fe02c00018 bmdma 0x1fe02c00028 irq 14
[  121.021552] pata_cmd64x: active 10 recovery 10 setup 3.
[  121.694109] pata_cmd64x: active 10 recovery 10 setup 3.
[  122.244996] pata_cmd64x: active 3 recovery 1 setup 1.
[  122.342321] pata_cmd64x: active 3 recovery 1 setup 1.
[  122.533229] ata1.00: configured for MWDMA2
[  122.574590] scsi 0:0:0:0: Direct-Access     ATA      ST3120026A       3.06 PQ: 0 ANSI: 5
[  122.704312] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
[  122.785084] sd 0:0:0:0: [sda] Write Protect is off
[  122.828859] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  122.876026] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  122.977380] pata_cmd64x: active 10 recovery 10 setup 3.
[  123.038061] pata_cmd64x: active 10 recovery 10 setup 3.
[  123.182957]  sda: sda1 sda2 sda3
[  123.215754] sd 0:0:0:0: [sda] Attached SCSI disk
[  123.295854] ata2.00: ATAPI: CRD-8322B, 1.06, max MWDMA2
[  123.350108] pata_cmd64x: active 3 recovery 1 setup 1.
[  123.405746] pata_cmd64x: active 3 recovery 1 setup 1.
[  123.504198] ata2.00: configured for MWDMA2
[  123.590960] scsi 1:0:0:0: CD-ROM               LG    CD-ROM CRD-8322B 1.06 PQ: 0 ANSI: 5
[  123.761319] sr 1:0:0:0: [sr0] scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
[  123.840121] cdrom: Uniform CD-ROM driver Revision: 3.20
[  123.901685] sr 1:0:0:0: Attached scsi CD-ROM sr0


> I believe the Ultra 10 uses the same motherboard so it's likely also
> affected. I believe these were in the first generation of "PC" like
> SPARC workstations.

Yes, Ultra 10 uses the same mainboard but in a more roomy tower case. My 
U10 has addon PCI SCSI controller so I'm not testing IDE there.

-- 
Meelis Roos (mroos@linux.ee)
