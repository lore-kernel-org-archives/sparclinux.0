From: William Lee Irwin III <wli@holomorphy.com>
Date: Fri, 19 Nov 2004 00:59:47 +0000
Subject: Re: circular console list in 2.6.9-bk3+
Message-Id: <20041119005947.GM2268@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041118144142.GG2268@holomorphy.com>
In-Reply-To: <20041118144142.GG2268@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 18 Nov 2004 06:41:42 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:
>> Some changes that added serial console retry logic aren't interacting
>> well with PROM console setup and teardown and whatever sunzilog.c does,
>> and appear to result in a circular console list (hence indefinitely
>> repeated output). The trick is, of course, that I'm not sure which of
>> the three is wrong.

On Thu, Nov 18, 2004 at 02:36:53PM -0800, David S. Miller wrote:
> Please elaborate.
> sunzilog_console_init() will be called at most one time and
> therefore it will register itself one time via register_console().
> I don't see how anything in register_console() can wind us up with
> a circular list, and thus the problem you seem to be describing.

We were doing okay until the following patch got merged. Then (booting
with -p and console=ttyS0,9600) it loops printk'ing the string
	"PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03"
indefinitely.


-- wli

ChangeSet 1.1988.93.9, 2004/10/19 16:11:22+01:00, rmk@flint.arm.linux.org.uk

	[SERIAL] Keep trying to register our console device.
	
	Some serial drivers receive their serial port device information via
	the device model.  This unfortunately means that the selected port
	may not be available when the console subsystem initialises, so we
	must keep trying to register the console after each port is added.



 serial_core.c |    9 +++++++++
 1 files changed, 9 insertions(+)


diff -Nru a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c	2004-10-19 20:33:48 -07:00
+++ b/drivers/serial/serial_core.c	2004-10-19 20:33:48 -07:00
@@ -2225,6 +2225,15 @@
 	 */
 	tty_register_device(drv->tty_driver, port->line, port->dev);
 
+	/*
+	 * If this driver supports console, and it hasn't been
+	 * successfully registered yet, try to re-register it.
+	 * It may be that the port was not available.
+	 */
+	if (port->type != PORT_UNKNOWN &&
+	    port->cons && !(port->cons->flags & CON_ENABLED))
+		register_console(port->cons);
+
  out:
 	up(&port_sem);
 
