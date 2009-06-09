From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 09 Jun 2009 11:22:10 +0000
Subject: [PATCH 4/7] Undefine srmmu_hwprobe in the CONFIG_LEON case.
Message-Id: <4A2E45E2.4070906@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080006020001050002080707"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080006020001050002080707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From 93d982ed55ae6f81a06329524fbfdf0fec4d9d1e Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 12:59:42 +0200
Subject: [PATCH 4/7] Undefine srmmu_hwprobe in the CONFIG_LEON case.
The sparc-leon SRMMU has no mmu probe logic implemented.
Instead function srmmu_swprobe() is used that is defined in
arch/sparc/mm/leon.c. arch/sparc/include/asm/leon.h on the
other hand defines srmmu_hwprobe(addr) as a macro

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
  arch/sparc/include/asm/pgtsrmmu.h |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 808555f..1701181 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -267,6 +267,7 @@ static inline void srmmu_flush_tlb_page(

  }

+#if !(defined(CONFIG_LEON))
  static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
  {
  	unsigned long retval;
@@ -278,6 +279,7 @@ static inline unsigned long srmmu_hwprob

  	return retval;
  }
+#endif

  static inline int
  srmmu_get_pte (unsigned long addr)
-- 
1.4.2.1


--------------080006020001050002080707
Content-Type: text/plain;
 name="0004-Undefine-srmmu_hwprobe-in-the-CONFIG_LEON-case.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0004-Undefine-srmmu_hwprobe-in-the-CONFIG_LEON-case.txt"

From 93d982ed55ae6f81a06329524fbfdf0fec4d9d1e Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 12:59:42 +0200
Subject: [PATCH 4/7] Undefine srmmu_hwprobe in the CONFIG_LEON case.
The sparc-leon SRMMU has no mmu probe logic implemented.
Instead function srmmu_swprobe() is used that is defined in
arch/sparc/mm/leon.c. arch/sparc/include/asm/leon.h on the
other hand defines srmmu_hwprobe(addr) as a macro

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/pgtsrmmu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 808555f..1701181 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -267,6 +267,7 @@ static inline void srmmu_flush_tlb_page(
 
 }
 
+#if !(defined(CONFIG_LEON))
 static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 {
 	unsigned long retval;
@@ -278,6 +279,7 @@ static inline unsigned long srmmu_hwprob
 
 	return retval;
 }
+#endif
 
 static inline int
 srmmu_get_pte (unsigned long addr)
-- 
1.4.2.1


--------------080006020001050002080707--
