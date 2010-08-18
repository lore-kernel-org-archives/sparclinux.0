From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Aug 2010 18:02:37 +0000
Subject: [PATCH] sparc64: fix atomic64 prototypes
Message-Id: <Pine.LNX.4.64.1008181316160.9287@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

This patch fixes atomic64 for sparc64. I'm sending another one, that does 
tiny microoptimization by using retl delay slot.


BTW. this is another case of that console breakage --- the failure happens 
after the console turns to dummy but before framebuffer is initialized. So 
it is not displayed and the machine seems hung. What do you think is the 
best idea to deal with it?

- if I remove "dummycon" from compilation, it displays the bug, but in 
case of no bug, bootconsole and framebuffer will fight over the hardware 
and cause crash.
One of the solutions would be to disable the bootconsole right before 
framebuffer initialization and don't compile "dummycon".

- the other possibility would be to load dummycon immediatelly before 
framebuffer (so that it kicks off bootconsole right before it would cause 
trouble)

- what is the purpose of dummycon anyway? kernel/printk.c seems to be able 
to work without any console, so why make a dummy console? It is there only 
to disable bootconsole?

What do you think would be the cleanest solution to the console problem?

Mikulas

---

If you turn on CONFIG_ATOMIC64_SELFTEST, the test fails on sparc64. The
assembler implementations of atomic64_t functions are correct but the
functions had their arguments and return values incorrectly declared as
'int'.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/sparc/include/asm/atomic_64.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.35-preempt/arch/sparc/include/asm/atomic_64.h
=================================--- linux-2.6.35-preempt.orig/arch/sparc/include/asm/atomic_64.h	2010-08-18 06:41:48.000000000 +0200
+++ linux-2.6.35-preempt/arch/sparc/include/asm/atomic_64.h	2010-08-18 15:09:32.000000000 +0200
@@ -20,14 +20,14 @@
 #define atomic64_set(v, i)	(((v)->counter) = i)
 
 extern void atomic_add(int, atomic_t *);
-extern void atomic64_add(int, atomic64_t *);
+extern void atomic64_add(long, atomic64_t *);
 extern void atomic_sub(int, atomic_t *);
-extern void atomic64_sub(int, atomic64_t *);
+extern void atomic64_sub(long, atomic64_t *);
 
 extern int atomic_add_ret(int, atomic_t *);
-extern int atomic64_add_ret(int, atomic64_t *);
+extern long atomic64_add_ret(long, atomic64_t *);
 extern int atomic_sub_ret(int, atomic_t *);
-extern int atomic64_sub_ret(int, atomic64_t *);
+extern long atomic64_sub_ret(long, atomic64_t *);
 
 #define atomic_dec_return(v) atomic_sub_ret(1, v)
 #define atomic64_dec_return(v) atomic64_sub_ret(1, v)
