From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 09 Jun 2009 11:22:00 +0000
Subject: [PATCH 2/7] Redefine MMU register access asi if CONFIG_LEON
Message-Id: <4A2E45D8.7080609@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070803020208020207010105"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070803020208020207010105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From fb5efd06d7e8ed5bc09b1be66cda8167342a2737 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 12:51:43 +0200
Subject: [PATCH 2/7] Redefine MMU register access asi if CONFIG_LEON
is defined

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
  arch/sparc/include/asm/asi.h |    5 +++++
  1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
index 74703c5..aa498f8 100644
--- a/arch/sparc/include/asm/asi.h
+++ b/arch/sparc/include/asm/asi.h
@@ -259,4 +259,9 @@ #define ASI_BLK_S		0xf1 /* Secondary, bl
  #define ASI_BLK_PL		0xf8 /* Primary, blk ld/st, little	*/
  #define ASI_BLK_SL		0xf9 /* Secondary, blk ld/st, little	*/

+#ifdef CONFIG_LEON
+#undef  ASI_M_MMUREGS
+#define ASI_M_MMUREGS		0x19
+#endif /* CONFIG_LEON */
+
  #endif /* _SPARC_ASI_H */
-- 
1.4.2.1


--------------070803020208020207010105
Content-Type: text/plain;
 name="0002-Redefine-MMU-register-access-asi-if-CONFIG_LEON.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-Redefine-MMU-register-access-asi-if-CONFIG_LEON.txt"

From fb5efd06d7e8ed5bc09b1be66cda8167342a2737 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 12:51:43 +0200
Subject: [PATCH 2/7] Redefine MMU register access asi if CONFIG_LEON
is defined

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/asi.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
index 74703c5..aa498f8 100644
--- a/arch/sparc/include/asm/asi.h
+++ b/arch/sparc/include/asm/asi.h
@@ -259,4 +259,9 @@ #define ASI_BLK_S		0xf1 /* Secondary, bl
 #define ASI_BLK_PL		0xf8 /* Primary, blk ld/st, little	*/
 #define ASI_BLK_SL		0xf9 /* Secondary, blk ld/st, little	*/
 
+#ifdef CONFIG_LEON
+#undef  ASI_M_MMUREGS
+#define ASI_M_MMUREGS		0x19
+#endif /* CONFIG_LEON */
+
 #endif /* _SPARC_ASI_H */
-- 
1.4.2.1


--------------070803020208020207010105--
