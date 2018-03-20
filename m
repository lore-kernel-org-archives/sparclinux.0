From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 20 Mar 2018 14:46:02 +0000
Subject: [PATCH sparc-next] sparc: Make auxiliary vectors for ADI available on 32-bit as well
Message-Id: <20180320144602.16535-1-khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: Khalid Aziz <khalid.aziz@oracle.com>, shannon.nelson@oracle.com, nagarathnam.muthusamy@oracle.com, nick.alcock@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

Commit c6202ca764ac ("sparc64: Add auxiliary vectors to report
platform ADI properties") adds auxiliary vectors to report ADI
capabilities on sparc64 platform only. This needs to be uniform
across 64-bit and 32-bit. This patch makes the same vectors
available on 32-bit as well.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
 arch/sparc/include/uapi/asm/auxvec.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/auxvec.h b/arch/sparc/include/uapi/asm/auxvec.h
index f9937ccfcd99..ab8780fb9df1 100644
--- a/arch/sparc/include/uapi/asm/auxvec.h
+++ b/arch/sparc/include/uapi/asm/auxvec.h
@@ -3,7 +3,6 @@
 
 #define AT_SYSINFO_EHDR		33
 
-#ifdef CONFIG_SPARC64
 /* Avoid overlap with other AT_* values since they are consolidated in
  * glibc and any overlaps can cause problems
  */
@@ -12,8 +11,5 @@
 #define AT_ADI_UEONADI	50
 
 #define AT_VECTOR_SIZE_ARCH	4
-#else
-#define AT_VECTOR_SIZE_ARCH	1
-#endif
 
 #endif /* !(__ASMSPARC_AUXVEC_H) */
-- 
2.11.0

