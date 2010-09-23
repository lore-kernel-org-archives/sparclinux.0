From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 23 Sep 2010 17:02:22 +0000
Subject: [2.6.36-rc regression] occasional complete system hangs on sparc64 SMP
Message-Id: <19611.34846.813757.309183@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On my Sun Blade 2500 (2 CPUs), post 2.6.35 kernels sometimes hang
completely without visible messages on either the console or in
the kernel logs.

The first two times (with -rc1 or -rc3) it happended during gcc
bootstraps + regression test runs, today (with -rc4) it happended
while compiling the 2.6.36-rc5 kernel.  It's very sporadic, perhaps
one of ten boots will eventually hang like this.

With 2.6.35 the machine is rock solid.

The 2.6.36-rc kernels do appear to be solid on a UP Ultra5, but that
one no longer does any gcc builds or tests, only kernel builds.

Any ideas, or do I have to try to bisect this?

/Mikael
