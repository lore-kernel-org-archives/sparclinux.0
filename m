From: David Miller <davem@davemloft.net>
Date: Fri, 04 Feb 2011 21:00:34 +0000
Subject: Re: sparc32 linux SMP
Message-Id: <20110204.130034.226785386.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D4C0193.2020900@gaisler.com>
In-Reply-To: <4D4C0193.2020900@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 04 Feb 2011 14:39:31 +0100

> I just want to report that we have been able to run the SPEC2000
> integer tests successfully on Linux SMP 2.6.38-rc1. After 2-3 days of
> running the tests (users=2) on a dual core LEON@70MHz on Debian Etch,
> the results were correct. Two months ago I was able to run for 1-2
> minutes before the system crashed in different ways or hanged.

I assume this is with the smp_call_function changes added to your tree,
right?

It would be nice to get the sun4m/sun4d bits written so I can integrate
that fix. :-)
