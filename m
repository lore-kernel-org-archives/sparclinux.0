From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Sat, 27 Apr 2019 12:51:45 +0000
Subject: [PATCH 04/41] drivers: tty: serial: dz: fix use fix bare 'unsigned'
Message-Id: <1556369542-13247-5-git-send-email-info@metux.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Fix checkpatch warnings:

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #103: FILE: dz.c:103:
    +static u16 dz_in(struct dz_port *dport, unsigned offset)

    WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #110: FILE: dz.c:110:
    +static void dz_out(struct dz_port *dport, unsigned offset, u16 value)

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/dz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index b3e9313..559d076 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -100,14 +100,14 @@ static inline struct dz_port *to_dport(struct uart_port *uport)
  * ------------------------------------------------------------
  */
 
-static u16 dz_in(struct dz_port *dport, unsigned offset)
+static u16 dz_in(struct dz_port *dport, unsigned int offset)
 {
 	void __iomem *addr = dport->port.membase + offset;
 
 	return readw(addr);
 }
 
-static void dz_out(struct dz_port *dport, unsigned offset, u16 value)
+static void dz_out(struct dz_port *dport, unsigned int offset, u16 value)
 {
 	void __iomem *addr = dport->port.membase + offset;
 
-- 
1.9.1
