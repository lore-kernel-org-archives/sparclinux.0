From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Sat, 27 Apr 2019 12:52:07 +0000
Subject: [PATCH 26/41] drivers: tty: serial: sunzilog: use dev_info() instead of printk()
Message-Id: <1556369542-13247-27-git-send-email-info@metux.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Using dev_info() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sunzilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index bc7af8b..6285bba 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1489,14 +1489,12 @@ static int zs_probe(struct platform_device *op)
 		}
 		uart_inst++;
 	} else {
-		printk(KERN_INFO "%s: Keyboard at MMIO 0x%llx (irq = %d) "
+		dev_info(&op->dev, "Keyboard at MMIO 0x%llx (irq = %d) "
 		       "is a %s\n",
-		       dev_name(&op->dev),
 		       (unsigned long long) up[0].port.mapbase,
 		       op->archdata.irqs[0], sunzilog_type(&up[0].port));
-		printk(KERN_INFO "%s: Mouse at MMIO 0x%llx (irq = %d) "
+		dev_info(&op->dev, "Mouse at MMIO 0x%llx (irq = %d) "
 		       "is a %s\n",
-		       dev_name(&op->dev),
 		       (unsigned long long) up[1].port.mapbase,
 		       op->archdata.irqs[0], sunzilog_type(&up[1].port));
 		kbm_inst++;
-- 
1.9.1
