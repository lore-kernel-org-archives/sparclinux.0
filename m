From: Chris Wright <chrisw@sous-sol.org>
Date: Tue, 23 Oct 2007 22:50:38 +0000
Subject: [PATCH] sparc64: pass correct addr in
Message-Id: <20071023225038.GR3660@sequoia.sous-sol.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Looks like the MAP_FIXED case is using the wrong address hint.  I'd expect
the comment "don't mess with it" means pass the request straight on through,
not change the address requested to -ENOMEM.  

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
BTW, just noticed by random code inspection, perhaps I've missed something.

 arch/sparc64/kernel/sys_sparc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc64/kernel/sys_sparc.c b/arch/sparc64/kernel/sys_sparc.c
index 560cb1e..c56573a 100644
--- a/arch/sparc64/kernel/sys_sparc.c
+++ b/arch/sparc64/kernel/sys_sparc.c
@@ -318,7 +318,7 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u
 
 	if (flags & MAP_FIXED) {
 		/* Ok, don't mess with it. */
-		return get_unmapped_area(NULL, addr, len, pgoff, flags);
+		return get_unmapped_area(NULL, orig_addr, len, pgoff, flags);
 	}
 	flags &= ~MAP_SHARED;
 
