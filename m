From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 14:43:40 +0000
Subject: Re: [PATCH v7 03/37] sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h
Message-Id: <CAK8P3a1MYopHeyWAs974zHRmfe5z8RS7G1mVQyC+iJXqa28EfA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1518505384.git.greentime@andestech.com> <4bb01fd533c66c357f3dc23a64f56414109a2aad.1518505384.git.greentime@andestech.com>
In-Reply-To: <4bb01fd533c66c357f3dc23a64f56414109a2aad.1518505384.git.greentime@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greentime Hu <green.hu@gmail.com>, sparclinux <sparclinux@vger.kernel.org>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>

On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> A commit for the nds32 architecture bootstrap("asm-generic/io.h: move
> ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
> will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
> in order to suppress re-definition errors we need to remove the #define
> in io_32.h.
>
> Also, the change adds a prototype for ioremap where size is size_t and
> offset is phys_addr_t so fix that as well.
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

This patch should have been addressed to the sparclinux mailing list to
the maintainers can see it, otherwise they are unlikely to notice.

Added it to Cc now.

Can you confirm that the patches are ordered correctly in your series so that
at no point, sparc is in a state that fails to be build cleanly?

If not, this may have to get merged into the other patch.

        Arnd

> ---
>  arch/sparc/include/asm/io_32.h | 5 -----
>  arch/sparc/kernel/ioport.c     | 4 ++--
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
> index cd51a89b393c..df2dc1784673 100644
> --- a/arch/sparc/include/asm/io_32.h
> +++ b/arch/sparc/include/asm/io_32.h
> @@ -127,12 +127,7 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst,
>   * Bus number may be embedded in the higher bits of the physical address.
>   * This is why we have no bus number argument to ioremap().
>   */
> -void __iomem *ioremap(unsigned long offset, unsigned long size);
> -#define ioremap_nocache(X,Y)   ioremap((X),(Y))
> -#define ioremap_wc(X,Y)                ioremap((X),(Y))
> -#define ioremap_wt(X,Y)                ioremap((X),(Y))
>  void iounmap(volatile void __iomem *addr);
> -
>  /* Create a virtual mapping cookie for an IO port range */
>  void __iomem *ioport_map(unsigned long port, unsigned int nr);
>  void ioport_unmap(void __iomem *);
> diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
> index 7eeef80c02f7..3bcef9ce74df 100644
> --- a/arch/sparc/kernel/ioport.c
> +++ b/arch/sparc/kernel/ioport.c
> @@ -122,12 +122,12 @@ static void xres_free(struct xresource *xrp) {
>   *
>   * Bus type is always zero on IIep.
>   */
> -void __iomem *ioremap(unsigned long offset, unsigned long size)
> +void __iomem *ioremap(phys_addr_t offset, size_t size)
>  {
>         char name[14];
>
>         sprintf(name, "phys_%08x", (u32)offset);
> -       return _sparc_alloc_io(0, offset, size, name);
> +       return _sparc_alloc_io(0, (unsigned long)offset, size, name);
>  }
>  EXPORT_SYMBOL(ioremap);
>
> --
> 2.16.1
>
