From: David Miller <davem@davemloft.net>
Date: Sun, 14 Sep 2008 04:18:52 +0000
Subject: Re: 16550 serial support
Message-Id: <20080913.211852.32524164.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080911143146.GA24923@orion.carnet.hr>
In-Reply-To: <20080911143146.GA24923@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 14 Sep 2008 02:52:12 +0200

> For the record I then also noticed this:
> 
> % sudo ls -l /proc/tty/driver/
> total 0
> -r--r--r-- 1 root root 0 2008-09-14 02:16 serial
> -r--r--r-- 1 root root 0 2008-09-14 02:16 sunsu
> 
> % sudo cat /proc/tty/driver/serial
> serinfo:1.0 driver revision:
> 0: uart:16C950/954 port:7FE01000930 irq:19 tx:290 rx:2875 fe:243 brk:12 RTS|CTS|DTR|DSR|CD
> 1: uart:16C950/954 port:7FE01000938 irq:19 tx:36 rx:33 RTS|DTR
> 2: uart:16550A port:7FE010009A0 irq:20 tx:0 rx:0
> 3: uart:16550A port:7FE010009A8 irq:20 tx:0 rx:0
> 
> % sudo cat /proc/tty/driver/sunsu 
> serinfo:1.0 driver revision:                      
> 0: uart:16550A mmio:0x7FE010003F8 irq:15 tx:380 rx:0 RTS|CTS|DTR|DSR|CD
> 1: uart:16550A mmio:0x7FE010002E8 irq:15 tx:72 rx:0 RTS|DTR
> 
> That definitely sounds suspicious.

Although this is a good area to investigate, conflicting ttyS? device
usage, I think the above is OK looking.

Those indexes "0", "1", etc. are within the namespace of the device
type itself.  It does not determine which ttyS? device index these
things gets hooked up to.

That is determined by the sunserial_register_minors() call made by
the Sun drivers and now 8250.

What should happen on your system is sunsu registers first, and takes
devices /dev/ttyS0 and /dev/ttyS1

Then later the PCI 8250 driver loads and takes /dev/ttyS2 and /dev/ttyS3
for your first card and /dev/ttyS4 and /dev/ttyS5 for your second card.

If you look at the contents of /proc/tty/drivers you can probably see
this.  For example, on my workstation it states:

davem@sunset:~/src/GIT/sparc-next-2.6$ cat /proc/tty/drivers
/dev/tty             /dev/tty        5       0 system:/dev/tty
/dev/console         /dev/console    5       1 system:console
/dev/ptmx            /dev/ptmx       5       2 system
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
sunsu                /dev/ttyS       4 64-65 serial
pty_slave            /dev/pts      136 0-1048575 pty:slave
pty_master           /dev/ptm      128 0-1048575 pty:master
unknown              /dev/tty        4 1-63 console
davem@sunset:~/src/GIT/sparc-next-2.6$ 

You probably have something that looks like:

sunsu                /dev/ttyS       4 64-65 serial
serial               /dev/ttyS       4 66-69 serial

which would match up with my predictions above.  /dev/ttyS0 uses
device minor 64, /dev/ttyS1 gets minor 65, etc.

