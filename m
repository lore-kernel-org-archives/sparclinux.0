From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 08:53:15 +0000
Subject: [PATCH] sparc: remove reg.h from Kbuild
Message-Id: <20090105085315.GA17530@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

remove stale reference from Kbuild.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

The better solution would be to integrate this with the
commit that remove the files - but this is only feasible
if you have not yet pushed out the tree.

	Sam 

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index aeaec45..deeb0fb 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -13,9 +13,6 @@ header-y += perfctr.h
 header-y += psrcompat.h
 header-y += psr.h
 header-y += pstate.h
-header-y += reg.h
-header-y += reg_32.h
-header-y += reg_64.h
 header-y += traps.h
 header-y += uctx.h
 header-y += utrap.h
