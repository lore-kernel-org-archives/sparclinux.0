From: Jan Engelhardt <jengelh@inai.de>
Date: Mon, 07 Jan 2013 15:51:31 +0000
Subject: Stop-A without Stop key
Message-Id: <alpine.LNX.2.01.1301071651170.23886@nerf07.vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


When running into the following situation:

Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
Call Trace:
 [000000000045e6a0] do_exit+0x780/0x800
 [000000000045ea68] do_group_exit+0x28/0xc0
 [000000000045eb14] SyS_exit_group+0x14/0x20
 [0000000000406134] linux_sparc_syscall32+0x34/0x40
Press Stop-A (L1-A) to return to the boot prom

how would one return to the bootprompt when there is no Stop/L1 key 
available, like over the SUNHV console? The serial break is mapped to 
sysrq, and as far as I remember, there is no Sysrq-... key defined for 
return-to-PROM, is there?
(Of course I could just use sysrq-b or the SP's system reset commands, 
but I am interested about getting back to 'ok' without a reset.)

thanks,
Jan
