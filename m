From: Allen <allen.lkml@gmail.com>
Date: Wed, 14 Nov 2018 06:56:27 +0000
Subject: Re: [PATCH v3 0/4] sparc: system call table generation support
Message-Id: <CAOMdWSJ1NiMTThftBysvsntPdRBHN7gq_w19gtzi6KmBKAdz+Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: firoz.khan@linaro.org
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, geert@linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pombredanne@nexb.com, Thomas Gleixner <tglx@linutronix.de>, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org

> Changes since v2:
>  - changed from generic-y to generated-y in Kbuild.
>  - added io_pgetevents entry in the syscall.tbl.
>  - updated the compat system call table.
>
> Changes since v1:
>  - optimized/updated the syscall table generation
>    scripts.
>  - fixed all mixed indentation issues in syscall.tbl.
>  - added "comments" in syscall.tbl.
>
> Firoz Khan (4):
>   sparc: move __IGNORE* entries to non uapi header
>   sparc: add __NR_syscalls along with NR_syscalls
>   sparc: add system call table generation support
>   sparc: generate uapi header and system call table files

Tested and looks fine.

Tested-by: Allen Pais <allen.lkml@gmail.com>

>  arch/sparc/Makefile                      |   3 +
>  arch/sparc/include/asm/Kbuild            |   4 +-
>  arch/sparc/include/asm/unistd.h          |  18 ++
>  arch/sparc/include/uapi/asm/Kbuild       |   2 +
>  arch/sparc/include/uapi/asm/unistd.h     | 426 +------------------------------
>  arch/sparc/kernel/syscalls/Makefile      |  55 ++++
>  arch/sparc/kernel/syscalls/syscall.tbl   | 409 +++++++++++++++++++++++++++++
>  arch/sparc/kernel/syscalls/syscallhdr.sh |  36 +++
>  arch/sparc/kernel/syscalls/syscalltbl.sh |  36 +++
>  arch/sparc/kernel/systbls_32.S           |  81 +-----
>  arch/sparc/kernel/systbls_64.S           | 157 +-----------
>  11 files changed, 572 insertions(+), 655 deletions(-)
>  create mode 100644 arch/sparc/kernel/syscalls/Makefile
>  create mode 100644 arch/sparc/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
>  create mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh
>
> --
> 1.9.1
>


-- 
       - Allen
