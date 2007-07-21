From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sat, 21 Jul 2007 14:27:01 +0000
Subject: [PATCH] constify of_platform_driver match_table
Message-Id: <20070722002701.77622474.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, wli@holomorphy.com, ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/of_platform.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Built for PowerPC allmodconfig and ppc64_defconfig and Sparc and Sparc64
defconfig.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 22c3837..448f70b 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -32,7 +32,7 @@ extern struct bus_type of_platform_bus_type;
 struct of_platform_driver
 {
 	const char		*name;
-	struct of_device_id	*match_table;
+	const struct of_device_id	*match_table;
 	struct module		*owner;
 
 	int	(*probe)(struct of_device* dev,
-- 
1.5.2.3

