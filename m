From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Tue, 25 Mar 2008 08:53:11 +0000
Subject: Re: build breakage on sparc64 due to commit 54cd6dde
Message-Id: <200803250953.11530.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <200803242053.22709.m.kozlowski@tuxland.pl>
In-Reply-To: <200803242053.22709.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

> > > If not, what kind of system is this?
> >  
> > It is mostly 'stable' version of gentoo.
> 
> I suspect they have two compilers installed, one 32-bit-only
> "gcc" and another "sparc64-linux-gcc" for building the kernel.
> Ho hum...

Hm. Got it.

> You can build kernels by setting CROSS_COMPILE=sparc64-linux-
> for the build.

Your recipe works but actually requires
CROSS_COMPILE=sparc64-unknown-linux-gnu- for the build.
 
> Longer term gentoo needs to get out of the stone ages and
> build their 32-bit compiler with 64-bit code generation
> support like every other sparc64 distribution does.

Ok. I guess I'll just report that to gentoo people.

Thanks,

	Mariusz
