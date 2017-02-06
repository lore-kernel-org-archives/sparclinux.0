From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Mon, 06 Feb 2017 14:32:41 +0000
Subject: [PATCH] sparc64: fix for user probes in high memory
Message-Id: <4e296aa1-f5b2-3d50-ae08-1a9f9cc70a45@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When returning from the user probe code into userspace process, PC & NPC are
truncated to 32 bits.

Due to shared libraries getting loaded very high in the virtual address 
space of
the process, placing a user probe inside a shared library makes the kernel
return into the process at the wrong address, causing it to seg'fault 
most of
the time.

This patch prevents truncating PC and NPC.

Signed-off-by: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Reviewed-by: David Aldridge <david.j.aldridge@oracle.com>
---
  arch/sparc/include/asm/uprobes.h |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/uprobes.h 
b/arch/sparc/include/asm/uprobes.h
index f87aae5..36196c1 100644
--- a/arch/sparc/include/asm/uprobes.h
+++ b/arch/sparc/include/asm/uprobes.h
@@ -42,8 +42,8 @@ struct arch_uprobe {
  };

  struct arch_uprobe_task {
-       u32 saved_tpc;
-       u32 saved_tnpc;
+       u64 saved_tpc;
+       u64 saved_tnpc;
  };

  struct task_struct;
--
1.7.1

