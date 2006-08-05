From: Marc Zyngier <maz@misterjones.org>
Date: Sat, 05 Aug 2006 08:59:12 +0000
Subject: [PATCH] Fix E250 console with RSC
Message-Id: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Folks,

This patch fixes the RSC console oops Daniel discovered. The
problem is that, when the console is redirected to the RSC, it uses
the second sunsab chip, which is perfectly detected. Unfortunately,
the console framework calls the sunsab_console_setup each time a port
is registered. This has some adverse effect, as the third port has not
been discovered yet...

This patch, tested on my own E250 through an RSC console, hides the
problem by defering the console setup until the port has been properly
initialized.

Dave, please consider applying.

	M.

This patch fixes yet another sunsab problem, when console is set to
anything but the first port. The console framework calls
sunsab_console_setup for each port, and we end up setting up a console
on a not yet discovered port, which leads to an Oops. Instead, defer
console setup until the requested port is properly initialized. Tested
on an E250 through an RSC console.

Reported by Daniel Smolik <marvin@mydatex.cz>

Signed-off-by: Marc Zyngier <maz@misterjones.org>

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index dc673e1..077c201 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -886,6 +886,15 @@ static int sunsab_console_setup(struct c
 	unsigned long flags;
 	unsigned int baud, quot;
 
+	/*
+	 * The console framework calls us for each and every port
+	 * registered. Defer the console setup until the requested
+	 * port has been properly discovered. A bit of a hack,
+	 * though...
+	 */
+	if (up->port.type != PORT_SUNSAB)
+		return -1;
+	
 	printk("Console: ttyS%d (SAB82532)\n",
 	       (sunsab_reg.minor - 64) + con->index);
 

-- 
And if you don't know where you're going, any road will take you there...
