From: Bob Picco <bpicco@meloft.net>
Date: Wed, 24 Sep 2014 23:12:02 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140924231202.GA4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Wed Sep 24 2014, 06:26:51PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Mon, 22 Sep 2014 14:56:31 -0400
> 
> > I'll review more.
> > 
> > Oh and boot with DEBUG_PAGEALLOC at some point.
> > Alright, need to chase a DEBUG_PAGEALLOC issue with prom_halt() blink:
> > [bpicco@zareason ~]$ cat /tmp/t5-blink.txt
> > [23233.728105] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> > [23233.753380] SUN4V-DTLB: Error at TPC[446930], tl 1
> > [23233.762729] SUN4V-DTLB: TPC<dma_4v_map_page+0x10/0x220>
> > [23233.773124] SUN4V-DTLB: O7[55206c]
> > [23233.779910] SUN4V-DTLB: O7<cache_grow+0x12c/0x200>
> > [23233.789455] SUN4V-DTLB: vaddr[1103f23e000] ctx[0] pte[0] error[2]
> > . We were nearly at the console login prompt. Hm, maybe turn off LDOMS
> > config :)
> > 
> > thanx and nice!
> 
> Bob, here is what I have now, can you please help me test it?
Absolutely. I'm slightly exhausted at the moment and productivity would
be uncertain.
> 
> It should restore 256MB/2GB/16GB page size usage.
> 
> The biggest bug was that I wasn't flushing the kernel TSB(s)
> after building the kernel page tables and NOP'ing out that
> instruction in kernel_physical_mapping_init().
Okay.
> 
> Once I fixed that everything runs smoothly so far :-)
Good.
> 
> I haven't gotten to testing DEBUG_PAGEALLOC yet, but I suspect it
> probably works now.
Ah, I didn't return to this. In fact I've been busy with other things.
I will help.
> 
> Thanks!
you're welcome!
