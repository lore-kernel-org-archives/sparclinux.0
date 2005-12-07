From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 07 Dec 2005 21:32:36 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051207.133236.97581111.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
	<20051207.123458.26771065.davem@davemloft.net>
	<Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
In-Reply-To: <Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Wed, 7 Dec 2005 22:22:42 +0100 (CET)

> I'm using the sunffb driver, as I wish to get the output from my creator3d 
> card, so that I can see something displayed as the monitor requiers a 13W3 
> connector. So I assume from your reply that framebuffer isn't working in 
> kernel 2.6 for sparc, but for other archs like ppc?

No, that should work just fine.  Just make sure "sunffb" is specified
as the driver to use in the xorg.conf file.

I have an ultra60 with creator here and I'll try to reproduce your
problem.

