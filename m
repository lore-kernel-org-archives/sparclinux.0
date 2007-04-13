From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 13 Apr 2007 17:26:09 +0000
Subject: [PATCH] Another minor inline fix for sparc64
Message-Id: <1176485169.3970.202.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-kUM8hZ92uKdYr7IHJuKa"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-kUM8hZ92uKdYr7IHJuKa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Caught this one building the sparc64 SMP kernel. Makes me wonder whether
my compiler (gcc version 4.1.1 20060629) is being oversensitive (or if
DaveM uses an older compiler which is less picky about inline ordering).

Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>


--=-kUM8hZ92uKdYr7IHJuKa
Content-Disposition: attachment; filename=linux-2.6.20-sparc64-inlinefix2.patch
Content-Type: text/x-patch; name=linux-2.6.20-sparc64-inlinefix2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.20.sparc64/include/asm-sparc64/spinlock.h.BAD	2007-04-13 12:56:03.000000000 -0400
+++ linux-2.6.20.sparc64/include/asm-sparc64/spinlock.h	2007-04-13 12:57:15.000000000 -0400
@@ -105,7 +105,7 @@
 
 /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
 
-static void inline __read_lock(raw_rwlock_t *lock)
+static inline void __read_lock(raw_rwlock_t *lock)
 {
 	unsigned long tmp1, tmp2;
 
@@ -130,7 +130,7 @@
 	: "memory");
 }
 
-static int inline __read_trylock(raw_rwlock_t *lock)
+static inline int __read_trylock(raw_rwlock_t *lock)
 {
 	int tmp1, tmp2;
 
@@ -152,7 +152,7 @@
 	return tmp1;
 }
 
-static void inline __read_unlock(raw_rwlock_t *lock)
+static inline void __read_unlock(raw_rwlock_t *lock)
 {
 	unsigned long tmp1, tmp2;
 
@@ -169,7 +169,7 @@
 	: "memory");
 }
 
-static void inline __write_lock(raw_rwlock_t *lock)
+static inline void __write_lock(raw_rwlock_t *lock)
 {
 	unsigned long mask, tmp1, tmp2;
 
@@ -196,7 +196,7 @@
 	: "memory");
 }
 
-static void inline __write_unlock(raw_rwlock_t *lock)
+static inline void __write_unlock(raw_rwlock_t *lock)
 {
 	__asm__ __volatile__(
 "	membar		#LoadStore | #StoreStore\n"
@@ -206,7 +206,7 @@
 	: "memory");
 }
 
-static int inline __write_trylock(raw_rwlock_t *lock)
+static inline int __write_trylock(raw_rwlock_t *lock)
 {
 	unsigned long mask, tmp1, tmp2, result;
 

--=-kUM8hZ92uKdYr7IHJuKa--

