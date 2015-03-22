From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 22 Mar 2015 19:27:26 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150322192726.GB19474@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <1426734106.4770.118.camel@kernel.crashing.org>
 <550A5E5D.90907@ozlabs.ru>
In-Reply-To: <550A5E5D.90907@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, Anton Blanchard <anton@au1.ibm.com>, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>

Turned out that I was able to iterate over it, and remove
both the ->cookie_to_index and the ->demap indirection from
iommu_tbl_ops.

That leaves only the odd iommu_flushall() hook, I'm trying
to find the history behind that (needed for sun4u platforms,
afaik, and not sure if there are other ways to achieve this).

Just sent out a new patch-set, which should reach all the 
people/lists on this thread.

If it's possible, it would also help to share any preliminary
code-samples with the iommu_table_ops you folks have in mind.

Please take a look at patchv5, and share your thoughts.

--Sowmini
