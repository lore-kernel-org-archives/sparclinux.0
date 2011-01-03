From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jan 2011 20:15:34 +0000
Subject: Re: [PATCH] sparc: fix sparse warnings in arch/sparc/prom for 32
Message-Id: <20110103.121534.233690879.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110103182755.GA9524@merkur.ravnborg.org>
In-Reply-To: <20110103182755.GA9524@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 3 Jan 2011 19:27:55 +0100

> Fix following sparse warnings:
> arch/sparc/prom/bootstr_32.c:32:35: warning: Using plain integer as NULL pointer
> arch/sparc/prom/memory.c:61:13: warning: symbol 'prom_meminit' was not declared. Should it be static?
> arch/sparc/prom/misc_32.c:74:1: error: symbol 'prom_halt' redeclared with different type (originally declared at arch/sparc/include/asm/oplib_32.h:67) - different modifiers
> arch/sparc/prom/ranges.c:16:26: warning: symbol 'promlib_obio_ranges' was not declared. Should it be static?
> arch/sparc/prom/ranges.c:17:5: warning: symbol 'num_obio_ranges' was not declared. Should it be static?
> arch/sparc/prom/ranges.c:39:1: warning: symbol 'prom_adjust_ranges' was not declared. Should it be static?
> arch/sparc/prom/ranges.c:69:13: warning: symbol 'prom_ranges_init' was not declared. Should it be static?
> arch/sparc/prom/tree_32.c:286:22: warning: Using plain integer as NULL pointer
> arch/sparc/prom/tree_32.c:286:38: warning: Using plain integer as NULL pointer
> 
> None of the warnings indicated any serious issues.
> 
> We are now sparse clean for 32 bit build in arch/sparc/prom.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.
