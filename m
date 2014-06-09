From: Peter Hurley <peter@hurleysoftware.com>
Date: Mon, 09 Jun 2014 23:48:17 +0000
Subject: FW: Linux 3.15: SPARC serial console regression
Message-Id: <1402357697-20976-1-git-send-email-peter@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140609205917.GA913@drone.musicnaut.iki.fi>
In-Reply-To: <20140609205917.GA913@drone.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seth Bollinger <sethb@digi.com>, Peter Hurley <peter@hurleysoftware.com>

On 06/09/2014 04:59 PM, Aaro Koskinen wrote:> Hi,
> 
> While testing the final 3.15, I noticed the serial console (sunsab)
> does not work anymore on Sun Ultra.
> 
> It will tx fine the console output during the boot. But then I try
> to type something e.g. at the login: prompt, it behaves oddly:
> it re-transmits some old output, and then stalls for a few secs, usually
> for each character. Typed characters are however received correctly.
> But the console is impossible to use...
> 
> I bisected this to:
> 
> 717f3bbab3c7628736ef738fdbf3d9a28578c26c is the first bad commit
> commit 717f3bbab3c7628736ef738fdbf3d9a28578c26c
> Author: Seth Bollinger <sethb@digi.com>
> Date:   Tue Mar 25 12:55:37 2014 -0500
> 
>      serial_core: Fix conditional start_tx on ring buffer not empty

[Let's try that again. This time without the mess]

Thanks for the report Aaro.

Looks like Seth's fix exposes some broken assumptions in the Sun
serial drivers.

Can you test the patch below?

Regards,
Peter Hurley

PS - Do you have a way to test also your setup using hardware flow
control, ie. CRTSCTS?  I ask because I would expect that to be broken
even before Seth's patch.

--- %< ---
From: Peter Hurley <peter@hurleysoftware.com>
Date: Mon, 9 Jun 2014 19:21:43 -0400
Subject: [PATCH] serial: sunsab: Test for no tx data on tx restart

Commit 717f3bbab3c7628736ef738fdbf3d9a28578c26c,
'serial_core: Fix conditional start_tx on ring buffer not empty'
exposes an incorrect assumption in sunsab's start_tx method; the
tx ring buffer can, in fact, be empty when restarting tx when
performing flow control.

Test for empty tx ring buffer when in sunsab's start_tx method.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/sunsab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 5faa8e9..b99a4ea 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -427,6 +427,9 @@ static void sunsab_start_tx(struct uart_port *port)
 	struct circ_buf *xmit = &up->port.state->xmit;
 	int i;
 
+	if (uart_circ_empty(xmit))
+		return;
+
 	up->interrupt_mask1 &= ~(SAB82532_IMR1_ALLS|SAB82532_IMR1_XPR);
 	writeb(up->interrupt_mask1, &up->regs->w.imr1);
 	
-- 
2.0.0

