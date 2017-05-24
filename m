From: Matt Redfearn <matt.redfearn@imgtec.com>
Date: Wed, 24 May 2017 09:01:39 +0000
Subject: Re: [PATCH 4/7] mips: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
Message-Id: <a870bfb8-a1c8-220e-460c-baa03b3fd554@imgtec.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170523220546.16758-1-palmer@dabbelt.com>
 <20170523220546.16758-5-palmer@dabbelt.com>
In-Reply-To: <20170523220546.16758-5-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Palmer Dabbelt <palmer@dabbelt.com>, monstr@monstr.eu, ralf@linux-mips.org, liqin.linux@gmail.com, lennox.wu@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Palmer,


On 23/05/17 23:05, Palmer Dabbelt wrote:
> These files are functionally identical to the shared copies that I
> recently added.
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>   arch/mips/Kconfig       |  1 +
>   arch/mips/lib/Makefile  |  2 +-
>   arch/mips/lib/ashldi3.c |  2 +-
>   arch/mips/lib/ashrdi3.c |  2 +-
>   arch/mips/lib/cmpdi2.c  |  2 +-
>   arch/mips/lib/libgcc.h  | 25 -------------------------
>   arch/mips/lib/lshrdi3.c |  2 +-
>   arch/mips/lib/ucmpdi2.c | 21 ---------------------
>   8 files changed, 6 insertions(+), 51 deletions(-)
>   delete mode 100644 arch/mips/lib/libgcc.h
>   delete mode 100644 arch/mips/lib/ucmpdi2.c
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2828ecde133d..b106e6165db0 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -70,6 +70,7 @@ config MIPS
>   	select HAVE_EXIT_THREAD
>   	select HAVE_REGS_AND_STACK_ACCESS_API
>   	select HAVE_COPY_THREAD_TLS
> +	select LIB_UCMPDI3
>   
>   menu "Machine selection"
>   
> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> index 0344e575f522..e38dbafea074 100644
> --- a/arch/mips/lib/Makefile
> +++ b/arch/mips/lib/Makefile
> @@ -15,4 +15,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
>   obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
>   
>   # libgcc-style stuff needed in the kernel
> -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
> +obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o
> diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
> index c3e22053d13e..b3d706155fce 100644
> --- a/arch/mips/lib/ashldi3.c
> +++ b/arch/mips/lib/ashldi3.c
> @@ -1,6 +1,6 @@
>   #include <linux/export.h>
>   
> -#include "libgcc.h"
> +#include <lib/libgcc.h>
>   
>   long long notrace __ashldi3(long long u, word_type b)
>   {
> diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
> index 17456024873d..bca87aca6f5c 100644
> --- a/arch/mips/lib/ashrdi3.c
> +++ b/arch/mips/lib/ashrdi3.c
> @@ -1,6 +1,6 @@
>   #include <linux/export.h>
>   
> -#include "libgcc.h"
> +#include <lib/libgcc.h>
>   
>   long long notrace __ashrdi3(long long u, word_type b)
>   {
> diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
> index 9d849d8743c9..774b109921b5 100644
> --- a/arch/mips/lib/cmpdi2.c
> +++ b/arch/mips/lib/cmpdi2.c
> @@ -1,6 +1,6 @@
>   #include <linux/export.h>
>   
> -#include "libgcc.h"
> +#include <lib/libgcc.h>
>   
>   word_type notrace __cmpdi2(long long a, long long b)
>   {
> diff --git a/arch/mips/lib/libgcc.h b/arch/mips/lib/libgcc.h
> deleted file mode 100644
> index 05909d58e2fe..000000000000
> --- a/arch/mips/lib/libgcc.h
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -#ifndef __ASM_LIBGCC_H
> -#define __ASM_LIBGCC_H
> -
> -#include <asm/byteorder.h>
> -
> -typedef int word_type __attribute__ ((mode (__word__)));
> -
> -#ifdef __BIG_ENDIAN
> -struct DWstruct {
> -	int high, low;
> -};
> -#elif defined(__LITTLE_ENDIAN)
> -struct DWstruct {
> -	int low, high;
> -};
> -#else
> -#error I feel sick.
> -#endif
> -
> -typedef union {
> -	struct DWstruct s;
> -	long long ll;
> -} DWunion;
> -
> -#endif /* __ASM_LIBGCC_H */
> diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
> index 221167c1be55..ceb1a5c14bc8 100644
> --- a/arch/mips/lib/lshrdi3.c
> +++ b/arch/mips/lib/lshrdi3.c
> @@ -1,6 +1,6 @@
>   #include <linux/export.h>
>   
> -#include "libgcc.h"
> +#include <lib/libgcc.h>
>   
>   long long notrace __lshrdi3(long long u, word_type b)
>   {
> diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
> deleted file mode 100644
> index 08067fa538f2..000000000000
> --- a/arch/mips/lib/ucmpdi2.c
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
> -{
> -	const DWunion au = {.ll = a};
> -	const DWunion bu = {.ll = b};
> -
> -	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
> -		return 0;
> -	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
> -		return 2;
> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> -		return 0;
> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> -		return 2;
> -	return 1;
> -}
> -
> -EXPORT_SYMBOL(__ucmpdi2);

This patch doesn't quite match the subject, since it only removes the 
mips specific implementation of __ucmpdi2. The following patch removes 
all of the intrinsics that you added to lib/ from arch/mips/lib. I've 
built & boot tested this on a MIPS pistachio platform.
Note that this patch will require rebasing on linux-next, since it will 
conflict with other changes in arch/mips/Kconfig

Thanks,
Matt

[PATCH] MIPS: Use generic libgcc intrinsics

These routines in arch/mips/lib/ are functionally identical to those
recently added to lib/ so remove them and select the generic ones.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
  arch/mips/Kconfig       |  5 +++++
  arch/mips/lib/Makefile  |  2 +-
  arch/mips/lib/ashldi3.c | 29 -----------------------------
  arch/mips/lib/ashrdi3.c | 31 -------------------------------
  arch/mips/lib/cmpdi2.c  | 27 ---------------------------
  arch/mips/lib/libgcc.h  | 25 -------------------------
  arch/mips/lib/lshrdi3.c | 29 -----------------------------
  arch/mips/lib/ucmpdi2.c | 21 ---------------------
  8 files changed, 6 insertions(+), 163 deletions(-)
  delete mode 100644 arch/mips/lib/ashldi3.c
  delete mode 100644 arch/mips/lib/ashrdi3.c
  delete mode 100644 arch/mips/lib/cmpdi2.c
  delete mode 100644 arch/mips/lib/libgcc.h
  delete mode 100644 arch/mips/lib/lshrdi3.c
  delete mode 100644 arch/mips/lib/ucmpdi2.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2828ecde133d..808626394e8d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -70,6 +70,11 @@ config MIPS
      select HAVE_EXIT_THREAD
      select HAVE_REGS_AND_STACK_ACCESS_API
      select HAVE_COPY_THREAD_TLS
+    select LIB_ASHLDI3
+    select LIB_ASHRDI3
+    select LIB_CMPDI2
+    select LIB_LSHRDI3
+    select LIB_UCMPDI2

  menu "Machine selection"

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 0344e575f522..814e739d6f86 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -15,4 +15,4 @@ obj-$(CONFIG_CPU_R3000)        += r3k_dump_tlb.o
  obj-$(CONFIG_CPU_TX39XX)    += r3k_dump_tlb.o

  # libgcc-style stuff needed in the kernel
-obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o 
ucmpdi2.o
+obj-y += bswapsi.o bswapdi.o
diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
deleted file mode 100644
index c3e22053d13e..000000000000
--- a/arch/mips/lib/ashldi3.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __ashldi3(long long u, word_type b)
-{
-    DWunion uu, w;
-    word_type bm;
-
-    if (b = 0)
-        return u;
-
-    uu.ll = u;
-    bm = 32 - b;
-
-    if (bm <= 0) {
-        w.s.low = 0;
-        w.s.high = (unsigned int) uu.s.low << -bm;
-    } else {
-        const unsigned int carries = (unsigned int) uu.s.low >> bm;
-
-        w.s.low = (unsigned int) uu.s.low << b;
-        w.s.high = ((unsigned int) uu.s.high << b) | carries;
-    }
-
-    return w.ll;
-}
-
-EXPORT_SYMBOL(__ashldi3);
diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
deleted file mode 100644
index 17456024873d..000000000000
--- a/arch/mips/lib/ashrdi3.c
+++ /dev/null
@@ -1,31 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __ashrdi3(long long u, word_type b)
-{
-    DWunion uu, w;
-    word_type bm;
-
-    if (b = 0)
-        return u;
-
-    uu.ll = u;
-    bm = 32 - b;
-
-    if (bm <= 0) {
-        /* w.s.high = 1..1 or 0..0 */
-        w.s.high -            uu.s.high >> 31;
-        w.s.low = uu.s.high >> -bm;
-    } else {
-        const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-        w.s.high = uu.s.high >> b;
-        w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-    }
-
-    return w.ll;
-}
-
-EXPORT_SYMBOL(__ashrdi3);
diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
deleted file mode 100644
index 9d849d8743c9..000000000000
--- a/arch/mips/lib/cmpdi2.c
+++ /dev/null
@@ -1,27 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type notrace __cmpdi2(long long a, long long b)
-{
-    const DWunion au = {
-        .ll = a
-    };
-    const DWunion bu = {
-        .ll = b
-    };
-
-    if (au.s.high < bu.s.high)
-        return 0;
-    else if (au.s.high > bu.s.high)
-        return 2;
-
-    if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-        return 0;
-    else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-        return 2;
-
-    return 1;
-}
-
-EXPORT_SYMBOL(__cmpdi2);
diff --git a/arch/mips/lib/libgcc.h b/arch/mips/lib/libgcc.h
deleted file mode 100644
index 05909d58e2fe..000000000000
--- a/arch/mips/lib/libgcc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef __ASM_LIBGCC_H
-#define __ASM_LIBGCC_H
-
-#include <asm/byteorder.h>
-
-typedef int word_type __attribute__ ((mode (__word__)));
-
-#ifdef __BIG_ENDIAN
-struct DWstruct {
-    int high, low;
-};
-#elif defined(__LITTLE_ENDIAN)
-struct DWstruct {
-    int low, high;
-};
-#else
-#error I feel sick.
-#endif
-
-typedef union {
-    struct DWstruct s;
-    long long ll;
-} DWunion;
-
-#endif /* __ASM_LIBGCC_H */
diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
deleted file mode 100644
index 221167c1be55..000000000000
--- a/arch/mips/lib/lshrdi3.c
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-long long notrace __lshrdi3(long long u, word_type b)
-{
-    DWunion uu, w;
-    word_type bm;
-
-    if (b = 0)
-        return u;
-
-    uu.ll = u;
-    bm = 32 - b;
-
-    if (bm <= 0) {
-        w.s.high = 0;
-        w.s.low = (unsigned int) uu.s.high >> -bm;
-    } else {
-        const unsigned int carries = (unsigned int) uu.s.high << bm;
-
-        w.s.high = (unsigned int) uu.s.high >> b;
-        w.s.low = ((unsigned int) uu.s.low >> b) | carries;
-    }
-
-    return w.ll;
-}
-
-EXPORT_SYMBOL(__lshrdi3);
diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
deleted file mode 100644
index 08067fa538f2..000000000000
--- a/arch/mips/lib/ucmpdi2.c
+++ /dev/null
@@ -1,21 +0,0 @@
-#include <linux/export.h>
-
-#include "libgcc.h"
-
-word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
-{
-    const DWunion au = {.ll = a};
-    const DWunion bu = {.ll = b};
-
-    if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
-        return 0;
-    else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
-        return 2;
-    if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
-        return 0;
-    else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
-        return 2;
-    return 1;
-}
-
-EXPORT_SYMBOL(__ucmpdi2);
-- 
2.7.4


