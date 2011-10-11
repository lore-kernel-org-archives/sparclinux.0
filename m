From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 11 Oct 2011 12:18:05 +0000
Subject: [PATCH 3/5] kernel,debug: SPARC KGDB stub strcpy fix
Message-Id: <1318335487-25506-4-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Works aroung the fact that strcpy with a constant string is
converted to memcpy by gcc and that  memcpy in SPARC returns 0.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 kernel/debug/gdbstub.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index a11db95..380753e 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -946,7 +946,8 @@ int gdb_serial_stub(struct kgdb_state *ks)
 		ptr = remcom_out_buffer;
 		*ptr++ = 'T';
 		ptr = pack_hex_byte(ptr, ks->signo);
-		ptr += strlen(strcpy(ptr, "thread:"));
+		strcpy(ptr, "thread:");
+		ptr += strlen(ptr);
 		int_to_threadref(thref, shadow_pid(current->pid));
 		ptr = pack_threadid(ptr, thref);
 		*ptr++ = ';';
-- 
1.6.4.1

