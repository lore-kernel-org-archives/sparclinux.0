From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 03 May 2010 14:12:00 +0000
Subject: parport on Sun Blade 2500 Red ?
Message-Id: <19422.55728.571998.756336@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

According to Sun's documentation, a Sun Blade 2500 Red includes
a PC-style parallel port.

If I build a kernel (any recent 2.6 kernel) with plain parport
support (PARPORT_PC=y), there are no kernel messages of any kind
related to parport, indicating it didn't find one. If I then add
PARPORT_PC_SUPERIO=y the kernel throws a low-level exception and
reboots instantly:

...
e3d: Found device at 0003:00:02.0
Console: switching to colour frame buffer device 144x56
f008fbfc: ttyS0 at MMIO 0x7fe010003f8 (irq = 23) is a 16550A
Console: ttyS0 (SU)
console [ttyS0] enabled
f0091638: ttyS1 at MMIO 0x7fe010002e8 (irq = 23) is a 16550A

Fatal Error Reset 
CPU 0000.0000.0000.0000 AFSR 0080.0000.0000.0000 AFAR 0000.0008.c004.0000 

No I don't intend to use the parport :-) I'm just curious.

/Mikael
