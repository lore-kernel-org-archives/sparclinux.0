From: vignesh babu <vignesh.babu@wipro.com>
Date: Mon, 13 Aug 2007 13:11:12 +0000
Subject: [kj] is_power_of_2 in include/asm-sparc64/vio.h
Message-Id: <1187009952.7273.14.camel@merlin.linuxcoe.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Replacing n & (n - 1) for power of 2 check by is_power_of_2(n)

Signed-off-by: vignesh babu <vignesh.babu@wipro.com>
---
diff --git a/include/asm-sparc64/vio.h b/include/asm-sparc64/vio.h
index f7417e9..2cc65a9 100644
--- a/include/asm-sparc64/vio.h
+++ b/include/asm-sparc64/vio.h
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/list.h>
+#include <linux/log2.h>
 
 #include <asm/ldc.h>
 #include <asm/mdesc.h>
@@ -258,7 +259,7 @@ static inline u32 vio_dring_avail(struct vio_dring_state *dr,
 				  unsigned int ring_size)
 {
 	/* Ensure build-time power-of-2.  */
-	BUILD_BUG_ON(ring_size & (ring_size - 1));
+	BUILD_BUG_ON(!is_power_of_2(ring_size));
 
 	return (dr->pending -
 		((dr->prod - dr->cons) & (ring_size - 1)));

-- 
Vignesh Babu BM 
_____________________________________________________________ 
"Why is it that every time I'm with you, makes me believe in magic?"

