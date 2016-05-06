From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 06 May 2016 23:00:41 +0000
Subject: Re: [patch V4] lib: GCD: Use binary GCD algorithm instead of Euclidean
Message-Id: <20160506160041.2b5e47757329c288efaed4fb@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri,  6 May 2016 17:42:42 +0800 zengzhaoxiu@163.com wrote:

> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> The binary GCD algorithm is based on the following facts:
> 	1. If a and b are all evens, then gcd(a,b) = 2 * gcd(a/2, b/2)
> 	2. If a is even and b is odd, then gcd(a,b) = gcd(a/2, b)
> 	3. If a and b are all odds, then gcd(a,b) = gcd((a-b)/2, b) = gcd((a+b)/2, b)
> 
> Even on x86 machines with reasonable division hardware, the binary
> algorithm runs about 25% faster (80% the execution time) than the
> division-based Euclidian algorithm.
> 
> On platforms like Alpha and ARMv6 where division is a function call to
> emulation code, it's even more significant.
> 
> There are two variants of the code here, depending on whether a
> fast __ffs (find least significant set bit) instruction is available.
> This allows the unpredictable branches in the bit-at-a-time shifting
> loop to be eliminated.
> 
> ...
>
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -27,6 +27,7 @@ config ALPHA
>  	select MODULES_USE_ELF_RELA
>  	select ODD_RT_SIGACTION
>  	select OLD_SIGSUSPEND
> +	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
>  	help

argh.  Please don't always put new items at end-of-list.  That's the
perfect way of maximizing the number of patch collisions.  Insert it at
a random position. avoiding the end (if the list isn't alpha-sorted,
which it should be).

<fixes it all up>

>
> ...
>
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -180,6 +180,16 @@
>  #endif
>  #endif
>  
> +/* __builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r */
> +#if !((defined(cpu_has_mips32r1) && cpu_has_mips32r1) || \
> +	  (defined(cpu_has_mips32r2) && cpu_has_mips32r2) || \
> +	  (defined(cpu_has_mips32r6) && cpu_has_mips32r6) || \
> +	  (defined(cpu_has_mips64r1) && cpu_has_mips64r1) || \
> +	  (defined(cpu_has_mips64r2) && cpu_has_mips64r2) || \
> +	  (defined(cpu_has_mips64r6) && cpu_has_mips64r6))
> +#define CONFIG_CPU_NO_EFFICIENT_FFS 1
> +#endif

#defining a CONFIG_ variable is pretty rude - defining these is the
role of the Kconfig system, not of header files macros.

This was easy:

--- a/arch/mips/include/asm/cpu-features.h~lib-gcd-use-binary-gcd-algorithm-instead-of-euclidean-fix
+++ a/arch/mips/include/asm/cpu-features.h
@@ -187,7 +187,7 @@
 	  (defined(cpu_has_mips64r1) && cpu_has_mips64r1) || \
 	  (defined(cpu_has_mips64r2) && cpu_has_mips64r2) || \
 	  (defined(cpu_has_mips64r6) && cpu_has_mips64r6))
-#define CONFIG_CPU_NO_EFFICIENT_FFS 1
+#define CPU_NO_EFFICIENT_FFS 1
 #endif
 
 #ifndef cpu_has_mips_1
--- a/lib/gcd.c~lib-gcd-use-binary-gcd-algorithm-instead-of-euclidean-fix
+++ a/lib/gcd.c
@@ -10,7 +10,7 @@
  * has decent hardware division.
  */
 
-#if !defined(CONFIG_CPU_NO_EFFICIENT_FFS)
+#if !defined(CONFIG_CPU_NO_EFFICIENT_FFS) && !defined(CPU_NO_EFFICIENT_FFS)
 
 /* If __ffs is available, the even/odd algorithm benchmarks slower. */
 unsigned long gcd(unsigned long a, unsigned long b)
_

