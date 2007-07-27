From: David Miller <davem@davemloft.net>
Date: Fri, 27 Jul 2007 01:24:44 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070726.182444.26278560.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 26 Jul 2007 12:21:29 +0200 (MEST)

> BTW, with this patch your test program now prints
> 
> x0:0x8e1000a0
> x8:0x00000006
> 
> i.e., bit 5 of x0 is now set for some reason.

That's the expected correct output, this indicates that
it is a PCI host bridge.

This being fixed is what makes all the X complaints
about mapping conflicts go away.
