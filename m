From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 10 Jun 2009 00:01:39 +0000
Subject: Re: [PATCH 4/7] Undefine srmmu_hwprobe in the CONFIG_LEON case.
Message-Id: <646765f40906091701y281faf32m1149bdce5f9ec6dc@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45E2.4070906@gaisler.com>
In-Reply-To: <4A2E45E2.4070906@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Jun 9, 2009 at 21:22, Konrad Eisele<konrad@gaisler.com> wrote:
> From 93d982ed55ae6f81a06329524fbfdf0fec4d9d1e Mon Sep 17 00:00:00 2001
> From: Konrad Eisele <konrad@gaisler.com>
> Date: Tue, 9 Jun 2009 12:59:42 +0200
> Subject: [PATCH 4/7] Undefine srmmu_hwprobe in the CONFIG_LEON case.
> The sparc-leon SRMMU has no mmu probe logic implemented.
> Instead function srmmu_swprobe() is used that is defined in
> arch/sparc/mm/leon.c. arch/sparc/include/asm/leon.h on the
> other hand defines srmmu_hwprobe(addr) as a macro
>
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>
> ---
> =A0arch/sparc/include/asm/pgtsrmmu.h | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/include/asm/pgtsrmmu.h
> b/arch/sparc/include/asm/pgtsrmmu.h
> index 808555f..1701181 100644
> --- a/arch/sparc/include/asm/pgtsrmmu.h
> +++ b/arch/sparc/include/asm/pgtsrmmu.h
> @@ -267,6 +267,7 @@ static inline void srmmu_flush_tlb_page(
>
> =A0}
>
> +#if !(defined(CONFIG_LEON))
> =A0static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
> =A0{
> =A0 =A0 =A0 =A0unsigned long retval;
> @@ -278,6 +279,7 @@ static inline unsigned long srmmu_hwprob
>
> =A0 =A0 =A0 =A0return retval;
> =A0}
> +#endif
>
> =A0static inline int
> =A0srmmu_get_pte (unsigned long addr)

Surely there is a better way to do this, oh and if this is the only
way, #ifndef CONFIG_LEON is much cleaner.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
