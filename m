From: David Miller <davem@davemloft.net>
Date: Wed, 13 Aug 2008 01:40:52 +0000
Subject: Re: console handover badness
Message-Id: <20080812.184052.193693538.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806211542050.21474@engineering.redhat.com>
	<20080811.233013.49328708.davem@davemloft.net>
	<Pine.LNX.4.64.0808122053280.31704@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0808122053280.31704@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 12 Aug 2008 21:11:53 -0400 (EDT)

> and then boot failure of 2.6.27-rc[12] because of bad memory 
> migratetype. Is this migratetype crash a known problem? --- the problem is 
> that starting with 2.6.27rc1, I'm getting crash with this backtrace:
> __list_add
> __free_pages_ok
> __free_pages
> __free_pages_bootmem
> __free_all_bootmem
> mem_init
> start_kernel_tlb_fixup_code
> --- the crash is due to migratetype = 5 in __free_one_page (inlined into 
> __free_pages_ok) and because there are only 5 migratettypes, it attempts 
> to add to a non-existent list.

Mikulas can you send me the .config you're using in 2.6.27 to trigger
this?

Thanks.
