From: Andreas Larsson <andreas@gaisler.com>
Date: Fri, 05 Dec 2014 09:55:28 +0000
Subject: [PATCH] sparc32,leon: Align ccall_info to prevent unaligned traps on crosscall
Message-Id: <1417773328-10396-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, software@gaisler.com

It is being filled in using std in leon_cross_call.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/leon_smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index ea2bad3..71e16f2 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -368,7 +368,7 @@ static struct smp_funcall {
 	unsigned long arg5;
 	unsigned long processors_in[NR_CPUS];	/* Set when ipi entered. */
 	unsigned long processors_out[NR_CPUS];	/* Set when ipi exited. */
-} ccall_info;
+} ccall_info __attribute__((aligned(8)));
 
 static DEFINE_SPINLOCK(cross_call_lock);
 
-- 
1.7.10.4

