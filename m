From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:50 +0000
Subject: [PATCH 12/34] sparc: drop use of extern for prototypes in arch/sparc/include/asm
Message-Id: <1400275572-17424-12-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-12-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-12-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Drop extern for all prototypes and adjust alignment of parameters
as required after the removal.
In a few rare cases adjust linelength to conform to maximum 80 chars,
and likewise in a few rare cases adjust alignment of parameters
to static functions.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/atomic_32.h      |   8 +-
 arch/sparc/include/asm/atomic_64.h      |  18 +-
 arch/sparc/include/asm/auxio_32.h       |   4 +-
 arch/sparc/include/asm/auxio_64.h       |   4 +-
 arch/sparc/include/asm/bitext.h         |   6 +-
 arch/sparc/include/asm/bitops_32.h      |   6 +-
 arch/sparc/include/asm/bitops_64.h      |  24 +--
 arch/sparc/include/asm/btext.h          |   2 +-
 arch/sparc/include/asm/bug.h            |   2 +-
 arch/sparc/include/asm/cacheflush_32.h  |   8 +-
 arch/sparc/include/asm/cacheflush_64.h  |  24 +--
 arch/sparc/include/asm/checksum_32.h    |   4 +-
 arch/sparc/include/asm/checksum_64.h    |  32 ++--
 arch/sparc/include/asm/cmpxchg_32.h     |   6 +-
 arch/sparc/include/asm/cmpxchg_64.h     |   4 +-
 arch/sparc/include/asm/delay_32.h       |   4 +-
 arch/sparc/include/asm/delay_64.h       |   4 +-
 arch/sparc/include/asm/device.h         |   2 +-
 arch/sparc/include/asm/dma-mapping.h    |   2 +-
 arch/sparc/include/asm/ebus_dma.h       |  16 +-
 arch/sparc/include/asm/floppy_32.h      |   3 +-
 arch/sparc/include/asm/floppy_64.h      |   2 +-
 arch/sparc/include/asm/ftrace.h         |   2 +-
 arch/sparc/include/asm/highmem.h        |  10 +-
 arch/sparc/include/asm/hvtramp.h        |   2 +-
 arch/sparc/include/asm/hypervisor.h     | 325 ++++++++++++++++------------=
----
 arch/sparc/include/asm/idprom.h         |   2 +-
 arch/sparc/include/asm/io_32.h          |  12 +-
 arch/sparc/include/asm/io_64.h          |  20 +-
 arch/sparc/include/asm/iommu_64.h       |   6 +-
 arch/sparc/include/asm/irq_32.h         |   2 +-
 arch/sparc/include/asm/irq_64.h         |  44 ++---
 arch/sparc/include/asm/irqflags_32.h    |   6 +-
 arch/sparc/include/asm/kdebug_64.h      |   2 +-
 arch/sparc/include/asm/kgdb.h           |   2 +-
 arch/sparc/include/asm/kprobes.h        |   6 +-
 arch/sparc/include/asm/ldc.h            |  66 +++----
 arch/sparc/include/asm/leon.h           |  54 +++---
 arch/sparc/include/asm/leon_pci.h       |   4 +-
 arch/sparc/include/asm/mdesc.h          |  32 ++--
 arch/sparc/include/asm/mmu_64.h         |   6 +-
 arch/sparc/include/asm/mmu_context_64.h |  24 +--
 arch/sparc/include/asm/nmi.h            |  10 +-
 arch/sparc/include/asm/oplib_32.h       |  68 +++----
 arch/sparc/include/asm/oplib_64.h       | 112 +++++------
 arch/sparc/include/asm/page_64.h        |   8 +-
 arch/sparc/include/asm/pci_64.h         |  14 +-
 arch/sparc/include/asm/pcic.h           |   8 +-
 arch/sparc/include/asm/pcr.h            |   6 +-
 arch/sparc/include/asm/pgalloc_64.h     |  16 +-
 arch/sparc/include/asm/pgtable_32.h     |  10 +-
 arch/sparc/include/asm/pgtable_64.h     |  58 +++---
 arch/sparc/include/asm/processor_32.h   |   4 +-
 arch/sparc/include/asm/processor_64.h   |   4 +-
 arch/sparc/include/asm/prom.h           |  24 +--
 arch/sparc/include/asm/ptrace.h         |   2 +-
 arch/sparc/include/asm/setup.h          |   2 +-
 arch/sparc/include/asm/smp_32.h         |   6 +-
 arch/sparc/include/asm/smp_64.h         |  18 +-
 arch/sparc/include/asm/spitfire.h       |   2 +-
 arch/sparc/include/asm/stacktrace.h     |   2 +-
 arch/sparc/include/asm/starfire.h       |   8 +-
 arch/sparc/include/asm/string_32.h      |  12 +-
 arch/sparc/include/asm/string_64.h      |  12 +-
 arch/sparc/include/asm/switch_to_32.h   |   6 +-
 arch/sparc/include/asm/switch_to_64.h   |   4 +-
 arch/sparc/include/asm/syscalls.h       |   8 +-
 arch/sparc/include/asm/timer_32.h       |   4 +-
 arch/sparc/include/asm/timer_64.h       |   6 +-
 arch/sparc/include/asm/tlb_64.h         |   8 +-
 arch/sparc/include/asm/tlbflush_64.h    |  22 +--
 arch/sparc/include/asm/topology_64.h    |   2 +-
 arch/sparc/include/asm/trap_block.h     |   6 +-
 arch/sparc/include/asm/uaccess.h        |   2 +-
 arch/sparc/include/asm/uaccess_32.h     |  14 +-
 arch/sparc/include/asm/uaccess_64.h     |  50 ++---
 arch/sparc/include/asm/vio.h            |  36 ++--
 arch/sparc/include/asm/visasm.h         |   3 +-
 arch/sparc/include/asm/xor_64.h         |  28 +--
 79 files changed, 711 insertions(+), 706 deletions(-)

diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/at=
omic_32.h
index 905832a..58fa8a5 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -19,11 +19,11 @@
=20
 #define ATOMIC_INIT(i)  { (i) }
=20
-extern int __atomic_add_return(int, atomic_t *);
-extern int atomic_cmpxchg(atomic_t *, int, int);
+int __atomic_add_return(int, atomic_t *);
+int atomic_cmpxchg(atomic_t *, int, int);
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
-extern int __atomic_add_unless(atomic_t *, int, int);
-extern void atomic_set(atomic_t *, int);
+int __atomic_add_unless(atomic_t *, int, int);
+void atomic_set(atomic_t *, int);
=20
 #define atomic_read(v)          (*(volatile int *)&(v)->counter)
=20
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/at=
omic_64.h
index be56a24..0582c02 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -19,15 +19,15 @@
 #define atomic_set(v, i)	(((v)->counter) =3D i)
 #define atomic64_set(v, i)	(((v)->counter) =3D i)
=20
-extern void atomic_add(int, atomic_t *);
-extern void atomic64_add(long, atomic64_t *);
-extern void atomic_sub(int, atomic_t *);
-extern void atomic64_sub(long, atomic64_t *);
+void atomic_add(int, atomic_t *);
+void atomic64_add(long, atomic64_t *);
+void atomic_sub(int, atomic_t *);
+void atomic64_sub(long, atomic64_t *);
=20
-extern int atomic_add_ret(int, atomic_t *);
-extern long atomic64_add_ret(long, atomic64_t *);
-extern int atomic_sub_ret(int, atomic_t *);
-extern long atomic64_sub_ret(long, atomic64_t *);
+int atomic_add_ret(int, atomic_t *);
+long atomic64_add_ret(long, atomic64_t *);
+int atomic_sub_ret(int, atomic_t *);
+long atomic64_sub_ret(long, atomic64_t *);
=20
 #define atomic_dec_return(v) atomic_sub_ret(1, v)
 #define atomic64_dec_return(v) atomic64_sub_ret(1, v)
@@ -106,7 +106,7 @@ static inline long atomic64_add_unless(atomic64_t *v, l=
ong a, long u)
=20
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
=20
-extern long atomic64_dec_if_positive(atomic64_t *v);
+long atomic64_dec_if_positive(atomic64_t *v);
=20
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
diff --git a/arch/sparc/include/asm/auxio_32.h b/arch/sparc/include/asm/aux=
io_32.h
index b816660..5d685df 100644
--- a/arch/sparc/include/asm/auxio_32.h
+++ b/arch/sparc/include/asm/auxio_32.h
@@ -34,8 +34,8 @@
  * NOTE: these routines are implementation dependent--
  * understand the hardware you are querying!
  */
-extern void set_auxio(unsigned char bits_on, unsigned char bits_off);
-extern unsigned char get_auxio(void); /* .../asm/floppy.h */
+void set_auxio(unsigned char bits_on, unsigned char bits_off);
+unsigned char get_auxio(void); /* .../asm/floppy.h */
=20
 /*
  * The following routines are provided for driver-compatibility
diff --git a/arch/sparc/include/asm/auxio_64.h b/arch/sparc/include/asm/aux=
io_64.h
index 7af9766..6079e59 100644
--- a/arch/sparc/include/asm/auxio_64.h
+++ b/arch/sparc/include/asm/auxio_64.h
@@ -82,7 +82,7 @@
  *
  * on - AUXIO_LTE_ON or AUXIO_LTE_OFF
  */
-extern void auxio_set_lte(int on);
+void auxio_set_lte(int on);
=20
 #define AUXIO_LED_ON	1
 #define AUXIO_LED_OFF	0
@@ -91,7 +91,7 @@ extern void auxio_set_lte(int on);
  *
  * on - AUXIO_LED_ON or AUXIO_LED_OFF
  */
-extern void auxio_set_led(int on);
+void auxio_set_led(int on);
=20
 #endif /* ifndef __ASSEMBLY__ */
=20
diff --git a/arch/sparc/include/asm/bitext.h b/arch/sparc/include/asm/bitex=
t.h
index 297b2f2..9c988bf 100644
--- a/arch/sparc/include/asm/bitext.h
+++ b/arch/sparc/include/asm/bitext.h
@@ -20,8 +20,8 @@ struct bit_map {
 	int num_colors;
 };
=20
-extern int bit_map_string_get(struct bit_map *t, int len, int align);
-extern void bit_map_clear(struct bit_map *t, int offset, int len);
-extern void bit_map_init(struct bit_map *t, unsigned long *map, int size);
+int bit_map_string_get(struct bit_map *t, int len, int align);
+void bit_map_clear(struct bit_map *t, int offset, int len);
+void bit_map_init(struct bit_map *t, unsigned long *map, int size);
=20
 #endif /* defined(_SPARC_BITEXT_H) */
diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bi=
tops_32.h
index 25a6766..4e94825 100644
--- a/arch/sparc/include/asm/bitops_32.h
+++ b/arch/sparc/include/asm/bitops_32.h
@@ -18,9 +18,9 @@
 #error only <linux/bitops.h> can be included directly
 #endif
=20
-extern unsigned long ___set_bit(unsigned long *addr, unsigned long mask);
-extern unsigned long ___clear_bit(unsigned long *addr, unsigned long mask);
-extern unsigned long ___change_bit(unsigned long *addr, unsigned long mask=
);
+unsigned long ___set_bit(unsigned long *addr, unsigned long mask);
+unsigned long ___clear_bit(unsigned long *addr, unsigned long mask);
+unsigned long ___change_bit(unsigned long *addr, unsigned long mask);
=20
 /*
  * Set bit 'nr' in 32-bit quantity at address 'addr' where bit '0'
diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bi=
tops_64.h
index 29011cc..0135028 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -14,12 +14,12 @@
 #include <linux/compiler.h>
 #include <asm/byteorder.h>
=20
-extern int test_and_set_bit(unsigned long nr, volatile unsigned long *addr=
);
-extern int test_and_clear_bit(unsigned long nr, volatile unsigned long *ad=
dr);
-extern int test_and_change_bit(unsigned long nr, volatile unsigned long *a=
ddr);
-extern void set_bit(unsigned long nr, volatile unsigned long *addr);
-extern void clear_bit(unsigned long nr, volatile unsigned long *addr);
-extern void change_bit(unsigned long nr, volatile unsigned long *addr);
+int test_and_set_bit(unsigned long nr, volatile unsigned long *addr);
+int test_and_clear_bit(unsigned long nr, volatile unsigned long *addr);
+int test_and_change_bit(unsigned long nr, volatile unsigned long *addr);
+void set_bit(unsigned long nr, volatile unsigned long *addr);
+void clear_bit(unsigned long nr, volatile unsigned long *addr);
+void change_bit(unsigned long nr, volatile unsigned long *addr);
=20
 #include <asm-generic/bitops/non-atomic.h>
=20
@@ -32,8 +32,8 @@ extern void change_bit(unsigned long nr, volatile unsigne=
d long *addr);
=20
 #ifdef __KERNEL__
=20
-extern int ffs(int x);
-extern unsigned long __ffs(unsigned long);
+int ffs(int x);
+unsigned long __ffs(unsigned long);
=20
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/sched.h>
@@ -43,10 +43,10 @@ extern unsigned long __ffs(unsigned long);
  * of bits set) of a N-bit word
  */
=20
-extern unsigned long __arch_hweight64(__u64 w);
-extern unsigned int __arch_hweight32(unsigned int w);
-extern unsigned int __arch_hweight16(unsigned int w);
-extern unsigned int __arch_hweight8(unsigned int w);
+unsigned long __arch_hweight64(__u64 w);
+unsigned int __arch_hweight32(unsigned int w);
+unsigned int __arch_hweight16(unsigned int w);
+unsigned int __arch_hweight8(unsigned int w);
=20
 #include <asm-generic/bitops/const_hweight.h>
 #include <asm-generic/bitops/lock.h>
diff --git a/arch/sparc/include/asm/btext.h b/arch/sparc/include/asm/btext.h
index 9b2bc6b..75a32b1 100644
--- a/arch/sparc/include/asm/btext.h
+++ b/arch/sparc/include/asm/btext.h
@@ -1,6 +1,6 @@
 #ifndef _SPARC_BTEXT_H
 #define _SPARC_BTEXT_H
=20
-extern int btext_find_display(void);
+int btext_find_display(void);
=20
 #endif /* _SPARC_BTEXT_H */
diff --git a/arch/sparc/include/asm/bug.h b/arch/sparc/include/asm/bug.h
index a24cbb1..eaa8f8d 100644
--- a/arch/sparc/include/asm/bug.h
+++ b/arch/sparc/include/asm/bug.h
@@ -5,7 +5,7 @@
 #include <linux/compiler.h>
=20
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-extern void do_BUG(const char *file, int line);
+void do_BUG(const char *file, int line);
 #define BUG() do {					\
 	do_BUG(__FILE__, __LINE__);			\
 	__builtin_trap();				\
diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/as=
m/cacheflush_32.h
index bb014c2..1216400 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -36,7 +36,7 @@
 #define flush_page_for_dma(addr) \
 	sparc32_cachetlb_ops->page_for_dma(addr)
=20
-extern void sparc_flush_page_to_ram(struct page *page);
+void sparc_flush_page_to_ram(struct page *page);
=20
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 #define flush_dcache_page(page)			sparc_flush_page_to_ram(page)
@@ -51,8 +51,8 @@ extern void sparc_flush_page_to_ram(struct page *page);
  * way the windows are all clean for the next process and the stack
  * frames are up to date.
  */
-extern void flush_user_windows(void);
-extern void kill_user_windows(void);
-extern void flushw_all(void);
+void flush_user_windows(void);
+void kill_user_windows(void);
+void flushw_all(void);
=20
 #endif /* _SPARC_CACHEFLUSH_H */
diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/as=
m/cacheflush_64.h
index 301736d..3896537 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -10,7 +10,7 @@
 /* Cache flush operations. */
 #define flushw_all()	__asm__ __volatile__("flushw")
=20
-extern void __flushw_user(void);
+void __flushw_user(void);
 #define flushw_user() __flushw_user()
=20
 #define flush_user_windows flushw_user
@@ -30,29 +30,29 @@ extern void __flushw_user(void);
  * use block commit stores (which invalidate icache lines) during
  * module load, so we need this.
  */
-extern void flush_icache_range(unsigned long start, unsigned long end);
-extern void __flush_icache_page(unsigned long);
+void flush_icache_range(unsigned long start, unsigned long end);
+void __flush_icache_page(unsigned long);
=20
-extern void __flush_dcache_page(void *addr, int flush_icache);
-extern void flush_dcache_page_impl(struct page *page);
+void __flush_dcache_page(void *addr, int flush_icache);
+void flush_dcache_page_impl(struct page *page);
 #ifdef CONFIG_SMP
-extern void smp_flush_dcache_page_impl(struct page *page, int cpu);
-extern void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
+void smp_flush_dcache_page_impl(struct page *page, int cpu);
+void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
 #else
 #define smp_flush_dcache_page_impl(page,cpu) flush_dcache_page_impl(page)
 #define flush_dcache_page_all(mm,page) flush_dcache_page_impl(page)
 #endif
