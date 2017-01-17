From: Kees Cook <keescook@chromium.org>
Date: Tue, 17 Jan 2017 17:33:28 +0000
Subject: Re: [PATCH] sparc32: mm: srmmu: add __ro_after_init to sparc32_cachetlb_ops structures
Message-Id: <CAGXu5j+LJxqpWXS6qWq93p2+EaPfOn83rVsay_ED8m9eGpVoeA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1484397114-7705-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1484397114-7705-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Jan 14, 2017 at 4:31 AM, Bhumika Goyal <bhumirks@gmail.com> wrote:
> The objects viking_ops, viking_sun4d_smp_ops and smp_cachetlb_ops of
> type sparc32_cachetlb_ops are not modified anywhere after getting modified
> in the init functions. Inside init their reference is also stored in a
> pointer of type const struct sparc32_cachetlb_ops *. So these structures
> are never modified after init, therefore add __ro_after to the declaration
> of these structures.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Yay more ro_after_init! :)

-Kees

> ---
> Instead of using __ro_after_init for the viking_* structures, should I
> use const by making two copies of these structures with different field values?
>
>  arch/sparc/mm/srmmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index c7f2a52..def82f6 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -1444,7 +1444,7 @@ static void poke_viking(void)
>         srmmu_set_mmureg(mreg);
>  }
>
> -static struct sparc32_cachetlb_ops viking_ops = {
> +static struct sparc32_cachetlb_ops viking_ops __ro_after_init = {
>         .cache_all      = viking_flush_cache_all,
>         .cache_mm       = viking_flush_cache_mm,
>         .cache_page     = viking_flush_cache_page,
> @@ -1475,7 +1475,7 @@ static void poke_viking(void)
>   * flushes going at once will require SMP locking anyways so there's
>   * no real value in trying any harder than this.
>   */
> -static struct sparc32_cachetlb_ops viking_sun4d_smp_ops = {
> +static struct sparc32_cachetlb_ops viking_sun4d_smp_ops __ro_after_init = {
>         .cache_all      = viking_flush_cache_all,
>         .cache_mm       = viking_flush_cache_mm,
>         .cache_page     = viking_flush_cache_page,
> @@ -1759,7 +1759,7 @@ static void smp_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
>         local_ops->sig_insns(mm, insn_addr);
>  }
>
> -static struct sparc32_cachetlb_ops smp_cachetlb_ops = {
> +static struct sparc32_cachetlb_ops smp_cachetlb_ops __ro_after_init = {
>         .cache_all      = smp_flush_cache_all,
>         .cache_mm       = smp_flush_cache_mm,
>         .cache_page     = smp_flush_cache_page,
> --
> 1.9.1
>



-- 
Kees Cook
Nexus Security
