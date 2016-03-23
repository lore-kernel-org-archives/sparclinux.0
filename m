From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 23 Mar 2016 22:41:06 +0000
Subject: [Patch V2 0/2] sparc64 support for crash utility
Message-Id: <1458772868-10255-1-git-send-email-dave.kleikamp@oracle.com>
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

V2:
 * Use SIZE(task_struct_flags) instead of just changing ULONG to UINT
 * Put new code in get_idle_threads() inside #ifdef SPARC64

Dave Kleikamp (2):
  sparc64 changes for gdb-7.6
  sparc64 changes

 Makefile            |    9 +-
 configure.c         |   23 +
 defs.h              |  191 ++++++++-
 diskdump.c          |   36 ++-
 gdb-7.6.patch       |   37 ++
 lkcd_vmdump_v2_v3.h |    2 +-
 sparc64.c           | 1186 +++++++++++++++++++++++++++++++++++++++++++++++++++
 symbols.c           |   10 +
 task.c              |   23 +-
 9 files changed, 1508 insertions(+), 9 deletions(-)
 create mode 100644 sparc64.c

