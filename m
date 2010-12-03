From: David Miller <davem@davemloft.net>
Date: Fri, 03 Dec 2010 18:40:55 +0000
Subject: [PATCH 4/9] sparc64: Unexport prom_service_exists().
Message-Id: <20101203.104055.233708672.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Only used by functions in misc_64.c so make it private
to that file.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/oplib_64.h |    1 -
 arch/sparc/prom/misc_64.c         |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index 8441d1a..daf02d3 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -259,7 +259,6 @@ extern int prom_setprop(phandle node, const char *prop_name, char *prop_value,
 			int value_size);
 
 extern phandle prom_inst2pkg(int);
-extern int prom_service_exists(const char *service_name);
 extern void prom_sun4v_guest_soft_state(void);
 
 extern int prom_ihandle2path(int handle, char *buffer, int bufsize);
diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
index d24bc44..b900fdf 100644
--- a/arch/sparc/prom/misc_64.c
+++ b/arch/sparc/prom/misc_64.c
@@ -18,7 +18,7 @@
 #include <asm/system.h>
 #include <asm/ldc.h>
 
-int prom_service_exists(const char *service_name)
+static int prom_service_exists(const char *service_name)
 {
 	unsigned long args[5];
 
-- 
1.7.3.2