=20
-extern void __flush_dcache_range(unsigned long start, unsigned long end);
+void __flush_dcache_range(unsigned long start, unsigned long end);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
-extern void flush_dcache_page(struct page *page);
+void flush_dcache_page(struct page *page);
=20
 #define flush_icache_page(vma, pg)	do { } while(0)
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
=20
-extern void flush_ptrace_access(struct vm_area_struct *, struct page *,
-				unsigned long uaddr, void *kaddr,
-				unsigned long len, int write);
+void flush_ptrace_access(struct vm_area_struct *, struct page *,
+			 unsigned long uaddr, void *kaddr,
+			 unsigned long len, int write);
=20
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)		\
 	do {								\
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/=
checksum_32.h
index bdbda14..c80cf02 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -29,7 +29,7 @@
  *
  * it's best to have buff aligned on a 32-bit boundary
  */
-extern __wsum csum_partial(const void *buff, int len, __wsum sum);
+__wsum csum_partial(const void *buff, int len, __wsum sum);
=20
 /* the same as csum_partial, but copies from fs:src while it
  * checksums
@@ -38,7 +38,7 @@ extern __wsum csum_partial(const void *buff, int len, __w=
sum sum);
  * better 64-bit) boundary
  */
=20
-extern unsigned int __csum_partial_copy_sparc_generic (const unsigned char=
 *, unsigned char *);
+unsigned int __csum_partial_copy_sparc_generic (const unsigned char *, uns=
igned char *);
=20
 static inline __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/=
checksum_64.h
index 019b961..b3c8b9d 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -29,7 +29,7 @@
  *
  * it's best to have buff aligned on a 32-bit boundary
  */
-extern __wsum csum_partial(const void * buff, int len, __wsum sum);
+__wsum csum_partial(const void * buff, int len, __wsum sum);
=20
 /* the same as csum_partial, but copies from user space while it
  * checksums
@@ -37,12 +37,12 @@ extern __wsum csum_partial(const void * buff, int len, =
__wsum sum);
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-extern __wsum csum_partial_copy_nocheck(const void *src, void *dst,
-					      int len, __wsum sum);
+__wsum csum_partial_copy_nocheck(const void *src, void *dst,
+				 int len, __wsum sum);
=20
-extern long __csum_partial_copy_from_user(const void __user *src,
-					  void *dst, int len,
-					  __wsum sum);
+long __csum_partial_copy_from_user(const void __user *src,
+				   void *dst, int len,
+				   __wsum sum);
=20
 static inline __wsum
 csum_partial_copy_from_user(const void __user *src,
@@ -59,9 +59,9 @@ csum_partial_copy_from_user(const void __user *src,
  *	Copy and checksum to user
  */
 #define HAVE_CSUM_COPY_USER
-extern long __csum_partial_copy_to_user(const void *src,
-					void __user *dst, int len,
-					  __wsum sum);
+long __csum_partial_copy_to_user(const void *src,
+				 void __user *dst, int len,
+				 __wsum sum);
=20
 static inline __wsum
 csum_and_copy_to_user(const void *src,
@@ -77,7 +77,7 @@ csum_and_copy_to_user(const void *src,
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
  * the majority of the time.
  */
-extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
+__sum16 ip_fast_csum(const void *iph, unsigned int ihl);
=20
 /* Fold a partial checksum without adding pseudo headers. */
 static inline __sum16 csum_fold(__wsum sum)
@@ -96,9 +96,9 @@ static inline __sum16 csum_fold(__wsum sum)
 }
=20
 static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
-					       unsigned int len,
-					       unsigned short proto,
-					       __wsum sum)
+					unsigned int len,
+					unsigned short proto,
+					__wsum sum)
 {
 	__asm__ __volatile__(
 "	addcc		%1, %0, %0\n"
@@ -116,9 +116,9 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, _=
_be32 daddr,
  * returns a 16-bit checksum, already complemented
  */
 static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-						   unsigned short len,
-						   unsigned short proto,
-						   __wsum sum)
+					unsigned short len,
+					unsigned short proto,
+					__wsum sum)
 {
 	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
 }
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/c=
mpxchg_32.h
index 1fae1a0..32c29a1 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -20,7 +20,7 @@ static inline unsigned long xchg_u32(__volatile__ unsigne=
d long *m, unsigned lon
 	return val;
 }
=20
-extern void __xchg_called_with_bad_pointer(void);
+void __xchg_called_with_bad_pointer(void);
=20
 static inline unsigned long __xchg(unsigned long x, __volatile__ void * pt=
r, int size)
 {
@@ -45,9 +45,9 @@ static inline unsigned long __xchg(unsigned long x, __vol=
atile__ void * ptr, int
 #define __HAVE_ARCH_CMPXCHG	1
=20
 /* bug catcher for when unsupported size is used - won't link */
-extern void __cmpxchg_called_with_bad_pointer(void);
+void __cmpxchg_called_with_bad_pointer(void);
 /* we only need to support cmpxchg of a u32 on sparc */
-extern unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
+unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
=20
 /* don't worry...optimizer will get rid of most of this */
 static inline unsigned long
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/c=
mpxchg_64.h
index 4adefe8..0e1ed6c 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -42,7 +42,7 @@ static inline unsigned long xchg64(__volatile__ unsigned =
long *m, unsigned long
=20
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),s=
izeof(*(ptr))))
=20
-extern void __xchg_called_with_bad_pointer(void);
+void __xchg_called_with_bad_pointer(void);
=20
 static inline unsigned long __xchg(unsigned long x, __volatile__ void * pt=
r,
 				       int size)
@@ -91,7 +91,7 @@ __cmpxchg_u64(volatile long *m, unsigned long old, unsign=
ed long new)
=20
 /* This function doesn't exist, so you'll get a linker error
    if something tries to do an invalid cmpxchg().  */
-extern void __cmpxchg_called_with_bad_pointer(void);
+void __cmpxchg_called_with_bad_pointer(void);
=20
 static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int si=
ze)
diff --git a/arch/sparc/include/asm/delay_32.h b/arch/sparc/include/asm/del=
ay_32.h
index bc9aba2..3fb8ca1 100644
--- a/arch/sparc/include/asm/delay_32.h
+++ b/arch/sparc/include/asm/delay_32.h
@@ -20,8 +20,8 @@ static inline void __delay(unsigned long loops)
 }
=20
 /* This is too messy with inline asm on the Sparc. */
-extern void __udelay(unsigned long usecs, unsigned long lpj);
-extern void __ndelay(unsigned long nsecs, unsigned long lpj);
+void __udelay(unsigned long usecs, unsigned long lpj);
+void __ndelay(unsigned long nsecs, unsigned long lpj);
=20
 #ifdef CONFIG_SMP
 #define __udelay_val	cpu_data(smp_processor_id()).udelay_val
diff --git a/arch/sparc/include/asm/delay_64.h b/arch/sparc/include/asm/del=
ay_64.h
index a77aa62..0ba5424 100644
--- a/arch/sparc/include/asm/delay_64.h
+++ b/arch/sparc/include/asm/delay_64.h
@@ -8,8 +8,8 @@
=20
 #ifndef __ASSEMBLY__
=20
-extern void __delay(unsigned long loops);
-extern void udelay(unsigned long usecs);
+void __delay(unsigned long loops);
+void udelay(unsigned long usecs);
 #define mdelay(n)	udelay((n) * 1000)
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/sparc/include/asm/device.h b/arch/sparc/include/asm/devic=
e.h
index daa6a8a..bb3f0b0 100644
--- a/arch/sparc/include/asm/device.h
+++ b/arch/sparc/include/asm/device.h
@@ -19,7 +19,7 @@ struct dev_archdata {
 	int			numa_node;
 };
