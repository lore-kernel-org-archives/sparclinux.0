From: Admar Schoonen <admar@luon.net>
Date: Thu, 23 Sep 2004 15:07:22 +0000
Subject: boot failure for 2.6.9-rc2 and 2.6.9-rc2-bk6
Message-Id: <20040923150722.GF31137@azrael.luon.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all

I have a Sun Blade 100 (UltraSPARC IIe, 500 MHz), 640 MB ram, SunPCi 2
pro and 2 ATi mach64 framebuffers (1 onboard, 1 pci card).

Kernels up to 2.6.8.1 work pretty fine, but 2.6.9-rc2, 2.6.9-rc2-bk4 and
2.6.9-rc2-bk6 fail to boot, showing this message:

Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.8

Remapping the kernel... done.
Booting Linux...

and then nothing happens. With 2.6.8.1 and before, the screen used to
blank almost immidiately after that, and then showing some messages in
black on a white background, followed by a flash and messages in grey on
a black background + quite penguin.

Note that 2.6.9-rc2-bk4 does boot fine on a Sun Ultra 5 (UltraSPARC IIi,
360 MHz), 256 MB ram, no pci cards. I am unable to test other kernels on
the ultra 5 at the moment, but I don't expect any problems on that
machine.

Could anybody tell me what is going wrong here?
And is there anybody with a an ultra sparc IIe (or ultra sparc IIi >500 MHz) that can boot 2.6.9-rc2 or later?

Best regards

Admar Schoonen

PS: CC any replies to me, as I am not subscribed to this list
