From: David Miller <davem@davemloft.net>
Date: Tue, 24 Mar 2015 22:16:17 +0000
Subject: Re: [PATCH v6 0/3] Generic IOMMU pooled allocator
Message-Id: <20150324.181617.1094177939652695812.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427210772.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1427210772.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 24 Mar 2015 13:10:27 -0400

> Deltas from patchv5:
> - removed iommu_tbl_ops, and instead pass the ->flush_all as
>   an indirection to iommu_tbl_pool_init()
> - only invoke ->flush_all when there is no large_pool, based on
>   the assumption that large-pool usage is infrequently encountered.

Generally this looks fine to me.

But about patch #2, I see no reason to have multiple iommu_pool_hash
tables.  Even from a purely sparc perspective, we can always just do
with just one of them.

Furthermore, you can even probably move it down into lib/iommu-common.c
itself.  iommu_tbl_pool_init() can do the one time initialization.
