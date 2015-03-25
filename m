From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 25 Mar 2015 17:36:01 +0000
Subject: Re: [PATCH v6 0/3] Generic IOMMU pooled allocator
Message-Id: <20150325173601.GA31861@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1427210772.git.sowmini.varadhan@oracle.com>
 <20150324.181617.1094177939652695812.davem@davemloft.net>
In-Reply-To: <20150324.181617.1094177939652695812.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On (03/24/15 18:16), David Miller wrote:
> Generally this looks fine to me.
> 
> But about patch #2, I see no reason to have multiple iommu_pool_hash
> tables.  Even from a purely sparc perspective, we can always just do
> with just one of them.
> 
> Furthermore, you can even probably move it down into lib/iommu-common.c
> itself.  iommu_tbl_pool_init() can do the one time initialization.

fixed in v7.

Ben, Alexey, do you need more time to review this?

--Sowmini
