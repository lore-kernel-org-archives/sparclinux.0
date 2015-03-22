From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 22 Mar 2015 23:32:29 +0000
Subject: Re: [PATCH v5 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <1427067149.4770.209.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1426986386.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1426986386.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Sun, 2015-03-22 at 15:22 -0400, Sowmini Varadhan wrote:
> Follows up on the feedback in the thread at
>   http://www.spinics.net/lists/sparclinux/msg13493.html
> 
> - removed ->cookie_to_index and ->demap indirection from the iommu_tbl_ops
>   The caller needs to call these functions as needed, before invoking
>   the generic arena allocator functions.
> 
> - added the "skip_span_boundary" argument to iommu_tbl_pool_init() for
>   those callers like LDC which do no care about span boundary checks.

Thanks. I'll try to look in depth some time this week, but poke me if
you don't hear from me, I'm a bit swamped at the moment. In the
meantime, Alexey might have some bandwidth to also check it out.

Cheers,
Ben.


