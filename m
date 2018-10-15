From: David Miller <davem@davemloft.net>
Date: Mon, 15 Oct 2018 03:26:08 +0000
Subject: [PATCH] sparc64: Make proc_id signed.
Message-Id: <20181014.202608.1653030600732371079.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


So that when it is unset, ie. '-1', userspace can see it
properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/cpudata_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 666d6b5c0440..9c3fc03abe9a 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -28,7 +28,7 @@ typedef struct {
 	unsigned short	sock_id;	/* physical package */
 	unsigned short	core_id;
 	unsigned short  max_cache_id;	/* groupings of highest shared cache */
-	unsigned short	proc_id;	/* strand (aka HW thread) id */
+	signed short	proc_id;	/* strand (aka HW thread) id */
 } cpuinfo_sparc;
 
 DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
-- 
2.19.1
