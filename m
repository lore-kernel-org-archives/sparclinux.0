From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 15:31:40 +0000
Subject: [PATCH 1/2] sparc32: fix cpuid_patch run-time patching
Message-Id: <20120520153140.GA13857@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From eecbbe31067e738d4342dee9709f14086cd4fbad Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 17:24:20 +0200
Subject: [PATCH 1/2] sparc32: fix cpuid_patch run-time patching

We hang forever when trying to do run-time patching of instructions
identified by the cpuid_patch section

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I tested this by replacing all sun4d code with sun4m code,
and I then modified the sun4m code to be wrong.
With no patching the kernel failed to boot.
With patching the kernel was able to boot after this little fix.

The bug was found when testing the flushi variant in the
following patch - but the bug-fix warranted a dedicated patch.

	Sam

 arch/sparc/kernel/setup_32.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 635df5c..d65b5a1 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -229,6 +229,8 @@ static void __init per_cpu_patch(void)
 		*(unsigned int *) (addr + 0) = insns[0];
 		*(unsigned int *) (addr + 4) = insns[1];
 		*(unsigned int *) (addr + 8) = insns[2];
+
+		p++;
 	}
 #ifdef CONFIG_SMP
 	local_ops->cache_all();
-- 
1.6.0.6

