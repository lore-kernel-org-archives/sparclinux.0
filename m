From: Ben Collins <bcollins@debian.org>
Date: Thu, 26 Aug 2004 13:23:10 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <20040826132310.GH2333@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>  * Bringing br0 down... *   Releasing DHCP lease for br0
>   [ ok ]
>  *   Stopping br0
>   [ ok ]
>  * Bringing lo down...  [ ok ]
>  * Stopping devfsd...  [ ok ]
>  * Deactivating swap...  [ ok ]
>  * Unmounting filesystems...  [ ok ]
>  * Shutting down the Logical Volume Manager...  [ ok ]
>  * Remounting remaining filesystems readonly...  [ ok ]
> m:sopn l ddvcs
> d d wthdt edol oe
> Rsatn ytm
> Resetting ... 

So your serial console works for userspace, but is broken from the
kernel? That last "Resetting..." is from the OBP I think.


> Remapping the kernel... done.
> Booting Linux...
> POLB u EEBo rm31. 000/11:2
> iu eso .. ro@bn0)(c eso .. 0463(etoLnx334)# M h u 60:01 D 04

That "Booting Linux..." is from the kernel too, but it's a prom_printf,
not a console (iow, sunsab) call.

> m:AtdtcigRI ras
> d uou .
> d . uou OE
> koradsatn. o
> version 2.85 booting
> 
> Gentoo Linux; http://www.gentoo.org/
>  Copyright 2001-2004 Gentoo Technologies, Inc.; Distributed under the GPL

And then userspace is ok again.

Dave, what's the difference between userspace going through the tty, and
kernel printk calls going into the console callbacks?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
