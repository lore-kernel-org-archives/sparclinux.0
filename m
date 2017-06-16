From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Fri, 16 Jun 2017 09:01:34 +0000
Subject: Re: [PATCH] sparc64: Exclude perf user callchain during critical sections
Message-Id: <83df3d3e-a732-3454-1f7c-85c3e9a76a93@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497416757-9894-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1497416757-9894-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> I tried to figure out how x86 handles this, and gave up after some
> time :-)  Can you figure it out?

I've had a look, what I found is that on x86 
event->attr.exclude_callchain_user is not set from the arch/x86/*

But perf unconditionally uses the NMI specific version of copy_from_user 
to prevent perf_callchain_user() to generated a fault:

arch/x86/include/asm/perf_event.h:#define arch_perf_out_copy_user 
copy_from_user_nmi

Where copy_from_user_nmi() is defined as follows:

arch/x86/lib/usercopy.c: /*
arch/x86/lib/usercopy.c:  * We rely on the nested NMI work to allow 
atomic faults from the NMI path; the
arch/x86/lib/usercopy.c:  * nested NMI paths are careful to preserve CR2.
arch/x86/lib/usercopy.c:  */
arch/x86/lib/usercopy.c: unsigned long
arch/x86/lib/usercopy.c: copy_from_user_nmi(void *to, const void __user 
*from, unsigned long n)
arch/x86/lib/usercopy.c: {
arch/x86/lib/usercopy.c:         unsigned long ret;
arch/x86/lib/usercopy.c:
arch/x86/lib/usercopy.c:         if (__range_not_ok(from, n, TASK_SIZE))
arch/x86/lib/usercopy.c:                 return 0;
arch/x86/lib/usercopy.c:
arch/x86/lib/usercopy.c:         /*
arch/x86/lib/usercopy.c:          * Even though this function is 
typically called from NMI/IRQ context
arch/x86/lib/usercopy.c:          * disable pagefaults so that its 
behaviour is consistent even when
arch/x86/lib/usercopy.c:          * called form other contexts.
arch/x86/lib/usercopy.c:          */
arch/x86/lib/usercopy.c:         pagefault_disable();
arch/x86/lib/usercopy.c:         ret = __copy_from_user_inatomic(to, 
from, n);
arch/x86/lib/usercopy.c:         pagefault_enable();
arch/x86/lib/usercopy.c:
arch/x86/lib/usercopy.c:         return ret;
arch/x86/lib/usercopy.c: }
arch/x86/lib/usercopy.c: EXPORT_SYMBOL_GPL(copy_from_user_nmi);

And the kernel also falls back (for other archs) to a version very 
similar to copy_from_user_nmi() where faults are disabled:

kernel/events/internal.h: #ifndef arch_perf_out_copy_user
kernel/events/internal.h: #define arch_perf_out_copy_user 
arch_perf_out_copy_user
kernel/events/internal.h:
kernel/events/internal.h: static inline unsigned long
kernel/events/internal.h: arch_perf_out_copy_user(void *dst, const void 
*src, unsigned long n)
kernel/events/internal.h: {
kernel/events/internal.h:         unsigned long ret;
kernel/events/internal.h:
kernel/events/internal.h:         pagefault_disable();
kernel/events/internal.h:         ret = __copy_from_user_inatomic(dst, 
src, n);
kernel/events/internal.h:         pagefault_enable();
kernel/events/internal.h:
kernel/events/internal.h:         return ret;
kernel/events/internal.h: }
kernel/events/internal.h: #endif
kernel/events/internal.h:
kernel/events/internal.h: DEFINE_OUTPUT_COPY(__output_copy_user, 
arch_perf_out_copy_user)

I believe that's how faults are prevented from perf.

-eric
