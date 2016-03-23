From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 23 Mar 2016 18:21:32 +0000
Subject: Fwd: [Crash-utility] [PATCH 0/2] sparc64 support for crash utility
Message-Id: <56F2DEAC.2000806@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dave,
I had meant to cc you on this, but it slipped my mind when I sent it.
The patches are in the archive at
https://www.redhat.com/archives/crash-utility/2016-March/msg00022.html
or I can resend them to you and sparclinux if you'd like.

Thanks,
Dave

-------- Forwarded Message --------
Subject: [Crash-utility] [PATCH 0/2] sparc64 support for crash utility
Date: Wed, 23 Mar 2016 11:22:30 -0500
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Reply-To: Discussion list for crash utility usage, maintenance and
development <crash-utility@redhat.com>
To: crash-utility@redhat.com
CC: Karl Volz <karl.volz@oracle.com>

These patches add support for the sparc64 architecture.

This supports running against a live kernel. Diskdump support is
also here, but the crashdump support for the kernel, kexec-tools,
and makedumpfile is still pending.

Initial work was done by Karl Volz with help from Bob Picco.

Dave Kleikamp (2):
  sparc64 changes for gdb-7.6
  sparc64 changes

 Makefile            |    9 +-
 configure.c         |   23 +
 defs.h              |  190 ++++++++-
 diskdump.c          |   36 ++-
 gdb-7.6.patch       |   37 ++
 lkcd_vmdump_v2_v3.h |    2 +-
 sparc64.c           | 1186
+++++++++++++++++++++++++++++++++++++++++++++++++++
 symbols.c           |   10 +
 task.c              |   11 +-
 9 files changed, 1496 insertions(+), 8 deletions(-)
 create mode 100644 sparc64.c

--
Crash-utility mailing list
Crash-utility@redhat.com
https://www.redhat.com/mailman/listinfo/crash-utility


