From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 19:35:22 +0000
Subject: Re: sparc-next compile errors
Message-Id: <20080830.123522.54394665.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48B958A0.3000505@earthlink.net>
In-Reply-To: <48B958A0.3000505@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Sat, 30 Aug 2008 10:26:40 -0400

> I get these errors when compiling sparc-next for sparc32 SMP:
>=20
> CC arch/sparc/kernel/dma.o
> arch/sparc/kernel/dma.c:156: error: redefinition of =E2=80=98dma_sync_sin=
gle_for_cpu=E2=80=99
> arch/sparc/kernel/dma.c:144: error: previous definition of =E2=80=98dma_s=
ync_single_for_cpu=E2=80=99 was here

This is what I get for doing my test builds with everything enabled. :)

It would only trigger if CONFIG_PCI was not set.

I just pushed the following fix to the tree, thanks for the report!

sparc: Stop setting NO_DMA.

This fixes the build with PCI disabled, we do want the
generic DMA facilities and interfaces even when just SBUS
is enabled.

Based upon a build failure report by Robert Reif.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index cb1dd35..abcd82b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -235,9 +235,6 @@ source "drivers/pci/Kconfig"
=20
 endif
=20
-config NO_DMA
-	def_bool !PCI
-
 config SUN_OPENPROMFS
 	tristate "Openprom tree appears in /proc/openprom"
 	help
--=20
1.5.6.5.GIT

=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
