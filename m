From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 14 Jan 2009 07:59:40 +0000
Subject: Re: sparc32 compile error: redefinition of =?UTF-8?Q?=E2=80=98smp?=
Message-Id: <20090113235940.12d856d0.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <496D4274.6000304@earthlink.net>
	<20090113.181039.185575172.davem@davemloft.net>
	<20090113184239.e6b6e68e.akpm@linux-foundation.org>
	<20090113184536.95ebc973.akpm@linux-foundation.org>
	<496D5E19.7040802@earthlink.net>
In-Reply-To: <496D5E19.7040802@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Reif <reif@earthlink.net>
Cc: David Miller <davem@davemloft.net>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, mingo@elte.hu, linux-kernel@vger.kernel.org

On Tue, 13 Jan 2009 22:38:01 -0500 Robert Reif <reif@earthlink.net> wrote:

> This worked:
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 2aebc4c..368227d 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -43,8 +43,10 @@ obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
>  ifeq ($(CONFIG_USE_GENERIC_SMP_HELPERS),y)
>  obj-y += smp.o
>  else
> +ifneq ($(CONFIG_SMP),y)
>  obj-y += up.o
>  endif
> +endif
>  obj-$(CONFIG_SMP) += spinlock.o
>  obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
>  obj-$(CONFIG_PROVE_LOCKING) += spinlock.o

This all can be simplified, can't it?

obj-$(CONFIG_USE_GENERIC_SMP_HELPERS) += smp.o
ifneq ($(CONFIG_SMP),y)
obj-y += up.o
endif

(someone please check my homework - I don't have a good track
record here ;))

--- a/kernel/Makefile~kernel-upc-omit-it-if-smp=y-use_generic_smp_helpers=n
+++ a/kernel/Makefile
@@ -40,9 +40,8 @@ obj-$(CONFIG_RT_MUTEXES) += rtmutex.o
 obj-$(CONFIG_DEBUG_RT_MUTEXES) += rtmutex-debug.o
 obj-$(CONFIG_RT_MUTEX_TESTER) += rtmutex-tester.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
-ifeq ($(CONFIG_USE_GENERIC_SMP_HELPERS),y)
-obj-y += smp.o
-else
+obj-$(CONFIG_USE_GENERIC_SMP_HELPERS) += smp.o
+ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_SMP) += spinlock.o
_

