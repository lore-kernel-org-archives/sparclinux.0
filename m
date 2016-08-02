From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 10:35:31 +0000
Subject: [PATCH 0028/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802103531.15637-1-baolex.ni@intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, dalias@libc.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, adam.buchbinder@gmail.com, julian.calaby@gmail.com, chuansheng.liu@intel.com, baolex.ni@intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/sparc/kernel/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index fa8e21a..881ba0b 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -163,7 +163,7 @@ static ssize_t store_mmustat_enable(struct device *s,
 	return count;
 }
 
-static DEVICE_ATTR(mmustat_enable, 0644, show_mmustat_enable, store_mmustat_enable);
+static DEVICE_ATTR(mmustat_enable, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, show_mmustat_enable, store_mmustat_enable);
 
 static int mmu_stats_supported;
 
-- 
2.9.2

