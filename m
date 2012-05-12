From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:44:18 +0000
Subject: [PATCH] sparc32: Remove some more sun4c code from floppy glue.
Message-Id: <20120512.004418.464938513654363888.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/floppy_32.h |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index 80382ab..f954856 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -102,25 +102,13 @@ static struct sun_floppy_ops sun_fdops;
 /* Routines unique to each controller type on a Sun. */
 static void sun_set_dor(unsigned char value, int fdc_82077)
 {
-	if (sparc_cpu_model = sun4c) {
-		unsigned int bits = 0;
-		if (value & 0x10)
-			bits |= AUXIO_FLPY_DSEL;
-		if ((value & 0x80) = 0)
-			bits |= AUXIO_FLPY_EJCT;
-		set_auxio(bits, (~bits) & (AUXIO_FLPY_DSEL|AUXIO_FLPY_EJCT));
-	}
-	if (fdc_82077) {
+	if (fdc_82077)
 		sun_fdc->dor_82077 = value;
-	}
 }
 
 static unsigned char sun_read_dir(void)
 {
-	if (sparc_cpu_model = sun4c)
-		return (get_auxio() & AUXIO_FLPY_DCHG) ? 0x80 : 0;
-	else
-		return sun_fdc->dir_82077;
+	return sun_fdc->dir_82077;
 }
 
 static unsigned char sun_82072_fd_inb(int port)
-- 
1.7.10

