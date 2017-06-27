From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 27 Jun 2017 07:52:00 +0000
Subject: [PATCH] sparc: time: make of_device_ids const.
Message-Id: <d1829888485f7cb11c40cc6518f1252343191405.1498549100.git.arvind.yadav.cs@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, tglx@linutronix.de, john.stultz@linaro.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   1082	   1048	    336	   2466	    9a2	arch/sparc/kernel/time_32.o

File size after constify:
   text	   data	    bss	    dec	    hex	filename
   1482	    632	    336	   2450	    992	arch/sparc/kernel/time_32.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/sparc/kernel/time_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 9f575df..2ce2e7b 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -298,7 +298,7 @@ static int clock_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id clock_match[] = {
+static const struct of_device_id clock_match[] = {
 	{
 		.name = "eeprom",
 	},
-- 
1.9.1

