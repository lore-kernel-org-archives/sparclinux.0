From: David Long <dave.long@linaro.org>
Date: Fri, 12 Aug 2016 20:24:44 +0000
Subject: [PATCH] Documentation: kprobes: Document jprobes stack copying limitations
Message-Id: <1471033484-2709-1-git-send-email-dave.long@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Some architectures (i.e.: sparc64 and arm64) make reasonable partial stack
duplication for jprobes problematic. Document this.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 Documentation/kprobes.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 1f9b3e2..1f6d45a 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -103,6 +103,16 @@ Note that the probed function's args may be passed on the stack
 or in registers.  The jprobe will work in either case, so long as the
 handler's prototype matches that of the probed function.
 
+Note that in some architectures (e.g.: arm64 and sparc64) the stack
+copy is not done, as the actual location of stacked parameters may be
+outside of a reasonable MAX_STACK_SIZE value and because that location
+cannot be determined by the jprobes code. In this case the jprobes
+user must be careful to make certain the calling signature of the
+function does not cause parameters to be passed on the stack (e.g.:
+more than eight function arguments, an argument of more than sixteen
+bytes, or more than 64 bytes of argument data, depending on
+architecture).
+
 1.3 Return Probes
 
 1.3.1 How Does a Return Probe Work?
-- 
2.5.0

