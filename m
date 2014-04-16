From: mroos@linux.ee
Date: Wed, 16 Apr 2014 22:22:17 +0000
Subject: Re: sparc64 WARNING: at mm/mmap.c:2757 exit_mmap+0x13c/0x160()
Message-Id: <alpine.SOC.1.00.1404170119550.20193@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20131022174612.GC24448@blackmetal.musicnaut.iki.fi> <20131022.135442.1072093301788210177.davem@davemloft.net> <20140414184353.GA5630@drone.musicnaut.iki.fi> <20140416.145822.1317931249717152474.davem@davemloft.net>
In-Reply-To: <20140416.145822.1317931249717152474.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aaro.koskinen@iki.fi, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, hughd@google.com

> > Just for the archives, I got one of these again with 3.14:
> 
> Meelis and Aaro, thanks again for all of your reports.
> 
> After pouring over a lot of the data and auditing some code I'm
> suspecting it's a problem with transparent huge pages.
> 
> One thing you two can do to help me further confirm this is to run
> with THP disabled for a while and see if you still get the log
> messages.

I have snice turned off CONFIG_TRANSPARENT_HUGEPAGE on 3 of 4 servers 
that had this problem (actually most of my sparc64 machines) and the 4th 
has

CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not se

and also has not had this problem since then. All 4 machines have been 
running through most -rc's of every kernel.

-- 
Meelis Roos <mroos@linux.ee>
