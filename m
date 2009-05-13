From: David Miller <davem@davemloft.net>
Date: Wed, 13 May 2009 05:01:46 +0000
Subject: Re: Sun fire T2000,BUG: NMI Watchdog detected LOCKUP on CPU12
Message-Id: <20090512.220146.30798687.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200905130300.12084.denys@visp.net.lb>
In-Reply-To: <200905130300.12084.denys@visp.net.lb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Denys Fedoryschenko <denys@visp.net.lb>
Date: Wed, 13 May 2009 03:00:11 +0300

> Hi
> 
> Got recently lockups on T2000 machine. Machine is relatively new.
> While compiling with crazy makeflags "-j17" getting such messages.
> Process which was being compiled stuck, and i cannot terminate it.

That's not "crazy", I use -j32 as a minumum for my builds. :-)

I started seeing these hangs with 2.6.30-rcX and will try to
bisect it down when I get back from my week long cruise.

It's definitely a post 2.6.29 regression.

