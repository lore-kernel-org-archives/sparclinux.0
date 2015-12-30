From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 30 Dec 2015 13:26:01 +0000
Subject: [PATCH 25/34] sparc: define __smp_xxx
Message-Id: <1451473761-30019-26-git-send-email-mst@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Ingo Molnar <mingo@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, virtualization@lists.linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

This defines __smp_XXX barriers for sparc,
for use by virtualization.

smp_XXX barriers are removed as they are
defined correctly by asm-generic/barriers.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sparc/include/asm/barrier_64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/barrier_64.h b/arch/sparc/include/asm/barrier_64.h
index 26c3f72..c9f6ee6 100644
--- a/arch/sparc/include/asm/barrier_64.h
+++ b/arch/sparc/include/asm/barrier_64.h
@@ -37,14 +37,14 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 1f\n\t" \
 #define rmb()	__asm__ __volatile__("":::"memory")
 #define wmb()	__asm__ __volatile__("":::"memory")
 
-#define smp_store_release(p, v)						\
+#define __smp_store_release(p, v)						\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
 
-#define smp_load_acquire(p)						\
+#define __smp_load_acquire(p)						\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
@@ -52,8 +52,8 @@ do {									\
 	___p1;								\
 })
 
-#define smp_mb__before_atomic()	barrier()
-#define smp_mb__after_atomic()	barrier()
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
 
 #include <asm-generic/barrier.h>
 
-- 
MST

