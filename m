From: Dave Anderson <anderson@redhat.com>
Date: Tue, 26 Apr 2016 18:53:55 +0000
Subject: Re: [Crash-utility] [PATCH V3 0/3] sparc64 support for crash utility
Message-Id: <2074937570.65459996.1461696835798.JavaMail.zimbra@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <118769276.65112900.1461685422983.JavaMail.zimbra@redhat.com>
In-Reply-To: <118769276.65112900.1461685422983.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi Dave,

Your 3-part patchset is queued for crash-7.1.5 in these two commits:

  https://github.com/crash-utility/crash/commit/569002249b1d57162a1e94f529d295828d4e0253
  https://github.com/crash-utility/crash/commit/fd2f8ef41e76c1276d9bbd33dfcff94dd6da9439

I hope to release crash-7.1.5 sometime later this week.

Dave

----- Original Message -----
> These patches add support for the sparc64 architecture.
> 
> This supports running against a live kernel. Diskdump support is
> also here, but the crashdump support for the kernel, kexec-tools,
> and makedumpfile is still pending.
> 
> Initial work was done by Karl Volz with help from Bob Picco.
> 
> V3:
>  * Broke task_struct_flags fix into separate patch
>  * A lot of various cleanups suggested by Sam Ravnborg
>  * Implemented sparc64_dump_machdep_table()
> 
> V2:
>  * Use SIZE(task_struct_flags) instead of just changing ULONG to UINT
>  * Put new code in get_idle_threads() inside #ifdef SPARC64
> 
> Dave Kleikamp (3):
>   Use proper size for task_struct->flags
>   Implement byte-by-byte memory access facilitators
>   crash-utility: Support for sparc64 architecture
> 
>  Makefile            |    9 +-
>  configure.c         |   23 +
>  defs.h              |  180 ++++++++-
>  diskdump.c          |   36 ++-
>  lkcd_vmdump_v2_v3.h |    2 +-
>  sparc64.c           | 1253
>  +++++++++++++++++++++++++++++++++++++++++++++++++++
>  symbols.c           |   10 +
>  task.c              |   23 +-
>  8 files changed, 1527 insertions(+), 9 deletions(-)
>  create mode 100644 sparc64.c
> 
> --
> Crash-utility mailing list
> Crash-utility@redhat.com
> https://www.redhat.com/mailman/listinfo/crash-utility
> 