=20
-extern void of_propagate_archdata(struct platform_device *bus);
+void of_propagate_archdata(struct platform_device *bus);
=20
 struct pdev_archdata {
 	struct resource		resource[PROMREG_MAX];
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/=
dma-mapping.h
index 05fe53f..1ee0271 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -7,7 +7,7 @@
=20
 #define DMA_ERROR_CODE	(~(dma_addr_t)0x0)
=20
-extern int dma_supported(struct device *dev, u64 mask);
+int dma_supported(struct device *dev, u64 mask);
=20
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
diff --git a/arch/sparc/include/asm/ebus_dma.h b/arch/sparc/include/asm/ebu=
s_dma.h
index f07a5b5..fcfb494 100644
--- a/arch/sparc/include/asm/ebus_dma.h
+++ b/arch/sparc/include/asm/ebus_dma.h
@@ -22,14 +22,14 @@ struct ebus_dma_info {
 	unsigned char	name[64];
 };
=20
-extern int ebus_dma_register(struct ebus_dma_info *p);
-extern int ebus_dma_irq_enable(struct ebus_dma_info *p, int on);
-extern void ebus_dma_unregister(struct ebus_dma_info *p);
-extern int ebus_dma_request(struct ebus_dma_info *p, dma_addr_t bus_addr,
+int ebus_dma_register(struct ebus_dma_info *p);
+int ebus_dma_irq_enable(struct ebus_dma_info *p, int on);
+void ebus_dma_unregister(struct ebus_dma_info *p);
+int ebus_dma_request(struct ebus_dma_info *p, dma_addr_t bus_addr,
 			    size_t len);
-extern void ebus_dma_prepare(struct ebus_dma_info *p, int write);
-extern unsigned int ebus_dma_residue(struct ebus_dma_info *p);
-extern unsigned int ebus_dma_addr(struct ebus_dma_info *p);
-extern void ebus_dma_enable(struct ebus_dma_info *p, int on);
+void ebus_dma_prepare(struct ebus_dma_info *p, int write);
+unsigned int ebus_dma_residue(struct ebus_dma_info *p);
+unsigned int ebus_dma_addr(struct ebus_dma_info *p);
+void ebus_dma_enable(struct ebus_dma_info *p, int on);
=20
 #endif /* __ASM_SPARC_EBUS_DMA_H */
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/fl=
oppy_32.h
index a8af6f0..071b83e 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -256,8 +256,7 @@ static inline void sun_fd_enable_dma(void)
 	pdma_areasize =3D pdma_size;
 }
=20
-extern int sparc_floppy_request_irq(unsigned int irq,
-                                    irq_handler_t irq_handler);
+int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler);
=20
 static int sun_fd_request_irq(void)
 {
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/fl=
oppy_64.h
index 7c90c50..6257564 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -296,7 +296,7 @@ struct sun_pci_dma_op {
 static struct sun_pci_dma_op sun_pci_dma_current =3D { -1U, 0, 0, NULL};
 static struct sun_pci_dma_op sun_pci_dma_pending =3D { -1U, 0, 0, NULL};
=20
-extern irqreturn_t floppy_interrupt(int irq, void *dev_id);
+irqreturn_t floppy_interrupt(int irq, void *dev_id);
=20
 static unsigned char sun_pci_fd_inb(unsigned long port)
 {
diff --git a/arch/sparc/include/asm/ftrace.h b/arch/sparc/include/asm/ftrac=
e.h
index b0f18e9..a1f1650 100644
--- a/arch/sparc/include/asm/ftrace.h
+++ b/arch/sparc/include/asm/ftrace.h
@@ -6,7 +6,7 @@
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
=20
 #ifndef __ASSEMBLY__
-extern void _mcount(void);
+void _mcount(void);
 #endif
=20
 #endif
diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/high=
mem.h
index 4f9e15c..92ded29 100644
--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -31,7 +31,7 @@ extern unsigned long highstart_pfn, highend_pfn;
 extern pgprot_t kmap_prot;
 extern pte_t *pkmap_page_table;
=20
-extern void kmap_init(void) __init;
+void kmap_init(void) __init;
=20
 /*
  * Right now we initialize only a single pte table. It can be extended
@@ -49,8 +49,8 @@ extern void kmap_init(void) __init;
=20
 #define PKMAP_END (PKMAP_ADDR(LAST_PKMAP))
=20
-extern void *kmap_high(struct page *page);
-extern void kunmap_high(struct page *page);
+void *kmap_high(struct page *page);
+void kunmap_high(struct page *page);
=20
 static inline void *kmap(struct page *page)
 {
@@ -68,8 +68,8 @@ static inline void kunmap(struct page *page)
 	kunmap_high(page);
 }
=20
-extern void *kmap_atomic(struct page *page);
-extern void __kunmap_atomic(void *kvaddr);
+void *kmap_atomic(struct page *page);
+void __kunmap_atomic(void *kvaddr);
=20
 #define flush_cache_kmaps()	flush_cache_all()
=20
diff --git a/arch/sparc/include/asm/hvtramp.h b/arch/sparc/include/asm/hvtr=
amp.h
index b2b9b94..04b56f8 100644
--- a/arch/sparc/include/asm/hvtramp.h
+++ b/arch/sparc/include/asm/hvtramp.h
@@ -19,7 +19,7 @@ struct hvtramp_descr {
 	struct hvtramp_mapping	maps[1];
 };
=20
-extern void hv_cpu_startup(unsigned long hvdescr_pa);
+void hv_cpu_startup(unsigned long hvdescr_pa);
=20
 #endif
=20
diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/h=
ypervisor.h
index ca121f0..94b39ca 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -98,7 +98,7 @@
 #define HV_FAST_MACH_EXIT		0x00
=20
 #ifndef __ASSEMBLY__
-extern void sun4v_mach_exit(unsigned long exit_code);
+void sun4v_mach_exit(unsigned long exit_code);
 #endif
=20
 /* Domain services.  */
@@ -127,9 +127,9 @@ extern void sun4v_mach_exit(unsigned long exit_code);
 #define HV_FAST_MACH_DESC		0x01
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_mach_desc(unsigned long buffer_pa,
-				     unsigned long buf_len,
-				     unsigned long *real_buf_len);
+unsigned long sun4v_mach_desc(unsigned long buffer_pa,
+			      unsigned long buf_len,
+			      unsigned long *real_buf_len);
 #endif
=20
 /* mach_sir()
@@ -148,7 +148,7 @@ extern unsigned long sun4v_mach_desc(unsigned long buff=
er_pa,
 #define HV_FAST_MACH_SIR		0x02
=20
 #ifndef __ASSEMBLY__
-extern void sun4v_mach_sir(void);
+void sun4v_mach_sir(void);
 #endif
=20
 /* mach_set_watchdog()
@@ -204,8 +204,8 @@ extern void sun4v_mach_sir(void);
 #define HV_FAST_MACH_SET_WATCHDOG	0x05
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_mach_set_watchdog(unsigned long timeout,
-					     unsigned long *orig_timeout);
+unsigned long sun4v_mach_set_watchdog(unsigned long timeout,
+				      unsigned long *orig_timeout);
 #endif
=20
 /* CPU services.
@@ -250,10 +250,10 @@ extern unsigned long sun4v_mach_set_watchdog(unsigned=
 long timeout,
 #define HV_FAST_CPU_START		0x10
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_cpu_start(unsigned long cpuid,
-				     unsigned long pc,
-				     unsigned long rtba,
-				     unsigned long arg0);
+unsigned long sun4v_cpu_start(unsigned long cpuid,
+			      unsigned long pc,
+			      unsigned long rtba,
+			      unsigned long arg0);
 #endif
=20
 /* cpu_stop()
@@ -278,7 +278,7 @@ extern unsigned long sun4v_cpu_start(unsigned long cpui=
d,
 #define HV_FAST_CPU_STOP		0x11
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_cpu_stop(unsigned long cpuid);
+unsigned long sun4v_cpu_stop(unsigned long cpuid);
 #endif
=20
 /* cpu_yield()
@@ -295,7 +295,7 @@ extern unsigned long sun4v_cpu_stop(unsigned long cpuid=
);
 #define HV_FAST_CPU_YIELD		0x12
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_cpu_yield(void);
+unsigned long sun4v_cpu_yield(void);
 #endif
=20
 /* cpu_qconf()
@@ -341,9 +341,9 @@ extern unsigned long sun4v_cpu_yield(void);
 #define  HV_CPU_QUEUE_NONRES_ERROR	 0x3f
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_cpu_qconf(unsigned long type,
-				     unsigned long queue_paddr,
-				     unsigned long num_queue_entries);
+unsigned long sun4v_cpu_qconf(unsigned long type,
+			      unsigned long queue_paddr,
+			      unsigned long num_queue_entries);
 #endif
=20
 /* cpu_qinfo()
@@ -394,7 +394,9 @@ extern unsigned long sun4v_cpu_qconf(unsigned long type,
 #define HV_FAST_CPU_MONDO_SEND		0x42
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_cpu_mondo_send(unsigned long cpu_count, unsigne=
d long cpu_list_pa, unsigned long mondo_block_pa);
+unsigned long sun4v_cpu_mondo_send(unsigned long cpu_count,
+				   unsigned long cpu_list_pa,
+				   unsigned long mondo_block_pa);
 #endif
=20
 /* cpu_myid()
@@ -425,7 +427,7 @@ extern unsigned long sun4v_cpu_mondo_send(unsigned long=
 cpu_count, unsigned long
 #define  HV_CPU_STATE_ERROR		 0x03
=20
 #ifndef __ASSEMBLY__
-extern long sun4v_cpu_state(unsigned long cpuid);
+long sun4v_cpu_state(unsigned long cpuid);
 #endif
=20
 /* cpu_set_rtba()
@@ -625,8 +627,8 @@ struct hv_fault_status {
 #define HV_FAST_MMU_TSB_CTX0		0x20
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_mmu_tsb_ctx0(unsigned long num_descriptions,
-					unsigned long tsb_desc_ra);
+unsigned long sun4v_mmu_tsb_ctx0(unsigned long num_descriptions,
+				 unsigned long tsb_desc_ra);
 #endif
=20
 /* mmu_tsb_ctxnon0()
@@ -710,7 +712,7 @@ extern unsigned long sun4v_mmu_tsb_ctx0(unsigned long n=
um_descriptions,
 #define HV_FAST_MMU_DEMAP_ALL		0x24
=20
 #ifndef __ASSEMBLY__
-extern void sun4v_mmu_demap_all(void);
+void sun4v_mmu_demap_all(void);
 #endif
=20
 /* mmu_map_perm_addr()
@@ -740,10 +742,10 @@ extern void sun4v_mmu_demap_all(void);
 #define HV_FAST_MMU_MAP_PERM_ADDR	0x25
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_mmu_map_perm_addr(unsigned long vaddr,
-					     unsigned long set_to_zero,
-					     unsigned long tte,
-					     unsigned long flags);
+unsigned long sun4v_mmu_map_perm_addr(unsigned long vaddr,
+				      unsigned long set_to_zero,
+				      unsigned long tte,
+				      unsigned long flags);
 #endif
=20
 /* mmu_fault_area_conf()
@@ -945,7 +947,7 @@ extern unsigned long sun4v_mmu_map_perm_addr(unsigned l=
ong vaddr,
 #define HV_FAST_TOD_GET			0x50
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_tod_get(unsigned long *time);
+unsigned long sun4v_tod_get(unsigned long *time);
 #endif
=20
 /* tod_set()
@@ -962,7 +964,7 @@ extern unsigned long sun4v_tod_get(unsigned long *time);
 #define HV_FAST_TOD_SET			0x51
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_tod_set(unsigned long time);
+unsigned long sun4v_tod_set(unsigned long time);
 #endif
=20
 /* Console services */
@@ -1038,14 +1040,14 @@ extern unsigned long sun4v_tod_set(unsigned long ti=
me);
 #define HV_FAST_CONS_WRITE		0x63
=20
 #ifndef __ASSEMBLY__
-extern long sun4v_con_getchar(long *status);
-extern long sun4v_con_putchar(long c);
-extern long sun4v_con_read(unsigned long buffer,
-			   unsigned long size,
-			   unsigned long *bytes_read);
-extern unsigned long sun4v_con_write(unsigned long buffer,
-				     unsigned long size,
-				     unsigned long *bytes_written);
+long sun4v_con_getchar(long *status);
+long sun4v_con_putchar(long c);
+long sun4v_con_read(unsigned long buffer,
+		    unsigned long size,
+		    unsigned long *bytes_read);
+unsigned long sun4v_con_write(unsigned long buffer,
+			      unsigned long size,
+			      unsigned long *bytes_written);
 #endif
=20
 /* mach_set_soft_state()
@@ -1080,8 +1082,8 @@ extern unsigned long sun4v_con_write(unsigned long bu=
ffer,
 #define  HV_SOFT_STATE_TRANSITION	 0x02
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_mach_set_soft_state(unsigned long soft_state,
-					       unsigned long msg_string_ra);
+unsigned long sun4v_mach_set_soft_state(unsigned long soft_state,
+				        unsigned long msg_string_ra);
 #endif
=20
 /* mach_get_soft_state()
@@ -1159,20 +1161,20 @@ extern unsigned long sun4v_mach_set_soft_state(unsi=
gned long soft_state,
 #define HV_FAST_SVC_CLRSTATUS		0x84
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_svc_send(unsigned long svc_id,
-				    unsigned long buffer,
-				    unsigned long buffer_size,
-				    unsigned long *sent_bytes);
-extern unsigned long sun4v_svc_recv(unsigned long svc_id,
-				    unsigned long buffer,
-				    unsigned long buffer_size,
-				    unsigned long *recv_bytes);
-extern unsigned long sun4v_svc_getstatus(unsigned long svc_id,
-					 unsigned long *status_bits);
-extern unsigned long sun4v_svc_setstatus(unsigned long svc_id,
-					 unsigned long status_bits);
-extern unsigned long sun4v_svc_clrstatus(unsigned long svc_id,
-					 unsigned long status_bits);
+unsigned long sun4v_svc_send(unsigned long svc_id,
+			     unsigned long buffer,
+			     unsigned long buffer_size,
+			     unsigned long *sent_bytes);
+unsigned long sun4v_svc_recv(unsigned long svc_id,
+			     unsigned long buffer,
+			     unsigned long buffer_size,
+			     unsigned long *recv_bytes);
+unsigned long sun4v_svc_getstatus(unsigned long svc_id,
+				  unsigned long *status_bits);
+unsigned long sun4v_svc_setstatus(unsigned long svc_id,
+				  unsigned long status_bits);
+unsigned long sun4v_svc_clrstatus(unsigned long svc_id,
+				  unsigned long status_bits);
 #endif
=20
 /* Trap trace services.
@@ -1458,8 +1460,8 @@ struct hv_trap_trace_entry {
 #define HV_FAST_INTR_DEVINO2SYSINO	0xa0
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_devino_to_sysino(unsigned long devhandle,
-					    unsigned long devino);
+unsigned long sun4v_devino_to_sysino(unsigned long devhandle,
+				     unsigned long devino);
 #endif
=20
 /* intr_getenabled()
@@ -1476,7 +1478,7 @@ extern unsigned long sun4v_devino_to_sysino(unsigned =
long devhandle,
 #define HV_FAST_INTR_GETENABLED		0xa1
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_intr_getenabled(unsigned long sysino);
+unsigned long sun4v_intr_getenabled(unsigned long sysino);
 #endif
=20
 /* intr_setenabled()
@@ -1492,7 +1494,8 @@ extern unsigned long sun4v_intr_getenabled(unsigned l=
ong sysino);
 #define HV_FAST_INTR_SETENABLED		0xa2
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_intr_setenabled(unsigned long sysino, unsigned =
long intr_enabled);
+unsigned long sun4v_intr_setenabled(unsigned long sysino,
+				    unsigned long intr_enabled);
 #endif
=20
 /* intr_getstate()
@@ -1508,7 +1511,7 @@ extern unsigned long sun4v_intr_setenabled(unsigned l=
ong sysino, unsigned long i
 #define HV_FAST_INTR_GETSTATE		0xa3
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_intr_getstate(unsigned long sysino);
+unsigned long sun4v_intr_getstate(unsigned long sysino);
 #endif
=20
 /* intr_setstate()
@@ -1528,7 +1531,7 @@ extern unsigned long sun4v_intr_getstate(unsigned lon=
g sysino);
 #define HV_FAST_INTR_SETSTATE		0xa4
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_intr_setstate(unsigned long sysino, unsigned lo=
ng intr_state);
+unsigned long sun4v_intr_setstate(unsigned long sysino, unsigned long intr=
_state);
 #endif
=20
 /* intr_gettarget()
@@ -1546,7 +1549,7 @@ extern unsigned long sun4v_intr_setstate(unsigned lon=
g sysino, unsigned long int
 #define HV_FAST_INTR_GETTARGET		0xa5
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_intr_gettarget(unsigned long sysino);
+unsigned long sun4v_intr_gettarget(unsigned long sysino);
 #endif
=20
 /* intr_settarget()
@@ -1563,7 +1566,7 @@ extern unsigned long sun4v_intr_gettarget(unsigned lo=
ng sysino);
 #define HV_FAST_INTR_SETTARGET		0xa6
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_intr_settarget(unsigned long sysino, unsigned l=
ong cpuid);
+unsigned long sun4v_intr_settarget(unsigned long sysino, unsigned long cpu=
id);
 #endif
=20
 /* vintr_get_cookie()
@@ -1647,30 +1650,30 @@ extern unsigned long sun4v_intr_settarget(unsigned =
long sysino, unsigned long cp
 #define HV_FAST_VINTR_SET_TARGET	0xae
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_vintr_get_cookie(unsigned long dev_handle,
-					    unsigned long dev_ino,
-					    unsigned long *cookie);
-extern unsigned long sun4v_vintr_set_cookie(unsigned long dev_handle,
-					    unsigned long dev_ino,
-					    unsigned long cookie);
-extern unsigned long sun4v_vintr_get_valid(unsigned long dev_handle,
-					   unsigned long dev_ino,
-					   unsigned long *valid);
-extern unsigned long sun4v_vintr_set_valid(unsigned long dev_handle,
-					   unsigned long dev_ino,
-					   unsigned long valid);
-extern unsigned long sun4v_vintr_get_state(unsigned long dev_handle,
-					   unsigned long dev_ino,
-					   unsigned long *state);
-extern unsigned long sun4v_vintr_set_state(unsigned long dev_handle,
-					   unsigned long dev_ino,
-					   unsigned long state);
-extern unsigned long sun4v_vintr_get_target(unsigned long dev_handle,
-					    unsigned long dev_ino,
-					    unsigned long *cpuid);
-extern unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
-					    unsigned long dev_ino,
-					    unsigned long cpuid);
+unsigned long sun4v_vintr_get_cookie(unsigned long dev_handle,
+				     unsigned long dev_ino,
+				     unsigned long *cookie);
+unsigned long sun4v_vintr_set_cookie(unsigned long dev_handle,
+				     unsigned long dev_ino,
+				     unsigned long cookie);
+unsigned long sun4v_vintr_get_valid(unsigned long dev_handle,
+				    unsigned long dev_ino,
+				    unsigned long *valid);
+unsigned long sun4v_vintr_set_valid(unsigned long dev_handle,
+				    unsigned long dev_ino,
+				    unsigned long valid);
+unsigned long sun4v_vintr_get_state(unsigned long dev_handle,
+				    unsigned long dev_ino,
+				    unsigned long *state);
+unsigned long sun4v_vintr_set_state(unsigned long dev_handle,
+				    unsigned long dev_ino,
+				    unsigned long state);
+unsigned long sun4v_vintr_get_target(unsigned long dev_handle,
+				     unsigned long dev_ino,
+				     unsigned long *cpuid);
+unsigned long sun4v_vintr_set_target(unsigned long dev_handle,
+				     unsigned long dev_ino,
+				     unsigned long cpuid);
 #endif
=20
 /* PCI IO services.
@@ -2627,50 +2630,50 @@ struct ldc_mtable_entry {
 #define HV_FAST_LDC_REVOKE		0xef
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_ldc_tx_qconf(unsigned long channel,
-					unsigned long ra,
-					unsigned long num_entries);
-extern unsigned long sun4v_ldc_tx_qinfo(unsigned long channel,
-					unsigned long *ra,
-					unsigned long *num_entries);
-extern unsigned long sun4v_ldc_tx_get_state(unsigned long channel,
-					    unsigned long *head_off,
-					    unsigned long *tail_off,
-					    unsigned long *chan_state);
-extern unsigned long sun4v_ldc_tx_set_qtail(unsigned long channel,
-					    unsigned long tail_off);
-extern unsigned long sun4v_ldc_rx_qconf(unsigned long channel,
-					unsigned long ra,
-					unsigned long num_entries);
-extern unsigned long sun4v_ldc_rx_qinfo(unsigned long channel,
-					unsigned long *ra,
-					unsigned long *num_entries);
-extern unsigned long sun4v_ldc_rx_get_state(unsigned long channel,
-					    unsigned long *head_off,
-					    unsigned long *tail_off,
-					    unsigned long *chan_state);
-extern unsigned long sun4v_ldc_rx_set_qhead(unsigned long channel,
-					    unsigned long head_off);
-extern unsigned long sun4v_ldc_set_map_table(unsigned long channel,
-					     unsigned long ra,
-					     unsigned long num_entries);
-extern unsigned long sun4v_ldc_get_map_table(unsigned long channel,
-					     unsigned long *ra,
-					     unsigned long *num_entries);
-extern unsigned long sun4v_ldc_copy(unsigned long channel,
-				    unsigned long dir_code,
-				    unsigned long tgt_raddr,
-				    unsigned long lcl_raddr,
-				    unsigned long len,
-				    unsigned long *actual_len);
-extern unsigned long sun4v_ldc_mapin(unsigned long channel,
-				     unsigned long cookie,
-				     unsigned long *ra,
-				     unsigned long *perm);
-extern unsigned long sun4v_ldc_unmap(unsigned long ra);
-extern unsigned long sun4v_ldc_revoke(unsigned long channel,
-				      unsigned long cookie,
-				      unsigned long mte_cookie);
+unsigned long sun4v_ldc_tx_qconf(unsigned long channel,
+				 unsigned long ra,
+				 unsigned long num_entries);
+unsigned long sun4v_ldc_tx_qinfo(unsigned long channel,
+				 unsigned long *ra,
+				 unsigned long *num_entries);
+unsigned long sun4v_ldc_tx_get_state(unsigned long channel,
+				     unsigned long *head_off,
+				     unsigned long *tail_off,
+				     unsigned long *chan_state);
+unsigned long sun4v_ldc_tx_set_qtail(unsigned long channel,
+				     unsigned long tail_off);
+unsigned long sun4v_ldc_rx_qconf(unsigned long channel,
+				 unsigned long ra,
+				 unsigned long num_entries);
+unsigned long sun4v_ldc_rx_qinfo(unsigned long channel,
+				 unsigned long *ra,
+				 unsigned long *num_entries);
+unsigned long sun4v_ldc_rx_get_state(unsigned long channel,
+				     unsigned long *head_off,
+				     unsigned long *tail_off,
+				     unsigned long *chan_state);
+unsigned long sun4v_ldc_rx_set_qhead(unsigned long channel,
+				     unsigned long head_off);
+unsigned long sun4v_ldc_set_map_table(unsigned long channel,
+				      unsigned long ra,
+				      unsigned long num_entries);
+unsigned long sun4v_ldc_get_map_table(unsigned long channel,
+				      unsigned long *ra,
+				      unsigned long *num_entries);
+unsigned long sun4v_ldc_copy(unsigned long channel,
+			     unsigned long dir_code,
+			     unsigned long tgt_raddr,
+			     unsigned long lcl_raddr,
+			     unsigned long len,
+			     unsigned long *actual_len);
+unsigned long sun4v_ldc_mapin(unsigned long channel,
+			      unsigned long cookie,
+			      unsigned long *ra,
+			      unsigned long *perm);
+unsigned long sun4v_ldc_unmap(unsigned long ra);
+unsigned long sun4v_ldc_revoke(unsigned long channel,
+			       unsigned long cookie,
+			       unsigned long mte_cookie);
 #endif
=20
 /* Performance counter services.  */
@@ -2727,14 +2730,14 @@ extern unsigned long sun4v_ldc_revoke(unsigned long=
 channel,
 #define HV_FAST_N2_SET_PERFREG		0x105
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_niagara_getperf(unsigned long reg,
-					   unsigned long *val);
-extern unsigned long sun4v_niagara_setperf(unsigned long reg,
-					   unsigned long val);
-extern unsigned long sun4v_niagara2_getperf(unsigned long reg,
-					    unsigned long *val);
-extern unsigned long sun4v_niagara2_setperf(unsigned long reg,
-					    unsigned long val);
+unsigned long sun4v_niagara_getperf(unsigned long reg,
+				    unsigned long *val);
+unsigned long sun4v_niagara_setperf(unsigned long reg,
+				    unsigned long val);
+unsigned long sun4v_niagara2_getperf(unsigned long reg,
+				     unsigned long *val);
+unsigned long sun4v_niagara2_setperf(unsigned long reg,
+				     unsigned long val);
 #endif
=20
 /* MMU statistics services.
@@ -2829,8 +2832,8 @@ struct hv_mmu_statistics {
 #define HV_FAST_MMUSTAT_INFO		0x103
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_mmustat_conf(unsigned long ra, unsigned long *o=
rig_ra);
-extern unsigned long sun4v_mmustat_info(unsigned long *ra);
+unsigned long sun4v_mmustat_conf(unsigned long ra, unsigned long *orig_ra);
+unsigned long sun4v_mmustat_info(unsigned long *ra);
 #endif
=20
 /* NCS crypto services  */
@@ -2919,9 +2922,9 @@ struct hv_ncs_qtail_update_arg {
 #define HV_FAST_NCS_REQUEST		0x110
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_ncs_request(unsigned long request,
-				       unsigned long arg_ra,
-				       unsigned long arg_size);
+unsigned long sun4v_ncs_request(unsigned long request,
+			        unsigned long arg_ra,
+			        unsigned long arg_size);
 #endif
=20
 #define HV_FAST_FIRE_GET_PERFREG	0x120
@@ -2930,18 +2933,18 @@ extern unsigned long sun4v_ncs_request(unsigned lon=
g request,
 #define HV_FAST_REBOOT_DATA_SET		0x172
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_reboot_data_set(unsigned long ra,
-					   unsigned long len);
+unsigned long sun4v_reboot_data_set(unsigned long ra,
+				    unsigned long len);
 #endif
=20
 #define HV_FAST_VT_GET_PERFREG		0x184
 #define HV_FAST_VT_SET_PERFREG		0x185
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_vt_get_perfreg(unsigned long reg_num,
-					  unsigned long *reg_val);
-extern unsigned long sun4v_vt_set_perfreg(unsigned long reg_num,
-					  unsigned long reg_val);
+unsigned long sun4v_vt_get_perfreg(unsigned long reg_num,
+				   unsigned long *reg_val);
+unsigned long sun4v_vt_set_perfreg(unsigned long reg_num,
+				   unsigned long reg_val);
 #endif
=20
 /* Function numbers for HV_CORE_TRAP.  */
@@ -2978,21 +2981,21 @@ extern unsigned long sun4v_vt_set_perfreg(unsigned =
long reg_num,
 #define HV_GRP_DIAG			0x0300
=20
 #ifndef __ASSEMBLY__
-extern unsigned long sun4v_get_version(unsigned long group,
-				       unsigned long *major,
-				       unsigned long *minor);
-extern unsigned long sun4v_set_version(unsigned long group,
-				       unsigned long major,
-				       unsigned long minor,
-				       unsigned long *actual_minor);
-
-extern int sun4v_hvapi_register(unsigned long group, unsigned long major,
-				unsigned long *minor);
-extern void sun4v_hvapi_unregister(unsigned long group);
-extern int sun4v_hvapi_get(unsigned long group,
-			   unsigned long *major,
-			   unsigned long *minor);
-extern void sun4v_hvapi_init(void);
+unsigned long sun4v_get_version(unsigned long group,
+			        unsigned long *major,
+			        unsigned long *minor);
+unsigned long sun4v_set_version(unsigned long group,
+			        unsigned long major,
+			        unsigned long minor,
+			        unsigned long *actual_minor);
+
+int sun4v_hvapi_register(unsigned long group, unsigned long major,
+			 unsigned long *minor);
+void sun4v_hvapi_unregister(unsigned long group);
+int sun4v_hvapi_get(unsigned long group,
+		    unsigned long *major,
+		    unsigned long *minor);
+void sun4v_hvapi_init(void);
 #endif
=20
 #endif /* !(_SPARC64_HYPERVISOR_H) */
diff --git a/arch/sparc/include/asm/idprom.h b/arch/sparc/include/asm/idpro=
m.h
index 6976aa2..3793f7f 100644
--- a/arch/sparc/include/asm/idprom.h
+++ b/arch/sparc/include/asm/idprom.h
@@ -20,6 +20,6 @@ struct idprom {
 };
=20
 extern struct idprom *idprom;
-extern void idprom_init(void);
+void idprom_init(void);
=20
 #endif /* !(_SPARC_IDPROM_H) */
diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 383f513..9f53290 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -130,18 +130,18 @@ static inline void sbus_memcpy_toio(volatile void __i=
omem *dst,
  * Bus number may be embedded in the higher bits of the physical address.
  * This is why we have no bus number argument to ioremap().
  */
-extern void __iomem *ioremap(unsigned long offset, unsigned long size);
+void __iomem *ioremap(unsigned long offset, unsigned long size);
 #define ioremap_nocache(X,Y)	ioremap((X),(Y))
 #define ioremap_wc(X,Y)		ioremap((X),(Y))
-extern void iounmap(volatile void __iomem *addr);
+void iounmap(volatile void __iomem *addr);
=20
 /* Create a virtual mapping cookie for an IO port range */
-extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
-extern void ioport_unmap(void __iomem *);
+void __iomem *ioport_map(unsigned long port, unsigned int nr);
+void ioport_unmap(void __iomem *);
=20
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+void pci_iounmap(struct pci_dev *dev, void __iomem *);
=20
=20
=20
@@ -162,7 +162,7 @@ static inline int sbus_can_burst64(void)
 	return 0; /* actually, sparc_cpu_model=3Dsun4d */
 }
 struct device;
-extern void sbus_set_sbus64(struct device *, int);
+void sbus_set_sbus64(struct device *, int);
=20
 #endif
=20
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 4484563..05381c3 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -90,12 +90,12 @@ static inline void _outl(u32 l, unsigned long addr)
 #define inl_p(__addr)		inl(__addr)
 #define outl_p(__l, __addr)	outl(__l, __addr)
=20
-extern void outsb(unsigned long, const void *, unsigned long);
-extern void outsw(unsigned long, const void *, unsigned long);
-extern void outsl(unsigned long, const void *, unsigned long);
-extern void insb(unsigned long, void *, unsigned long);
-extern void insw(unsigned long, void *, unsigned long);
-extern void insl(unsigned long, void *, unsigned long);
+void outsb(unsigned long, const void *, unsigned long);
+void outsw(unsigned long, const void *, unsigned long);
+void outsl(unsigned long, const void *, unsigned long);
+void insb(unsigned long, void *, unsigned long);
+void insw(unsigned long, void *, unsigned long);
+void insl(unsigned long, void *, unsigned long);
=20
 static inline void ioread8_rep(void __iomem *port, void *buf, unsigned lon=
g count)
 {
@@ -508,12 +508,12 @@ static inline void iounmap(volatile void __iomem *add=
r)
 #define iowrite32be(val,X)		__raw_writel(val,X)
=20
 /* Create a virtual mapping cookie for an IO port range */
-extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
-extern void ioport_unmap(void __iomem *);
+void __iomem *ioport_map(unsigned long port, unsigned int nr);
+void ioport_unmap(void __iomem *);
=20
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+void pci_iounmap(struct pci_dev *dev, void __iomem *);
=20
 static inline int sbus_can_dma_64bit(void)
 {
@@ -524,7 +524,7 @@ static inline int sbus_can_burst64(void)
 	return 1;
 }
 struct device;
-extern void sbus_set_sbus64(struct device *, int);
+void sbus_set_sbus64(struct device *, int);
=20
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
diff --git a/arch/sparc/include/asm/iommu_64.h b/arch/sparc/include/asm/iom=
mu_64.h
index caf798b..2b9321a 100644
--- a/arch/sparc/include/asm/iommu_64.h
+++ b/arch/sparc/include/asm/iommu_64.h
@@ -58,8 +58,8 @@ struct strbuf {
 	volatile unsigned long	__flushflag_buf[(64+(64-1)) / sizeof(long)];
 };
=20
-extern int iommu_table_init(struct iommu *iommu, int tsbsize,
-			    u32 dma_offset, u32 dma_addr_mask,
-			    int numa_node);
+int iommu_table_init(struct iommu *iommu, int tsbsize,
+		     u32 dma_offset, u32 dma_addr_mask,
+		     int numa_node);
=20
 #endif /* !(_SPARC64_IOMMU_H) */
diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_3=
2.h
index 9277e51..eecd3d8 100644
--- a/arch/sparc/include/asm/irq_32.h
+++ b/arch/sparc/include/asm/irq_32.h
@@ -16,7 +16,7 @@
=20
 #define irq_canonicalize(irq)	(irq)
=20
-extern void __init init_IRQ(void);
+void __init init_IRQ(void);
 void __init sun4d_init_sbi_irq(void);
=20
 #define NO_IRQ		0xffffffff
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_6=
4.h
index abf6afe..375cffc 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -39,32 +39,32 @@
  */
 #define NR_IRQS    255
=20
-extern void irq_install_pre_handler(int irq,
-				    void (*func)(unsigned int, void *, void *),
-				    void *arg1, void *arg2);
+void irq_install_pre_handler(int irq,
+			     void (*func)(unsigned int, void *, void *),
+			     void *arg1, void *arg2);
 #define irq_canonicalize(irq)	(irq)
-extern unsigned int build_irq(int inofixup, unsigned long iclr, unsigned l=
ong imap);
-extern unsigned int sun4v_build_irq(u32 devhandle, unsigned int devino);
-extern unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino);
-extern unsigned int sun4v_build_msi(u32 devhandle, unsigned int *irq_p,
-				    unsigned int msi_devino_start,
-				    unsigned int msi_devino_end);
-extern void sun4v_destroy_msi(unsigned int irq);
-extern unsigned int sun4u_build_msi(u32 portid, unsigned int *irq_p,
-				    unsigned int msi_devino_start,
-				    unsigned int msi_devino_end,
-				    unsigned long imap_base,
-				    unsigned long iclr_base);
-extern void sun4u_destroy_msi(unsigned int irq);
-
-extern unsigned char irq_alloc(unsigned int dev_handle,
-				    unsigned int dev_ino);
+unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long ima=
p);
+unsigned int sun4v_build_irq(u32 devhandle, unsigned int devino);
+unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino);
+unsigned int sun4v_build_msi(u32 devhandle, unsigned int *irq_p,
+			     unsigned int msi_devino_start,
+			     unsigned int msi_devino_end);
+void sun4v_destroy_msi(unsigned int irq);
+unsigned int sun4u_build_msi(u32 portid, unsigned int *irq_p,
+			     unsigned int msi_devino_start,
+			     unsigned int msi_devino_end,
+			     unsigned long imap_base,
+			     unsigned long iclr_base);
+void sun4u_destroy_msi(unsigned int irq);
+
+unsigned char irq_alloc(unsigned int dev_handle,
+			unsigned int dev_ino);
 #ifdef CONFIG_PCI_MSI
-extern void irq_free(unsigned int irq);
+void irq_free(unsigned int irq);
 #endif
=20
-extern void __init init_IRQ(void);
-extern void fixup_irqs(void);
+void __init init_IRQ(void);
+void fixup_irqs(void);
=20
 static inline void set_softint(unsigned long bits)
 {
diff --git a/arch/sparc/include/asm/irqflags_32.h b/arch/sparc/include/asm/=
irqflags_32.h
index e414c06..71cc284 100644
--- a/arch/sparc/include/asm/irqflags_32.h
+++ b/arch/sparc/include/asm/irqflags_32.h
@@ -15,9 +15,9 @@
 #include <linux/types.h>
 #include <asm/psr.h>
=20
-extern void arch_local_irq_restore(unsigned long);
-extern unsigned long arch_local_irq_save(void);
-extern void arch_local_irq_enable(void);
+void arch_local_irq_restore(unsigned long);
+unsigned long arch_local_irq_save(void);
+void arch_local_irq_enable(void);
=20
 static inline notrace unsigned long arch_local_save_flags(void)
 {
diff --git a/arch/sparc/include/asm/kdebug_64.h b/arch/sparc/include/asm/kd=
ebug_64.h
index feb3578..04465de 100644
--- a/arch/sparc/include/asm/kdebug_64.h
+++ b/arch/sparc/include/asm/kdebug_64.h
@@ -3,7 +3,7 @@
=20
 struct pt_regs;
=20
-extern void bad_trap(struct pt_regs *, long);
+void bad_trap(struct pt_regs *, long);
=20
 /* Grossly misnamed. */
 enum die_val {
diff --git a/arch/sparc/include/asm/kgdb.h b/arch/sparc/include/asm/kgdb.h
index b6ef301..5a8ee15 100644
--- a/arch/sparc/include/asm/kgdb.h
+++ b/arch/sparc/include/asm/kgdb.h
@@ -30,7 +30,7 @@ enum regnames {
 #define NUMREGBYTES		((GDB_Y + 1) * 8)
 #endif
=20
-extern void arch_kgdb_breakpoint(void);
+void arch_kgdb_breakpoint(void);
=20
 #define BREAK_INSTR_SIZE	4
 #define CACHE_FLUSH_IS_SAFE	1
diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kpro=
bes.h
index 5879d71..b2613c28 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -43,7 +43,7 @@ struct kprobe_ctlblk {
 	struct prev_kprobe prev_kprobe;
 };
=20
-extern int kprobe_exceptions_notify(struct notifier_block *self,
-				    unsigned long val, void *data);
-extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+int kprobe_exceptions_notify(struct notifier_block *self,
+			     unsigned long val, void *data);
+int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 #endif /* _SPARC64_KPROBES_H */
diff --git a/arch/sparc/include/asm/ldc.h b/arch/sparc/include/asm/ldc.h
index bdb524a..c8c67f6 100644
--- a/arch/sparc/include/asm/ldc.h
+++ b/arch/sparc/include/asm/ldc.h
@@ -4,9 +4,9 @@
 #include <asm/hypervisor.h>
=20
 extern int ldom_domaining_enabled;
-extern void ldom_set_var(const char *var, const char *value);
-extern void ldom_reboot(const char *boot_command);
-extern void ldom_power_off(void);
+void ldom_set_var(const char *var, const char *value);
+void ldom_reboot(const char *boot_command);
+void ldom_power_off(void);
=20
 /* The event handler will be evoked when link state changes
  * or data becomes available on the receive side.
@@ -51,30 +51,30 @@ struct ldc_channel_config {
 struct ldc_channel;
=20
 /* Allocate state for a channel.  */
-extern struct ldc_channel *ldc_alloc(unsigned long id,
-				     const struct ldc_channel_config *cfgp,
-				     void *event_arg);
+struct ldc_channel *ldc_alloc(unsigned long id,
+			      const struct ldc_channel_config *cfgp,
+			      void *event_arg);
=20
 /* Shut down and free state for a channel.  */
-extern void ldc_free(struct ldc_channel *lp);
+void ldc_free(struct ldc_channel *lp);
=20
 /* Register TX and RX queues of the link with the hypervisor.  */
-extern int ldc_bind(struct ldc_channel *lp, const char *name);
+int ldc_bind(struct ldc_channel *lp, const char *name);
=20
 /* For non-RAW protocols we need to complete a handshake before
  * communication can proceed.  ldc_connect() does that, if the
  * handshake completes successfully, an LDC_EVENT_UP event will
  * be sent up to the driver.
  */
-extern int ldc_connect(struct ldc_channel *lp);
-extern int ldc_disconnect(struct ldc_channel *lp);
+int ldc_connect(struct ldc_channel *lp);
+int ldc_disconnect(struct ldc_channel *lp);
=20
-extern int ldc_state(struct ldc_channel *lp);
+int ldc_state(struct ldc_channel *lp);
=20
 /* Read and write operations.  Only valid when the link is up.  */
-extern int ldc_write(struct ldc_channel *lp, const void *buf,
-		     unsigned int size);
-extern int ldc_read(struct ldc_channel *lp, void *buf, unsigned int size);
+int ldc_write(struct ldc_channel *lp, const void *buf,
+	      unsigned int size);
+int ldc_read(struct ldc_channel *lp, void *buf, unsigned int size);
=20
 #define LDC_MAP_SHADOW	0x01
 #define LDC_MAP_DIRECT	0x02
@@ -92,22 +92,22 @@ struct ldc_trans_cookie {
 };
=20
 struct scatterlist;
-extern int ldc_map_sg(struct ldc_channel *lp,
-		      struct scatterlist *sg, int num_sg,
-		      struct ldc_trans_cookie *cookies, int ncookies,
-		      unsigned int map_perm);
+int ldc_map_sg(struct ldc_channel *lp,
+	       struct scatterlist *sg, int num_sg,
+	       struct ldc_trans_cookie *cookies, int ncookies,
+	       unsigned int map_perm);
=20
-extern int ldc_map_single(struct ldc_channel *lp,
-			  void *buf, unsigned int len,
-			  struct ldc_trans_cookie *cookies, int ncookies,
-			  unsigned int map_perm);
+int ldc_map_single(struct ldc_channel *lp,
+		   void *buf, unsigned int len,
+		   struct ldc_trans_cookie *cookies, int ncookies,
+		   unsigned int map_perm);
=20
-extern void ldc_unmap(struct ldc_channel *lp, struct ldc_trans_cookie *coo=
kies,
-		      int ncookies);
+void ldc_unmap(struct ldc_channel *lp, struct ldc_trans_cookie *cookies,
+	       int ncookies);
=20
-extern int ldc_copy(struct ldc_channel *lp, int copy_dir,
-		    void *buf, unsigned int len, unsigned long offset,
-		    struct ldc_trans_cookie *cookies, int ncookies);
+int ldc_copy(struct ldc_channel *lp, int copy_dir,
+	     void *buf, unsigned int len, unsigned long offset,
+	     struct ldc_trans_cookie *cookies, int ncookies);
=20
 static inline int ldc_get_dring_entry(struct ldc_channel *lp,
 				      void *buf, unsigned int len,
@@ -127,12 +127,12 @@ static inline int ldc_put_dring_entry(struct ldc_chan=
nel *lp,
 	return ldc_copy(lp, LDC_COPY_OUT, buf, len, offset, cookies, ncookies);
 }
=20
-extern void *ldc_alloc_exp_dring(struct ldc_channel *lp, unsigned int len,
-				 struct ldc_trans_cookie *cookies,
-				 int *ncookies, unsigned int map_perm);
+void *ldc_alloc_exp_dring(struct ldc_channel *lp, unsigned int len,
+			  struct ldc_trans_cookie *cookies,
+			  int *ncookies, unsigned int map_perm);
=20
-extern void ldc_free_exp_dring(struct ldc_channel *lp, void *buf,
-			       unsigned int len,
-			       struct ldc_trans_cookie *cookies, int ncookies);
+void ldc_free_exp_dring(struct ldc_channel *lp, void *buf,
+		        unsigned int len,
+		        struct ldc_trans_cookie *cookies, int ncookies);
=20
 #endif /* _SPARC64_LDC_H */
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index c2f6ff6..204771c 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -82,8 +82,8 @@ static inline unsigned long leon_load_reg(unsigned long p=
addr)
 #define LEON_BYPASS_LOAD_PA(x)      leon_load_reg((unsigned long)(x))
 #define LEON_BYPASS_STORE_PA(x, v)  leon_store_reg((unsigned long)(x), (un=
signed long)(v))
=20
-extern void leon_switch_mm(void);
-extern void leon_init_IRQ(void);
+void leon_switch_mm(void);
+void leon_init_IRQ(void);
=20
 static inline unsigned long sparc_leon3_get_dcachecfg(void)
 {
@@ -196,14 +196,14 @@ static inline int sparc_leon3_cpuid(void)
 #ifndef __ASSEMBLY__
 struct vm_area_struct;
=20
-extern unsigned long leon_swprobe(unsigned long vaddr, unsigned long *padd=
r);
-extern void leon_flush_icache_all(void);
-extern void leon_flush_dcache_all(void);
-extern void leon_flush_cache_all(void);
-extern void leon_flush_tlb_all(void);
+unsigned long leon_swprobe(unsigned long vaddr, unsigned long *paddr);
+void leon_flush_icache_all(void);
+void leon_flush_dcache_all(void);
+void leon_flush_cache_all(void);
+void leon_flush_tlb_all(void);
 extern int leon_flush_during_switch;
-extern int leon_flush_needed(void);
-extern void leon_flush_pcache_all(struct vm_area_struct *vma, unsigned lon=
g page);
+int leon_flush_needed(void);
+void leon_flush_pcache_all(struct vm_area_struct *vma, unsigned long page);
=20
 /* struct that hold LEON3 cache configuration registers */
 struct leon3_cacheregs {
@@ -217,29 +217,29 @@ struct leon3_cacheregs {
=20
 struct device_node;
 struct task_struct;
-extern unsigned int leon_build_device_irq(unsigned int real_irq,
-					   irq_flow_handler_t flow_handler,
-					   const char *name, int do_ack);
-extern void leon_update_virq_handling(unsigned int virq,
-			      irq_flow_handler_t flow_handler,
-			      const char *name, int do_ack);
-extern void leon_init_timers(void);
-extern void leon_trans_init(struct device_node *dp);
-extern void leon_node_init(struct device_node *dp, struct device_node ***n=
extp);
-extern void init_leon(void);
-extern void poke_leonsparc(void);
-extern void leon3_getCacheRegs(struct leon3_cacheregs *regs);
+unsigned int leon_build_device_irq(unsigned int real_irq,
+				   irq_flow_handler_t flow_handler,
+				   const char *name, int do_ack);
+void leon_update_virq_handling(unsigned int virq,
+			       irq_flow_handler_t flow_handler,
+			       const char *name, int do_ack);
+void leon_init_timers(void);
+void leon_trans_init(struct device_node *dp);
+void leon_node_init(struct device_node *dp, struct device_node ***nextp);
+void init_leon(void);
+void poke_leonsparc(void);
+void leon3_getCacheRegs(struct leon3_cacheregs *regs);
 extern int leon3_ticker_irq;
=20
 #ifdef CONFIG_SMP
-extern int leon_smp_nrcpus(void);
-extern void leon_clear_profile_irq(int cpu);
-extern void leon_smp_done(void);
-extern void leon_boot_cpus(void);
-extern int leon_boot_one_cpu(int i, struct task_struct *);
+int leon_smp_nrcpus(void);
+void leon_clear_profile_irq(int cpu);
+void leon_smp_done(void);
+void leon_boot_cpus(void);
+int leon_boot_one_cpu(int i, struct task_struct *);
 void leon_init_smp(void);
 void leon_enable_irq_cpu(unsigned int irq_nr, unsigned int cpu);
-extern irqreturn_t leon_percpu_timer_interrupt(int irq, void *unused);
+irqreturn_t leon_percpu_timer_interrupt(int irq, void *unused);
=20
 extern unsigned int smpleon_ipi[];
 extern unsigned int linux_trap_ipi15_leon[];
diff --git a/arch/sparc/include/asm/leon_pci.h b/arch/sparc/include/asm/leo=
n_pci.h
index bfd3ab3..049d067 100644
--- a/arch/sparc/include/asm/leon_pci.h
+++ b/arch/sparc/include/asm/leon_pci.h
@@ -16,7 +16,7 @@ struct leon_pci_info {
 	int (*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
 };
=20
-extern void leon_pci_init(struct platform_device *ofdev,
-				struct leon_pci_info *info);
+void leon_pci_init(struct platform_device *ofdev,
+		   struct leon_pci_info *info);
=20
 #endif /* _ASM_LEON_PCI_H_ */
diff --git a/arch/sparc/include/asm/mdesc.h b/arch/sparc/include/asm/mdesc.h
index 139097f..aebeb88 100644
--- a/arch/sparc/include/asm/mdesc.h
+++ b/arch/sparc/include/asm/mdesc.h
@@ -12,13 +12,13 @@ struct mdesc_handle;
  * the first argument to all of the operational calls that work
  * on mdescs.
  */
-extern struct mdesc_handle *mdesc_grab(void);
-extern void mdesc_release(struct mdesc_handle *);
+struct mdesc_handle *mdesc_grab(void);
+void mdesc_release(struct mdesc_handle *);
=20
 #define MDESC_NODE_NULL		(~(u64)0)
=20
-extern u64 mdesc_node_by_name(struct mdesc_handle *handle,
-			      u64 from_node, const char *name);
+u64 mdesc_node_by_name(struct mdesc_handle *handle,
+		       u64 from_node, const char *name);
 #define mdesc_for_each_node_by_name(__hdl, __node, __name) \
 	for (__node =3D mdesc_node_by_name(__hdl, MDESC_NODE_NULL, __name); \
 	     (__node) !=3D MDESC_NODE_NULL; \
@@ -34,9 +34,9 @@ extern u64 mdesc_node_by_name(struct mdesc_handle *handle,
  *
  * These same rules apply to mdesc_node_name().
  */
-extern const void *mdesc_get_property(struct mdesc_handle *handle,
-				      u64 node, const char *name, int *lenp);
-extern const char *mdesc_node_name(struct mdesc_handle *hp, u64 node);
+const void *mdesc_get_property(struct mdesc_handle *handle,
+			       u64 node, const char *name, int *lenp);
+const char *mdesc_node_name(struct mdesc_handle *hp, u64 node);
=20
 /* MD arc iteration, the standard sequence is:
  *
@@ -50,16 +50,16 @@ extern const char *mdesc_node_name(struct mdesc_handle =
*hp, u64 node);
 #define MDESC_ARC_TYPE_FWD	"fwd"
 #define MDESC_ARC_TYPE_BACK	"back"
=20
-extern u64 mdesc_next_arc(struct mdesc_handle *handle, u64 from,
-			  const char *arc_type);
+u64 mdesc_next_arc(struct mdesc_handle *handle, u64 from,
+		   const char *arc_type);
 #define mdesc_for_each_arc(__arc, __hdl, __node, __type) \
 	for (__arc =3D mdesc_next_arc(__hdl, __node, __type); \
 	     (__arc) !=3D MDESC_NODE_NULL; \
 	     __arc =3D mdesc_next_arc(__hdl, __arc, __type))
=20
-extern u64 mdesc_arc_target(struct mdesc_handle *hp, u64 arc);
+u64 mdesc_arc_target(struct mdesc_handle *hp, u64 arc);
=20
-extern void mdesc_update(void);
+void mdesc_update(void);
=20
 struct mdesc_notifier_client {
 	void (*add)(struct mdesc_handle *handle, u64 node);
@@ -69,12 +69,12 @@ struct mdesc_notifier_client {
 	struct mdesc_notifier_client	*next;
 };
=20
-extern void mdesc_register_notifier(struct mdesc_notifier_client *client);
+void mdesc_register_notifier(struct mdesc_notifier_client *client);
=20
-extern void mdesc_fill_in_cpu_data(cpumask_t *mask);
-extern void mdesc_populate_present_mask(cpumask_t *mask);
-extern void mdesc_get_page_sizes(cpumask_t *mask, unsigned long *pgsz_mask=
);
+void mdesc_fill_in_cpu_data(cpumask_t *mask);
+void mdesc_populate_present_mask(cpumask_t *mask);
+void mdesc_get_page_sizes(cpumask_t *mask, unsigned long *pgsz_mask);
=20
-extern void sun4v_mdesc_init(void);
+void sun4v_mdesc_init(void);
=20
 #endif
diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_6=
4.h
index f668797..70067ce 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -67,9 +67,9 @@ struct tsb {
 	unsigned long pte;
 } __attribute__((aligned(TSB_ENTRY_ALIGNMENT)));
=20
-extern void __tsb_insert(unsigned long ent, unsigned long tag, unsigned lo=
ng pte);
-extern void tsb_flush(unsigned long ent, unsigned long tag);
-extern void tsb_init(struct tsb *tsb, unsigned long size);
+void __tsb_insert(unsigned long ent, unsigned long tag, unsigned long pte);
+void tsb_flush(unsigned long ent, unsigned long tag);
+void tsb_init(struct tsb *tsb, unsigned long size);
=20
 struct tsb_config {
 	struct tsb		*tsb;
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/a=
sm/mmu_context_64.h
index 3d528f0..b84be67 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -17,20 +17,20 @@ extern spinlock_t ctx_alloc_lock;
 extern unsigned long tlb_context_cache;
 extern unsigned long mmu_context_bmap[];
=20
-extern void get_new_mmu_context(struct mm_struct *mm);
+void get_new_mmu_context(struct mm_struct *mm);
 #ifdef CONFIG_SMP
-extern void smp_new_mmu_context_version(void);
+void smp_new_mmu_context_version(void);
 #else
 #define smp_new_mmu_context_version() do { } while (0)
 #endif
=20
-extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
-extern void destroy_context(struct mm_struct *mm);
+int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+void destroy_context(struct mm_struct *mm);
=20
-extern void __tsb_context_switch(unsigned long pgd_pa,
-				 struct tsb_config *tsb_base,
-				 struct tsb_config *tsb_huge,
-				 unsigned long tsb_descr_pa);
+void __tsb_context_switch(unsigned long pgd_pa,
+			  struct tsb_config *tsb_base,
+			  struct tsb_config *tsb_huge,
+			  unsigned long tsb_descr_pa);
=20
 static inline void tsb_context_switch(struct mm_struct *mm)
 {
@@ -46,9 +46,11 @@ static inline void tsb_context_switch(struct mm_struct *=
mm)
 			     , __pa(&mm->context.tsb_descr[0]));
 }
=20
-extern void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsign=
ed long mm_rss);
+void tsb_grow(struct mm_struct *mm,
+	      unsigned long tsb_index,
+	      unsigned long mm_rss);
 #ifdef CONFIG_SMP
-extern void smp_tsb_sync(struct mm_struct *mm);
+void smp_tsb_sync(struct mm_struct *mm);
 #else
 #define smp_tsb_sync(__mm) do { } while (0)
 #endif
@@ -66,7 +68,7 @@ extern void smp_tsb_sync(struct mm_struct *mm);
 	: "r" (CTX_HWBITS((__mm)->context)), \
 	  "r" (SECONDARY_CONTEXT), "i" (ASI_DMMU), "i" (ASI_MMU))
=20
-extern void __flush_tlb_mm(unsigned long, unsigned long);
+void __flush_tlb_mm(unsigned long, unsigned long);
=20
 /* Switch the current MM context. */
 static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *m=
m, struct task_struct *tsk)
diff --git a/arch/sparc/include/asm/nmi.h b/arch/sparc/include/asm/nmi.h
index 72e6500..26ad2b2 100644
--- a/arch/sparc/include/asm/nmi.h
+++ b/arch/sparc/include/asm/nmi.h
@@ -1,13 +1,13 @@
 #ifndef __NMI_H
 #define __NMI_H
=20
-extern int __init nmi_init(void);
-extern void perfctr_irq(int irq, struct pt_regs *regs);
-extern void nmi_adjust_hz(unsigned int new_hz);
+int __init nmi_init(void);
+void perfctr_irq(int irq, struct pt_regs *regs);
+void nmi_adjust_hz(unsigned int new_hz);
=20
 extern atomic_t nmi_active;
=20
-extern void start_nmi_watchdog(void *unused);
-extern void stop_nmi_watchdog(void *unused);
+void start_nmi_watchdog(void *unused);
+void stop_nmi_watchdog(void *unused);
=20
 #endif /* __NMI_H */
diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/opl=
ib_32.h
index c72f304..56a09b9 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -43,28 +43,28 @@ extern struct linux_nodeops *prom_nodeops;
 /* You must call prom_init() before using any of the library services,
  * preferably as early as possible.  Pass it the romvec pointer.
  */
-extern void prom_init(struct linux_romvec *rom_ptr);
+void prom_init(struct linux_romvec *rom_ptr);
=20
 /* Boot argument acquisition, returns the boot command line string. */
-extern char *prom_getbootargs(void);
+char *prom_getbootargs(void);
=20
 /* Miscellaneous routines, don't really fit in any category per se. */
=20
 /* Reboot the machine with the command line passed. */
-extern void prom_reboot(char *boot_command);
+void prom_reboot(char *boot_command);
=20
 /* Evaluate the forth string passed. */
-extern void prom_feval(char *forth_string);
+void prom_feval(char *forth_string);
=20
 /* Enter the prom, with possibility of continuation with the 'go'
  * command in newer proms.
  */
-extern void prom_cmdline(void);
+void prom_cmdline(void);
=20
 /* Enter the prom, with no chance of continuation for the stand-alone
  * which calls this.
  */
-extern void __noreturn prom_halt(void);
+void __noreturn prom_halt(void);
=20
 /* Set the PROM 'sync' callback function to the passed function pointer.
  * When the user gives the 'sync' command at the prom prompt while the
@@ -73,37 +73,37 @@ extern void __noreturn prom_halt(void);
  * XXX The arguments are different on V0 vs. V2->higher proms, grrr! XXX
  */
 typedef void (*sync_func_t)(void);
-extern void prom_setsync(sync_func_t func_ptr);
+void prom_setsync(sync_func_t func_ptr);
=20
 /* Acquire the IDPROM of the root node in the prom device tree.  This
  * gets passed a buffer where you would like it stuffed.  The return value
  * is the format type of this idprom or 0xff on error.
  */
-extern unsigned char prom_get_idprom(char *idp_buffer, int idpbuf_size);
+unsigned char prom_get_idprom(char *idp_buffer, int idpbuf_size);
=20
 /* Get the prom major version. */
-extern int prom_version(void);
+int prom_version(void);
=20
 /* Get the prom plugin revision. */
-extern int prom_getrev(void);
+int prom_getrev(void);
=20
 /* Get the prom firmware revision. */
-extern int prom_getprev(void);
+int prom_getprev(void);
=20
 /* Write a buffer of characters to the console. */
-extern void prom_console_write_buf(const char *buf, int len);
+void prom_console_write_buf(const char *buf, int len);
=20
 /* Prom's internal routines, don't use in kernel/boot code. */
-extern __printf(1, 2) void prom_printf(const char *fmt, ...);
-extern void prom_write(const char *buf, unsigned int len);
+__printf(1, 2) void prom_printf(const char *fmt, ...);
+void prom_write(const char *buf, unsigned int len);
=20
 /* Multiprocessor operations... */
=20
 /* Start the CPU with the given device tree node, context table, and conte=
xt
  * at the passed program counter.
  */
-extern int prom_startcpu(int cpunode, struct linux_prom_registers *context=
_table,
-			 int context, char *program_counter);
+int prom_startcpu(int cpunode, struct linux_prom_registers *context_table,
+		  int context, char *program_counter);
=20
 /* Initialize the memory lists based upon the prom version. */
 void prom_meminit(void);
@@ -111,65 +111,65 @@ void prom_meminit(void);
 /* PROM device tree traversal functions... */
=20
 /* Get the child node of the given node, or zero if no child exists. */
-extern phandle prom_getchild(phandle parent_node);
+phandle prom_getchild(phandle parent_node);
=20
 /* Get the next sibling node of the given node, or zero if no further
  * siblings exist.
  */
-extern phandle prom_getsibling(phandle node);
+phandle prom_getsibling(phandle node);
=20
 /* Get the length, at the passed node, of the given property type.
  * Returns -1 on error (ie. no such property at this node).
  */
-extern int prom_getproplen(phandle thisnode, const char *property);
+int prom_getproplen(phandle thisnode, const char *property);
=20
 /* Fetch the requested property using the given buffer.  Returns
  * the number of bytes the prom put into your buffer or -1 on error.
  */
-extern int __must_check prom_getproperty(phandle thisnode, const char *pro=
perty,
-					 char *prop_buffer, int propbuf_size);
+int __must_check prom_getproperty(phandle thisnode, const char *property,
+				  char *prop_buffer, int propbuf_size);
=20
 /* Acquire an integer property. */
-extern int prom_getint(phandle node, char *property);
+int prom_getint(phandle node, char *property);
=20
 /* Acquire an integer property, with a default value. */
-extern int prom_getintdefault(phandle node, char *property, int defval);
+int prom_getintdefault(phandle node, char *property, int defval);
=20
 /* Acquire a boolean property, 0=FALSE 1=3DTRUE. */
-extern int prom_getbool(phandle node, char *prop);
+int prom_getbool(phandle node, char *prop);
=20
 /* Acquire a string property, null string on error. */
-extern void prom_getstring(phandle node, char *prop, char *buf, int bufsiz=
e);
+void prom_getstring(phandle node, char *prop, char *buf, int bufsize);
=20
 /* Search all siblings starting at the passed node for "name" matching
  * the given string.  Returns the node on success, zero on failure.
  */
-extern phandle prom_searchsiblings(phandle node_start, char *name);
+phandle prom_searchsiblings(phandle node_start, char *name);
=20
 /* Returns the next property after the passed property for the given
  * node.  Returns null string on failure.
  */
-extern char *prom_nextprop(phandle node, char *prev_property, char *buffer=
);
+char *prom_nextprop(phandle node, char *prev_property, char *buffer);
=20
 /* Returns phandle of the path specified */
-extern phandle prom_finddevice(char *name);
+phandle prom_finddevice(char *name);
=20
 /* Set the indicated property at the given node with the passed value.
  * Returns the number of bytes of your value that the prom took.
  */
-extern int prom_setprop(phandle node, const char *prop_name, char *prop_va=
lue,
-			int value_size);
+int prom_setprop(phandle node, const char *prop_name, char *prop_value,
+		 int value_size);
=20
-extern phandle prom_inst2pkg(int);
+phandle prom_inst2pkg(int);
=20
 /* Dorking with Bus ranges... */
=20
 /* Apply promlib probes OBIO ranges to registers. */
-extern void prom_apply_obio_ranges(struct linux_prom_registers *obioregs, =
int nregs);
+void prom_apply_obio_ranges(struct linux_prom_registers *obioregs, int nre=
gs);
=20
 /* Apply ranges of any prom node (and optionally parent node as well) to r=
egisters. */
-extern void prom_apply_generic_ranges(phandle node, phandle parent,
-				      struct linux_prom_registers *sbusregs, int nregs);
+void prom_apply_generic_ranges(phandle node, phandle parent,
+			       struct linux_prom_registers *sbusregs, int nregs);
=20
 void prom_ranges_init(void);
=20
diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/opl=
ib_64.h
index a12dbe3..f346824 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -62,100 +62,100 @@ struct linux_mem_p1275 {
 /* You must call prom_init() before using any of the library services,
  * preferably as early as possible.  Pass it the romvec pointer.
  */
-extern void prom_init(void *cif_handler, void *cif_stack);
+void prom_init(void *cif_handler, void *cif_stack);
=20
 /* Boot argument acquisition, returns the boot command line string. */
-extern char *prom_getbootargs(void);
+char *prom_getbootargs(void);
=20
 /* Miscellaneous routines, don't really fit in any category per se. */
=20
 /* Reboot the machine with the command line passed. */
-extern void prom_reboot(const char *boot_command);
+void prom_reboot(const char *boot_command);
=20
 /* Evaluate the forth string passed. */
-extern void prom_feval(const char *forth_string);
+void prom_feval(const char *forth_string);
=20
 /* Enter the prom, with possibility of continuation with the 'go'
  * command in newer proms.
  */
-extern void prom_cmdline(void);
+void prom_cmdline(void);
=20
 /* Enter the prom, with no chance of continuation for the stand-alone
  * which calls this.
  */
-extern void prom_halt(void) __attribute__ ((noreturn));
+void prom_halt(void) __attribute__ ((noreturn));
=20
 /* Halt and power-off the machine. */
-extern void prom_halt_power_off(void) __attribute__ ((noreturn));
+void prom_halt_power_off(void) __attribute__ ((noreturn));
=20
 /* Acquire the IDPROM of the root node in the prom device tree.  This
  * gets passed a buffer where you would like it stuffed.  The return value
  * is the format type of this idprom or 0xff on error.
  */
-extern unsigned char prom_get_idprom(char *idp_buffer, int idpbuf_size);
+unsigned char prom_get_idprom(char *idp_buffer, int idpbuf_size);
=20
 /* Write a buffer of characters to the console. */
-extern void prom_console_write_buf(const char *buf, int len);
+void prom_console_write_buf(const char *buf, int len);
=20
 /* Prom's internal routines, don't use in kernel/boot code. */
-extern __printf(1, 2) void prom_printf(const char *fmt, ...);
-extern void prom_write(const char *buf, unsigned int len);
+__printf(1, 2) void prom_printf(const char *fmt, ...);
+void prom_write(const char *buf, unsigned int len);
=20
 /* Multiprocessor operations... */
 #ifdef CONFIG_SMP
 /* Start the CPU with the given device tree node at the passed program
  * counter with the given arg passed in via register %o0.
  */
-extern void prom_startcpu(int cpunode, unsigned long pc, unsigned long arg=
);
+void prom_startcpu(int cpunode, unsigned long pc, unsigned long arg);
=20
 /* Start the CPU with the given cpu ID at the passed program
  * counter with the given arg passed in via register %o0.
  */
-extern void prom_startcpu_cpuid(int cpuid, unsigned long pc, unsigned long=
 arg);
+void prom_startcpu_cpuid(int cpuid, unsigned long pc, unsigned long arg);
=20
 /* Stop the CPU with the given cpu ID.  */
-extern void prom_stopcpu_cpuid(int cpuid);
+void prom_stopcpu_cpuid(int cpuid);
=20
 /* Stop the current CPU. */
-extern void prom_stopself(void);
+void prom_stopself(void);
=20
 /* Idle the current CPU. */
-extern void prom_idleself(void);
+void prom_idleself(void);
=20
 /* Resume the CPU with the passed device tree node. */
-extern void prom_resumecpu(int cpunode);
+void prom_resumecpu(int cpunode);
 #endif
=20
 /* Power management interfaces. */
=20
 /* Put the current CPU to sleep. */
-extern void prom_sleepself(void);
+void prom_sleepself(void);
=20
 /* Put the entire system to sleep. */
-extern int prom_sleepsystem(void);
+int prom_sleepsystem(void);
=20
 /* Initiate a wakeup event. */
-extern int prom_wakeupsystem(void);
+int prom_wakeupsystem(void);
=20
 /* MMU and memory related OBP interfaces. */
=20
 /* Get unique string identifying SIMM at given physical address. */
-extern int prom_getunumber(int syndrome_code,
-			   unsigned long phys_addr,
-			   char *buf, int buflen);
+int prom_getunumber(int syndrome_code,
+		    unsigned long phys_addr,
+		    char *buf, int buflen);
=20
 /* Retain physical memory to the caller across soft resets. */
-extern int prom_retain(const char *name, unsigned long size,
-		       unsigned long align, unsigned long *paddr);
+int prom_retain(const char *name, unsigned long size,
+		unsigned long align, unsigned long *paddr);
=20
 /* Load explicit I/D TLB entries into the calling processor. */
-extern long prom_itlb_load(unsigned long index,
-			   unsigned long tte_data,
-			   unsigned long vaddr);
+long prom_itlb_load(unsigned long index,
+		    unsigned long tte_data,
+		    unsigned long vaddr);
=20
-extern long prom_dtlb_load(unsigned long index,
-			   unsigned long tte_data,
-			   unsigned long vaddr);
+long prom_dtlb_load(unsigned long index,
+		    unsigned long tte_data,
+		    unsigned long vaddr);
=20
 /* Map/Unmap client program address ranges.  First the format of
  * the mapping mode argument.
@@ -170,81 +170,81 @@ extern long prom_dtlb_load(unsigned long index,
 #define PROM_MAP_IE	0x0100 /* Invert-Endianness */
 #define PROM_MAP_DEFAULT (PROM_MAP_WRITE | PROM_MAP_READ | PROM_MAP_EXEC |=
 PROM_MAP_CACHED)
=20
-extern int prom_map(int mode, unsigned long size,
-		    unsigned long vaddr, unsigned long paddr);
-extern void prom_unmap(unsigned long size, unsigned long vaddr);
+int prom_map(int mode, unsigned long size,
+	     unsigned long vaddr, unsigned long paddr);
+void prom_unmap(unsigned long size, unsigned long vaddr);
=20
=20
 /* PROM device tree traversal functions... */
=20
 /* Get the child node of the given node, or zero if no child exists. */
-extern phandle prom_getchild(phandle parent_node);
+phandle prom_getchild(phandle parent_node);
=20
 /* Get the next sibling node of the given node, or zero if no further
  * siblings exist.
  */
-extern phandle prom_getsibling(phandle node);
+phandle prom_getsibling(phandle node);
=20
 /* Get the length, at the passed node, of the given property type.
  * Returns -1 on error (ie. no such property at this node).
  */
-extern int prom_getproplen(phandle thisnode, const char *property);
+int prom_getproplen(phandle thisnode, const char *property);
=20
 /* Fetch the requested property using the given buffer.  Returns
  * the number of bytes the prom put into your buffer or -1 on error.
  */
-extern int prom_getproperty(phandle thisnode, const char *property,
-			    char *prop_buffer, int propbuf_size);
+int prom_getproperty(phandle thisnode, const char *property,
+		     char *prop_buffer, int propbuf_size);
=20
 /* Acquire an integer property. */
-extern int prom_getint(phandle node, const char *property);
+int prom_getint(phandle node, const char *property);
=20
 /* Acquire an integer property, with a default value. */
-extern int prom_getintdefault(phandle node, const char *property, int defv=
al);
+int prom_getintdefault(phandle node, const char *property, int defval);
=20
 /* Acquire a boolean property, 0=FALSE 1=3DTRUE. */
-extern int prom_getbool(phandle node, const char *prop);
+int prom_getbool(phandle node, const char *prop);
=20
 /* Acquire a string property, null string on error. */
-extern void prom_getstring(phandle node, const char *prop, char *buf,
-			   int bufsize);
+void prom_getstring(phandle node, const char *prop, char *buf,
+		    int bufsize);
=20
 /* Does the passed node have the given "name"? YES=3D1 NO=3D0 */
-extern int prom_nodematch(phandle thisnode, const char *name);
+int prom_nodematch(phandle thisnode, const char *name);
=20
 /* Search all siblings starting at the passed node for "name" matching
  * the given string.  Returns the node on success, zero on failure.
  */
-extern phandle prom_searchsiblings(phandle node_start, const char *name);
+phandle prom_searchsiblings(phandle node_start, const char *name);
=20
 /* Return the first property type, as a string, for the given node.
  * Returns a null string on error. Buffer should be at least 32B long.
  */
-extern char *prom_firstprop(phandle node, char *buffer);
+char *prom_firstprop(phandle node, char *buffer);
=20
 /* Returns the next property after the passed property for the given
  * node.  Returns null string on failure. Buffer should be at least 32B lo=
ng.
  */
-extern char *prom_nextprop(phandle node, const char *prev_property, char *=
buf);
+char *prom_nextprop(phandle node, const char *prev_property, char *buf);
=20
 /* Returns 1 if the specified node has given property. */
-extern int prom_node_has_property(phandle node, const char *property);
+int prom_node_has_property(phandle node, const char *property);
=20
 /* Returns phandle of the path specified */
-extern phandle prom_finddevice(const char *name);
+phandle prom_finddevice(const char *name);
=20
 /* Set the indicated property at the given node with the passed value.
  * Returns the number of bytes of your value that the prom took.
  */
-extern int prom_setprop(phandle node, const char *prop_name, char *prop_va=
lue,
-			int value_size);
+int prom_setprop(phandle node, const char *prop_name, char *prop_value,
+		 int value_size);
=20
-extern phandle prom_inst2pkg(int);
-extern void prom_sun4v_guest_soft_state(void);
+phandle prom_inst2pkg(int);
+void prom_sun4v_guest_soft_state(void);
=20
-extern int prom_ihandle2path(int handle, char *buffer, int bufsize);
+int prom_ihandle2path(int handle, char *buffer, int bufsize);
=20
 /* Client interface level routines. */
-extern void p1275_cmd_direct(unsigned long *);
+void p1275_cmd_direct(unsigned long *);
=20
 #endif /* !(__SPARC64_OPLIB_H) */
diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page=
_64.h
index aac53fc..bf10998 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -31,17 +31,17 @@
=20
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 struct pt_regs;
-extern void hugetlb_setup(struct pt_regs *regs);
+void hugetlb_setup(struct pt_regs *regs);
 #endif
=20
 #define WANT_PAGE_VIRTUAL
=20
-extern void _clear_page(void *page);
+void _clear_page(void *page);
 #define clear_page(X)	_clear_page((void *)(X))
 struct page;
-extern void clear_user_page(void *addr, unsigned long vaddr, struct page *=
page);
+void clear_user_page(void *addr, unsigned long vaddr, struct page *page);
 #define copy_page(X,Y)	memcpy((void *)(X), (void *)(Y), PAGE_SIZE)
-extern void copy_user_page(void *to, void *from, unsigned long vaddr, stru=
ct page *topage);
+void copy_user_page(void *to, void *from, unsigned long vaddr, struct page=
 *topage);
=20
 /* Unlike sparc32, sparc64's parameter passing API is more
  * sane in that structures which as small enough are passed
diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_6=
4.h
index 1633b71..2c9a3e9 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -57,7 +57,7 @@ static inline void pci_dma_burst_advice(struct pci_dev *p=
dev,
=20
 /* Return the index of the PCI controller for device PDEV. */
=20
-extern int pci_domain_nr(struct pci_bus *bus);
+int pci_domain_nr(struct pci_bus *bus);
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
 	return 1;
@@ -69,9 +69,9 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
 #define get_pci_unmapped_area get_fb_unmapped_area
=20
-extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct =
*vma,
-			       enum pci_mmap_state mmap_state,
-			       int write_combine);
+int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state,
+			int write_combine);
=20
 static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 {
@@ -79,9 +79,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *=
dev, int channel)
 }
=20
 #define HAVE_ARCH_PCI_RESOURCE_TO_USER
-extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
-				 const struct resource *rsrc,
-				 resource_size_t *start, resource_size_t *end);
+void pci_resource_to_user(const struct pci_dev *dev, int bar,
+			  const struct resource *rsrc,
+			  resource_size_t *start, resource_size_t *end);
 #endif /* __KERNEL__ */
=20
 #endif /* __SPARC64_PCI_H */
diff --git a/arch/sparc/include/asm/pcic.h b/arch/sparc/include/asm/pcic.h
index 6676cbc..f417067 100644
--- a/arch/sparc/include/asm/pcic.h
+++ b/arch/sparc/include/asm/pcic.h
@@ -30,10 +30,10 @@ struct linux_pcic {
 };
=20
 #ifdef CONFIG_PCIC_PCI
-extern int pcic_present(void);
-extern int pcic_probe(void);
-extern void pci_time_init(void);
-extern void sun4m_pci_init_IRQ(void);
+int pcic_present(void);
+int pcic_probe(void);
+void pci_time_init(void);
+void sun4m_pci_init_IRQ(void);
 #else
 static inline int pcic_present(void) { return 0; }
 static inline int pcic_probe(void) { return 0; }
diff --git a/arch/sparc/include/asm/pcr.h b/arch/sparc/include/asm/pcr.h
index 942bb17..cdf800c 100644
--- a/arch/sparc/include/asm/pcr.h
+++ b/arch/sparc/include/asm/pcr.h
@@ -12,8 +12,8 @@ struct pcr_ops {
 };
 extern const struct pcr_ops *pcr_ops;
=20
-extern void deferred_pcr_work_irq(int irq, struct pt_regs *regs);
-extern void schedule_deferred_pcr_work(void);
+void deferred_pcr_work_irq(int irq, struct pt_regs *regs);
+void schedule_deferred_pcr_work(void);
=20
 #define PCR_PIC_PRIV		0x00000001 /* PIC access is privileged */
 #define PCR_STRACE		0x00000002 /* Trace supervisor events  */
@@ -45,6 +45,6 @@ extern void schedule_deferred_pcr_work(void);
 #define PCR_N4_PICNHT		0x00020000 /* PIC non-hypervisor trap  */
 #define PCR_N4_NTC		0x00040000 /* Next-To-Commit wrap      */
=20
-extern int pcr_arch_init(void);
+int pcr_arch_init(void);
=20
 #endif /* __PCR_H */
diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/p=
galloc_64.h
index bcfe063..39a7ac4 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -38,12 +38,12 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t=
 *pmd)
 	kmem_cache_free(pgtable_cache, pmd);
 }
=20
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-				   unsigned long address);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm,
-			       unsigned long address);
-extern void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
-extern void pte_free(struct mm_struct *mm, pgtable_t ptepage);
+pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
+			    unsigned long address);
+pgtable_t pte_alloc_one(struct mm_struct *mm,
+			unsigned long address);
+void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
+void pte_free(struct mm_struct *mm, pgtable_t ptepage);
=20
 #define pmd_populate_kernel(MM, PMD, PTE)	pmd_set(MM, PMD, PTE)
 #define pmd_populate(MM, PMD, PTE)		pmd_set(MM, PMD, PTE)
@@ -51,12 +51,12 @@ extern void pte_free(struct mm_struct *mm, pgtable_t pt=
epage);
=20
 #define check_pgt_cache()	do { } while (0)
=20
-extern void pgtable_free(void *table, bool is_page);
+void pgtable_free(void *table, bool is_page);
=20
 #ifdef CONFIG_SMP
=20
 struct mmu_gather;
-extern void tlb_remove_table(struct mmu_gather *, void *);
+void tlb_remove_table(struct mmu_gather *, void *);
=20
 static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, b=
ool is_page)
 {
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/p=
gtable_32.h
index 16629e7..b9b91ae 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -25,8 +25,8 @@
 struct vm_area_struct;
 struct page;
=20
-extern void load_mmu(void);
-extern unsigned long calc_highpages(void);
+void load_mmu(void);
+unsigned long calc_highpages(void);
 unsigned long __init bootmem_init(unsigned long *pages_avail);
=20
 #define pte_ERROR(e)   __builtin_trap()
@@ -57,7 +57,7 @@ unsigned long __init bootmem_init(unsigned long *pages_av=
ail);
  * srmmu.c will assign the real one (which is dynamically sized) */
 #define swapper_pg_dir NULL
=20
-extern void paging_init(void);
+void paging_init(void);
=20
 extern unsigned long ptr_in_current_pgd;
=20
@@ -429,8 +429,8 @@ extern unsigned long *sparc_valid_addr_bitmap;
 #define GET_IOSPACE(pfn)		(pfn >> (BITS_PER_LONG - 4))
 #define GET_PFN(pfn)			(pfn & 0x0fffffffUL)
=20
-extern int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigne=
d long,
-			   unsigned long, pgprot_t);
+int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned long,
+		    unsigned long, pgprot_t);
=20
 static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 				     unsigned long from, unsigned long pfn,
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/p=
gtable_64.h
index 0f9e945..521b8d8 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -188,9 +188,9 @@
=20
 #ifndef __ASSEMBLY__
=20
-extern pte_t mk_pte_io(unsigned long, pgprot_t, int, unsigned long);
+pte_t mk_pte_io(unsigned long, pgprot_t, int, unsigned long);
=20
-extern unsigned long pte_sz_bits(unsigned long size);
+unsigned long pte_sz_bits(unsigned long size);
=20
 extern pgprot_t PAGE_KERNEL;
 extern pgprot_t PAGE_KERNEL_LOCKED;
@@ -758,8 +758,8 @@ static inline int pmd_present(pmd_t pmd)
 #define pmd_none(pmd)			(!pmd_val(pmd))
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
-		       pmd_t *pmdp, pmd_t pmd);
+void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+		pmd_t *pmdp, pmd_t pmd);
 #else
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
@@ -821,8 +821,8 @@ static inline unsigned long __pmd_page(pmd_t pmd)
 #define pte_unmap(pte)			do { } while (0)
