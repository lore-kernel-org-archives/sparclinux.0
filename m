From: Roel Kluin <12o3l@tiscali.nl>
Date: Thu, 06 Mar 2008 13:27:36 +0000
Subject: [PATCH] sparc64: aout32_core_dump(): convert strncpy(x, y, sizeof(x))
Message-Id: <47CFF148.8050608@tiscali.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

This patch was not yet tested. Please confirm it's right.
---
strncpy does not append '\0' if the length of the source string equals
the size parameter, strlcpy does.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/sparc64/kernel/binfmt_aout32.c b/arch/sparc64/kernel/binfmt_aout32.c
index 9877f2d..0a63d18 100644
--- a/arch/sparc64/kernel/binfmt_aout32.c
+++ b/arch/sparc64/kernel/binfmt_aout32.c
@@ -100,7 +100,7 @@ static int aout32_core_dump(long signr, struct pt_regs *regs, struct file *file,
 	set_fs(KERNEL_DS);
 	has_dumped = 1;
 	current->flags |= PF_DUMPCORE;
-       	strncpy(dump.u_comm, current->comm, sizeof(dump.u_comm));
+	strlcpy(dump.u_comm, current->comm, sizeof(dump.u_comm));
 	dump.signal = signr;
 	aout_dump_thread(regs, &dump);
 
