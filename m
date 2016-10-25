From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 17:27:54 +0000
Subject: Re: NMI watchdog: BUG: soft lockup
Message-Id: <20161025.132754.2126439466725155599.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
In-Reply-To: <60822DF7-477D-433C-85AA-FE04D1D4B7B0@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 13:18:08 -0400 (EDT)

> So the full virtual address comparison is something like:
> 
> 	unsigned long compare = (tag >> 22) << 22; /* Clear CONTEXT bits */
> 
> 	compare |= (tsb_index & (nentries - 1)) << 13;
> 
> 	if (vaddr = compare)
> 		goto match;
> 
> The swapper TSB only stores PAGE_SIZE translations.

Ok, this should work:

static void flush_tsb_kernel_range_scan(unsigned long start, unsigned long end)
{
        unsigned long idx;

        for (idx = 0; idx < KERNEL_TSB_NENTRIES; idx++) {
                struct tsb *ent = &swapper_tsb[idx];
                unsigned long match = idx << 13;

                match |= (ent->tag << 22);
                if (match >= start && match < end)
                        ent->tag = (1UL << TSB_TAG_INVALID_BIT);
        }
}

Bits 13-"21+N" come from the TSB index, and the tag always stores
bits 22 and above.  So simply 'or'ing them together always gives
us a usable match value.