=20
 /* Actual page table PTE updates.  */
-extern void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
-			  pte_t *ptep, pte_t orig, int fullmm);
+void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
+		   pte_t *ptep, pte_t orig, int fullmm);
=20
 #define __HAVE_ARCH_PMDP_GET_AND_CLEAR
 static inline pmd_t pmdp_get_and_clear(struct mm_struct *mm,
@@ -881,24 +881,24 @@ static inline void __set_pte_at(struct mm_struct *mm,=
 unsigned long addr,
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pmd_t swapper_low_pmd_dir[PTRS_PER_PMD];
=20
-extern void paging_init(void);
-extern unsigned long find_ecache_flush_span(unsigned long size);
+void paging_init(void);
+unsigned long find_ecache_flush_span(unsigned long size);
=20
 struct seq_file;
-extern void mmu_info(struct seq_file *);
+void mmu_info(struct seq_file *);
=20
 struct vm_area_struct;
-extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t=
 *);
+void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-extern void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long=
 addr,
-				 pmd_t *pmd);
+void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
+			  pmd_t *pmd);
=20
 #define __HAVE_ARCH_PGTABLE_DEPOSIT
-extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-				       pgtable_t pgtable);
+void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
+				pgtable_t pgtable);
=20
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
-extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *=
pmdp);
+pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
=20
 /* Encode and de-code a swap entry */
