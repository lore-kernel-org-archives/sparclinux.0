From: Doug Anderson <dianders@chromium.org>
Date: Tue, 04 Feb 2020 22:13:39 +0000
Subject: Re: [sparc64] unable to build kernel after bbfceba15f8 / "kdb: Get rid of confusing diag msg from "r
Message-Id: <CAD=FV=UYbMMr+obKqCvKpfpsJ-T5n6p9cZZsjFwF4kfTKM0Jqw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqyB_g3S0OHkNcyDiS8PX-vGwrtH+3Cp-YNJ7SGj3x6bDg@mail.gmail.com>
In-Reply-To: <CADxRZqyB_g3S0OHkNcyDiS8PX-vGwrtH+3Cp-YNJ7SGj3x6bDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>

Hi,

On Tue, Feb 4, 2020 at 1:14 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> Hello!
>
> After (bisected) bbfceba15f8d1260c328a254efc2b3f2deae4904 got
> mainline, i'm unable to build kernel with the following messages:
>
> ~/linux-2.6$ make -j olddefconfig; make kernel/debug/kdb/
> scripts/kconfig/conf  --olddefconfig Kconfig
> #
> # No change to .config
> #
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
> <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>   CC      kernel/debug/kdb/kdb_main.o
> kernel/debug/kdb/kdb_main.c: In function ‘kdb_rd’:
> kernel/debug/kdb/kdb_main.c:1857:11: error: ‘dbg_reg_def’ undeclared
> (first use in this function); did you mean ‘dbg_reg_def_t’?
>  1857 |   rsize = dbg_reg_def[i].size * 2;
>       |           ^~~~~~~~~~~
>       |           dbg_reg_def_t
> kernel/debug/kdb/kdb_main.c:1857:11: note: each undeclared identifier
> is reported only once for each function it appears in
> kernel/debug/kdb/kdb_main.c:1868:12: error: implicit declaration of
> function ‘dbg_get_reg’ [-Werror=implicit-function-declaration]
>  1868 |    rname = dbg_get_reg(i, &reg8, kdb_current_regs);
>       |            ^~~~~~~~~~~
> kernel/debug/kdb/kdb_main.c:1868:10: warning: assignment to ‘char *’
> from ‘int’ makes pointer from integer without a cast
> [-Wint-conversion]
>  1868 |    rname = dbg_get_reg(i, &reg8, kdb_current_regs);
>       |          ^
> kernel/debug/kdb/kdb_main.c:1874:10: warning: assignment to ‘char *’
> from ‘int’ makes pointer from integer without a cast
> [-Wint-conversion]
>  1874 |    rname = dbg_get_reg(i, &reg16, kdb_current_regs);
>       |          ^
> kernel/debug/kdb/kdb_main.c:1880:10: warning: assignment to ‘char *’
> from ‘int’ makes pointer from integer without a cast
> [-Wint-conversion]
>  1880 |    rname = dbg_get_reg(i, &reg32, kdb_current_regs);
>       |          ^
> kernel/debug/kdb/kdb_main.c:1886:10: warning: assignment to ‘char *’
> from ‘int’ makes pointer from integer without a cast
> [-Wint-conversion]
>  1886 |    rname = dbg_get_reg(i, &reg64, kdb_current_regs);
>       |          ^
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:266: kernel/debug/kdb/kdb_main.o] Error 1
> make[2]: *** [scripts/Makefile.build:503: kernel/debug/kdb] Error 2
> make[1]: *** [scripts/Makefile.build:503: kernel/debug] Error 2
> make: *** [Makefile:1681: kernel] Error 2
>
>
> reversing bbfceba15f8d with current git master branch - makes kernel
> compilable again.
>
> kernel config attached

Argh.  Sorry about this.  :(  I'm not setup with a sparc compiler, but
I've simulated your results on arm64 by just commenting out the
definition of "DBG_MAX_REG_NUM" in "arch/arm64/include/asm/kgdb.h".
Hopefully:

https://lore.kernel.org/r/20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid

...will fix you?

-Doug
