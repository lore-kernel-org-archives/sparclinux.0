From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Thu, 28 Dec 2006 12:43:44 +0000
Subject: IRQ-problem with cs4231 alsa driver on SBUS
Message-Id: <4593BC00.4010902@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I am using an ultra 2 with two 300 MHz CPU's, kernel 2.6.18.5.
I tried to make a VOIP appliction (twinkle) work on my machine.
I have to use the OSS emulation layer, if I configure ALSA in
the application it will not work.
With OSS it works fine for a while, but after exactly 99999 IRQ's
from the cs4231 card I get the following kernel message:

irq 7: nobody cared (try booting with the "irqpoll" option)
Call Trace:
 [000000000046df14] __do_IRQ+0xec/0x140
 [000000000041c400] handler_irq+0x7c/0x94
 [00000000004108b4] tl0_irq5+0x1c/0x20
 [0000000000418564] cpu_idle+0x34/0xb8
 [00000000006e2660] start_kernel+0x234/0x23c
 [00000000004045d8] setup_trap_table+0x0/0x100
 [0000000000000000] 0x8
handlers:
[<0000000010079a64>] (snd_cs4231_sbus_interrupt+0x8/0x31c [snd_sun_cs4231])
Disabling IRQ #7

After this, sound stops working.
Booting with the irqpoll option as suggested gives an endless
stream of errors as soon as I use sound. I get following repeated
message:

SYSIO[1f]: Uncorrectable ECC Error, primary error type[???]
SYSIO[1f]: DOFF[7] SIZE[7] MID[1f]
SYSIO[1f]: AFAR[000001ffffffffff]
SYSIO[1f]: Secondary UE errors [(none)]
SYSIO[1f]: Correctable ECC Error, primary error type[???]
SYSIO[1f]: DOFF[7] ECC Syndrome[ff] Size[7] MID[1f]
SYSIO[1f]: AFAR[000001ffffffffff]
SYSIO[1f]: Secondary CE errors [(none)]
SYSIO[1f]: SBUS Error, primary error type[???] read(0)
SYSIO[1f]: size[2] MID[1]
SYSIO[1f]: AFAR[000001ffdc000010]
SYSIO[1f]: Secondary SBUS errors [(none)]

Any idea what the messages mean or what I can do to correct the problem?

Regards
              Georg Chini
