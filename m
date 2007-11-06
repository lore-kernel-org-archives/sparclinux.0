From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Tue, 06 Nov 2007 17:06:46 +0000
Subject: [PATCH] SPARC64: Use "is_power_of_2" macro for simplicity.
Message-Id: <Pine.LNX.4.64.0711061205440.25032@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/include/asm-sparc64/vio.h b/include/asm-sparc64/vio.h
index f7417e9..d4de32f 100644
--- a/include/asm-sparc64/vio.h
+++ b/include/asm-sparc64/vio.h
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/list.h>
+#include <linux/log2.h>

 #include <asm/ldc.h>
 #include <asm/mdesc.h>
@@ -257,8 +258,7 @@ static inline void *vio_dring_entry(struct vio_dring_state *dr,
 static inline u32 vio_dring_avail(struct vio_dring_state *dr,
 				  unsigned int ring_size)
 {
-	/* Ensure build-time power-of-2.  */
-	BUILD_BUG_ON(ring_size & (ring_size - 1));
+	BUILD_BUG_ON(!is_power_of_2(ring_size));

 	return (dr->pending -
 		((dr->prod - dr->cons) & (ring_size - 1)));
-- 
====================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
====================================
