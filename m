From: David Miller <davem@davemloft.net>
Date: Mon, 22 Sep 2014 19:13:16 +0000
Subject: Re: [PATCH] sparc64: swapper_tsb and swapper_4m_tsb phys correction
Message-Id: <20140922.151316.326051969533835003.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410886239-15774-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Mon, 22 Sep 2014 14:56:31 -0400

> David Miller wrote:	[Mon Sep 22 2014, 12:22:46AM EDT]
>> From: Bob Picco <bpicco@meloft.net>
>> Date: Fri, 19 Sep 2014 15:57:31 -0400
>> 
>> To the rest of the kernel this is transparent, because all
>> vmalloc et al. mappings have virtual addresses which index
>> to swapper_pg_dir.
> Yes, I reviewed most of the code before attempting to use it :)
> 
> Jalap?no and T5-2 seem happy. From T5-2:
> [    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.

Yeah we only get down to 2 locked TLB entries when we deal with
ditching the vmemmap table too, which I'll work on combining into this
work.

> Alright, need to chase a DEBUG_PAGEALLOC issue with prom_halt() blink:
> [bpicco@zareason ~]$ cat /tmp/t5-blink.txt
> [23233.728105] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> [23233.753380] SUN4V-DTLB: Error at TPC[446930], tl 1
> [23233.762729] SUN4V-DTLB: TPC<dma_4v_map_page+0x10/0x220>
> [23233.773124] SUN4V-DTLB: O7[55206c]
> [23233.779910] SUN4V-DTLB: O7<cache_grow+0x12c/0x200>
> [23233.789455] SUN4V-DTLB: vaddr[1103f23e000] ctx[0] pte[0] error[2]
> . We were nearly at the console login prompt. Hm, maybe turn off LDOMS
> config :)

Hmmm...
