From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 24 Feb 2021 11:14:37 +0000
Subject: Newer kernels fail to boot on a U450?
Message-Id: <6cb1a2ea-c228-abbf-7aa7-0046799eff1e@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I've recently had to help a client rescue a U450 and so I asked them to burn the 
latest debian ports ISO (thank you Adrian!) to boot into a rescue shell.

Unfortunately the kernel is unable to boot: grub loads the kernel and initrd into 
memory but then immediately displays a "Divide by zero" error and hangs. This is 
before any kernel dmesg output is displayed on the console and from the style of the 
message I'm fairly sure that the error message is coming from the PROM.

I then asked them to work backwards through a collection of historical debian-ports 
ISOs that I own until we found one that would boot. The results were as follows:


debian-10.0.0-sparc64-NETINST-1.iso (kernel 5.9.0-1-sparc64, grub) - FAILS
debian-9.0-sparc64-NETINST-1.iso (kernel 4.14.0-3-sparc64, SILO) - FAILS
debian-7.7.0-sparc-netinst.iso (kernel 3.2.0-4-sparc64, SILO) - FAILS
debian-6.0.4-sparc-netinst.iso (kernel 2.6.32-5-sparc64, SILO) - WORKS


Having eliminated the change of bootloader from SILO to grub as the problem, it 
really seems as if something in the kernel broke booting on a U450 between versions 
2.6.32 and 3.2.0. I should add that these ISOs all boot fine under 
qemu-system-sparc64 which is a U5 machine, so the newer kernels are not completely 
broken.

Do people still run newer kernels on older hardware? If there is interest, I may be 
able to get some more diagnostic information. In particular I'd be curious to know if 
Oracle do any routine testing of newer kernels on machines such as the U450 and 
whether anyone there can reproduce the problem.


ATB,

Mark.
