From: Christophe Jacquet <jacquetc@free.fr>
Date: Sun, 09 Apr 2006 15:33:50 +0000
Subject: Parallel port problems on Sun Ultra10
Message-Id: <1144596830.4439295e52873@imp1-g19.free.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have an Ubuntu distribution running on a Sun Ultra10, with kernel 2.6.15.
Printing causes the workstation to crash. Here are the steps I can reproduce:

1) Inserting the module "parport_pc":

I type "modprobe parport_pc", and I get the following output on the console:

parport0: PC-style at 0x1fff13043bc (0x1fff13047bc), irq
7567552<7>0x1fff13043bc: F
IFO is 16 bytes
0x1fff13043bc: readIntrThreshold is 8
 , dma 0 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: Printer, Hewlett-Packard HP LaserJet 1100

This seems to be OK: the driver can communicate with the printer, since it
retrieves its model string.


2) Inserting the module "lp"

I type "modprobe lp" and I just get the message:

lp0: using parport0 (interrupt-driven).


3) Testing the printer

When I type " echo 'Hello world' >/dev/lp0 ", I get the message:

lp0: ECP mode

The string gets printed on the printer.

Then, Linux crashes. I get no more messages. The Bash prompt never comes back. I
can interact with OBP by hitting "Stop-A", and reboot the machine.


I hope this report will be useful. Thanks for any help you could give me. Best
regards.


Christophe Jacquet.
