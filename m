From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 01:40:00 +0000
Subject: Re: 16550 serial support
Message-Id: <20080911.184000.243404018.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 12 Sep 2008 02:40:14 +0200

> OK, I did a clean rebuild and reboot, but no dice:
> 
> Serial: 8250/16550 driver4 ports, IRQ sharing disabled
> Unable to handle kernel NULL pointer dereference

Please add this follow-on patch:

--- drivers/serial/8250.c~	2008-09-11 16:41:05.000000000 -0700
+++ drivers/serial/8250.c	2008-09-11 18:39:22.000000000 -0700
@@ -2673,7 +2673,6 @@ static struct uart_driver serial8250_reg
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
-	.nr			= UART_NR,
 	.cons			= SERIAL8250_CONSOLE,
 };
 
@@ -2959,8 +2958,9 @@ static int __init serial8250_init(void)
 		spin_lock_init(&irq_lists[i].lock);
 
 #ifdef CONFIG_SPARC
-	ret = sunserial_register_minors(&serial8250_reg, nr_uarts);
+	ret = sunserial_register_minors(&serial8250_reg, UART_NR);
 #else
+	serial8250_reg.nr = UART_NR;
 	ret = uart_register_driver(&serial8250_reg);
 #endif
 	if (ret)
