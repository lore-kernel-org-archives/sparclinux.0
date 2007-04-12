From: David Miller <davem@davemloft.net>
Date: Thu, 12 Apr 2007 21:43:14 +0000
Subject: Re: gcc-4.2.0 20070316 (prerelease) miscompiles sparc64 kernel
Message-Id: <20070412.144314.119296413.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200704040723.l347N7ks017930@harpo.it.uu.se>
In-Reply-To: <200704040723.l347N7ks017930@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 4 Apr 2007 09:23:07 +0200 (MEST)

> The 2.6.21-rc5 kernel compiled with gcc-4.2.0 20070316 boots ok
> but is thrown into an infinite loop by `hdparm -Tt /dev/hda'.
> Sysrq-P tells me that the call chain in the loop is:
> 
> __up_read or __handle_mm_fault [varies]
> do_sparc64_fault
> sparc64_realfault_common
> compat_sys_shmat
> 
> The kernel works when built with gcc-3.4.6, 4.0.4, or 4.1.2.
> 
> I'll do some more debugging next week, if I have time.

Any updates?
