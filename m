From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 24 Aug 2013 14:04:35 +0000
Subject: Re: [PATCH]sparc64: Flush locked TLB entries used to map initmem
Message-Id: <33201377353075@web21f.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <48681375722364@web3g.yandex.ru>
In-Reply-To: <48681375722364@web3g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

We can't move BSS up. I use non-standard bootloader and it eats this.
But SILO doesn't want, he says about multiple loadable segments in ELF file.
So the patch is not applicable. Sorry.

05.08.2013, 21:06, "Kirill Tkhai" <tkhai@yandex.ru>:
> Check if __init_begin <=3D (some 4Mb aligned address) < __init_end.
> If true then flush corresponding 4Mb TLB page.
>
> Move BSS at the middle of the image to make initmem be last range
> of mapped kernel area.
>
> It's not likely case, but sometimes can be useful.
>
> I use flush_tlb_kernel_range which flushes 8K pages sequentially
> and only the first flush() has a result. It seems it's not necessary
> to introduce new function for one-time boot use...
>
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
> CC: David Miller <davem@davemloft.net>
> ---
> =9Aarch/sparc/kernel/head_64.S =9A=9A=9A=9A| =9A=9A=9A4 ++--
> =9Aarch/sparc/kernel/vmlinux.lds.S | =9A=9A=9A3 ++-
> =9Aarch/sparc/mm/init_64.c =9A=9A=9A=9A=9A=9A=9A=9A| =9A=9A17 +++++++++++=
++++++
> =9A3 files changed, 21 insertions(+), 3 deletions(-)
> diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
> index 26b706a..81dbb74 100644
> --- a/arch/sparc/kernel/head_64.S
> +++ b/arch/sparc/kernel/head_64.S
> @@ -681,8 +681,8 @@ tlb_fixup_done:
> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* Clear the bss */
> =9A=9A=9A=9A=9A=9A=9A=9A=9Asethi %hi(__bss_start), %o0
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aor %o0, %lo(__bss_start), %o0
> - sethi %hi(_end), %o1
> - or %o1, %lo(_end), %o1
> + sethi %hi(__bss_stop), %o1
> + or %o1, %lo(__bss_stop), %o1
> =9A=9A=9A=9A=9A=9A=9A=9A=9Acall __bzero
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Asub %o1, %o0, %o1
>
> diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.=
lds.S
> index 0bacceb..be57226 100644
> --- a/arch/sparc/kernel/vmlinux.lds.S
> +++ b/arch/sparc/kernel/vmlinux.lds.S
> @@ -64,6 +64,8 @@ SECTIONS
> =9A=9A=9A=9A=9A=9A=9A=9A=9A/* End of data section */
> =9A=9A=9A=9A=9A=9A=9A=9A=9A_edata =3D .;
>
> + BSS_SECTION(0, 0, 0)
> +
> =9A=9A=9A=9A=9A=9A=9A=9A=9A.fixup : {
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A__start___fixup =3D .;
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*(.fixup)
> @@ -141,7 +143,6 @@ SECTIONS
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9A. =3D ALIGN(PAGE_SIZE);
> =9A=9A=9A=9A=9A=9A=9A=9A=9A__init_end =3D .;
> - BSS_SECTION(0, 0, 0)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A_end =3D . ;
>
> =9A=9A=9A=9A=9A=9A=9A=9A=9ASTABS_DEBUG
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index ed82eda..52bfcf8 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2079,6 +2079,21 @@ void __init mem_init(void)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Acheetah_ecache_flush_i=
nit();
> =9A}
>
> +/* Flush locked TLB entry (entries) if it is used to map initmem range
> + * only, i.e. __init_begin <=3D (some 4Mb aligned address) < __init_end.
> + */
> +static void flush_initmem_tlb_entries(void)
> +{
> + unsigned long begin =3D round_up((unsigned long)(__init_begin), 1 << 22=
);
> + unsigned long end =3D round_up((unsigned long)(__init_end), 1 << 22);
> +
> + if (begin >=3D end)
> + return;
> +
> + pr_info("TLB: Flushing initmem range [%016lx, %016lx]\n", begin, end-1);
> + flush_tlb_kernel_range(begin, end);
> +}
> +
> =9Avoid free_initmem(void)
> =9A{
> =9A=9A=9A=9A=9A=9A=9A=9A=9Aunsigned long addr, initend;
> @@ -2108,6 +2123,8 @@ void free_initmem(void)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aif (do_free)
> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9Afree_reserved_page(virt_to_page(page));
> =9A=9A=9A=9A=9A=9A=9A=9A=9A}
> +
> + flush_initmem_tlb_entries();
> =9A}
>
> =9A#ifdef CONFIG_BLK_DEV_INITRD
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
