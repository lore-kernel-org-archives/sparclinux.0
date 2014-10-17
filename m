From: Meelis Roos <mroos@linux.ee>
Date: Fri, 17 Oct 2014 11:12:09 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <alpine.LRH.2.11.1410171410210.25429@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20141016.160742.1639247937393238792.davem@redhat.com> <alpine.LRH.2.11.1410162313440.19924@adalberg.ut.ee> <20141016.162001.599580415052560455.davem@redhat.com> <20141016.165017.1151349565275102498.davem@davemloft.net>
In-Reply-To: <20141016.165017.1151349565275102498.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

> From: David Miller <davem@redhat.com>
> Date: Thu, 16 Oct 2014 16:20:01 -0400 (EDT)
> 
> > So I'm going to audit all the code paths to make sure we don't put garbage
> > into the fault_code value.
> 
> There are two code paths where we can put garbage into the fault_code
> value.  And for the dtlb_prot.S case, the value we put in there is
> TLB_TAG_ACCESS which is 0x30, which include bit 0x20 which is that
> FAULT_CODE_BAD_RA indication which is erroneously triggering.
> 
> The other path is via hugepage TLB misses, for the situation where
> we haven't allocated the huge TSB for the thread yet.  That might
> explain some other longer-term problems we've had.
> 
> I'm about to test the following fix:

Thank you - it seems to work fine for me on E3500 on top of 
3.17.0-07551-g052db7e + slab alignment fix.

However, on top of mainline HEAD 3.17.0-09670-g0429fbc it explodes with 
scheduler BUG - just reported to LKML + sched maintainers.

-- 
Meelis Roos (mroos@linux.ee)
