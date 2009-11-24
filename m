From: David Miller <davem@davemloft.net>
Date: Tue, 24 Nov 2009 22:21:29 +0000
Subject: [PATCH 3/7]: sunsu: Fix detection of SU ports which are RSC
Message-Id: <20091124.142129.107634104.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


These device nodes are named "rsc-console" and "rsc-control" rather
than 'serial', but the device_type property is 'serial' so we'll
tip off of that for detection.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/serial/sunsu.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index 68d262b..f6511a4 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1517,6 +1517,10 @@ static const struct of_device_id su_match[] = {
 		.name = "serial",
 		.compatible = "su",
 	},
+	{
+		.type = "serial",
+		.compatible = "su",
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, su_match);
@@ -1548,6 +1552,12 @@ static int __init sunsu_init(void)
 				num_uart++;
 		}
 	}
+	for_each_node_by_type(dp, "serial") {
+		if (of_device_is_compatible(dp, "su")) {
+			if (su_get_type(dp) = SU_PORT_PORT)
+				num_uart++;
+		}
+	}
 
 	if (num_uart) {
 		err = sunserial_register_minors(&sunsu_reg, num_uart);
-- 
1.6.5.3

