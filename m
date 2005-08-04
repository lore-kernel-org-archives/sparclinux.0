From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 04 Aug 2005 01:26:19 +0000
Subject: atyfb driver regression between 2.6.8 and 2.6.11/12
Message-Id: <Pine.LNX.4.61.0508032115450.9739@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

We have received a couple of reports [0] of atyfb driver misbehaving on 
Blade 100 in 2.6.11 and .12 (works fine in 2.6.8). It is reported that in 
console the first column of symbols is corrupt/missing and in X the mouse 
cursor is not visible, even though X appears to function properly 
otherwise. Bug submitter noticed, that the driver prints out different 
MCLK value during initalization on 2.6.8 and 2.6.11. On 2.6.8 (where 
everything works properly) he gets:

atyfb: 3D RAGE (XL) [0x4752 rev 0x27] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK

while on 2.6.11 it reads

atyfb: 3D RAGE XL (Mach64 GR, PCI-33MHz) [0x4752 rev 0x27]
atyfb: 8M SDRAM (1:1), 29.498928 MHz XTAL, 230 MH z PLL, 83 Mhz MCLK, 63 MHz XCLK

Disabling framebuffer by passing a 'video=atyfb:off vga=normal' boot 
option fixes the cursor in X, however there are still some issues on the 
console.

I have tried to poke it myself, but it looks like there has been a ton of 
changes to the driver, which will take me ages to figure out. If you have 
any ideas on how to fix it, please let me know.

[0] http://bugs.debian.org/317756

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
