From: Robert Reif <reif@earthlink.net>
Date: Sun, 11 May 2008 22:35:19 +0000
Subject: [PATCH] fix sparc32 build
Message-Id: <482774A7.1080104@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040505000709010104070906"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0708041525230.24119@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0708041525230.24119@mtfhpc.demon.co.uk>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040505000709010104070906
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Fix sparc32 build error due to undefined bool type.

CC [M] fs/ocfs2/dlm/userdlm.o
In file included from include/asm/sigcontext.h:6,
from include/asm/signal.h:5,
from include/linux/signal.h:4,
from fs/ocfs2/dlm/userdlm.c:30:
include/asm/ptrace.h:42: error: expected =91=3D=92, =91,=92, =91;=92, =91as=
m=92 or=20
=91__attribute__=92 before =91pt_regs_is_syscall=92
include/asm/ptrace.h:47: error: expected =91=3D=92, =91,=92, =91;=92, =91as=
m=92 or=20
=91__attribute__=92 before =91pt_regs_clear_syscall=92
make[3]: *** [fs/ocfs2/dlm/userdlm.o] Error 1
make[2]: *** [fs/ocfs2/dlm] Error 2
make[1]: *** [fs/ocfs2] Error 2
make: *** [fs] Error 2

Signed-off-by: Robert Reif <reif@earthlink.net>



--------------040505000709010104070906
Content-Type: text/plain;
 name="ptrace.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ptrace.diff.txt"

diff --git a/include/asm-sparc/ptrace.h b/include/asm-sparc/ptrace.h
index 6b5e6ce..0afb867 100644
--- a/include/asm-sparc/ptrace.h
+++ b/include/asm-sparc/ptrace.h
@@ -10,6 +10,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/types.h>
+
 struct pt_regs {
 	unsigned long psr;
 	unsigned long pc;

--------------040505000709010104070906--
