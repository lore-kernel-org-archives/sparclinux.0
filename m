From: Pasi Pirhonen <upi@centos.fi>
Date: Thu, 19 Apr 2007 13:04:15 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070419130414.GE6300@centos.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Thu, Apr 19, 2007 at 12:41:39AM -0700, David Miller wrote:
> 
> The current driver should not hit the problems you saw.  I plan
> to post in-full the current driver as a patch in a few moments,
> if you could retest this case with it, I'd really appreciate it.
> 

Did add this 'new esp v2' to linux-2.6.21-rc7 and booted with two of
those seagates, which did timeout previously. No problems at all.
Ran quickly 'dbench 32' for sda and sdb simultaneously, if that is
proving anything. Will leave those running in loop while i do get some
sleep .... and hope those dbench-loop will be still alive when i wake
up :)

Good job so far with the new esp driver.


---- CLIP CLIP ----
SCSI subsystem initialized
scsi0 : esp
esp: esp0 found at /sbus@3,0/SUNW,fas@3,8800000,
regs[1c738810000:1c738800000] irq[20]
esp: esp0 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
scsi 0:0:0:0: Sequential-Access HP       C1537A           L007 PQ: 0 ANSI: 2
 target0:0:0: Beginning Domain Validation
 target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
scsi 0:0:2:0: Direct-Access     SEAGATE  ST336704LSUN36G  032C PQ: 0 ANSI: 3
 target0:0:2: Beginning Domain Validation
 target0:0:2: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
 target0:0:2: Domain Validation skipping write tests
 target0:0:2: Ending Domain Validation
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:2:0: Attached scsi disk sda
scsi 0:0:3:0: Direct-Access     SEAGATE  ST336704LSUN36G  032C PQ: 0 ANSI: 3
 target0:0:3: Beginning Domain Validation
 target0:0:3: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
 target0:0:3: Domain Validation skipping write tests
 target0:0:3: Ending Domain Validation
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
sdb: Write Protect is off
sdb: Mode Sense: cf 00 10 08
SCSI device sdb: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
sdb: Write Protect is off
sdb: Mode Sense: cf 00 10 08
SCSI device sdb: write cache: disabled, read cache: enabled, supports DPO and FUA
 sdb: sdb1 sdb2 sdb3
sd 0:0:3:0: Attached scsi disk sdb
scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
 target0:0:6: Beginning Domain Validation
 target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
--- CLIP CLIP ---

-- 
Pasi Pirhonen - upi@iki.fi - http://pasi.pirhonen.eu/
Top-postings silently ignored
