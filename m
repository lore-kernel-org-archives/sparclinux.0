From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sun, 27 May 2007 16:44:18 +0000
Subject: [PATCH] Linux always started with 9600 8N1
Message-Id: <Pine.LNX.4.61.0705271816310.7344@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0705261649590.7344@yvahk01.tjqt.qr>
 <20070526.154745.30164056.davem@davemloft.net>
In-Reply-To: <20070526.154745.30164056.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


On May 26 2007 15:47, David Miller wrote:
>> I have set the OBP to run at 115200, also set agetty on ttyS0 to do the 
>> same, and also added console=ttyS0,115200 to silo.conf (and also tried 
>> console=ttyS0,115200n8). But! Linux still gives me 9600 8N1. The ominous 
>> double screen blanking (why is that done anyway?) already takes place 
>> with 9600. I smell a bug. What do you think?
>
>The code in drivers/serial/suncore.c:sunserial_console_termios()
>should be parsing your OBP settings, add some tracing and see why it
>isn't working.
>
>Please track the bug down for us, thanks :-)

Just why did no one get a kernel oops? After all, the code tried to
write to constant memory.

This is the first patch of two. There is yet another section of Linux 
code that runs in 9600-only, and I need to figure out which.

---

The Linux kernel ignored the PROM's serial settings (115200,n,8,1 in
my case). This was because mode_prop remained "ttyX-mode" (expected:
"ttya-mode") due to the constness of string literals when used with 
"char *". Since there is no "ttyX-mode" property in the PROM, Linux
always used the default 9600.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

---
 drivers/serial/suncore.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.21.sparc64/drivers/serial/suncore.c
=================================--- linux-2.6.21.sparc64.orig/drivers/serial/suncore.c
+++ linux-2.6.21.sparc64/drivers/serial/suncore.c
@@ -30,9 +30,9 @@ void
 sunserial_console_termios(struct console *con)
 {
 	char mode[16], buf[16], *s;
-	char *mode_prop = "ttyX-mode";
-	char *cd_prop = "ttyX-ignore-cd";
-	char *dtr_prop = "ttyX-rts-dtr-off";
+	char mode_prop[] = "ttyX-mode";
+	char cd_prop[]   = "ttyX-ignore-cd";
+	char dtr_prop[]  = "ttyX-rts-dtr-off";
 	char *ssp_console_modes_prop = "ssp-console-modes";
 	int baud, bits, stop, cflag;
 	char parity;
#<EOF>
