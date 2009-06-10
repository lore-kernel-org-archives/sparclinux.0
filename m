From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 10 Jun 2009 11:08:50 +0000
Subject: Re: [PATCH 1/7] CONFIG_SPARC_LEON option
Message-Id: <646765f40906100408g148eefcfn1ac9ac248630a9ab@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1244628574-23789-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1244628574-23789-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Konrad: sorry for the double message, hit reply instead of reply-all -
it's best to keep things on-list =)

On Wed, Jun 10, 2009 at 20:09, <konrad@gaisler.com> wrote:
> From: Konrad Eisele <konrad@gaisler.com>
> This macro will shield, if undefined, the sun-sparc code
> from LEON specific code. In particular include/asm/leon.h
> will get empty through #ifdef arch/sparc/kernel/leon.c not
> compiled through Makefile:obj-$(CONFIG_SPARC_LEON)
> arch/sparc/mm/leon.c not compiled through
> Makefile:obj-$(CONFIG_SPARC_LEON)
> ---
>  arch/sparc/Kconfig            |    6
>  arch/sparc/include/asm/leon.h |  571 +++++++++++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/leon_k.c    |  195 ++++++++++++++
>  arch/sparc/mm/leon_m.c        |  254 ++++++++++++++++++
>  4 files changed, 1026 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
> new file mode 100644
> index 0000000..e051692
> --- /dev/null
> +++ b/arch/sparc/include/asm/leon.h

[snip]

> +#ifndef __ASSEMBLY__
> +
> +/* do a virtual address read without cache */
> +static inline unsigned long leon_readnobuffer_reg(unsigned long paddr)
> +{
> +       unsigned long retval;
> +       __asm__ __volatile__("lda [%1] %2, %0\n\t" :
> +                            "=r"(retval) : "r"(paddr), "i"(ASI_LEON_NOCACHE));
> +       return retval;
> +}
> +
> +/* do a physical address bypass write, i.e. for 0x80000000 */
> +static inline void leon_store_reg(unsigned long paddr, unsigned long value)
> +{
> +       __asm__ __volatile__("sta %0, [%1] %2\n\t" : : "r"(value), "r"(paddr),
> +                            "i"(ASI_LEON_BYPASS) : "memory");
> +}
> +
> +/* do a physical address bypass load, i.e. for 0x80000000 */
> +static inline unsigned long leon_load_reg(unsigned long paddr)
> +{
> +       unsigned long retval;
> +       __asm__ __volatile__("lda [%1] %2, %0\n\t" :
> +                            "=r"(retval) : "r"(paddr), "i"(ASI_LEON_BYPASS));
> +       return retval;
> +}
> +
> +extern inline void leon_srmmu_disabletlb(void)
> +{
> +       unsigned int retval;
> +       __asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
> +                            "i"(ASI_LEON_MMUREGS));
> +       retval |= LEON_CNR_CTRL_TLBDIS;
> +       __asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retval), "r"(0),
> +                            "i"(ASI_LEON_MMUREGS) : "memory");
> +}
> +
> +extern inline void leon_srmmu_enabletlb(void)
> +{
> +       unsigned int retval;
> +       __asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
> +                            "i"(ASI_LEON_MMUREGS));
> +       retval = retval & ~LEON_CNR_CTRL_TLBDIS;
> +       __asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retval), "r"(0),
> +                            "i"(ASI_LEON_MMUREGS) : "memory");
> +}

[snip]

> +extern inline unsigned long sparc_leon3_get_dcachecfg(void)
> +{
> +       unsigned int retval;
> +       __asm__ __volatile__("lda [%1] %2, %0\n\t" :
> +                            "=r"(retval) :
> +                            "r"(ASI_LEON3_SYSCTRL_DCFG),
> +                            "i"(ASI_LEON3_SYSCTRL));
> +       return retval;
> +}
> +
> +/*enable snooping*/
> +extern inline void sparc_leon3_enable_snooping(void)
> +{
> +       __asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
> +                         "set 0x800000, %%l2\n\t"
> +                         "or  %%l2, %%l1, %%l2\n\t"
> +                         "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
> +};
> +
> +extern inline void sparc_leon3_disable_cache(void)
> +{
> +       __asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
> +                         "set 0x00000f, %%l2\n\t"
> +                         "andn  %%l2, %%l1, %%l2\n\t"
> +                         "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
> +};

I don't understand what's going on with this code, but I don't think
it should live in a header file.

Thanks,

--

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
