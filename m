From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 26 Jan 2011 16:37:05 +0000
Subject: [PATCH] SPARC/LEON: FPU-FSR only available when FPU present
Message-Id: <1296059825-22822-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/cpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 0dc714f..7925c54 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -324,7 +324,7 @@ void __cpuinit cpu_probe(void)
 	psr = get_psr();
 	put_psr(psr | PSR_EF);
 #ifdef CONFIG_SPARC_LEON
-	fpu_vers = 7;
+	fpu_vers = get_psr() & PSR_EF ? ((get_fsr() >> 17) & 0x7) : 7;
 #else
 	fpu_vers = ((get_fsr() >> 17) & 0x7);
 #endif
-- 
1.5.4

