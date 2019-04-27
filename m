From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Sat, 27 Apr 2019 12:51:46 +0000
Subject: [PATCH 05/41] drivers: tty: serial: dz: use pr_info() instead of incomplete printk()
Message-Id: <1556369542-13247-6-git-send-email-info@metux.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Fix the checkpatch warning:

    WARNING: printk() should include KERN_<LEVEL> facility level
    #934: FILE: dz.c:934:
    +	printk("%s%s\n", dz_name, dz_version);

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/dz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 559d076..e2670c4 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -931,7 +931,7 @@ static int __init dz_init(void)
 	if (IOASIC)
 		return -ENXIO;
 
-	printk("%s%s\n", dz_name, dz_version);
+	pr_info("%s%s\n", dz_name, dz_version);
 
 	dz_init_ports();
 
-- 
1.9.1