@@ -914,9 +914,9 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct mm_=
struct *mm, pmd_t *pmdp);
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
=20
 /* File offset in PTE support. */
-extern unsigned long pte_file(pte_t);
+unsigned long pte_file(pte_t);
 #define pte_to_pgoff(pte)	(pte_val(pte) >> PAGE_SHIFT)
-extern pte_t pgoff_to_pte(unsigned long);
+pte_t pgoff_to_pte(unsigned long);
 #define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 1UL)
=20
 extern unsigned long sparc64_valid_addr_bitmap[];
@@ -931,7 +931,7 @@ static inline bool kern_addr_valid(unsigned long addr)
 	return test_bit(paddr >> 22, sparc64_valid_addr_bitmap);
 }
=20
-extern int page_in_phys_avail(unsigned long paddr);
+int page_in_phys_avail(unsigned long paddr);
=20
 /*
  * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
@@ -941,8 +941,8 @@ extern int page_in_phys_avail(unsigned long paddr);
 #define GET_IOSPACE(pfn)		(pfn >> (BITS_PER_LONG - 4))
 #define GET_PFN(pfn)			(pfn & 0x0fffffffffffffffUL)
=20
-extern int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigne=
d long,
-			   unsigned long, pgprot_t);
+int remap_pfn_range(struct vm_area_struct *, unsigned long, unsigned long,
+		    unsigned long, pgprot_t);
=20
 static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 				     unsigned long from, unsigned long pfn,
@@ -970,20 +970,20 @@ static inline int io_remap_pfn_range(struct vm_area_s=
truct *vma,
 /* We provide a special get_unmapped_area for framebuffer mmaps to try and=
 use
  * the largest alignment possible such that larget PTEs can be used.
  */
