From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Date: Tue, 16 May 2017 23:50:57 +0000
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
Message-Id: <1494978657.21847.74.camel@au1.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <65b8a658-76d1-0617-ece8-ff7a3c1c4046@oracle.com>
	 <20170512.125708.475573831936972365.davem@davemloft.net>
	 <6da8d4a6-3332-8331-c329-b05efd88a70d@oracle.com>
	 <20170512.133742.2144484253675877904.davem@davemloft.net>
In-Reply-To: <20170512.133742.2144484253675877904.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>, pasha.tatashin@oracle.com
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Fri, 2017-05-12 at 13:37 -0400, David Miller wrote:
> > Right now it is larger, but what I suggested is to add a new optimized
> > routine just for this case, which would do STBI for 64-bytes but
> > without membar (do membar at the end of memmap_init_zone() and
> > deferred_init_memmap()
> > 
> > #define struct_page_clear(page)                                 \
> >          __asm__ __volatile__(                                   \
> >          "stxa   %%g0, [%0]%2\n"                                 \
> >          "stxa   %%xg0, [%0 + %1]%2\n"                           \
> >          : /* No output */                                       \
> >          : "r" (page), "r" (0x20), "i"(ASI_BLK_INIT_QUAD_LDD_P))
> > 
> > And insert it into __init_single_page() instead of memset()
> > 
> > The final result is 4.01s/T which is even faster compared to current
> > 4.97s/T
> 
> Ok, indeed, that would work.

On ppc64, that might not. We have a dcbz instruction that clears an
entire cache line at once. That's what we use for memset's and page
clearing. However, 64 bytes is half a cache line on modern processors
so we can't use it with that semantic and would have to fallback to the
slower stores.

Cheers,
Ben.

