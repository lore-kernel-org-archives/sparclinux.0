From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 06 Jan 2009 20:17:42 +0000
Subject: [PATCH] sparc64: refactor code in viohs.c
Message-Id: <20090106201742.GA17714@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The sparc64 allmodconfig build broke due to enabling of the
branch_tracer that does some very clever things with
all if conditions. This caused my gcc 3.4.5 to be so confused that
it emitted a warning:

arch/sparc/kernel/viohs.c: In function `vio_control_pkt_engine':
arch/sparc/kernel/viohs.c:335: warning: 'nver' might be used uninitialized in this function

And with -Werror this broke the build.

Refactor code so it:
1) becomes more readable
2) no longer emit a warning with the branch_tracer enabled

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index 708fa17..aa6ac70 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -337,8 +337,10 @@ static int process_ver_nack(struct vio_driver_state *vio,
 	viodbg(HS, "GOT VERSION NACK maj[%u] min[%u] devclass[%u]\n",
 	       pkt->major, pkt->minor, pkt->dev_class);
 
-	if ((pkt->major = 0 && pkt->minor = 0) ||
-	    !(nver = find_by_major(vio, pkt->major)))
+	if (pkt->major = 0 && pkt->minor = 0)
+		return handshake_failure(vio);
+	nver = find_by_major(vio, pkt->major);
+	if (!nver)
 		return handshake_failure(vio);
 
 	if (send_version(vio, nver->major, nver->minor) < 0)
