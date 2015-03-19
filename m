From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 19 Mar 2015 05:27:57 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <550A5E5D.90907@ozlabs.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <1426734106.4770.118.camel@kernel.crashing.org>
In-Reply-To: <1426734106.4770.118.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, Anton Blanchard <anton@au1.ibm.com>, paulus@samba.org, sowmini.varadhan@oracle.com, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 03/19/2015 02:01 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2015-03-18 at 22:25 -0400, David Miller wrote:
>> PowerPC folks, we're trying to kill the locking contention in our
>> IOMMU allocators and noticed that you guys have a nice solution to
>> this in your IOMMU code.
>
>   .../...
>
> Adding Alexei too who is currently doing some changes to our iommu
> code to deal with KVM.
>
> One thing I noticed is the asymetry in your code between the alloc
> and the free path. The alloc path is similar to us in that the lock
> covers the allocation and that's about it, there's no actual mapping to
> the HW done, it's done by the caller level right ?
>
> The free path however, in your case, takes the lock and calls back into
> "demap" (which I assume is what removes the translation from the HW)
> with the lock held. There's also some mapping between cookies
> and index which here too isn't exposed to the alloc side but is
> exposed to the free side.
>
> I'm sure there's a rationale for that but it would be good if you could
> explain it and document the semantics of those 3 callbacks in the iommu
> ops.
>
> One thing that Alexey is doing on our side is to move some of the
> hooks to manipulate the underlying TCEs (ie. iommu PTEs) from our
> global ppc_md. data structure to a new iommu_table_ops, so your patches
> will definitely collide with our current work so we'll have to figure
> out how things can made to match. We might be able to move more than
> just the allocator to the generic code, and the whole implementation of
> map_sg/unmap_sg if we have the right set of "ops", unless you see a
> reason why that wouldn't work for you ?
>
> We also need to add some additional platform specific fields to certain
> iommu table instances to deal with some KVM related tracking of pinned
> "DMAble" memory, here too we might have to be creative and possibly
> enclose the generic iommu_table in a platform specific variant.
>
> Alexey, any other comment ?


Agree about missing symmetry. In general, I would call it "zoned 
pool-locked memory allocator"-ish rather than iommu_table and have no 
callbacks there.

The iommu_tbl_range_free() caller could call cookie_to_index() and what the 
reset() callback does here - I do not understand, some documentation would 
help here, and demap() does not have to be executed under the lock (as 
map() is not executed under the lock).

btw why demap, not unmap? :)


-- 
Alexey
