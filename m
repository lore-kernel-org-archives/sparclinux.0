From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:25:39 +0000
Subject: [PATCH 01/34] sparc32: fix build breakage
Message-Id: <1400275572-17424-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add forward declaration to kernel.h to fix build breakage
in some configurations

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index de9ac1a..8bc2c81 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -27,6 +27,7 @@ static inline unsigned long kimage_addr_to_ra(const char *p)
 
 #ifdef CONFIG_SPARC32
 /* setup_32.c */
+struct linux_romvec;
 void sparc32_start_kernel(struct linux_romvec *rp);
 
 /* cpu.c */
-- 
1.9.0

