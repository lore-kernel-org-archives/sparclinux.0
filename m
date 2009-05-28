From: Robert Reif <reif@earthlink.net>
Date: Thu, 28 May 2009 02:21:37 +0000
Subject: Re: sparc32 boot problem (SCSI?)
Message-Id: <4A1DF531.4030402@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1608E3.6040009@earthlink.net>
In-Reply-To: <4A1608E3.6040009@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Robert Reif wrote:
> I'm trying to bisect this and have narrowed it down to
> late in the merge window.  Unfortunately I can't easily narrow
> it down further because module loading also broke during
> the same time frame.
I bisected it down to this but it makes no sense.

f894e74dc1983062d30d4e1b79bdb90b8a847f52 is first bad commit
commit f894e74dc1983062d30d4e1b79bdb90b8a847f52
Author: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date:   Fri Apr 3 01:42:50 2009 +0530

    [SCSI] qlogicpti: use request_firmware
   
    Firmware blob is little endian
   
    Thanks to Stephen Rothwell for fixing typos
   
    Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
    Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

It's an sbus module but not one I'm using.  I had to disable module
versioning and enable forced module loading to get around the
module loading bug fixed shortly after this series.

May 27 21:19:42 ss20-1 kernel: [42949376.370000] Freeing unused kernel 
memory: 132k freed
May 27 21:19:42 ss20-1 kernel: [42949377.210000] input: Sun Mouse as 
/class/input/input0
May 27 21:19:42 ss20-1 kernel: [42949378.400000] SCSI subsystem initialized
May 27 21:19:42 ss20-1 kernel: [42949378.540000] esp: esp0, 
regs[fd407000:fd406000] irq[36]
May 27 21:19:42 ss20-1 kernel: [42949378.550000] esp: esp0 is a FAS100A, 
40 MHz (ccf=0), SCSI ID 7
May 27 21:19:42 ss20-1 kernel: [42949381.570000] scsi0 : esp
May 27 21:19:42 ss20-1 kernel: [42949381.590000] esp: esp1, 
regs[fd409000:fd408000] irq[53]
May 27 21:19:42 ss20-1 kernel: [42949381.600000] esp: esp1 is a FASHME, 
40 MHz (ccf=0), SCSI ID 7
May 27 21:19:42 ss20-1 kernel: [42949384.620000] scsi1 : esp
May 27 21:19:42 ss20-1 kernel: [42949384.650000] scsi 1:0:0:0: 
Direct-Access     SEAGATE  ST39102LCSUN9.0G 0828 PQ: 0 ANSI: 2
May 27 21:19:42 ss20-1 kernel: [42949384.660000]  target1:0:0: Beginning 
Domain Validation
May 27 21:19:42 ss20-1 kernel: [42949384.680000]  target1:0:0: FAST-10 
WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
May 27 21:19:42 ss20-1 kernel: [42949384.690000]  target1:0:0: Domain 
Validation skipping write tests
May 27 21:19:42 ss20-1 kernel: [42949384.700000]  target1:0:0: Ending 
Domain Validation
May 27 21:19:42 ss20-1 kernel: [42949389.550000] Driver 'sd' needs 
updating - please use bus_type methods
May 27 21:19:42 ss20-1 kernel: [42949389.580000] sd 1:0:0:0: [sda] 
17689267 512-byte hardware sectors: (9.05 GB/8.43 GiB)
May 27 21:19:42 ss20-1 kernel: [42949389.590000] sd 1:0:0:0: [sda] Write 
Protect is off
May 27 21:19:42 ss20-1 kernel: [42949389.600000] sd 1:0:0:0: [sda] Mode 
Sense: cf 00 10 08
May 27 21:19:42 ss20-1 kernel: [42949389.600000] sd 1:0:0:0: [sda] Write 
cache: disabled, read cache: enabled, supports DPO and FUA
May 27 21:19:42 ss20-1 kernel: [42949389.620000]  sda: sda1 sda2 sda3 sda4
May 27 21:19:42 ss20-1 kernel: [42949389.680000] sd 1:0:0:0: [sda] 
Attached SCSI disk

