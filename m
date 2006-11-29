From: Alexey Dobriyan <adobriyan@openvz.org>
Date: Wed, 29 Nov 2006 08:42:09 +0000
Subject: [PATCH] sparc{,64}: propagate ptrace_traceme() return value
Message-Id: <20061129084209.GA10848@localhost.sw.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

ptrace_traceme() consolidation made

	ret = ptrace_traceme();

dead write.

Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 arch/sparc/kernel/ptrace.c   |    5 ++++-
 arch/sparc64/kernel/ptrace.c |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/arch/sparc/kernel/ptrace.c
+++ b/arch/sparc/kernel/ptrace.c
@@ -289,7 +289,10 @@ #endif
 
 	if (request = PTRACE_TRACEME) {
 		ret = ptrace_traceme();
-		pt_succ_return(regs, 0);
+		if (ret < 0)
+			pt_error_return(regs, -ret);
+		else
+			pt_succ_return(regs, 0);
 		goto out;
 	}
 
--- a/arch/sparc64/kernel/ptrace.c
+++ b/arch/sparc64/kernel/ptrace.c
@@ -202,7 +202,10 @@ #ifdef DEBUG_PTRACE
 #endif
 	if (request = PTRACE_TRACEME) {
 		ret = ptrace_traceme();
-		pt_succ_return(regs, 0);
+		if (ret < 0)
+			pt_error_return(regs, -ret);
+		else
+			pt_succ_return(regs, 0);
 		goto out;
 	}
 