-extern unsigned long get_fb_unmapped_area(struct file *filp, unsigned long,
-					  unsigned long, unsigned long,
-					  unsigned long);
+unsigned long get_fb_unmapped_area(struct file *filp, unsigned long,
+				   unsigned long, unsigned long,
+				   unsigned long);
 #define HAVE_ARCH_FB_UNMAPPED_AREA
=20
-extern void pgtable_cache_init(void);
-extern void sun4v_register_fault_status(void);
-extern void sun4v_ktsb_register(void);
-extern void __init cheetah_ecache_flush_init(void);
-extern void sun4v_patch_tlb_handlers(void);
+void pgtable_cache_init(void);
+void sun4v_register_fault_status(void);
+void sun4v_ktsb_register(void);
+void __init cheetah_ecache_flush_init(void);
+void sun4v_patch_tlb_handlers(void);
=20
 extern unsigned long cmdline_memory_size;
=20
-extern asmlinkage void do_sparc64_fault(struct pt_regs *regs);
+asmlinkage void do_sparc64_fault(struct pt_regs *regs);
=20
 #endif /* !(__ASSEMBLY__) */
=20
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm=
/processor_32.h
index 2bc9818..a564817 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -74,7 +74,7 @@ struct thread_struct {
 }
=20
 /* Return saved PC of a blocked thread. */
