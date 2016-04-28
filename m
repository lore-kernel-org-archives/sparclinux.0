From: "George Spelvin" <linux@horizon.com>
Date: Thu, 28 Apr 2016 16:48:56 +0000
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
Message-Id: <20160428164856.10120.qmail@ns.horizon.com>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Another few comments:

1. Would ARCH_HAS_FAST_FFS involve fewer changes than CPU_NO_EFFICIENT_FFS?
   
   Rather than updating all the Kconfig files, it could be #defined in
   the arch/*/asm/bitops.h files where the __ffs macro is defined.  E.g.

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index 4bdfbd44..c9c307a8 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -333,6 +333,7 @@ static inline unsigned long ffz(unsigned long word)
 static inline unsigned long __ffs(unsigned long word)
 {
 #if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
+#define ARCH_HAS_FAST_FFS 1
 	/* Whee.  EV67 can calculate it directly.  */
 	return __kernel_cttz(word);
 #else

Looking at the available architectures (list below), it looks like we
have 9 with fast __ffs, 13 without, and 7 where it depends on the model.
Three of the architectures without could have one written.

In terms of code changes, ARCH_HAS_SLOW_FFS would be slightly smaller,
inserting it into the asm-generic version and the few arch-specific
versions (marked "NO" below) which have optimized but bit-at-a-time code.

__ffs on the available architectures:
	Alpha: sometimes (CONFIG_ALPHA_EV6, CONFIG_ALPHA_EV67)
	ARC: sometimes (!CONFIG_ISA_ARCOMPACT)
	ARM: sometimes (V5+)
	ARM64: NO, could be written using RBIT and CLZ
	AVR: yes
	Blackfin: NO, could be written using hweight()
	C6x: yes
	CRIS: NO
	FR-V: yes
	H8300: NO
	Hexagon: yes
	IA64: yes
	M32R: NO
	M68k: sometimes
	MetaG: NO
	Microblaze: NO
	MIPS: sometimes
	MN10300: yes
	OpenRISC: NO
	PA-RISC: NO?  Interesting code, but I think it's a net loss.
	PowerPC: yes
	S390: sometimes (CONFIG_HAVE_MARCH_Z9_109_FEATURES)
	Score: NO
	SH: NO
	SPARC: NO
	Tile: NO, could be written using hweight()
	Unicore32: yes
	x86: yes
	Xtensa: sometimes (XCHAL_HAVE_NSA)


2. The documentation could definitely be improved.  If I may humbly
   recommend something like the following.  I think it's particularly
   important to say in the summary line that this is replacing something
   rather than adding (which sets off code bloat alarms).

+Subject: lib: GCD: Use binary GCD algorithm instead of Euclidean
+
+Even on x86 machines with reasonable division hardware, the binary
+algorithm runs about 25% faster (80% the execution time) than the
+division-based Euclidian algorithm.
+
+On platforms like Alpha and ARMv6 where division is a function call to
+emulation code, it's even more significant.
+
+There are two variants of the code here, depending on whether a
+fast __ffs (find least significant set bit) instruction is available.
+This allows the unpredictable branches in the bit-at-a-time shifting
+loop to be eliminated.
+
+If fast __ffs is not available, the "even/odd" GCD variant is used.
+This adds an additional test in the loop to choose between
+(a-b)/4 and (a+b)/4, dividing by 4 each iteration.  If fast __ffs
+is available, this doesn't help.


3. The benchmarking could be made more realistic.  Zhaoxiu Zeng's test
   program uses full-width random inputs.  However, if there is a large
   difference in the size of the inputs, it takes the binary algorithm
   many steps to do what division does in one.
   
   (Aside: I'd use informal address, but I don't know which name to use.
   Are those names in Western given-family order Zhaoxiu ZENG, or Eastern
   family-given order ZHAOXIU Zeng?)

For example, if I benchmark
	gcd(random64(), 1000000)
the binary code is barely faster on a Phenom, and if I drop that to
1000, it's actually 25% slower.  On Ivy Bridge, the binary code is
still consistently faster in both cases.

On a Pentium 4, if anyone cares, the binary code is 2.4x faster
on full-width inputs (32 bits in this case!), 25% faster with a fixed
1,000,000 and about 7% slower with a fixed 1,000.

It still seems like a net win to me, especially as the large speedups
apply to the worst case (so you're saving large*large), while the
slowdowns apply to the best case (you're losing small*small).
But if someone wants to do suggest more realistic benchmark conditions,
it would be interesting.

This entire function isn't actually used in any performance-sensitive
places AFAICT, so it's not very important one way or another, but I
understand the urge.


One way I changed the benchmark program was to eliminate the sleep(1)
calls, bump the iteration count 100-fold, and do two passes over the
list of, discarding the first one.

Without that, the Euclidean algorithm, being the first to run, gets a
huge penalty due to the CPU throttling up in the middle of its run.
