From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 21:42:50 +0000
Subject: Re: 16550 serial support
Message-Id: <20080911.144250.189112204.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 11 Sep 2008 16:31:46 +0200

> Here's me with my dunce hat yet again...
> 
> I wanted to add serial ports to a Fire v240 (so that I can connect the
> Fire 280R's serial console cable to it). So I went to the nearest shop
> and bought a PCI card with a couple of RS-232 ports. It is identified by
> lspci as:
> 
> 0001:00:02.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) (rev 01)
> 
> But then I noticed that no kernel module detected this, and that
> SERIAL_8250 depends on (BROKEN || !SPARC). Googling didn't help much,
> most users installed this in PCs and it seems everything worked for them
> (apart from an occasional setserial(8)-related complaint).
> 
> Is this then completely unsupported, supported by a different part of
> the kernel (sunsu, sunsab?), or?

We don't build this on sparc, because, at least a long time ago it was
difficult to get the device to not poke around at the standard ISA port
locations for the rs232 ports.

It might actually work.

Try just removing that "depends on" line and then enable SERIAL_8250_PCI
but do not enable any of the other SERIAL_8250_ variants.  Actually it
seems to take care of enabling SERIAL_8250_PCI automatically.

Let me know how it goes.

Wait... let me first check if it will build properly and not spit out
any suspicious errors...

Yeah, it won't build:

drivers/serial/8250.c:93:24: error: asm/serial.h: No such file or directory

What does it want in there?  Let's have a look.... Ok, it seems we can get
by with just providing a BASE_BAUD definition.

The following patch should get it building for you so you can test it out.
Meanwhile, I'll toss this into sparc-next-2.6

serial: Allow 8250 to be built on sparc.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/serial.h |    6 ++++++
 drivers/serial/Kconfig          |    1 -
 2 files changed, 6 insertions(+), 1 deletions(-)
 create mode 100644 arch/sparc/include/asm/serial.h

diff --git a/arch/sparc/include/asm/serial.h b/arch/sparc/include/asm/serial.h
new file mode 100644
index 0000000..f90d61c
--- /dev/null
+++ b/arch/sparc/include/asm/serial.h
@@ -0,0 +1,6 @@
+#ifndef __SPARC_SERIAL_H
+#define __SPARC_SERIAL_H
+
+#define BASE_BAUD ( 1843200 / 16 )
+
+#endif /* __SPARC_SERIAL_H */
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 77cb342..db54763 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -9,7 +9,6 @@ menu "Serial drivers"
 # The new 8250/16550 serial drivers
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
-	depends on (BROKEN || !SPARC)
 	select SERIAL_CORE
 	---help---
 	  This selects whether you want to include the driver for the standard
-- 
1.5.6.5.GIT

