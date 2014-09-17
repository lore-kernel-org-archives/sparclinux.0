From: Bob Picco <bpicco@meloft.net>
Date: Wed, 17 Sep 2014 12:19:38 +0000
Subject: Re: [PATCH V2] sparc64: sun4v TLB error power off events
Message-Id: <20140917121938.GJ17331@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1410874007-11501-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410874007-11501-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Tue Sep 16 2014, 05:47:25PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Tue, 16 Sep 2014 09:26:47 -0400
> 
> I just looked into this a bit while reviewing this patch.
Okay.
> 
> > A more recent one is an ITLB issue with a bad pagesize which could
> > be a hardware bug.
> 
> The error is signalled solely by the hypervisor.  Let's look at the
> PTE it doesn't like.
I agree and forgot about this in the context of bus error.

Note, I've seen this issue once or twice. Perhaps only on my ~P0 T4-2.
I couldn't find the issue in my T5-2 log.
> 
> > This is recent mainline for ITLB:
> > [ 3708.179864] SUN4V-ITLB: TPC<0xfffffc010071cefc>
> > [ 3708.188866] SUN4V-ITLB: O7[fffffc010071cee8]
> > [ 3708.197377] SUN4V-ITLB: O7<0xfffffc010071cee8>
> > [ 3708.206539] SUN4V-ITLB: vaddr[e0003] ctx[1a3c] pte[2900000dcc800eeb] error[4]
> 
> Indeed bad pagesize is signalled.  The page size bits are in the low
> 3 bits of the PTE, which here is 0x3 which should encode a 4MB page.
Yes.
> 
> However I notice that 0x8 is set, which is a reserved bit.  That
> shouldn't happen, and could be what the hypervisor really doesn't
> like.
Also _PAGE_VALID isn't set.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
