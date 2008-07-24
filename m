From: David Miller <davem@davemloft.net>
Date: Thu, 24 Jul 2008 03:25:33 +0000
Subject: Re: [Bug 11046] New: Kernel bug in mm/bootmem.c on Sparc machines
Message-Id: <20080723.202533.114601491.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-11046-27@http.bugzilla.kernel.org/>
	<20080706132049.4019e09f.akpm@linux-foundation.org>
In-Reply-To: <20080706132049.4019e09f.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, lomp0101@gmx.net, linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 6 Jul 2008 13:20:49 -0700

> On Sun,  6 Jul 2008 13:02:28 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id046
 ...
> > Here is the BUG:
> > 
> > [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.11.5 2003/11/12 10:40'
> > [    0.000000] PROMLIB: Root node compatible: 
> > [    0.000000] Linux version 2.6.25.10 (root@sparc1) (gcc version 4.1.2
> > 20061115 (prerelease) (Debian 4.1.1-21)) #5 SMP Sun Jul 6 21:05:42 CEST 2008
> > [    0.000000] console [earlyprom0] enabled
> > [    0.000000] ARCH: SUN4U
> > [    0.000000] Ethernet address: 00:03:ba:7a:f3:d6
> > [    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
> > [    0.000000] Remapping the kernel... done.
> > [    0.000000] kernel BUG at mm/bootmem.c:125!

This can only happen if you attach a zero-sized initrd to the kernel.

I see platforms like x86 sometimes have explicit checks for a zero
size to guard reserve_bootmem() and similar calls, but if that's what
callers are all going to do doesn't it make better sense for
reserve_bootmem_core() to just return instead of BUG on a zero size
argument?
