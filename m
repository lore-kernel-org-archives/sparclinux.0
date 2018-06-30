From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 Jun 2018 04:45:10 +0000
Subject: [PATCH] sparc32: cacheflush_32: Declare struct page
Message-Id: <1530333910-31209-1-git-send-email-linux@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Mauro Carvalho Chehab <mchehab@s-opensource.com>

Building allmodconfig images for sparc32 generates warnings such as

arch/sparc/include/asm/cacheflush_32.h:40:37: warning:
	'struct page' declared inside parameter list

This results in odd warnings such as

arch/sparc/include/asm/cacheflush_32.h:40:6: note:
	expected 'struct page *' but argument is of type 'struct page *'

With recent compilers (gcc 5.5.0 and later), this warning turns into
a build error when compiling drivers/staging/media/omap4iss/iss_video.c.

./include/linux/highmem.h: In function 'copy_user_highpage':
./include/linux/highmem.h:233:36: error:
	passing argument 1 of 'sparc_flush_page_to_ram'
				from incompatible pointer type

Declare struct page to fix the problem.

Fixes: 84fc727ed49c ("media: omap4iss: make it build with COMPILE_TEST")
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/include/asm/cacheflush_32.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index fb66094a2c30..acb072c71e42 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -4,6 +4,8 @@
 
 #include <asm/cachetlb_32.h>
 
+struct page;
+
 #define flush_cache_all() \
 	sparc32_cachetlb_ops->cache_all()
 #define flush_cache_mm(mm) \
-- 
2.7.4

