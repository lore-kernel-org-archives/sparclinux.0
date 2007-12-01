From: David Miller <davem@davemloft.net>
Date: Sat, 01 Dec 2007 12:57:42 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.99 (Beta 2 for 3.0)
Message-Id: <20071201.045742.193703459.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1196454535.3432.18.camel@localhost.localdomain>
In-Reply-To: <1196454535.3432.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Sat, 01 Dec 2007 13:43:30 +0100

> 
> >> - Systems that boot off qlogic attached disks are not supported, because 
> >> there is no working firmware loader in anaconda, and the qlogic driver 
> >> needs firmware.
> > 
> > That's very unfortunate, how are qlogic device handled on other
> > platforms?
> 
> In Debian you just install the firmware package, udevl will handle it
> then. If you have to boot from it, you need to rebuild your initrd after
> installing the firmware package.
> The installer doesn't support non-free modules yet unfortunately, but
> with some not too complicated tricks you can install Debian without
> problems.

I said "other platforms" as in x86, x86_64, powerpc.

I know debian can do it, as I run ubuntu on most of my
qlogic based sparc64 systems just fine.
