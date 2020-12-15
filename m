From: Guo Ren <guoren@kernel.org>
Date: Tue, 15 Dec 2020 06:09:03 +0000
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-Id: <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de> <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
In-Reply-To: <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Davidlohr Bueso <dave@stgolabs.net>, Elena Reshetova <elena.reshetova@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

Hi Arnd,

On Mon, Dec 14, 2020 at 9:15 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, Dec 12, 2020 at 9:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sat, Dec 12 2020 at 13:26, Marco Elver wrote:
> > > On Thu, Mar 07, 2019 at 10:14AM +0100, Arnd Bergmann wrote:
> > >> -static void __init futex_detect_cmpxchg(void)
> > >> +static noinline void futex_detect_cmpxchg(void)
> > >>  {
> > >>  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> > >>      u32 curval;
> > >
> > > What ever happened to this patch?
> >
> > It obviously fell through the cracks.
> >
> > > I'm seeing this again with the attached config + next-20201211 (for
> > > testing https://bugs.llvm.org/show_bug.cgi?idH492). Had to apply this
> > > patch to build the kernel.
> >
> > What really bothers me is to remove the __init from a function which is
> > clearly only used during init. And looking deeper it's simply a hack.
> >
> > This function is only needed when an architecture has to runtime
> > discover whether the CPU supports it or not. ARM has unconditional
> > support for this, so the obvious thing to do is the below.
> >
>
> Ah perfect, that is clearly the right solution here.
>
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -86,6 +86,7 @@ config ARM
> >         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >         select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> >         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > +       select HAVE_FUTEX_CMPXCHG if FUTEX
> >         select HAVE_GCC_PLUGINS
> >         select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
> >         select HAVE_IDE if PCI || ISA || PCMCIA
>
> I had a look at what other architectures always implement
> futex_atomic_cmpxchg_inatomic() or can use the asm-generic non-SMP version,
> and I found that it's pretty much all of them, the odd ones being just sparc32
> and csky, which use asm-generic/futex.h but do have an SMP option,
> as well as xtensa
>
> I would guess that for csky, this is a mistake, as the architecture is fairly
> new and should be able to implement it. Not sure about sparc32.

The c610, c807, c810 don't support SMP, so futex_cmpxchg_enabled = 1
with asm-generic's implementation.
For c860, there is no HAVE_FUTEX_CMPXCHG and cmpxchg_inatomic/inuser
implementation, so futex_cmpxchg_enabled = 0.

Thx for point it out, we'll implement cmpxchg_inatomic/inuser for C860
and still use asm-generic for non-smp CPUs:

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index a2189c0..e968c58 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -49,6 +49,7 @@ config CSKY
        select HAVE_FUNCTION_TRACER
        select HAVE_FUNCTION_GRAPH_TRACER
        select HAVE_FUNCTION_ERROR_INJECTION
+       select HAVE_FUTEX_CMPXCHG if FUTEX && SMP
        select HAVE_FTRACE_MCOUNT_RECORD
        select HAVE_KERNEL_GZIP
        select HAVE_KERNEL_LZO
diff --git a/arch/csky/include/asm/futex.h b/arch/csky/include/asm/futex.h
new file mode 100644
index 00000000..29275e8
--- /dev/null
+++ b/arch/csky/include/asm/futex.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_CSKY_FUTEX_H
+#define __ASM_CSKY_FUTEX_H
+
+#ifndef CONFIG_SMP
+#include <asm-generic/futex.h>
+#else
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <linux/errno.h>
+
+static inline int
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+{
+       int oldval = 0, ret = 0;
+
+       if (!access_ok(uaddr, sizeof(u32)))
+               return -EFAULT;
+
+       <...>
+
+       return ret;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+                             u32 oldval, u32 newval)
+{
+       int ret = 0;
+       u32 val;
+       uintptr_t tmp;
+
+       if (!access_ok(uaddr, sizeof(u32)))
+               return -EFAULT;
+
+       <...>
+
+       return ret;
+}
+#endif
+#endif /* __ASM_CSKY_FUTEX_H */
-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
