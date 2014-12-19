From: David Miller <davem@davemloft.net>
Date: Fri, 19 Dec 2014 20:56:31 +0000
Subject: Re: [PATCH RFC sparc] Break up iommu from monolithic lock for the map to multiple pools/locks
Message-Id: <20141219.155631.592540097139014715.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141219151616.GB25248@oracle.com>
In-Reply-To: <20141219151616.GB25248@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 15:44:54 -0500

> On (12/19/14 15:24), David Miller wrote:
>> > 
>> > sounds good, I'll do this and get back over the next week.
>> > (Some things like the demap function pointer may need to be
>> > generalized a bit, e.g., pass  the iommu_pool * to the callback for
>> > other archs)
>> 
>> It might be cleaner to have a "const struct iommu_ops *" kind of thing
>> in the base iommu structure.
> 
> Agreed. The powerpc iommu_table also has a large_pool that I did
> not look too carefully into - used for allocating  npages > 15 , iirc.  
> I dont know how commonly that happens. 

That large_pool mechanism might help prevent the other pools from
getting fragmented and thus lead to premature allocation failures.
