From: David Miller <davem@davemloft.net>
Date: Mon, 15 Aug 2011 20:03:10 +0000
Subject: Re: About ARCH=sparc and what to pass to recordmcount.pl
Message-Id: <20110815.130310.1591151569459178811.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110815152102.GK11398@pengutronix.de>
In-Reply-To: <20110815152102.GK11398@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 15 Aug 2011 15:55:00 -0400

> But if they use recordmcount.c instead, then nothing needs to be done
> with recordmcount.pl.
> 
> recordmcount.c looks at the elf file itself to determine what arch it is
> for. If this is supported, then everything should work, and you get a
> faster build of the kernel as an extra bonus.

Looks like it should work as-is, just need to add HAVE_C_RECORDMCOUNT
to arch/sparc/Kconfig under SPARC64.

I'll take a look.

But meanwhile, the debian folks should pass the right ARCH down into
to build :-)
