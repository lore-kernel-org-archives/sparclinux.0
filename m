From: RChan <rspchan@starhub.net.sg>
Date: Wed, 20 Oct 2004 03:04:52 +0000
Subject: [PATCH] sunsu.c
Message-Id: <4175D5D4.3090702@starhub.net.sg>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following patch fixes an oops in the serial subsystem
when using a agetty/login on ttyS[01] reported by me on the
mailing list. I suspect member values from the uart_sunsu_port structure are
not correctly transferred to the uart_port structure?

System: Sun Fire V210
Kernel: 2.6.[89]
Problem report: 
http://marc.theaimsgroup.com/?l=linux-sparc&m9819243824775&w=2

--- linux.old/drivers/serial/sunsu.c.ORIG        2004-10-20 
10:03:52.000000000 +0800
+++ linux/drivers/serial/sunsu.c     2004-10-20 10:43:40.000000000 +0800
@@ -689,6 +690,7 @@
        } else {
                retval = request_irq(up->irq, sunsu_serial_interrupt,
                                     SA_SHIRQ, su_typev[up->su_type], up);
+               port->irq = up->irq;
        }
        if (retval) {
                printk("su: Cannot register IRQ %d\n", up->irq);


Somehow the irq setting is not transferred to the uart_port structure 
causing
a later oops in synchronize_irq due to NULL pointer dereference. I am 
now able to login on ttyS[01].
The kernel still reports irq as 0 during booting; I am still trying to 
track this
one down. Any pointers as to the earliest stage at which port->irq has 
supposedly been
set to a "good" value, and where does 2.4.2[67] get values for 
interrupts such as 4,7ac
from? (BTW I am a total newbie to the Sparc architecture so please forgive
the dumb questions.)



