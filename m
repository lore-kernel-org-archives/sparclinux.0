From: David Miller <davem@davemloft.net>
Date: Sun, 01 Dec 2013 19:30:35 +0000
Subject: Re: SPARC: 3.13-rc1 and newer: kernel size issue with tftpboot.img
Message-Id: <20131201.143035.154056199944332076.davem@davemloft.net>
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

That would defeat the whole point of having one kernel image that
works on all sparc64 systems.

This data structure must be locked into the TLB and therefore must
be in the main kernel image.  I'll try to look into doing things
differently but it won't be done any time soon as I'm very backlogged
with just networking patch review after coming home from travelling.
