From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 07 May 2007 19:49:30 +0000
Subject: Re: [PATCH]: Final ESP driver rewrite
Message-Id: <20070507194930.GB27915@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20070427.002829.43009224.davem@davemloft.net>
In-Reply-To: <20070427.002829.43009224.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello David,

Building this I got the following warnings from modpost:

WARNING: vmlinux - Section mismatch: reference to .init.text:esp_bootup_reset from .text between 'esp_eh_host_reset_handler' (at offset 0x108814) and 'esp_info'
WARNING: vmlinux - Section mismatch: reference to .init.text:scsi_esp_register from __ksymtab between '__ksymtab_scsi_esp_register' (at offset 0x2a20) and '__ksymtab_scsi_esp_intr'

Regarding the first one: esp_bootup_reset gets called from
esp_eh_host_reset_handler, so it cannot be __devinit. The patch
attached fixes this.

The second one is more tricky. From my understanding the ksymtab
sections do not affect what modpost is checking here, so my guess
is we should ignore that warning.

I've also attached the boot output I get, no problems with the code.
Nice job!

Regards,
Martin Habets

        Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
esp: esp0, regs[fd016000:fd00f000] irq[36]
esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
scsi0 : esp
scsi 0:0:0:0: Sequential-Access Quantum  DLT4000          DA97 PQ: 0 ANSI: 2
 target0:0:0: Beginning Domain Validation
 target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
scsi 0:0:1:0: Direct-Access     SEAGATE  ST39173W SUN9.0G 7063 PQ: 0 ANSI: 2
 target0:0:1: Beginning Domain Validation
 target0:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:1: Domain Validation skipping write tests
 target0:0:1: Ending Domain Validation
scsi 0:0:3:0: Direct-Access     SEAGATE  ST32550W SUN2.1G 0416 PQ: 0 ANSI: 2
 target0:0:3: Beginning Domain Validation
 target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:3: Domain Validation skipping write tests
 target0:0:3: Ending Domain Validation
esp: esp0, regs[fd017000:fd011000] irq[53]
esp: esp0 is a FAS236, 40 MHz (ccf=0), SCSI ID 7
scsi1 : esp
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
sd 0:0:1:0: Attached scsi disk sda
SCSI device sdb: 4194995 512-byte hdwr sectors (2148 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sdb: 4194995 512-byte hdwr sectors (2148 MB)
sdb: Write Protect is off
sdb: Mode Sense: ab 00 10 08
SCSI device sdb: write cache: disabled, read cache: enabled, supports DPO and FUA
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5
sd 0:0:3:0: Attached scsi disk sdb

---
Index: linux/drivers/scsi/esp_scsi.c
=================================--- linux.orig/drivers/scsi/esp_scsi.c	2007-05-07 14:33:05.000000000 +0100
+++ linux/drivers/scsi/esp_scsi.c	2007-05-07 20:37:29.000000000 +0100
@@ -2211,7 +2211,7 @@
 }
 
 /* This places the ESP into a known state at boot time. */
-static void __devinit esp_bootup_reset(struct esp *esp)
+static void esp_bootup_reset(struct esp *esp)
 {
 	u8 val;
 
