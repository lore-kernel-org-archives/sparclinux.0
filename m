From: Meelis Roos <mroos@linux.ee>
Date: Sun, 12 Aug 2007 11:42:03 +0000
Subject: ESP: cosmetic printk error during detection
Message-Id: <Pine.SOC.4.64.0708121438030.24332@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I testbooted 2.6.23-rc2 on my Ultra 1 that has 3 SCSI controllers - 
builtin, ESP, addon esp+hme and a qlogicpti. The detection lines of both 
these esp controllers tell about esp0 although they clearly seem to be 
about different controllers:

esp: esp0, regs[1ffe8800000:1ffe8400000] irq[10]
esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
scsi0 : esp
esp: esp0, regs[1ff08810000:1ff08800000] irq[14]
esp: esp0 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
scsi 0:0:0:0: Direct-Access     MAXTOR   ATLAS10K4_36SCA  DFV0 PQ: 0 ANSI: 3
 target0:0:0: Beginning Domain Validation
 target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
scsi 0:0:6:0: CD-ROM            TOSHIBA  XM-5401TASUN4XCD 2565 PQ: 0 ANSI: 2
 target0:0:6: Beginning Domain Validation
 target0:0:6: FAST-5 SCSI 4.2 MB/s ST (236 ns, offset 15)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation
scsi1 : esp

The second esp0 should be esp1. In the code, esp->host->unique_id is 
printed there and after printing the unique_id is assigned like that: 

esp->host->unique_id = instance++;

Should it be ++instance instead?

-- 
Meelis Roos (mroos@linux.ee)
