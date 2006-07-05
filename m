From: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
Date: Wed, 05 Jul 2006 21:07:31 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <20060705210728.GC2347@cassis>
List-Id: <sparclinux.vger.kernel.org>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

(Stripped `linux-kernel@'.)

2 days, 9 hours, 28 minutes, 40 seconds ago, Mikael Pettersson wrote:
> In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with
> frequent lock-up like behaviour on my Ultra5 (ATI Mach64).
> 
> I finally managed to trace the cause to this change in 2.6.16-git6:

Can you be more specific as to which version of Xorg you are using?

Several people including me have reported being unable to run Xorg 7.0
on ATI-based sparc64 machines such as U5s [0].  Symptoms include kernel
hangs as well as transient [1,2] or permanent [3] filesystem corruptions.

I just recompiled a kernel with your patch and it doesn't make any
difference in that respect (besides, re-adding the
`prot = __pgprot(...)' line looks questionable since the input value of
PROT becomes unused as a result).

Xorg 6.9, OTOH, was apparently working fine for most people.

Thanks,
Ludovic.

[0] http://lists.debian.org/debian-sparc/2006/04/msg00096.html
[1] http://lists.debian.org/debian-sparc/2006/05/msg00008.html
[2] http://lists.debian.org/debian-sparc/2006/06/msg00112.html
[3] http://lists.debian.org/debian-sparc/2006/06/msg00141.html
