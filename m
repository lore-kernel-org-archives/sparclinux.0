From: Peter Hurley <peter@hurleysoftware.com>
Date: Sun, 01 Dec 2013 14:39:30 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <1385908770-14131-1-git-send-email-peter@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12/01/2013 03:16 AM, Meelis Roos wrote:
>> On 11/30/2013 08:31 PM, Meelis Roos wrote:
>>>> Does the RED state exception trigger if you manually break to the prom
>>>> command line and issue a boot command?
>>>
>>> It seems I can not break from running kernel to PROM by sending break
>>> from minicom. PROM itself reacts to my break (during memory test for
>>> example) so it's Linux not accepting the break. I seem to remember it
>>> having worked some time ago, although not when the kergel hung.
>>
>> Argghh.
>>
>> There were some changes to sunsab.c a couple of versions ago; maybe we
>> broke it.
>>
>> Can you confirm BRKs are being received with
>> 'sudo cat /proc/tty/driver/serial'
> 
> In 3.12:
> 
> # cat /proc/tty/driver/sunsab
> serinfo:1.0 driver revision:
> 0: uart:SAB82532 V3.2 mmio:0x1FFF1400000 irq:5 tx:5163 rx:0 CTS|DSR|CD
> 1: uart:SAB82532 V3.2 mmio:0x1FFF1400040 irq:5 tx:0 rx:
> 
> cat /proc/sys/kernel/stop-a
> 1
> 
> # cat /proc/sys/kernel/reboot-cmd
> 
> (it was empty, so default "boot" should be used AFAIK)

Meelis,

Would you please re-test trying to break to the PROM with this debug
patch?  As with the bootpromfs debug patch, the output is in
'/sys/kernel/debug/trace'.

Regards,
Peter Hurley

--- >% ---
Subject: [PATCH] serial/sunsab: Debug BRKs

Debug patch.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/sunsab.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 5d6136b..1e7a17e 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -153,9 +153,12 @@ receive_chars(struct uart_sunsab_port *up,
 	}
 
 	/* Count may be zero for BRK, so we check for it here */
-	if ((stat->sreg.isr1 & SAB82532_ISR1_BRK) &&
-	    (up->port.line = up->port.cons->index))
-		saw_console_brk = 1;
+	if (stat->sreg.isr1 & SAB82532_ISR1_BRK) {
+		if (up->port.line = up->port.cons->index)
+			saw_console_brk = 1;
+		trace_printk("%d: console:%d count:%d port:%p\n",
+			     up->port.line, up->port.cons->index, count, port);
+	}
 
 	for (i = 0; i < count; i++) {
 		unsigned char ch = buf[i], flag;
-- 
1.8.1.2

