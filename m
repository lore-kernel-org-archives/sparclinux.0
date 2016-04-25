From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 25 Apr 2016 18:28:05 +0000
Subject: [PATCH V3 0/3] sparc64 support for crash utility
Message-Id: <1461608888-5063-1-git-send-email-dave.kleikamp@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

These patches add support for the sparc64 architecture.

This supports running against a live kernel. Diskdump support is
also here, but the crashdump support for the kernel, kexec-tools,
and makedumpfile is still pending.

Initial work was done by Karl Volz with help from Bob Picco.

V3:
 * Broke task_struct_flags fix into separate patch
 * A lot of various cleanups suggested by Sam Ravnborg
 * Implemented sparc64_dump_machdep_table()

V2:
 * Use SIZE(task_struct_flags) instead of just changing ULONG to UINT
 * Put new code in get_idle_threads() inside #ifdef SPARC64

Dave Kleikamp (3):
  Use proper size for task_struct->flags
  Implement byte-by-byte memory access facilitators
  crash-utility: Support for sparc64 architecture

 Makefile            |    9 +-
 configure.c         |   23 +
 defs.h              |  180 ++++++++-
 diskdump.c          |   36 ++-
 lkcd_vmdump_v2_v3.h |    2 +-
 sparc64.c           | 1253 +++++++++++++++++++++++++++++++++++++++++++++++++++
 symbols.c           |   10 +
 task.c              |   23 +-
 8 files changed, 1527 insertions(+), 9 deletions(-)
 create mode 100644 sparc64.c

