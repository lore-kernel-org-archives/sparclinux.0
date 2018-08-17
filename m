From: David Miller <davem@davemloft.net>
Date: Fri, 17 Aug 2018 19:29:30 +0000
Subject: Re: [PATCH] mach64: detect the dot clock divider correctly on sparc
Message-Id: <20180817.122930.56806860055783628.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.02.1808171515550.31883@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808171515550.31883@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 17 Aug 2018 15:19:37 -0400 (EDT)

> On Sun Ultra 5, it happens that the dot clock is not set up properly for
> some videomodes. For example, if we set the videomode "r1024x768x60" in
> the firmware, Linux would incorrectly set a videomode with refresh rate
> 180Hz when booting (suprisingly, my LCD monitor can display it, although
> display quality is very low).
> 
> The reason is this: Older mach64 cards set the divider in the register
> VCLK_POST_DIV. The register has four 2-bit fields (the field that is
> actually used is specified in the lowest two bits of the register
> CLOCK_CNTL). The 2 bits select divider "1, 2, 4, 8". On newer mach64 cards,
> there's another bit added - the top four bits of PLL_EXT_CNTL extend the
> divider selection, so we have possible dividers "1, 2, 4, 8, 3, 5, 6, 12".
> The Linux driver clears the top four bits of PLL_EXT_CNTL and never sets
> them, so it can work regardless if the card supports them. However, the
> sparc64 firmware may set these extended dividers during boot - and the
> mach64 driver detects incorrect dot clock in this case.
> 
> This patch makes the driver read the additional divider bit from
> PLL_EXT_CNTL and calculate the initial refresh rate properly.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

Acked-by: David S. Miller <davem@davemloft.net>
