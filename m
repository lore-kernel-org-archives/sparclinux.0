From: Meelis Roos <mroos@linux.ee>
Date: Sun, 15 Mar 2009 13:23:48 +0000
Subject: Re: Ultra1 ESP detection problem
Message-Id: <Pine.SOC.4.64.0903151522120.17798@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0903132344220.21922@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I attached a patch, let me know if it works for you.

It works, thank you!

[   43.147216] esp: esp0, regs[1ffe8800000:1ffe8400000] irq[10]
[   43.213133] esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
[   46.291912] scsi0 : esp
[   46.323301] scsi 0:0:0:0: Direct-Access     MAXTOR   ATLAS10K4_36SCA  DFV0 PQ: 0 ANSI: 3
[   46.418551] scsi target0:0:0: Beginning Domain Validation
[   46.485859] scsi target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   46.568915] scsi target0:0:0: Domain Validation skipping write tests
[   46.643444] scsi target0:0:0: Ending Domain Validation
[   47.884605] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM-5401TASUN4XCD 2565 PQ: 0 ANSI: 2
[   47.979808] scsi target0:0:6: Beginning Domain Validation
[   48.058500] scsi target0:0:6: FAST-5 SCSI 4.2 MB/s ST (236 ns, offset 15)
[   48.145698] scsi target0:0:6: Domain Validation skipping write tests
[   48.219925] scsi target0:0:6: Ending Domain Validation
[   48.290452] esp: esp1, regs[1ff08810000:1ff08800000] irq[14]
[   48.356317] esp: esp1 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[   51.432077] scsi1 : esp
[   54.975344] Driver 'sd' needs updating - please use bus_type methods
[   55.051093] sd 0:0:0:0: [sda] 71833096 512-byte hardware sectors: (36.7 GB/34.2 GiB)
[   55.144227] sd 0:0:0:0: [sda] Write Protect is off
[   55.199693] sd 0:0:0:0: [sda] Mode Sense: ed 00 10 08
[   55.261650] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   55.364374] sd 0:0:0:0: [sda] 71833096 512-byte hardware sectors: (36.7 GB/34.2 GiB)
[   55.457911] sd 0:0:0:0: [sda] Write Protect is off
[   55.513420] sd 0:0:0:0: [sda] Mode Sense: ed 00 10 08
[   55.575465] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   55.677044]  sda: sda1 sda2 sda3 sda4
[   55.725075] sd 0:0:0:0: [sda] Attached SCSI disk
[   62.519240] Driver 'sr' needs updating - please use bus_type methods
[   63.493504] sr0: scsi-1 drive
[   63.527163] Uniform CD-ROM driver Revision: 3.20
[   63.583676] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   64.471604] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   64.533811] sr 0:0:6:0: Attached scsi generic sg1 type 5


-- 
Meelis Roos (mroos@linux.ee)
