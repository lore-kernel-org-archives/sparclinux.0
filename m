From: RChan <rspchan@starhub.net.sg>
Date: Thu, 21 Oct 2004 08:30:37 +0000
Subject: Re: [PATCH] sunsu.c
Message-Id: <417773AD.2070309@starhub.net.sg>
List-Id: <sparclinux.vger.kernel.org>
References: <4175D5D4.3090702@starhub.net.sg>
In-Reply-To: <4175D5D4.3090702@starhub.net.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here's a fix-up earlier in the code path so that the irq is not reported 
as 0;
this occurs in sunsu_serial_init (actually that makes more sense) then where
I originally put it in sunsu_startup.

I now get
 
ttyS0 at MMIO 0x7fe010003f8 (irq = 7607552) is a 16550A
ttyS1 at MMIO 0x7fe010002e8 (irq = 7607552) is a 16550A

serial_core.c obviously isn't going to use __irq_itoa() to get a "nice" 
representation
of the irq so these irq numbers look weird but more reassuring than 0.



--- /usr/src/linux.old/drivers/serial/sunsu.c.ORIG        2004-10-20 
10:03:52.000000000 +0800
+++ /usr/src/linux/drivers/serial/sunsu.c     2004-10-20 
18:14:23.000000000 +0800
@@ -1092,6 +1092,7 @@
                                up->port.membase = (char *) 
isa_dev->resource.start;
                                up->port.mapbase = isa_dev->resource.start;
                                up->irq = isa_dev->irq;
+                               up->port.irq = up->irq;
                                goto ebus_done;
                        }
                }




David S. Miller wrote:

>On Wed, 20 Oct 2004 11:04:52 +0800
>RChan <rspchan@starhub.net.sg> wrote:
>
>  
>
>>The following patch fixes an oops in the serial subsystem
>>when using a agetty/login on ttyS[01] reported by me on the
>>mailing list. I suspect member values from the uart_sunsu_port structure are
>>not correctly transferred to the uart_port structure?
>>    
>>
>
>Thanks a lot, I'll take a closer look at your bug fix
>soon.  I think the propagation should be occuring
>automatically and I want to find out why that might
>not be occuring.
>
>  
>