-extern unsigned long thread_saved_pc(struct task_struct *t);
+unsigned long thread_saved_pc(struct task_struct *t);
=20
 /* Do necessary setup to start up a newly executed thread. */
 static inline void start_thread(struct pt_regs * regs, unsigned long pc,
@@ -107,7 +107,7 @@ static inline void start_thread(struct pt_regs * regs, =
unsigned long pc,
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while(0)
=20
-extern unsigned long get_wchan(struct task_struct *);
+unsigned long get_wchan(struct task_struct *);
=20
 #define task_pt_regs(tsk) ((tsk)->thread.kregs)
 #define KSTK_EIP(tsk)  ((tsk)->thread.kregs->pc)
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm=
/processor_64.h
index 27ff7ae..7028fe1 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -95,7 +95,7 @@ struct thread_struct {
=20
 /* Return saved PC of a blocked thread. */
 struct task_struct;
-extern unsigned long thread_saved_pc(struct task_struct *);
+unsigned long thread_saved_pc(struct task_struct *);
=20
 /* On Uniprocessor, even in RMO processes see TSO semantics */
 #ifdef CONFIG_SMP
@@ -194,7 +194,7 @@ do { \
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while (0)
=20
-extern unsigned long get_wchan(struct task_struct *task);
+unsigned long get_wchan(struct task_struct *task);
=20
 #define task_pt_regs(tsk) (task_thread_info(tsk)->kregs)
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index 11ebd65..d955c8d 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -36,28 +36,28 @@ struct of_irq_controller {
 	void		*data;
 };
=20
-extern struct device_node *of_find_node_by_cpuid(int cpuid);
-extern int of_set_property(struct device_node *node, const char *name, voi=
d *val, int len);
+struct device_node *of_find_node_by_cpuid(int cpuid);
+int of_set_property(struct device_node *node, const char *name, void *val,=
 int len);
 extern struct mutex of_set_property_mutex;
-extern int of_getintprop_default(struct device_node *np,
-				 const char *name,
+int of_getintprop_default(struct device_node *np,
+			  const char *name,
 				 int def);
-extern int of_find_in_proplist(const char *list, const char *match, int le=
n);
+int of_find_in_proplist(const char *list, const char *match, int len);
=20
-extern void prom_build_devicetree(void);
-extern void of_populate_present_mask(void);
-extern void of_fill_in_cpu_data(void);
+void prom_build_devicetree(void);
+void of_populate_present_mask(void);
+void of_fill_in_cpu_data(void);
=20
 struct resource;
-extern void __iomem *of_ioremap(struct resource *res, unsigned long offset=
, unsigned long size, char *name);
-extern void of_iounmap(struct resource *res, void __iomem *base, unsigned =
long size);
+void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsig=
ned long size, char *name);
+void of_iounmap(struct resource *res, void __iomem *base, unsigned long si=
ze);
=20
 extern struct device_node *of_console_device;
 extern char *of_console_path;
 extern char *of_console_options;
=20
-extern void irq_trans_init(struct device_node *dp);
-extern char *build_path_component(struct device_node *dp);
+void irq_trans_init(struct device_node *dp);
+char *build_path_component(struct device_node *dp);
=20
 #endif /* __KERNEL__ */
 #endif /* _SPARC_PROM_H */
diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrac=
e.h
index bdfafd7..bac6a94 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -73,7 +73,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return regs->u_regs[UREG_I0];
 }
 #ifdef CONFIG_SMP
-extern unsigned long profile_pc(struct pt_regs *);
+unsigned long profile_pc(struct pt_regs *);
 #else
 #define profile_pc(regs) instruction_pointer(regs)
 #endif
diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index fb54505..9520e2e 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -47,7 +47,7 @@ unsigned long safe_compute_effective_address(struct pt_re=
gs *, unsigned int);
=20
 #endif
=20
-extern void sun_do_break(void);
+void sun_do_break(void);
 extern int stop_a_enabled;
 extern int scons_pwroff;
=20
diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_3=
2.h
index 3c8917f..7c24e08 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -93,15 +93,15 @@ static inline void xc4(smpfunc_t func, unsigned long ar=
g1, unsigned long arg2,
 				    arg1, arg2, arg3, arg4);
 }
=20
-extern void arch_send_call_function_single_ipi(int cpu);
-extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+void arch_send_call_function_single_ipi(int cpu);
+void arch_send_call_function_ipi_mask(const struct cpumask *mask);
=20
 static inline int cpu_logical_map(int cpu)
 {
 	return cpu;
 }
=20
-extern int hard_smp_processor_id(void);
+int hard_smp_processor_id(void);
=20
 #define raw_smp_processor_id()		(current_thread_info()->cpu)
=20
diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_6=
4.h
index 0571039..753c9d9 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -33,29 +33,29 @@
 DECLARE_PER_CPU(cpumask_t, cpu_sibling_map);
 extern cpumask_t cpu_core_map[NR_CPUS];
=20
-extern void arch_send_call_function_single_ipi(int cpu);
-extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+void arch_send_call_function_single_ipi(int cpu);
+void arch_send_call_function_ipi_mask(const struct cpumask *mask);
=20
 /*
  *	General functions that each host system must provide.
  */
=20
-extern int hard_smp_processor_id(void);
+int hard_smp_processor_id(void);
 #define raw_smp_processor_id() (current_thread_info()->cpu)
=20
-extern void smp_fill_in_sib_core_maps(void);
-extern void cpu_play_dead(void);
+void smp_fill_in_sib_core_maps(void);
+void cpu_play_dead(void);
=20
-extern void smp_fetch_global_regs(void);
-extern void smp_fetch_global_pmu(void);
+void smp_fetch_global_regs(void);
+void smp_fetch_global_pmu(void);
=20
 struct seq_file;
 void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
=20
 #ifdef CONFIG_HOTPLUG_CPU
-extern int __cpu_disable(void);
-extern void __cpu_die(unsigned int cpu);
+int __cpu_disable(void);
+void __cpu_die(unsigned int cpu);
 #endif
=20
 #endif /* !(__ASSEMBLY__) */
diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spi=
tfire.h
index 6b67e50..3fc58691 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -62,7 +62,7 @@ extern enum ultra_tlb_layout tlb_type;
 extern int sun4v_chip_type;
=20
 extern int cheetah_pcache_forced_on;
-extern void cheetah_enable_pcache(void);
+void cheetah_enable_pcache(void);
=20
 #define sparc64_highest_locked_tlbent()	\
 	(tlb_type =3D spitfire ? \
diff --git a/arch/sparc/include/asm/stacktrace.h b/arch/sparc/include/asm/s=
tacktrace.h
index 6cee39a..c30d066 100644
--- a/arch/sparc/include/asm/stacktrace.h
+++ b/arch/sparc/include/asm/stacktrace.h
@@ -1,6 +1,6 @@
 #ifndef _SPARC64_STACKTRACE_H
 #define _SPARC64_STACKTRACE_H
=20
-extern void stack_trace_flush(void);
+void stack_trace_flush(void);
=20
 #endif /* _SPARC64_STACKTRACE_H */
diff --git a/arch/sparc/include/asm/starfire.h b/arch/sparc/include/asm/sta=
rfire.h
index d56ce60a..c100dc2 100644
--- a/arch/sparc/include/asm/starfire.h
+++ b/arch/sparc/include/asm/starfire.h
@@ -11,10 +11,10 @@
=20
 extern int this_is_starfire;
=20
-extern void check_if_starfire(void);
-extern int starfire_hard_smp_processor_id(void);
-extern void starfire_hookup(int);
-extern unsigned int starfire_translate(unsigned long imap, unsigned int up=
aid);
+void check_if_starfire(void);
+int starfire_hard_smp_processor_id(void);
+void starfire_hookup(int);
+unsigned int starfire_translate(unsigned long imap, unsigned int upaid);
=20
 #endif
 #endif
diff --git a/arch/sparc/include/asm/string_32.h b/arch/sparc/include/asm/st=
ring_32.h
index 12f6785..69974e9 100644
--- a/arch/sparc/include/asm/string_32.h
+++ b/arch/sparc/include/asm/string_32.h
@@ -15,7 +15,7 @@
=20
 #ifdef __KERNEL__
=20
-extern void __memmove(void *,const void *,__kernel_size_t);
+void __memmove(void *,const void *,__kernel_size_t);
=20
 #ifndef EXPORT_SYMTAB_STROPS
=20
@@ -40,8 +40,8 @@ extern void __memmove(void *,const void *,__kernel_size_t=
);
 #undef memscan
 #define memscan(__arg0, __char, __arg2)						\
 ({										\
-	extern void *__memscan_zero(void *, size_t);				\
-	extern void *__memscan_generic(void *, int, size_t);			\
+	void *__memscan_zero(void *, size_t);					\
+	void *__memscan_generic(void *, int, size_t);				\
 	void *__retval, *__addr =3D (__arg0);					\
 	size_t __size =3D (__arg2);						\
 										\
@@ -54,14 +54,14 @@ extern void __memmove(void *,const void *,__kernel_size=
_t);
 })
=20
 #define __HAVE_ARCH_MEMCMP
-extern int memcmp(const void *,const void *,__kernel_size_t);
+int memcmp(const void *,const void *,__kernel_size_t);
=20
 /* Now the str*() stuff... */
 #define __HAVE_ARCH_STRLEN
-extern __kernel_size_t strlen(const char *);
+__kernel_size_t strlen(const char *);
=20
 #define __HAVE_ARCH_STRNCMP
-extern int strncmp(const char *, const char *, __kernel_size_t);
+int strncmp(const char *, const char *, __kernel_size_t);
=20
 #endif /* !EXPORT_SYMTAB_STROPS */
=20
diff --git a/arch/sparc/include/asm/string_64.h b/arch/sparc/include/asm/st=
ring_64.h
index 9623bc2..5936b8f 100644
--- a/arch/sparc/include/asm/string_64.h
+++ b/arch/sparc/include/asm/string_64.h
@@ -19,7 +19,7 @@
=20
 /* First the mem*() things. */
 #define __HAVE_ARCH_MEMMOVE
-extern void *memmove(void *, const void *, __kernel_size_t);
+void *memmove(void *, const void *, __kernel_size_t);
=20
 #define __HAVE_ARCH_MEMCPY
 #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
@@ -32,8 +32,8 @@ extern void *memmove(void *, const void *, __kernel_size_=
t);
 #undef memscan
 #define memscan(__arg0, __char, __arg2)					\
 ({									\
-	extern void *__memscan_zero(void *, size_t);			\
-	extern void *__memscan_generic(void *, int, size_t);		\
+	void *__memscan_zero(void *, size_t);				\
+	void *__memscan_generic(void *, int, size_t);			\
 	void *__retval, *__addr =3D (__arg0);				\
 	size_t __size =3D (__arg2);					\
 									\
@@ -46,14 +46,14 @@ extern void *memmove(void *, const void *, __kernel_siz=
e_t);
 })
=20
 #define __HAVE_ARCH_MEMCMP
-extern int memcmp(const void *,const void *,__kernel_size_t);
+int memcmp(const void *,const void *,__kernel_size_t);
=20
 /* Now the str*() stuff... */
 #define __HAVE_ARCH_STRLEN
-extern __kernel_size_t strlen(const char *);
+__kernel_size_t strlen(const char *);
=20
 #define __HAVE_ARCH_STRNCMP
-extern int strncmp(const char *, const char *, __kernel_size_t);
+int strncmp(const char *, const char *, __kernel_size_t);
=20
 #endif /* !EXPORT_SYMTAB_STROPS */
=20
diff --git a/arch/sparc/include/asm/switch_to_32.h b/arch/sparc/include/asm=
/switch_to_32.h
index e32e82b..16f1037 100644
--- a/arch/sparc/include/asm/switch_to_32.h
+++ b/arch/sparc/include/asm/switch_to_32.h
@@ -99,8 +99,8 @@ extern struct thread_info *current_set[NR_CPUS];
 	  "o0", "o1", "o2", "o3",                   "o7");	\
 	} while(0)
=20
-extern void fpsave(unsigned long *fpregs, unsigned long *fsr,
-		   void *fpqueue, unsigned long *fpqdepth);
-extern void synchronize_user_stack(void);
+void fpsave(unsigned long *fpregs, unsigned long *fsr,
+	    void *fpqueue, unsigned long *fpqdepth);
+void synchronize_user_stack(void);
=20
 #endif /* __SPARC_SWITCH_TO_H */
diff --git a/arch/sparc/include/asm/switch_to_64.h b/arch/sparc/include/asm=
/switch_to_64.h
index 8d28480..10e7633 100644
--- a/arch/sparc/include/asm/switch_to_64.h
+++ b/arch/sparc/include/asm/switch_to_64.h
@@ -65,7 +65,7 @@ do {	save_and_clear_fpu();						\
 	  "o0", "o1", "o2", "o3", "o4", "o5",       "o7");		\
 } while(0)
=20
-extern void synchronize_user_stack(void);
-extern void fault_in_user_windows(void);
+void synchronize_user_stack(void);
+void fault_in_user_windows(void);
=20
 #endif /* __SPARC64_SWITCH_TO_64_H */
diff --git a/arch/sparc/include/asm/syscalls.h b/arch/sparc/include/asm/sys=
calls.h
index bf8972a..b0a0db8 100644
--- a/arch/sparc/include/asm/syscalls.h
+++ b/arch/sparc/include/asm/syscalls.h
@@ -3,9 +3,9 @@
=20
 struct pt_regs;
=20
-extern asmlinkage long sparc_do_fork(unsigned long clone_flags,
-				     unsigned long stack_start,
-				     struct pt_regs *regs,
-				     unsigned long stack_size);
+asmlinkage long sparc_do_fork(unsigned long clone_flags,
+			      unsigned long stack_start,
+			      struct pt_regs *regs,
+			      unsigned long stack_size);
=20
 #endif /* _SPARC64_SYSCALLS_H */
diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/tim=
er_32.h
index 13d0035..f8e708a 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -34,11 +34,11 @@ static inline unsigned int timer_value(unsigned int val=
ue)
=20
 extern volatile u32 __iomem *master_l10_counter;
=20
-extern irqreturn_t notrace timer_interrupt(int dummy, void *dev_id);
+irqreturn_t notrace timer_interrupt(int dummy, void *dev_id);
=20
 #ifdef CONFIG_SMP
 DECLARE_PER_CPU(struct clock_event_device, sparc32_clockevent);
-extern void register_percpu_ce(int cpu);
+void register_percpu_ce(int cpu);
 #endif
=20
 #endif /* !(_SPARC_TIMER_H) */
diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/tim=
er_64.h
index 01197d8..fce4150 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -23,8 +23,8 @@ struct sparc64_tick_ops {
=20
 extern struct sparc64_tick_ops *tick_ops;
=20
-extern unsigned long sparc64_get_clock_tick(unsigned int cpu);
-extern void setup_sparc64_timer(void);
-extern void __init time_init(void);
+unsigned long sparc64_get_clock_tick(unsigned int cpu);
+void setup_sparc64_timer(void);
+void __init time_init(void);
=20
 #endif /* _SPARC64_TIMER_H */
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_6=
4.h
index 190e189..4cb392f 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -8,19 +8,19 @@
 #include <asm/mmu_context.h>
=20
 #ifdef CONFIG_SMP
-extern void smp_flush_tlb_pending(struct mm_struct *,
+void smp_flush_tlb_pending(struct mm_struct *,
 				  unsigned long, unsigned long *);
 #endif
=20
 #ifdef CONFIG_SMP
-extern void smp_flush_tlb_mm(struct mm_struct *mm);
+void smp_flush_tlb_mm(struct mm_struct *mm);
 #define do_flush_tlb_mm(mm) smp_flush_tlb_mm(mm)
 #else
 #define do_flush_tlb_mm(mm) __flush_tlb_mm(CTX_HWBITS(mm->context), SECOND=
ARY_CONTEXT)
 #endif
=20
-extern void __flush_tlb_pending(unsigned long, unsigned long, unsigned lon=
g *);
-extern void flush_tlb_pending(void);
+void __flush_tlb_pending(unsigned long, unsigned long, unsigned long *);
+void flush_tlb_pending(void);
=20
 #define tlb_start_vma(tlb, vma) do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/=
tlbflush_64.h
index 3c3c89f..816d820 100644
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -14,9 +14,9 @@ struct tlb_batch {
 	unsigned long vaddrs[TLB_BATCH_NR];
 };
=20
-extern void flush_tsb_kernel_range(unsigned long start, unsigned long end);
-extern void flush_tsb_user(struct tlb_batch *tb);
-extern void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr);
+void flush_tsb_kernel_range(unsigned long start, unsigned long end);
+void flush_tsb_user(struct tlb_batch *tb);
+void flush_tsb_user_page(struct mm_struct *mm, unsigned long vaddr);
=20
 /* TLB flush operations. */
=20
@@ -36,15 +36,15 @@ static inline void flush_tlb_range(struct vm_area_struc=
t *vma,
=20
 #define __HAVE_ARCH_ENTER_LAZY_MMU_MODE
=20
-extern void flush_tlb_pending(void);
-extern void arch_enter_lazy_mmu_mode(void);
-extern void arch_leave_lazy_mmu_mode(void);
+void flush_tlb_pending(void);
+void arch_enter_lazy_mmu_mode(void);
+void arch_leave_lazy_mmu_mode(void);
 #define arch_flush_lazy_mmu_mode()      do {} while (0)
=20
 /* Local cpu only.  */
-extern void __flush_tlb_all(void);
-extern void __flush_tlb_page(unsigned long context, unsigned long vaddr);
-extern void __flush_tlb_kernel_range(unsigned long start, unsigned long en=
d);
+void __flush_tlb_all(void);
+void __flush_tlb_page(unsigned long context, unsigned long vaddr);
+void __flush_tlb_kernel_range(unsigned long start, unsigned long end);
=20
 #ifndef CONFIG_SMP
=20
@@ -60,8 +60,8 @@ static inline void global_flush_tlb_page(struct mm_struct=
 *mm, unsigned long vad
=20
 #else /* CONFIG_SMP */
=20
-extern void smp_flush_tlb_kernel_range(unsigned long start, unsigned long =
end);
-extern void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr);
+void smp_flush_tlb_kernel_range(unsigned long start, unsigned long end);
+void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr);
=20
 #define flush_tlb_kernel_range(start, end) \
 do {	flush_tsb_kernel_range(start,end); \
diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/=
topology_64.h
index a2d10fc..ed8f071 100644
--- a/arch/sparc/include/asm/topology_64.h
+++ b/arch/sparc/include/asm/topology_64.h
@@ -18,7 +18,7 @@ static inline int cpu_to_node(int cpu)
=20
 struct pci_bus;
 #ifdef CONFIG_PCI
-extern int pcibus_to_node(struct pci_bus *pbus);
+int pcibus_to_node(struct pci_bus *pbus);
 #else
 static inline int pcibus_to_node(struct pci_bus *pbus)
 {
diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/t=
rap_block.h
index 7e26b2d..6fd4436 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -51,11 +51,11 @@ struct trap_per_cpu {
 	unsigned long		__per_cpu_base;
 } __attribute__((aligned(64)));
 extern struct trap_per_cpu trap_block[NR_CPUS];
-extern void init_cur_cpu_trap(struct thread_info *);
-extern void setup_tba(void);
+void init_cur_cpu_trap(struct thread_info *);
+void setup_tba(void);
 extern int ncpus_probed;
=20
-extern unsigned long real_hard_smp_processor_id(void);
+unsigned long real_hard_smp_processor_id(void);
=20
 struct cpuid_patch_entry {
 	unsigned int	addr;
diff --git a/arch/sparc/include/asm/uaccess.h b/arch/sparc/include/asm/uacc=
ess.h
index 0167d26..bd56c28 100644
--- a/arch/sparc/include/asm/uaccess.h
+++ b/arch/sparc/include/asm/uaccess.h
@@ -9,6 +9,6 @@
 #define user_addr_max() \
 	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
=20
-extern long strncpy_from_user(char *dest, const char __user *src, long cou=
nt);
+long strncpy_from_user(char *dest, const char __user *src, long count);
=20
 #endif
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/u=
access_32.h
index 53a28dd..9634d08 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -78,9 +78,9 @@ struct exception_table_entry
 };
=20
 /* Returns 0 if exception not found and fixup otherwise.  */
-extern unsigned long search_extables_range(unsigned long addr, unsigned lo=
ng *g2);
+unsigned long search_extables_range(unsigned long addr, unsigned long *g2);
=20
-extern void __ret_efault(void);
+void __ret_efault(void);
=20
 /* Uh, these should become the main single-value transfer routines..
  * They automatically use the right size if we just have the right
@@ -152,7 +152,7 @@ __asm__ __volatile__(							\
        : "=3D&r" (ret) : "r" (x), "m" (*__m(addr)),			\
 	 "i" (-EFAULT))
=20
-extern int __put_user_bad(void);
+int __put_user_bad(void);
=20
 #define __get_user_check(x,addr,size,type) ({ \
 register int __gu_ret; \
@@ -244,9 +244,9 @@ __asm__ __volatile__(							\
 	".previous\n\t"							\
        : "=3D&r" (x) : "m" (*__m(addr)), "i" (retval))
=20
-extern int __get_user_bad(void);
+int __get_user_bad(void);
=20
-extern unsigned long __copy_user(void __user *to, const void __user *from,=
 unsigned long size);
+unsigned long __copy_user(void __user *to, const void __user *from, unsign=
ed long size);
=20
 static inline unsigned long copy_to_user(void __user *to, const void *from=
, unsigned long n)
 {
@@ -306,8 +306,8 @@ static inline unsigned long clear_user(void __user *add=
r, unsigned long n)
 		return n;
 }
=20
-extern __must_check long strlen_user(const char __user *str);
-extern __must_check long strnlen_user(const char __user *str, long n);
+__must_check long strlen_user(const char __user *str);
+__must_check long strnlen_user(const char __user *str, long n);
=20
 #endif  /* __ASSEMBLY__ */
=20
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/u=
access_64.h
index ad7e178..c990a5e 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -76,8 +76,8 @@ struct exception_table_entry {
         unsigned int insn, fixup;
 };
=20
-extern void __ret_efault(void);
-extern void __retl_efault(void);
+void __ret_efault(void);
+void __retl_efault(void);
=20
 /* Uh, these should become the main single-value transfer routines..
  * They automatically use the right size if we just have the right
@@ -134,7 +134,7 @@ __asm__ __volatile__(							\
        : "=3Dr" (ret) : "r" (x), "r" (__m(addr)),				\
 	 "i" (-EFAULT))
=20
-extern int __put_user_bad(void);
+int __put_user_bad(void);
=20
 #define __get_user_nocheck(data,addr,size,type) ({ \
 register int __gu_ret; \
@@ -204,13 +204,13 @@ __asm__ __volatile__(							\
 	".previous\n\t"							\
        : "=3Dr" (x) : "r" (__m(addr)), "i" (retval))
=20
-extern int __get_user_bad(void);
+int __get_user_bad(void);
=20
-extern unsigned long __must_check ___copy_from_user(void *to,
-						    const void __user *from,
-						    unsigned long size);
-extern unsigned long copy_from_user_fixup(void *to, const void __user *fro=
m,
-					  unsigned long size);
+unsigned long __must_check ___copy_from_user(void *to,
+					     const void __user *from,
+					     unsigned long size);
+unsigned long copy_from_user_fixup(void *to, const void __user *from,
+				   unsigned long size);
 static inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long size)
 {
@@ -223,11 +223,11 @@ copy_from_user(void *to, const void __user *from, uns=
igned long size)
 }
 #define __copy_from_user copy_from_user
=20
-extern unsigned long __must_check ___copy_to_user(void __user *to,
-						  const void *from,
-						  unsigned long size);
-extern unsigned long copy_to_user_fixup(void __user *to, const void *from,
-					unsigned long size);
+unsigned long __must_check ___copy_to_user(void __user *to,
+					   const void *from,
+					   unsigned long size);
+unsigned long copy_to_user_fixup(void __user *to, const void *from,
+				 unsigned long size);
 static inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long size)
 {
@@ -239,11 +239,11 @@ copy_to_user(void __user *to, const void *from, unsig=
ned long size)
 }
 #define __copy_to_user copy_to_user
=20
-extern unsigned long __must_check ___copy_in_user(void __user *to,
-						  const void __user *from,
-						  unsigned long size);
-extern unsigned long copy_in_user_fixup(void __user *to, void __user *from,
-					unsigned long size);
+unsigned long __must_check ___copy_in_user(void __user *to,
+					   const void __user *from,
+					   unsigned long size);
+unsigned long copy_in_user_fixup(void __user *to, void __user *from,
+				 unsigned long size);
 static inline unsigned long __must_check
 copy_in_user(void __user *to, void __user *from, unsigned long size)
 {
@@ -255,20 +255,20 @@ copy_in_user(void __user *to, void __user *from, unsi=
gned long size)
 }
 #define __copy_in_user copy_in_user
=20
-extern unsigned long __must_check __clear_user(void __user *, unsigned lon=
g);
+unsigned long __must_check __clear_user(void __user *, unsigned long);
=20
 #define clear_user __clear_user
=20
-extern __must_check long strlen_user(const char __user *str);
-extern __must_check long strnlen_user(const char __user *str, long n);
+__must_check long strlen_user(const char __user *str);
+__must_check long strnlen_user(const char __user *str, long n);
=20
 #define __copy_to_user_inatomic __copy_to_user
 #define __copy_from_user_inatomic __copy_from_user
=20
 struct pt_regs;
-extern unsigned long compute_effective_address(struct pt_regs *,
-					       unsigned int insn,
-					       unsigned int rd);
+unsigned long compute_effective_address(struct pt_regs *,
+					unsigned int insn,
+					unsigned int rd);
=20
 #endif  /* __ASSEMBLY__ */
=20
diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index 432afa8..e0f6c39 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -372,14 +372,14 @@ do {	if (vio->debug & VIO_DEBUG_##TYPE) \
 		       vio->vdev->channel_id, ## a); \
 } while (0)
=20
-extern int __vio_register_driver(struct vio_driver *drv, struct module *ow=
ner,
+int __vio_register_driver(struct vio_driver *drv, struct module *owner,
 				 const char *mod_name);
 /*
  * vio_register_driver must be a macro so that KBUILD_MODNAME can be expan=
ded
  */
 #define vio_register_driver(driver)		\
 	__vio_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
-extern void vio_unregister_driver(struct vio_driver *drv);
+void vio_unregister_driver(struct vio_driver *drv);
=20
 static inline struct vio_driver *to_vio_driver(struct device_driver *drv)
 {
@@ -391,21 +391,21 @@ static inline struct vio_dev *to_vio_dev(struct devic=
e *dev)
 	return container_of(dev, struct vio_dev, dev);
 }
=20
-extern int vio_ldc_send(struct vio_driver_state *vio, void *data, int len);
-extern void vio_link_state_change(struct vio_driver_state *vio, int event);
-extern void vio_conn_reset(struct vio_driver_state *vio);
-extern int vio_control_pkt_engine(struct vio_driver_state *vio, void *pkt);
-extern int vio_validate_sid(struct vio_driver_state *vio,
-			    struct vio_msg_tag *tp);
-extern u32 vio_send_sid(struct vio_driver_state *vio);
-extern int vio_ldc_alloc(struct vio_driver_state *vio,
-			 struct ldc_channel_config *base_cfg, void *event_arg);
-extern void vio_ldc_free(struct vio_driver_state *vio);
-extern int vio_driver_init(struct vio_driver_state *vio, struct vio_dev *v=
dev,
-			   u8 dev_class, struct vio_version *ver_table,
-			   int ver_table_size, struct vio_driver_ops *ops,
-			   char *name);
-
-extern void vio_port_up(struct vio_driver_state *vio);
+int vio_ldc_send(struct vio_driver_state *vio, void *data, int len);
+void vio_link_state_change(struct vio_driver_state *vio, int event);
+void vio_conn_reset(struct vio_driver_state *vio);
+int vio_control_pkt_engine(struct vio_driver_state *vio, void *pkt);
+int vio_validate_sid(struct vio_driver_state *vio,
+		     struct vio_msg_tag *tp);
+u32 vio_send_sid(struct vio_driver_state *vio);
+int vio_ldc_alloc(struct vio_driver_state *vio,
+		  struct ldc_channel_config *base_cfg, void *event_arg);
+void vio_ldc_free(struct vio_driver_state *vio);
+int vio_driver_init(struct vio_driver_state *vio, struct vio_dev *vdev,
+		    u8 dev_class, struct vio_version *ver_table,
+		    int ver_table_size, struct vio_driver_ops *ops,
+		    char *name);
+
+void vio_port_up(struct vio_driver_state *vio);
=20
 #endif /* _SPARC64_VIO_H */
diff --git a/arch/sparc/include/asm/visasm.h b/arch/sparc/include/asm/visas=
m.h
index 39ca301..b266737 100644
--- a/arch/sparc/include/asm/visasm.h
+++ b/arch/sparc/include/asm/visasm.h
@@ -57,7 +57,8 @@ static inline void save_and_clear_fpu(void) {
 "		" : : "i" (FPRS_FEF|FPRS_DU) :
 		"o5", "g1", "g2", "g3", "g7", "cc");
 }
-extern int vis_emul(struct pt_regs *, unsigned int);
+
+int vis_emul(struct pt_regs *, unsigned int);
 #endif
=20
 #endif /* _SPARC64_ASI_H */
diff --git a/arch/sparc/include/asm/xor_64.h b/arch/sparc/include/asm/xor_6=
4.h
index ee8edc6..50c8828 100644
--- a/arch/sparc/include/asm/xor_64.h
+++ b/arch/sparc/include/asm/xor_64.h
@@ -20,13 +20,13 @@
=20
 #include <asm/spitfire.h>
=20
-extern void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
-extern void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *);
-extern void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *, unsigned long *);
-extern void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
-		      unsigned long *, unsigned long *, unsigned long *);
+void xor_vis_2(unsigned long, unsigned long *, unsigned long *);
+void xor_vis_3(unsigned long, unsigned long *, unsigned long *,
+	       unsigned long *);
+void xor_vis_4(unsigned long, unsigned long *, unsigned long *,
+	       unsigned long *, unsigned long *);
+void xor_vis_5(unsigned long, unsigned long *, unsigned long *,
+	       unsigned long *, unsigned long *, unsigned long *);
=20
 /* XXX Ugh, write cheetah versions... -DaveM */
=20
@@ -38,13 +38,13 @@ static struct xor_block_template xor_block_VIS =3D {
         .do_5	=3D xor_vis_5,
 };
=20
-extern void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
-extern void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *);
-extern void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *, unsigned long *);
-extern void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
-			  unsigned long *, unsigned long *, unsigned long *);
+void xor_niagara_2(unsigned long, unsigned long *, unsigned long *);
+void xor_niagara_3(unsigned long, unsigned long *, unsigned long *,
+		   unsigned long *);
+void xor_niagara_4(unsigned long, unsigned long *, unsigned long *,
+		   unsigned long *, unsigned long *);
+void xor_niagara_5(unsigned long, unsigned long *, unsigned long *,
+		   unsigned long *, unsigned long *, unsigned long *);
=20
 static struct xor_block_template xor_block_niagara =3D {
         .name	=3D "Niagara",
--=20
1.9.0

