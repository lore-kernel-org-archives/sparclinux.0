From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 19 Mar 2015 13:34:07 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150319133407.GA32355@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <1426734106.4770.118.camel@kernel.crashing.org>
 <550A5E5D.90907@ozlabs.ru>
In-Reply-To: <550A5E5D.90907@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, Anton Blanchard <anton@au1.ibm.com>, paulus@samba.org, sowmini.varadhan@oracle.com, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>


On 03/19/2015 02:01 PM, Benjamin Herrenschmidt wrote:

Ben> One thing I noticed is the asymetry in your code between the alloc
Ben> and the free path. The alloc path is similar to us in that the lock
Ben> covers the allocation and that's about it, there's no actual mapping to
Ben> the HW done, it's done by the caller level right ?

yes, the only constraint  is that the h/w alloc transaction should be
done after the arena-alloc, whereas for the unmap, the h/w  transaction
should happen first, and arena-unmap should happen after.

Ben> The free path however, in your case, takes the lock and calls back into
Ben> "demap" (which I assume is what removes the translation from the HW)
Ben> with the lock held. There's also some mapping between cookies
Ben> and index which here too isn't exposed to the alloc side but is
Ben> exposed to the free side.

Regarding the ->demap indirection- somewhere between V1 and V2, I 
realized that, at least for sun4v, it's not necessary to hold
the pool lock when doing the unmap, (V1 had originally passed this
a the ->demap). Revisiting the LDC change, I think that even that
has no pool-specific info that needs to be passed in, so possibly the
->demap is not required at all?

I can remove that, and re-verify the LDC code (though I might
not be able to get to this till early next week, as I'm travelling
at the moment).

About the cookie_to_index, that came out of observation of the
LDC code (ldc_cookie_to_index in patchset 3). In the LDC case, 
the workflow is approximately
   base = alloc_npages(..); /* calls iommu_tbl_range_alloc *.
   /* set up cookie_state using base */
   /* populate cookies calling fill_cookies() -> make_cookie() */
The make_cookie() is the inverse operation of cookie_to_index()
(afaict, the code is not very well commented, I'm afraid), but 
I need that indirection to figure out which bitmap to clear.

I dont know if there's a better way to do this, or if
the ->cookie_to_index can get more complex for other IOMMU users

Ben> One thing that Alexey is doing on our side is to move some of the
Ben> hooks to manipulate the underlying TCEs (ie. iommu PTEs) from our
Ben> global ppc_md. data structure to a new iommu_table_ops, so your patches
Ben> will definitely collide with our current work so we'll have to figure
Ben> out how things can made to match. We might be able to move more than
Ben> just the allocator to the generic code, and the whole implementation of
Ben> map_sg/unmap_sg if we have the right set of "ops", unless you see a
Ben> reason why that wouldn't work for you ?

I cant think of why that wont work, though it would help to see
the patch itself..


Ben> We also need to add some additional platform specific fields to certain
Ben> iommu table instances to deal with some KVM related tracking of pinned
Ben> "DMAble" memory, here too we might have to be creative and possibly
Ben> enclose the generic iommu_table in a platform specific variant.
Ben> 
Ben> Alexey, any other comment ?
Ben> 
Ben> Cheers,
Ben> Ben.
Ben> 
Ben> 
Ben> 
Ben> --
Ben> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
Ben> the body of a message to majordomo@vger.kernel.org
Ben> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Ben> 
Ben>Alexey, any other comment ?

On (03/19/15 16:27), Alexey Kardashevskiy wrote:
Alexey> 
Alexey> Agree about missing symmetry. In general, I would call it "zoned
Alexey> pool-locked memory allocator"-ish rather than iommu_table and have
Alexey> no callbacks there.
Alexey> 
Alexey> The iommu_tbl_range_free() caller could call cookie_to_index() and

Problem is that tbl_range_free itself needs the `entry' from
-Alexey>cookie_to_index.. dont know if there's a way to move the code
to avoid that..

Alexey> what the reset() callback does here - I do not understand, some

The -Alexey>reset callback came out of the sun4u use-case. Davem might
have more history here than I do, but my understanding is that the
iommu_flushall() was needed on the older sun4u architectures, where
there was on intermediating HV?

Alexey> documentation would help here, and demap() does not have to be
Alexey> executed under the lock (as map() is not executed under the lock).
Alexey> 
Alexey> btw why demap, not unmap? :)

Maybe neither is needed, as you folks made me realize above.

--Sowmini

