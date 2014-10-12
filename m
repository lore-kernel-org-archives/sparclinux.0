From: David Miller <davem@davemloft.net>
Date: Sun, 12 Oct 2014 17:20:12 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141012.132012.254712930139255731.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141011.221510.1574777235900788349.davem@davemloft.net>
In-Reply-To: <20141011.221510.1574777235900788349.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, linux-mm@kvack.org, mroos@linux.ee, sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 11 Oct 2014 22:15:10 -0400 (EDT)

> 
> I'm getting tons of the following on sparc64:
> 
> [603965.383447] Kernel unaligned access at TPC[546b58] free_block+0x98/0x1a0
> [603965.396987] Kernel unaligned access at TPC[546b60] free_block+0xa0/0x1a0
> [603965.410523] Kernel unaligned access at TPC[546b58] free_block+0x98/0x1a0

The unaligned accesses are happening in the SLAB_OBJ_PFMEMALLOC code,
which assumes that all object pointers are "unsigned long" aligned:

static inline void set_obj_pfmemalloc(void **objp)
{
        *objp = (void *)((unsigned long)*objp | SLAB_OBJ_PFMEMALLOC);
        return;
}

etc. etc.

But that code has been there working forever.  Something changed
recently such that this assumption no longer holds.

In all of the cases, the address is 4-byte aligned but not 8-byte
aligned.  And they are vmalloc addresses.

Which made me suspect the percpu commit:

==========
commit bf0dea23a9c094ae869a88bb694fbe966671bf6d
Author: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date:   Thu Oct 9 15:26:27 2014 -0700

    mm/slab: use percpu allocator for cpu cache
==========

And indeed, reverting this commit fixes the problem.
