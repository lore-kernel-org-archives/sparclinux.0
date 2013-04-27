From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sat, 27 Apr 2013 10:13:16 +0000
Subject: [PATCH] serial: sunsu: add missing platform_driver_unregister() when module exit
Message-Id: <CAPgLHd_4TH7Ur2VWtqHD3puc9eCkfHKEP9dA-ZwnxE8MtpGLww@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

We have registered platform driver when module init, and
need unregister it when module exit.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
no compile test.
---
 drivers/tty/serial/sunsu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 451687c..0d84657 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1592,6 +1592,7 @@ static int __init sunsu_init(void)
 
 static void __exit sunsu_exit(void)
 {
+	platform_driver_unregister(&su_driver);
 	if (sunsu_reg.nr)
 		sunserial_unregister_minors(&sunsu_reg, sunsu_reg.nr);
 }

