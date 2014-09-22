From: Bob Picco <bpicco@meloft.net>
Date: Mon, 22 Sep 2014 18:56:31 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140922185631.GW17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Mon Sep 22 2014, 12:22:46AM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Fri, 19 Sep 2014 15:57:31 -0400
> 
> > Hi,
> > David Miller wrote:	[Fri Sep 19 2014, 03:28:46PM EDT]
> >> From: David Miller <davem@davemloft.net>
> >> Date: Thu, 18 Sep 2014 19:16:37 -0400 (EDT)
> >> 
> >> > I'm half-way done with the "use kernel page tables for everything"
> >> > patch, and will post once I have something that at least work for
> >> > me.
> >> 
> >> Bob, I ran into a major roadblock which is going to delay this work
> >> a little bit.
> > Okay.
> >> 
> >> In fact it pointed out a bug we introduced when increasing max phys
> >> bits to 47.  We broke DEBUG_PAGEALLOC completely.  The issue is that
> >> the page table layout only supports up to 43-bits.
> > Oh bugger yes. I recall testing this when first introducting four level
> > page table layout in late 2012 and early 2013. It just isn't an everyday
> > thought but VERY nice to have.
> >> 
> >> I'll brain storm about this over the weekend.
> > Me too.
> 
> Ok, here is what I have so far and I just got it working.
I thought about this issue some over the weekend and PRIQ. Most variants 
considered for this issue were not appealing.
> 
> The long and short of it is that we have a 4-level page table
> but only for the PAGE_OFFSET linear kernel mappings.
This is the variant that seems good to me. It should prevent future issues
for at least another core revision - me hopes.
> 
> To the rest of the kernel this is transparent, because all
> vmalloc et al. mappings have virtual addresses which index
> to swapper_pg_dir.
Yes, I reviewed most of the code before attempting to use it :)

Jalap?no and T5-2 seem happy. From T5-2:
[    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.
> 
> The only thing I have to do is bring back 256MB et al. mapping usage
> for suitable aligned PAGE_OFFSET linear areas.  It's only using 4MB
> mappings at the moment.
Okay.

I'll review more.

Oh and boot with DEBUG_PAGEALLOC at some point.
Alright, need to chase a DEBUG_PAGEALLOC issue with prom_halt() blink:
[bpicco@zareason ~]$ cat /tmp/t5-blink.txt
[23233.728105] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[23233.753380] SUN4V-DTLB: Error at TPC[446930], tl 1
[23233.762729] SUN4V-DTLB: TPC<dma_4v_map_page+0x10/0x220>
[23233.773124] SUN4V-DTLB: O7[55206c]
[23233.779910] SUN4V-DTLB: O7<cache_grow+0x12c/0x200>
[23233.789455] SUN4V-DTLB: vaddr[1103f23e000] ctx[0] pte[0] error[2]
. We were nearly at the console login prompt. Hm, maybe turn off LDOMS
config :)

thanx and nice!
