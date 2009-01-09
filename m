From: David Miller <davem@davemloft.net>
Date: Fri, 09 Jan 2009 00:48:03 +0000
Subject: Re: sparc32 broke
Message-Id: <20090108.164803.166517203.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49669B15.7020107@earthlink.net>
In-Reply-To: <49669B15.7020107@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Thu, 08 Jan 2009 19:32:21 -0500

> A compile of todays mainline produces this compile error:
>=20
> arch/sparc/kernel/sun4d_smp.c:63: error: expected identifier or =E2=80=98=
(=E2=80=99 before =E2=80=98{=E2=80=99 token
> arch/sparc/kernel/sun4d_smp.c: In function =E2=80=98smp4d_callin=E2=80=99:
> arch/sparc/kernel/sun4d_smp.c:118: error: lvalue required as left operand=
 of assignment
> arch/sparc/kernel/sun4d_smp.c:118: error: lvalue required as left operand=
 of assignment

Thanks for the report, I've committed the fix below to sparc-2.6

> Prior to today, sparc32 has also failed to boot completely for the last f=
ew days.
> It boots but fails in the init scripts when it can't find the boot partit=
ion.
>=20
> Ill try to bisect the boot problem but it will take a while.

Thanks, let us know if you need any help figuring something out.

sparc: Fix sun4d_irq.c build.

Reported by Robert Reif.

Fallout from 'swap' changes.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4d_smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 16ab0cb..50afaed 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -60,7 +60,7 @@ extern int __smp4d_processor_id(void);
 #define SMP_PRINTK(x)
 #endif
=20
-static inline unsigned long swap(volatile unsigned long *ptr, unsigned lon=
g val)
+static inline unsigned long sun4d_swap(volatile unsigned long *ptr, unsign=
ed long val)
 {
 	__asm__ __volatile__("swap [%1], %0\n\t" :
 			     "=3D&r" (val), "=3D&r" (ptr) :
@@ -115,7 +115,7 @@ void __cpuinit smp4d_callin(void)
 	local_flush_tlb_all();
=20
 	/* Allow master to continue. */
-	swap((unsigned long *)&cpu_callin_map[cpuid], 1);
+	sun4d_swap((unsigned long *)&cpu_callin_map[cpuid], 1);
 	local_flush_cache_all();
 	local_flush_tlb_all();
 =09
--=20
1.6.1.15.g159c88

=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
