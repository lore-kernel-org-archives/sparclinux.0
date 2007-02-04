From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Sun, 04 Feb 2007 03:52:31 +0000
Subject: [PATCH] Missing pagemap include for sparc64
Message-Id: <20070204035231.GA8115@Krystal>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Missing pagemap include for sparc64

I tried to compile linux 2.6.20-rc7 using a cross compiler
x86_64->sparc64 and found out an include was missing.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


--- a/include/asm-sparc64/tlb.h
+++ b/include/asm-sparc64/tlb.h
@@ -2,6 +2,7 @@
 #define _SPARC64_TLB_H
 
 #include <linux/swap.h>
+#include <linux/pagemap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
