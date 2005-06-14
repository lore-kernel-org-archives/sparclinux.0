From: Jakub Bogusz <qboosh@pld-linux.org>
Date: Tue, 14 Jun 2005 19:23:06 +0000
Subject: [PATCH 2.4][SPARC64] fix sys32_utimes(somefile, NULL)
Message-Id: <20050614192306.GC13702@fngna.oyu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

This patch fixes utimes(somefile, NULL) syscalls on sparc64 kernel with
32-bit userland - use of uninitialized value resulted in making random
timestamps, which confused e.g. sudo.
It has been already fixed (by davem) in linux-2.6 tree 30 months ago.

Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.4.31/arch/sparc64/kernel/sys_sparc32.c.orig	2005-06-06 14:55:31.000000000 +0200
+++ linux-2.4.31/arch/sparc64/kernel/sys_sparc32.c	2005-06-14 12:00:15.000000000 +0200
@@ -4267,7 +4267,7 @@
 
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		ret = sys_utimes(kfilename, &ktvs[0]);
+		ret = sys_utimes(kfilename, (tvs ? &ktvs[0] : NULL));
 		set_fs(old_fs);
 
 		putname(kfilename);


-- 
Jakub Bogusz    http://qboosh.cs.net.pl/
