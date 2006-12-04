From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Mon, 04 Dec 2006 09:44:19 +0000
Subject: [2.4 PATCH] sparc64 dma parenthesis fixes
Message-Id: <200612041044.19475.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello,

=A0=A0=A0=A0=A0=A0=A0=A0This patch fixes some sparc64 dma macros.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

=A0include/asm-sparc64/dma.h | =A0 =A06 +++---
=A01 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.4.34-pre6-a/include/asm-sparc64/dma.h	2000-02-01 08:37:19.00000=
0000 +0100
+++ linux-2.4.34-pre6-b/include/asm-sparc64/dma.h	2006-12-01 12:00:23.00000=
0000 +0100
@@ -153,9 +153,9 @@ extern void dvma_init(struct sbus_bus *)
 #define DMA_MAXEND(addr) (0x01000000UL-(((unsigned long)(addr))&0x00ffffff=
UL))
=20
 /* Yes, I hack a lot of elisp in my spare time... */
-#define DMA_ERROR_P(regs)  (((sbus_readl((regs) + DMA_CSR) & DMA_HNDL_ERRO=
R))
-#define DMA_IRQ_P(regs)    (((sbus_readl((regs) + DMA_CSR)) & (DMA_HNDL_IN=
TR | DMA_HNDL_ERROR)))
-#define DMA_WRITE_P(regs)  (((sbus_readl((regs) + DMA_CSR) & DMA_ST_WRITE))
+#define DMA_ERROR_P(regs)  (sbus_readl((regs) + DMA_CSR) & DMA_HNDL_ERROR)
+#define DMA_IRQ_P(regs)    ((sbus_readl((regs) + DMA_CSR)) & (DMA_HNDL_INT=
R | DMA_HNDL_ERROR))
+#define DMA_WRITE_P(regs)  (sbus_readl((regs) + DMA_CSR) & DMA_ST_WRITE)
 #define DMA_OFF(__regs)		\
 do {	u32 tmp =3D sbus_readl((__regs) + DMA_CSR); \
 	tmp &=3D ~DMA_ENABLE; \


--=20
Regards,

	Mariusz Kozlowski
