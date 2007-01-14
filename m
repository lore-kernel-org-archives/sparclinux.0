From: Bob Breuer <breuerr@mc.net>
Date: Sun, 14 Jan 2007 20:32:57 +0000
Subject: [PATCH] sparc32: fix gcc over-optimizatoin near ip_fast_csum
Message-Id: <45AA9379.8060700@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix over-optimization by GCC near ip_fast_csum.

In some cases such as:
	iph->check = 0;
	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
GCC may optimize out the previous store.

Observed as a failure of NFS over udp (bad checksums on ip fragments) when 
compiled with GCC 3.4.2.

Signed-off-by: Bob Breuer <breuerr@mc.net>
---
diff --git a/include/asm-sparc/checksum.h b/include/asm-sparc/checksum.h
index 267e631..34518ea 100644
--- a/include/asm-sparc/checksum.h
+++ b/include/asm-sparc/checksum.h
@@ -151,7 +151,7 @@ static inline __sum16 ip_fast_csum(const
 			     "xnor\t%%g0, %0, %0"
 			     : "=r" (sum), "=&r" (iph)
 			     : "r" (ihl), "1" (iph)
-			     : "g2", "g3", "g4", "cc");
+			     : "g2", "g3", "g4", "cc", "memory");
 	return sum;
 }
 


