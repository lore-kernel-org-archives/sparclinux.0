From: Meelis Roos <mroos@linux.ee>
Date: Thu, 24 Mar 2005 06:37:29 +0000
Subject: Re: sunbmac panic when no card present
Message-Id: <Pine.SOC.4.61.0503240834190.24800@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0503221030220.29185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Ok, one more thing to try.  Still in serial_core.c, let's also add a 
> BUG_ON(info->tty=NULL) in the middle of uart_write_wakeup().  I don't expect 
> this bug to trigger.  My current guess is that the tty is closed between 
> scheduling and running the tasklet.  How about adding a printk after each 
> time where info->tty is set:  near line 1224 in uart_close(), line 1320 in 
> uart_hangup(), and line 1538 in uart_open().  If my guess is right, we will 
> see a uart_close just before the BUG from the tasklet.

Sounds quite possible, this reminds me that when the machine starts up, 
minicom changes serial stgatus from "Offline" to "Online" and it remains 
Online during bootup but is Offiline during normal work. It seems to 
work though - when I do shutdown, I see all the messages scrolling by.

With these printk's and the additional BUG check, the new BUG trigges 
very early on boot, during init startup:

VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 104k freed
uart_open setting info->tty = f0846000
uart_open setting info->tty = f0846000
uart_close setting info->tty = NULL
uart_open setting info->tty = f0846000
uart_close setting info->tty = NULL
kernel BUG at drivers/serial/serial_core.c:73!
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
init(1): Kernel bad trap [#1]
PSR: 40400fc4 PC: f00f49a8 NPC: f00f49ac Y: 00000000    Not tainted
PC: <uart_write_wakeup+0x54/0x60>
%G: 00000049 f0195c00  f0195fc4 40400fe2  f002f084 f0195c00  f0862000 00000000
%O: 00000032 f017eaa8  00000049 500a4880  500197c8 00000314  f0863db0 f00f49a0
RPC: <uart_write_wakeup+0x4c/0x60>
%L: 40800fc5 f0011530  f0011534 00000020  0000000c 6d610000  f0862000 50171e9c
%I: f01d1f20 00049000  00000004 80808080  00000001 00000050  f0863e18 f00f900c
Caller[f00f900c]: sunzilog_transmit_chars+0xf8/0x180
Caller[f00f91c8]: sunzilog_interrupt+0x134/0x174
Caller[f0012f58]: handler_irq+0x78/0xa4
Caller[f0010758]: patch_handler_irq+0x0/0x24
Caller[500097e0]: 0x500097e0
Instruction DUMP: 92102049  7ffc7846  901222a8 <91d02005> 81c7e008  81e80000  9
Kernel panic - not syncing: Aiee, killing interrupt handler!

-- 
Meelis Roos (mroos@linux.ee)
