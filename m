From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sun, 03 Oct 2010 21:36:16 +0000
Subject: Re: [2.6.36-rc regression] occasional complete system hangs on sparc64 SMP
Message-Id: <19624.63312.156073.410319@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <19611.34846.813757.309183@pilspetsen.it.uu.se>
In-Reply-To: <19611.34846.813757.309183@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Mikael Pettersson writes:
 > On my Sun Blade 2500 (2 CPUs), post 2.6.35 kernels sometimes hang
 > completely without visible messages on either the console or in
 > the kernel logs.
 > 
 > The first two times (with -rc1 or -rc3) it happended during gcc
 > bootstraps + regression test runs, today (with -rc4) it happended
 > while compiling the 2.6.36-rc5 kernel.  It's very sporadic, perhaps
 > one of ten boots will eventually hang like this.
 > 
 > With 2.6.35 the machine is rock solid.
 > 
 > The 2.6.36-rc kernels do appear to be solid on a UP Ultra5, but that
 > one no longer does any gcc builds or tests, only kernel builds.
 > 
 > Any ideas, or do I have to try to bisect this?

I've been testing older kernels and can now say that 2.6.35-git5
and newer kernels are definitely affected, but 2.6.35-git4 seems
solid.  I'll dig deeper into the .35-git4->git5 changes towards
the end of next week.

I never got any data out of sysrq-y or any other sysrq when a hang
occurs; usually they'd just print the name of the command but no data,
sometimes they'd oops and crash the kernel even harder.

/Mikael
