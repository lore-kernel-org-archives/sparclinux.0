From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 17 Apr 2006 20:17:05 +0000
Subject: Re: 2.6.17-rc1+git, Sym2: unknown symbol pcibios_resource_to_bus
Message-Id: <20060417.131705.40072804.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0604171849100.21709@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0604171849100.21709@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sparclinux@vger.kernel.org, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 17 Apr 2006 18:49:41 +0300 (EEST)

Putting linux-scsi and James back on the CC:

> Forwarded from linux-scsi.
 ...
> pcibios_resource_to_bus is a new function which is inline in
> asm-generic/pci.h.   However, sparc64 overrides it as an external
> function which is in arch/sparc64/kernel/pci.c, so this looks like some
> type of sparc issue.

Why does the SYM2 driver possible even need this symbol?
That's what I'd like to have explained.

When this slipped into the Ubuntu kernel, I pushed back on it because
the usage was bogus, and I fear this is the same exact thing rearing
it's ugly head.

There is no reason to export this symbol outside of the generic PCI
code, which does not require a module symbol export.
