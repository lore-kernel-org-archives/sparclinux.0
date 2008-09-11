From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 23:46:12 +0000
Subject: Re: 16550 serial support
Message-Id: <20080911.164612.203342133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 12 Sep 2008 01:27:29 +0200

> Oh, I think I have a small clue... the latter four messages come from
> the 8250_pci loading attempt, but the first message is from the 8250 loading
> attempt - which also fails (but does the printk which makes it look all
> right). A standalone attempt reveals:
> 
> % sudo modprobe 8250
> FATAL: Error inserting 8250 (/lib/modules/2.6.27-rc4/kernel/drivers/serial/8250.ko): Device or resource busy
> % 
> 
> That should be EBUSY, and that gets mentioned twice in
> serial8250_request_std_resource() and once in
> serial8250_request_rsa_resource(), after failures of request_mem_region()
> and request_region(). Both of those are macros for __request_region().
> The stuff past that is uncharted territory for me :)

I think it's this platform ISA device it registers in 8250.c

No... I think I see the problem.  Your suspicion about sunsu
appears to be correct.

Both drivers want to register devices using major number TTY_MAJOR
and minor number(s) 64, 65, etc.

So whichever driver gets it first succeeds, and then the other
gets -EBUSY.

Here is a quick patch that might make it work.

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 342e12f..3afd31e 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -44,6 +44,10 @@
 
 #include "8250.h"
 
+#ifdef CONFIG_SPARC
+#include "suncore.h"
+#endif
+
 /*
  * Configuration:
  *   share_irqs - whether we pass IRQF_SHARED to request_irq().  This option
@@ -2954,7 +2958,11 @@ static int __init serial8250_init(void)
 	for (i = 0; i < NR_IRQS; i++)
 		spin_lock_init(&irq_lists[i].lock);
 
+#ifdef CONFIG_SPARC
+	ret = sunserial_register_minors(&serial8250_reg, nr_uarts);
+#else
 	ret = uart_register_driver(&serial8250_reg);
+#endif
 	if (ret)
 		goto out;
 
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 7e7383e..7bc1292 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -4,6 +4,16 @@
 
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
+
+# These Sparc drivers have to appear before others such as 8250
+# which share ttySx minor node space.  Otherwise console device
+# names change and other unplesantries.
+obj-$(CONFIG_SERIAL_SUNCORE) += suncore.o
+obj-$(CONFIG_SERIAL_SUNHV) += sunhv.o
+obj-$(CONFIG_SERIAL_SUNZILOG) += sunzilog.o
+obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
+obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
+
 obj-$(CONFIG_SERIAL_8250) += 8250.o
 obj-$(CONFIG_SERIAL_8250_PNP) += 8250_pnp.o
 obj-$(CONFIG_SERIAL_8250_GSC) += 8250_gsc.o
@@ -31,12 +41,7 @@ obj-$(CONFIG_SERIAL_S3C2400) += s3c2400.o
 obj-$(CONFIG_SERIAL_S3C2410) += s3c2410.o
 obj-$(CONFIG_SERIAL_S3C2412) += s3c2412.o
 obj-$(CONFIG_SERIAL_S3C2440) += s3c2440.o
-obj-$(CONFIG_SERIAL_SUNCORE) += suncore.o
-obj-$(CONFIG_SERIAL_SUNHV) += sunhv.o
-obj-$(CONFIG_SERIAL_SUNZILOG) += sunzilog.o
 obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
-obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
-obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
 obj-$(CONFIG_SERIAL_MUX) += mux.o
 obj-$(CONFIG_SERIAL_68328) += 68328serial.o
 obj-$(CONFIG_SERIAL_68360) += 68360serial.o
