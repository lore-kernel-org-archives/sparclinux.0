From: Meelis Roos <mroos@linux.ee>
Date: Mon, 17 Apr 2006 15:49:41 +0000
Subject: Re: 2.6.17-rc1+git, Sym2: unknown symbol pcibios_resource_to_bus
Message-Id: <Pine.SOC.4.61.0604171849100.21709@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Forwarded from linux-scsi.

---------- Forwarded message ----------
Date: Mon, 17 Apr 2006 10:30:50 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-scsi@vger.kernel.org
Subject: Re: 2.6.17-rc1+git, Sym2: unknown symbol pcibios_resource_to_bus

On Mon, 2006-04-17 at 13:22 +0300, Meelis Roos wrote:
> WARNING: /lib/modules/2.6.17-rc1-gc19f7a9e/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.ko needs unknown symbol pcibios_resource_to_bus
>
> Is is something missing from sparc64, or is sym53c8xx using something
> arch-specific (pcibios sounds like it)?

pcibios_resource_to_bus is a new function which is inline in
asm-generic/pci.h.   However, sparc64 overrides it as an external
function which is in arch/sparc64/kernel/pci.c, so this looks like some
type of sparc issue.

James

