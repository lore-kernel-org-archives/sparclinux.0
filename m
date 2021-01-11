From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Mon, 11 Jan 2021 09:16:46 +0000
Subject: Re: [patch V3 13/37] mips/mm/highmem: Switch to generic kmap atomic
Message-Id: <20210111091646.hkugbtlcced3vmno@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <JUTMMQ.NNFWKIUV7UUJ1@crapouillou.net>
 <20210108235805.GA17543@alpha.franken.de>
 <20210109003352.GA18102@alpha.franken.de>
In-Reply-To: <20210109003352.GA18102@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: juri.lelli@redhat.com, linux-aio@kvack.org, Paul Cercueil <paul@crapouillou.net>, airlied@linux.ie, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, bsegall@google.com, jcmvbkbc@gmail.com, ray.huang@amd.com, paulus@samba.org, kraxel@redhat.com, sparclinux@vger.kernel.org, deanbo422@gmail.com, hch@lst.de, vincent.guittot@linaro.org, paulmck@kernel.org, mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, airlied@redhat.com, linux-snps-arc@lists.infradead.org, linux-mm@kvack.org, mgorman@suse.de, linux-xtensa@linux-xtensa.org, arnd@arndb.de, intel-gfx@lists.freedesktop.org, sroland@vmware.com, josef@toxicpanda.com, rostedt@goodmis.org, torvalds@linuxfoundation.org, green.hu@gmail.com, rodrigo.vivi@intel.com, dsterba@suse.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, chris@zankel.net, monstr@monstr.eu, nickhu@andestech.com, clm@fb.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, bcrl@kvack.org, spice-devel@lists.freedesktop.org, vgupta@synopsys.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, bristot@redhat.com, davem@davemloft.net, linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk

On 2021-01-09 01:33:52 [+0100], Thomas Bogendoerfer wrote:
> On Sat, Jan 09, 2021 at 12:58:05AM +0100, Thomas Bogendoerfer wrote:
> > On Fri, Jan 08, 2021 at 08:20:43PM +0000, Paul Cercueil wrote:
> > > Hi Thomas,
> > > 
> > > 5.11 does not boot anymore on Ingenic SoCs, I bisected it to this commit.
> > > 
> > > Any idea what could be happening?
> > 
> > not yet, kernel crash log of a Malta QEMU is below.
> 
> update:
> 
> This dirty hack lets the Malta QEMU boot again:
> 
> diff --git a/mm/highmem.c b/mm/highmem.c
> index c3a9ea7875ef..190cdda1149d 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -515,7 +515,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
>  	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
>  	BUG_ON(!pte_none(*(kmap_pte - idx)));
>  	pteval = pfn_pte(pfn, prot);
> -	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
> +	set_pte(kmap_pte - idx, pteval);
>  	arch_kmap_local_post_map(vaddr, pteval);
>  	current->kmap_ctrl.pteval[kmap_local_idx()] = pteval;
>  	preempt_enable();
> 
> set_pte_at() tries to update cache and could do an kmap_atomic() there.
So the old implementation used set_pte() while the new one uses
set_pte_at().

> Not sure, if this is allowed at this point.
The problem is the recursion
  kmap_atomic() -> __update_cache() -> kmap_atomic()

and kmap_local_idx_push() runs out if index space before stack space.

I'm not sure if the __update_cache() worked for highmem. It has been
added for that in commit
   f4281bba81810 ("MIPS: Handle highmem pages in __update_cache")

but it assumes that the address returned by kmap_atomic() is the same or
related enough for flush_data_cache_page() to work.

> Thomas.
> 

Sebastian
