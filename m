From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 27 Nov 2015 14:26:16 +0000
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in NMI
Message-Id: <CAMo8BfJKrrCxhHFEgOrB+KgttjZOSKO1a=FMdEw=YcHa2KDCqw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-2-git-send-email-pmladek@suse.com>
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Peter,

On Fri, Nov 27, 2015 at 2:09 PM, Petr Mladek <pmladek@suse.com> wrote:
> printk() takes some locks and could not be used a safe way in NMI
> context.
>
> The chance of a deadlock is real especially when printing
> stacks from all CPUs. This particular problem has been addressed
> on x86 by the commit a9edc8809328 ("x86/nmi: Perform a safe NMI stack
> trace on all CPUs").
>
> This patch reuses most of the code and makes it generic. It is
> useful for all messages and architectures that support NMI.
>
> The alternative printk_func is set when entering and is reseted when
> leaving NMI context. It queues IRQ work to copy the messages into
> the main ring buffer in a safe context.
>
> __printk_nmi_flush() copies all available messages and reset
> the buffer. Then we could use a simple cmpxchg operations to
> get synchronized with writers. There is also used a spinlock
> to get synchronized with other flushers.
>
> We do not longer use seq_buf because it depends on external lock.
> It would be hard to make all supported operations safe for
> a lockless use. It would be confusing and error prone to
> make only some operations safe.
>
> The code is put into separate printk/nmi.c as suggested by
> Steven Rostedt. It needs a per-CPU buffer and is compiled only
> on architectures that call nmi_enter(). This is achieved by
> the new HAVE_NMI Kconfig flag.
>
> One exception is arm where the deferred printing is used for
> printing backtraces even without NMI. For this purpose,
> we define NEED_PRINTK_NMI Kconfig flag. The alternative
> printk_func is explicitly set when IPI_CPU_BACKTRACE is
> handled.
>
> Another exception is Xtensa architecture that uses just a
> fake NMI.

It's called fake because it's actually maskable, but sometimes
it is safe to use it as NMI (when there are no other IRQs at the
same priority level and that level equals EXCM level). That
condition is checked in arch/xtensa/include/asm/processor.h
So 'fake' here is to avoid confusion with real NMI that exists
on xtensa (and is not currently used in linux), otherwise code
that runs in fake NMI must follow the NMI rules.

To make xtensa compatible with your change we can add a
choice whether fake NMI should be used to kconfig. It can
then set HAVE_NMI accordingly. I'll post a patch for xtensa.

-- 
Thanks.
-- Max
