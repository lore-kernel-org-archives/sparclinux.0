From: David Miller <davem@davemloft.net>
Date: Tue, 04 Mar 2014 20:46:26 +0000
Subject: Re: [PATCH] sparc64 - strict devmem
Message-Id: <20140304.154626.731012431363751577.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1393866035-7939-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1393866035-7939-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Mon,  3 Mar 2014 12:00:35 -0500

> From: bob picco <bpicco@meloft.net>
> 
> This patch adds support to enable STRICT_DEVMEM for sparc64. By selecting the
> new config option you enable this feature.
> 
> CC: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Bob Picco <bob.picco@oracle.com>

Ok, I looked more deeply into this and I'm going to rescind my request
to use kern_addr_valid().

This devmem_is_allowed() seems to also want to allow non-RAM MMIO
accesses too.

So using the iomem resource is probably the way to go.

Two things:

1) We have to make sure caching will be disabled and the side-effect
   bit will be set in accesses to non-RAM pages.

2) Our implementation of devmem_is_allowed() should be aligned as
   much as possible with other implementations.  Perhaps powerpc
   is the best example to use.

Thanks.


