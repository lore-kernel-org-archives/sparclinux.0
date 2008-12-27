From: David Miller <davem@davemloft.net>
Date: Sat, 27 Dec 2008 09:37:12 +0000
Subject: Re: [PATCH] sparc64: use unsigned long long for u64
Message-Id: <20081227.013712.63335017.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081223131746.GA7456@uranus.ravnborg.org>
	<20081227.005452.261413194.davem@davemloft.net>
	<20081227092404.GA10375@uranus.ravnborg.org>
In-Reply-To: <20081227092404.GA10375@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, mingo@elte.hu, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, kenchen@google.com, paulus@samba.org, tglx@linutronix.de, hpa@zytor.com, linux-next@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 27 Dec 2008 10:24:04 +0100

> So it looks like my gcc does not promote:
> ((tagval & 0x0fffffff00000000UL) >> 19UL) to unsigned long long int
> but your gcc does?
> 
> My gcc (build with Dan Kegel's crosstool):
> $ /opt/crosstool/gcc-3.4.5-glibc-2.3.6/sparc64-unknown-linux-gnu/bin/sparc64-unknown-linux-gnu-gcc -v
> Reading specs from /opt/crosstool/gcc-3.4.5-glibc-2.3.6/sparc64-unknown-linux-gnu/lib/gcc/sparc64-unknown-linux-gnu/3.4.5/specs
> Configured with: /home/sam/devel/crosstool-0.43/build/sparc64-unknown-linux-gnu/gcc-3.4.5-glibc-2.3.6/gcc-3.4.5/configure --target=sparc64-unknown-linux-gnu --host=i686-host_pc-linux-gnu --prefix=/opt/crosstool/gcc-3.4.5-glibc-2.3.6/sparc64-unknown-linux-gnu --disable-multilib --with-cpu=ultrasparc3 --enable-cxx-flags=-mcpu=ultrasparc3 --with-headers=/opt/crosstool/gcc-3.4.5-glibc-2.3.6/sparc64-unknown-linux-gnu/sparc64-unknown-linux-gnu/include --with-local-prefix=/opt/crosstool/gcc-3.4.5-glibc-2.3.6/sparc64-unknown-linux-gnu/sparc64-unknown-linux-gnu --disable-nls --enable-threads=posix --enable-symvers=gnu --enable-__cxa_atexit --enable-languages=c --enable-shared --enable-c99 --enable-long-long
> Thread model: posix
> gcc version 3.4.5

I'm using a native gcc-4.1.3 here:

gcc (GCC) 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)

When you cross build 32-bit to 64-bit, a small but non-zero
number of warning checks and optimizations are not performed
and I think that is what you're hitting here.
