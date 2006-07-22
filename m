From: David Miller <davem@davemloft.net>
Date: Sat, 22 Jul 2006 08:35:41 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <20060722.013541.108738463.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Newport <crn@netunix.com>
Date: Fri, 21 Jul 2006 23:03:31 +0100

> A year or so ago I did a few patches for Sun4d and there was a note in 
> the iommu code about sun4d not having a register that was used for 
> scratch data in sun4m.
> Could this bug be back ?
> 
> Sorry to be vague, this is from memory.

It would be nice to have something specific, I see nothing
explicit in the current tree:

arch/sparc/kernel/entry.S:	 * %l5 -- scratch for ld/st address
arch/sparc/kernel/entry.S:	 * %l7 -- scratch [floppy byte, ld/st address, aux. data]
arch/sparc/kernel/wuf.S:/* Now macros for the available scratch registers in this routine. */
