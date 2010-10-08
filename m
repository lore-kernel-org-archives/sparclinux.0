From: Andres Salomon <dilinger@queued.net>
Date: Fri, 08 Oct 2010 07:43:54 +0000
Subject: [PATCH 1/2 v2] of: move phandle/ihandle into types.h and export to
Message-Id: <20101008004354.13b5b254@debxo>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


We need phandle for some exported sparc headers; of.h isn't an
exported header, and it would be silly to export it when all we
really need is one or two types from it.  Also, later patches
use phandle in structs that are exported to userspace, so export
a __kernel_phandle type.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 include/linux/of.h    |    3 ---
 include/linux/types.h |    7 +++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index cad7cf0..db184dc 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -25,9 +25,6 @@
 
 #ifdef CONFIG_OF
 
-typedef u32 phandle;
-typedef u32 ihandle;
-
 struct property {
 	char	*name;
 	int	length;
diff --git a/include/linux/types.h b/include/linux/types.h
index 01a082f..67a034a 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -178,10 +178,17 @@ typedef __u64 __bitwise __be64;
 typedef __u16 __bitwise __sum16;
 typedef __u32 __bitwise __wsum;
 
+/* Basic openboot/openfirmware types */
+typedef __u32 __kernel_phandle;
+typedef __u32 __kernel_ihandle;
+
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
 typedef unsigned __bitwise__ fmode_t;
 
+typedef __kernel_phandle phandle;
+typedef __kernel_ihandle ihandle;
+
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 typedef u64 phys_addr_t;
 #else
-- 
1.5.6.5

