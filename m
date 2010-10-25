From: Namhyung Kim <namhyung@gmail.com>
Date: Mon, 25 Oct 2010 16:31:19 +0000
Subject: Re: [PATCH 2/3] sparc32: remove CONFIG_HAVE_PERF_EVENTS option
Message-Id: <1288024279.1689.23.camel@leonhard>
List-Id: <sparclinux.vger.kernel.org>
References: <1288021958-3130-1-git-send-email-namhyung@gmail.com>
	 <1288021958-3130-2-git-send-email-namhyung@gmail.com>
	 <20101025.085937.226775583.davem@davemloft.net>
In-Reply-To: <20101025.085937.226775583.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

2010-10-25 (=EC=9B=94), 08:59 -0700, David Miller:
> From: Namhyung Kim <namhyung@gmail.com>
> Date: Tue, 26 Oct 2010 00:52:37 +0900
>=20
> > Remove HAVE_PERF_EVENTS and PERF_USE_VMALLOC under config
> > SPARC because they're under SPARC64 too. Supporting
> > perf_event needs atomic64 operations but AFAIK sparc32
> > doesn't provide them, CMIIW. ;-) Also removes redundant
> > HAVE_IRQ_WORK line.
> >=20
> > Signed-off-by: Namhyung Kim <namhyung@gmail.com>
>=20
> The generic non-hw perf event stuff builds fine on sparc32,
> please don't remove this unless you have a legitimate build
> failure to report and fix.
>=20
> Even if sparc32 doesn't provide atomic64_t support, it very
> easily could do so using include/asm-generic/atomic64.h which
> implements them using spinlocks.

Now I see following build failure without this patch. Maybe some work is
needed to deal with atomic64_t. I'll try to prepare for it soon. Thanks.


  CC      arch/sparc/kernel/setup_32.o
In file included from arch/sparc/include/asm/local64.h:1:0,
                 from include/linux/perf_event.h:465,
                 from include/linux/ftrace_event.h:8,
                 from include/trace/syscall.h:6,
                 from include/linux/syscalls.h:76,
                 from arch/sparc/kernel/setup_32.c:23:
include/asm-generic/local64.h:62:2: error: expected
                            specifier-qualifier-list before 'atomic64_t'
In file included from include/linux/ftrace_event.h:8:0,
                 from include/trace/syscall.h:6,
                 from include/linux/syscalls.h:76,
                 from arch/sparc/kernel/setup_32.c:23:
include/linux/perf_event.h:722:2: error: expected
                            specifier-qualifier-list before 'atomic64_t'
include/linux/perf_event.h: In function 'perf_fetch_caller_regs':
include/linux/perf_event.h:1004:2: error: 'struct pt_regs' has no member
                                           named 'tstate'
include/linux/perf_event.h:1004:2: error: 'struct pt_regs' has no member
                                           named 'tpc'
include/linux/perf_event.h:1004:2: error: 'struct pt_regs' has no member
                                           named 'tnpc'
include/linux/perf_event.h:1004:2: error: 'struct pt_regs' has no member
                                           named 'tpc'
make[3]: *** [arch/sparc/kernel/setup_32.o] Error 1
make[2]: *** [arch/sparc/kernel] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2


--=20
Regards,
Namhyung Kim


