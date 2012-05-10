From: David Miller <davem@davemloft.net>
Date: Thu, 10 May 2012 03:08:20 +0000
Subject: Re: [PATCH] sparc: fix build fail in mm/init_64.c when NEED_MULTIPLE_NODES is off
Message-Id: <20120509.230820.1210795228945340631.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1336610669-31449-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1336610669-31449-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed,  9 May 2012 20:44:29 -0400

> Commit 625d693e9784f988371e69c2b41a2172c0be6c11 (linux-next)
> 
>     "sparc64: Convert over to NO_BOOTMEM."
> 
> causes the following compile failure for sparc64 allnoconfig:
> 
>   arch/sparc/mm/init_64.c:822:16: error: unused variable 'paddr'
>   arch/sparc/mm/init_64.c:1759:7: error: unused variable 'node'
>   arch/sparc/mm/init_64.c:809:12: error: 'memblock_nid_range' defined but not used
> 
> The paddr decl can easily be shuffled within the ifdef.  The
> memblock_nid_range is just a stub function for when NEED_MULTIPLE_NODES
> is off, but the only caller is within a NEED_MULTIPLE_NODES enabled
> section, so we can simply delete it.
> 
> The unused "node" is slightly more interesting.  In the case of
> "# CONFIG_NEED_MULTIPLE_NODES is not set" we no longer get the
> definition of:
> 
>  #define NODE_DATA(nid)          (node_data[nid])
> 
> from arch/sparc/include/asm/mmzone.h - but instead we get:
> 
>  #define NODE_DATA(nid)          (&contig_page_data)
> 
> from include/linux/mmzone.h -- and since the arg is ignored,
> the thing really is unused.  Rather than put in a confusing
> looking __maybe_unused, simply splitting the declaration
> from the assignment seemed to me to be the least offensive.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks Paul.

Although I think the 'node' issue is just going to bite us again in
the future.  I think it no longer warns only because GCC's flow
analysis can't see the issue any more, and at some point in the future
it will be able to and we'll have the warning once more.

I would say that the final fix is to simply make the non-NUMA
NODE_DATA() definition create a dummy use of 'nid'.
