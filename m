From: Vladimir Volovich <vvv@vsu.ru>
Date: Fri, 25 Mar 2005 15:20:19 +0000
Subject: running 2.6.* on sparc with Creator 3D and ATY Mach64
Message-Id: <87vf7f7nws.fsf@video.uic.vsu.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following message is a courtesy copy of an article
that has been posted to linux.debian.ports.sparc as well.

Hi!

i'd very much like to run 2.6.* kernels on Sun Ultra 10 which is
currently successfully running 2.4.27, but i have a problem with
video.

Here is part of dmesg from 2.4.27:

Mar 17 19:33:39 video kernel: Console: switching to colour frame buffer device 144x54
Mar 17 19:33:39 video kernel: fb0: Creator 3D at 000001fc00000000 type 51 DAC 10
Mar 17 19:33:39 video kernel: atyfb: 3D RAGE (GT) [0x4754 rev 0x9a] 2M SGRAM, 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 Mhz XCLK
Mar 17 19:33:39 video kernel: fb1: ATY Mach64 frame buffer device on PCI

But when i try to boot with 2.6.11, i get no framebuffer - and there
is no output to the screen after SILO has loaded the kernel. here's
the fb-related dmesg output from 2.6.11:

Mar 17 19:29:41 video kernel: atyfb: 3D RAGE (Mach64 GT) [0x4754 rev 0x02]
Mar 17 19:29:41 video kernel: atyfb: 2M SGRAM (1:1), 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz XCLK
Mar 17 19:29:41 video kernel: debug atyfb: Mach64 non-shadow register values:
Mar 17 19:29:41 video kernel: debug atyfb: 0x2000:  004F0063 000C0051 01DF020C 000201E9
Mar 17 19:29:41 video kernel: debug atyfb: 0x2010:  00570000 14000000 08000000 0B000200
Mar 17 19:29:41 video kernel: debug atyfb: 0x2020:  00480AA0 00C0079A 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x2030:  00000000 00000031 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x2040:  00000000 00000000 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x2050:  00000000 00000000 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x2060:  F1FFF5F5 FFFFFDFE 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x2070:  00000000 00000000 00003020 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x2080:  00000000 00000000 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x2090:  00A63000 00000000 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x20A0:  7B23A040 00000000 00000000 05000001
Mar 17 19:29:41 video kernel: debug atyfb: 0x20B0:  004210B3 00010000 00010000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x20C0:  00FF0000 86010182 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x20D0:  00000100 00000000 00000000 00003842
Mar 17 19:29:41 video kernel: debug atyfb: 0x20E0:  9A004754 0000001D 00000000 00000000
Mar 17 19:29:41 video kernel: debug atyfb: 0x20F0:  00000000 0000A955 E17FFCF8 00000000
Mar 17 19:29:41 video kernel:
Mar 17 19:29:41 video kernel: debug atyfb: Mach64 PLL register values:
Mar 17 19:29:41 video kernel: debug atyfb: 0x00:  CDD52414 A80343FD 8E82E701 A61B0000
Mar 17 19:29:41 video kernel: debug atyfb: 0x10:  CDD52414 A80343FD 8E82E701 A61B0000
Mar 17 19:29:41 video kernel: debug atyfb: 0x20:  CDD52414 A80343FD 8E82E701 A61B0000
Mar 17 19:29:41 video kernel: debug atyfb: 0x30:  CDD52414 A80343FD 8E82E701 A61B0000
Mar 17 19:29:41 video kernel:
Mar 17 19:29:41 video kernel: Console: switching to colour frame buffer device 80x30
Mar 17 19:29:41 video kernel: atyfb: fb0: ATY Mach64 frame buffer device on PCI
Mar 17 19:29:41 video kernel: ffb: FFB at 000001fc00000000 type 51 DAC 10

I waited for a while after the boot in the hope that X will
successfully start, despite the absence of framebuffer console, but it
did not happen.... (though the screen became just black after X
attempted to initialize)

Is there a way to make the 2.6.* kernel use the Creator 3D on 2.6.11,
in the presence of Mach64?

Best,
v.

