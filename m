From: "Art Haas" <ahaas@airmail.net>
Date: Thu, 10 Feb 2005 19:02:53 +0000
Subject: [PATCH] Fix for spinlock.h
Message-Id: <20050210190253.GF2387@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

For grins I've started a build for an SMP configuration, and things died
quickly. The patch below was needed to correct the macro definition.
Maybe this can slip into 2.6.11?

Art Haas

=== include/asm-sparc/spinlock.h 1.8 vs edited ==--- 1.8/include/asm-sparc/spinlock.h	2005-01-20 10:21:24 -06:00
+++ edited/include/asm-sparc/spinlock.h	2005-02-10 10:51:24 -06:00
@@ -91,7 +91,7 @@
 #endif
 } spinlock_t;
 
-#define SPIN_LOCK_UNLOCKED	{ 0, }
+#define SPIN_LOCK_UNLOCKED	(spinlock_t) { 0 }
 
 #define spin_lock_init(lock)   (*((unsigned char *)(lock)) = 0)
 #define spin_is_locked(lock)    (*((volatile unsigned char *)(lock)) != 0)
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
