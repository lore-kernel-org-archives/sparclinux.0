From: David Miller <davem@davemloft.net>
Date: Mon, 20 Oct 2014 15:51:29 +0000
Subject: Re: SPARC: 3.13-rc1 and newer: kernel size issue with tftpboot.img
Message-Id: <20141020.115129.474669322183368388.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20131201190220.GC30823@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20131201190220.GC30823@blackmetal.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 1 Dec 2013 21:02:20 +0200

> The bloat seems to be coming from arch/sparc/mm/init_64.c:
> 
> 	   text    data     bss     dec     hex filename
> 	  10147   13536 4335264 4358947  428323 arch/sparc/mm/init_64.o
> 
> The cause is MAX_PHYS_ADDRESS_BITS changing from 41 to 47. Would it be
> possible to make this configurable for legacy SPARCs? Manually patching
> this value back to 41 seems to at least produce a bootable image (no
> further testing done).

This issue should now be fully addressed.

The kernel image BSS should now be just over 6MB smaller. 

I'm going to try and backport the changes that are going into v3.18
that allowed this to happen as far back in -stable as possible.

Just FYI...
