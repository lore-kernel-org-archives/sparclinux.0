From: David Miller <davem@davemloft.net>
Date: Fri, 19 Dec 2014 20:24:41 +0000
Subject: Re: [PATCH RFC sparc] Break up iommu from monolithic lock for the map to multiple pools/locks
Message-Id: <20141219.152441.2177745236204323257.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141219151616.GB25248@oracle.com>
In-Reply-To: <20141219151616.GB25248@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 15:06:51 -0500

> On (12/19/14 14:57), David Miller wrote:
>> 
>> The core operation is the range allocation.  So if you just put the
>> powerpc alloc/free code (basically, the bulk of your patch) into
>> lib/iommu-common.c or similar, that ought to be a good starting point.
> 
> sounds good, I'll do this and get back over the next week.
> (Some things like the demap function pointer may need to be
> generalized a bit, e.g., pass  the iommu_pool * to the callback for
> other archs)

It might be cleaner to have a "const struct iommu_ops *" kind of thing
in the base iommu structure.
