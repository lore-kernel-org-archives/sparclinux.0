From: Vincent Cojot <coyote@step.polymtl.ca>
Date: Thu, 18 Mar 2004 14:05:14 +0000
Subject: 'Inconsistent console: input 3, output 3' with 2.4.25
Message-Id: <Pine.GSO.4.58.0403180843540.12102@step.polymtl.ca>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi everyone,

Just rebuilt a tftp64.img boot image using Aurora 1.0, updates
and Christian Joensson's 2.4.25-0.1 src.rpm (based on Aurora's src.rpm).

Also, this tftp64.img was rebuilt using buildinstall on a fully updated
Aurora 1.0 machine (Ultra2 Model 1300). I wondering if anyone knows what's
going on here..

First the problem dump:

{e0} ok boot net -p
Resetting...


Sun Fire 15000, using IOSRAM based Console
Copyright 1998-2002 Sun Microsystems, Inc.  All rights reserved.
OpenBoot  4.7.6, 32768 MB memory installed, Serial #44630847.
Ethernet address 0:0:be:a9:3:3f, Host ID: 82a9033f.



Rebooting with command: boot net -p
Boot device: /pci@fc,700000/pci@1/network@0  File and args: -p
100 Mbps HDX Link up
Timeout waiting for ARP/RARP packet
Timeout waiting for ARP/RARP packet
Timeout waiting for ARP/RARP packet
Timeout waiting for ARP/RARP packet
Timeout waiting for ARP/RARP packet
1f5000 TILO
Selecting sun4u kernel...
/
PROMLIB: Sun IEEE Boot Prom 4.7.6 2003/02/13 18:57
<4>Linux version 2.4.25-0.1sparcBOOT (root@u1sparc.j-son.org) (gcc driver version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release) executing gcc
version egcs-2.92.11) #1 Wed Mar 10 18:55:19 CET 2004
<4>ARCH: SUN4U
Linux version 2.4.25-0.1sparcBOOT (root@u1sparc.j-son.org) (gcc driver version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release) executing gcc
version egcs-2.92.11) #1 Wed Mar 10 18:55:19 CET 2004
<4>ARCH: SUN4U
ARCH: SUN4U
Ethernet address: 00:00:be:a9:03:3f
Inconsistent console: input 3, output 3
Program terminated
{e0} ok

From an external viewpoint, I don't really understand why it should
complain about the console considering that the F15K has "/ssp-serial" in
'show-devs' just like an E10k (I don't know if the E10K still works with
recent 2.4.x kernels, which might explain some of this but..):

{e0} ok show-devs
[...snip...]
/memory-controller@103,400000
/SUNW,UltraSPARC-III+@103,0
/memory-controller@102,400000
/SUNW,UltraSPARC-III+@102,0
/memory-controller@101,400000
/SUNW,UltraSPARC-III+@101,0
/memory-controller@100,400000
/SUNW,UltraSPARC-III+@100,0
[...snip...]
/idprom
/nvram
/ssp-serial
/virtual-memory
/memory@m0,e0
/aliases
/options
/openprom
/chosen
/packages
[...snip...]
{e0} ok

Furthermore,

After looking at /usr/src/linux-2.4.25-0.1sparc/arch/sparc/prom/console.c
and /usr/src/linux-2.4.25-0.1sparc/arch/sparc64/kernel/setup.c, I'm not
too sure about where I'd start hacking to get this running. If anyone has
an idea... :)

Cheers,

,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,
Vincent S. Cojot, Computer Engineering. STEP project. _.,-*~'`^`'~*-,._.,-*~
Ecole Polytechnique de Montreal, Comite Micro-Informatique. _.,-*~'`^`'~*-,.
Linux Xview/OpenLook resources page _.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'
http://step.polymtl.ca/~coyote  _.,-*~'`^`'~*-,._ coyote@step.polymtl.ca

They cannot scare me with their empty spaces
Between stars - on stars where no human race is
I have it in me so much nearer home
To scare myself with my own desert places.       - Robert Frost
