From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2014 22:07:42 +0000
Subject: Re: [PATCH] sparc64: mem mmap
Message-Id: <20140909.150742.2088869806473484134.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410104925-22342-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410104925-22342-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Sun,  7 Sep 2014 11:48:45 -0400

> From: bob picco <bpicco@meloft.net>
> 
> This patch attempts to restrict mmap of /dev/mem. It tightens up the bus
> error (DTLB errors) issues related to mmap of /dev/mem.
> 
> A root privileged application like python using dmidecode mmap-s /dev/mem to
> examine an x86 magic area which is non-existent on sparc64. This results
> in a power off event within sun4v_dtlb_error_report because the HV reports
> an invalid RA.
> 
> The mmap restriction of /dev/mem does introduce ARCH_HAS_VALID_PHYS_ADDR_RANGE.
> This does cause us to clone the functionality of valid_phys_addr_range. A
> mapper is not allowed to mmap a range which isn't kern_addr_valid true on
> every 4Mb boundary.
> 
> Cc: sparclinux@vger.kernel.org
> Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

I think the fact that you are defining the restriction for read/write
differently for mmap should give you some pause.

There really should be no difference.

The reason you're doing this is because if we access the physical
address on the kernel side and it's a bad RA, we fault cleanly,
whereas if the user does this we do not.

And I think, given this, the real fix is to make user side accesses
recover cleanly just as the kernel ones do.

Therefore, this kind of continues the feedback for the TLB error
handling patch we've been discussing.

It seems to me that if the hypervisor errors out with "BAD RA", and we
are accessing a user page, we can just bus error the process.

What do you think?
