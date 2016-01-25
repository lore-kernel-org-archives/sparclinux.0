From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 25 Jan 2016 22:24:20 +0000
Subject: [PATCH v2 06/16] auditsc: For seccomp events, log syscall compat state using in_compat_syscall
Message-Id: <2c5ac9f83ad077d1f66c9e6469eb73274703f6d1.1453759363.git.luto@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org

Except on SPARC, this is what the code always did.  SPARC compat
seccomp was buggy, although the impact of the bug was limited
because SPARC 32-bit and 64-bit syscall numbers are the same.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/auditsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 195ffaee50b9..7d0e3cf8abe1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2412,8 +2412,8 @@ void __audit_seccomp(unsigned long syscall, long signr, int code)
 		return;
 	audit_log_task(ab);
 	audit_log_format(ab, " sig=%ld arch=%x syscall=%ld compat=%d ip=0x%lx code=0x%x",
-			 signr, syscall_get_arch(), syscall, is_compat_task(),
-			 KSTK_EIP(current), code);
+			 signr, syscall_get_arch(), syscall,
+			 in_compat_syscall(), KSTK_EIP(current), code);
 	audit_log_end(ab);
 }
 
-- 
2.5.0

