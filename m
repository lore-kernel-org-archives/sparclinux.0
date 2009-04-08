From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 08 Apr 2009 05:29:19 +0000
Subject: Re: kernel bug with CONFIG_KEYBOARD_ATKBD=y
Message-Id: <200904080029.20097.dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
References: <200904071001.19368.dennis@ausil.us>
In-Reply-To: <200904071001.19368.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 07 April 2009 05:24:11 pm David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 07 Apr 2009 15:16:38 -0700 (PDT)
>
> > From: Dennis Gilmore <dennis@ausil.us>
> > Date: Tue, 7 Apr 2009 17:10:08 -0500
> >
> >> On Tuesday 07 April 2009 04:57:55 pm David Miller wrote:
> >>> From: Dennis Gilmore <dennis@ausil.us>
> >>> Date: Tue, 7 Apr 2009 10:01:17 -0500
> >>>
> >>> > Initalizing network drop monitor service
> >>> > kernel BUG at
> >>> > /builddir/build/BUILD/kernel-2.6.29/linux-2.6.29.sparc64/arch/sparc/i
> >>> >nclu de/asm/tlb_64.h:48!
> >>>
> >>> What kernel is this tree based upon?  2.6.29.1?
> >>
> >> yeah 2.6.29.1
> >
> > A sparc64 fix I put into 2.6.29.1 is likely the cause.  It's possible
> > I put in a version without a particular issue cured.
>
> Indeed, here is the fix, I'll push it to -stable.  Thanks for your
> report:
>
> sparc64: Fix bug in ("sparc64: Flush TLB before releasing pages.")
>
> [ No upstream commit, this regression was added only to 2.6.29.1 ]
>
> Unfortunately I merged an earlier version of commit
> b6816b706138c3870f03115071872cad824f90b4 ("sparc64: Flush TLB before
> releasing pages.") than what I actually tested and merged upstream.
>
> Simply diffing asm/tlb_64.h in Linus's tree vs. what ended up in
> 2.6.29.1 confirms this.
>
> Sync things up to fix BUG() triggers some users are seeing.
>
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/include/asm/tlb_64.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sparc/include/asm/tlb_64.h
> b/arch/sparc/include/asm/tlb_64.h index 0aaa086..ee38e73 100644
> --- a/arch/sparc/include/asm/tlb_64.h
> +++ b/arch/sparc/include/asm/tlb_64.h
> @@ -57,9 +57,9 @@ static inline struct mmu_gather *tlb_gather_mmu(struct
> mm_struct *mm, unsigned i
>
>  static inline void tlb_flush_mmu(struct mmu_gather *mp)
>  {
> +	if (!mp->fullmm)
> +		flush_tlb_pending();
>  	if (mp->need_flush) {
> -		if (!mp->fullmm)
> -			flush_tlb_pending();
>  		free_pages_and_swap_cache(mp->pages, mp->pages_nr);
>  		mp->pages_nr = 0;
>  		mp->need_flush = 0;
Thanks Dave,

I can confirm that i can boot a 2.6.29.1 kernel with the patch applied.

Dennis
