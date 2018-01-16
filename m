From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 16 Jan 2018 15:34:33 +0000
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to compat_time.h
Message-Id: <20180116103433.0a1356d3@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
        <20180116021818.24791-3-deepa.kernel@gmail.com>
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: tglx@linutronix.de, john.stultz@linaro.org, linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, acme@kernel.org, benh@kernel.crashing.org, borntraeger@de.ibm.com, catalin.marinas@arm.com, cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net, deller@gmx.de, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com, hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au, oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net, paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org, rric@kernel.org, schwidefsky@de.ibm.com, sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org, sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, will.deacon@arm.com, x86@kernel.org

On Mon, 15 Jan 2018 18:18:10 -0800
Deepa Dinamani <deepa.kernel@gmail.com> wrote:

> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 09ad88572746..db25aa15b705 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> @@ -49,7 +49,7 @@ int ftrace_int3_handler(struct pt_regs *regs);
>  #if !defined(__ASSEMBLY__) && !defined(COMPILE_OFFSETS)
>  
>  #if defined(CONFIG_FTRACE_SYSCALLS) && defined(CONFIG_IA32_EMULATION)
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  
>  /*
>   * Because ia32 syscalls do not map to x86_64 syscall numbers
