From: Louis Liu <pttdog@gmail.com>
Date: Thu, 24 Nov 2016 09:35:30 +0000
Subject: Re: SILO Issues on an E4900
Message-Id: <CAHVHM28mY1cFOCO9w6zpOWms9jm_FCPVriFoKh69ynTV-5kXiQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
In-Reply-To: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I boot with the latest debian sparc64 install image (2006-11-22), and
have the same problem.

It looks like _start is placed on 0x4020?

Hope the following messages is helpful

Sun Fire 4800
OpenFirmware version 5.18.0 (09/20/04 21:21)
Copyright 2001-2004 Sun Microsystems, Inc.  All rights reserved.
Use is subject to license terms.
SmartFirmware, Copyright (C) 1996-2001.  All rights reserved.
14336 MB memory installed, Serial #50839752.
Ethernet address 0:3:ba:7:c0:c8, Host ID: 8307c0c8.

Rebooting with command: boot /ssm@0,0/pci@18,700000/pci@2/scsi@2/disk@6,0:f
TL = 1, TT = 10. ERROR: Illegal Instruction
TSTATE= 0x1400 [ccr = 0x0, asi = 0x0, pstate = 0x14, cwp = 0x0]
TPC= 0000000000004004
TNPC= 0000000000004008
TICK= 80000019fd46bf21, TICKCMP = 8000000000000000

debugger entered.

{10} ok 4000 dis
0x4000:    sethi   %hi(0xc041c00), %g0
0x4004:    illtrap 0x1840
0x4008:    illtrap 0x0
0x400c:    illtrap 0x1b0
0x4010:    illtrap 0x0
0x4014:    illtrap 0x4000
0x4018:    illtrap 0x0
0x401c:    illtrap 0x0
0x4020:    call    0x4028
0x4024:    mov     %o7, %l0
{10} ok 4028 dis
0x4028:    sethi   %hi(0x5800), %i1
0x402c:    or      %i1, 0x50, %i1
0x4030:    sethi   %hi(0x4000), %l1
0x4034:    or      %l1, 0x0, %l1
0x4038:    mov     %l1, %i0
0x403c:    jmpl    %o7 + 0xc0, %l7
0x4040:    sub     %i1, %l1, %l2

2016-09-12 8:02 GMT+08:00  <alexmcwhirter@triadic.us>:
> I was wondering if anyone has posted here about SILO failing to load on
> Serengeti and Amazon machines? These would be the Sun Fire 3800, 4800, 4810,
> 6800, E2900, E4900, and E6900. These machines are similar in the fact that
> they all use modularized system controllers running VxWorks which in turn
> runs a Java implementation of the SSC software.
>
> On an E4900 i am getting an error nearly identical to this users post about
> a 6800.
>
>
>
> I'm having trouble trying to boot off of an install CD (I don't have
> networking set up at the moment, but could probably get that set up).  I'm
> trying to install on a 2nd "B" domain on the machine, with a single
> CPU/memory board.
>
> When I try to issue the command to boot from the CDROM:
>
> {14} ok boot /ssm@0,0/pci@1a,700000/pci@1/SUNW,isptwo@4/sd@6,0:f
>  or
> {14} ok boot /ssm@0,0/pci@1a,700000/pci@1/SUNW,isptwo@4/sd@6,0
>
> I immediately get the error message (no text between command and this):
>
> <-------------------
> ERROR: Illegal Instruction
> debugger entered.
> <-------------------
>
> Looking at where the PC is and what's there in memory (seems to be same
> for sd@6,0 and sd@6,0:f):
>
> <-------------------
> {14} ok %pc .
> 4004
> {14} ok 4000 40 dump
>              \/  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
> 0123456789ABCDEF
> 00000004000  01 03 01 07 00 00 18 f0 00 00 00 00 00 00 01 88
> ................
> 00000004010  00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 00
> ......@.........
> 00000004020  40 00 00 02 a0 10 00 0f 33 00 00 16 b2 16 61 00
> @.......3.....a.
> 00000004030  23 00 00 10 a2 14 60 00 b0 10 00 11 af c3 e0 c0
> #.....`.........
> <-------------------
>
> I can boot a copy of Solaris installed on the disk just fine.  Here's a
> copy of the output from the openboot prom initialising:
>
> <-------------------
> Resetting ...
> Copying IO prom to Cpu dram
> .{/N0/SB5/P0} @(#) lpost        5.15.2  2003/08/04 10:27
> {/N0/SB5/P0} Copyright 2001-2003 Sun Microsystems, Inc.  All rights
> reserved.
> {/N0/SB5/P0} Use is subject to license terms.
> ..................................
> {/N0/SB5/P0} Running PCI IO Controller Basic Tests
> {/N0/SB5/P0} Jumping to memory 00000000.00000020 [00000010]
> {/N0/SB5/P0} System PCI IO post code running from memory
> {/N0/SB5/P0} @(#) lpost         5.15.2  2003/08/04 10:28
> {/N0/SB5/P0} Copyright 2001-2003 Sun Microsystems, Inc.  All rights
> reserved.
> {/N0/SB5/P0} Use is subject to license terms.
> {/N0/SB5/P0} Subtest: PCI IO Controller Register Initialization for aid 0x1a
> {/N0/SB5/P0} Running PCI IO Controller Functional Tests
> {/N0/SB5/P0} Running SBBC Basic Tests
> {/N0/SB5/P0} Subtest: SBBC PCI Reg Initialization for aid 0x1a
> {/N0/SB5/P0} Running PCI IO Controller Basic Tests
> {/N0/SB5/P0} Subtest: PCI IO Controller Register Initialization for aid 0x1b
> {/N0/SB5/P0} Running PCI IO Controller Functional Tests
> {/N0/SB5/P0} @(#) lpost         5.15.2  2003/08/04 10:27
> {/N0/SB5/P0} Copyright 2001-2003 Sun Microsystems, Inc.  All rights
> reserved.
> {/N0/SB5/P0} Use is subject to license terms.
> {/N0/SB5/P1} @(#) lpost         5.15.2  2003/08/04 10:27
> {/N0/SB5/P1} Copyright 2001-2003 Sun Microsystems, Inc.  All rights
> reserved.
> {/N0/SB5/P1} Use is subject to license terms.
> {/N0/IB7/P0} Passed
> {/N0/IB7/P1} Passed
> {/N0/SB5/P0} Running Domain Level Tests
> {/N0/SB5/P2} @(#) lpost         5.15.2  2003/08/04 10:27
> {/N0/SB5/P3} @(#) lpost         5.15.2  2003/08/04 10:27
> {/N0/SB5/P2} Copyright 2001-2003 Sun Microsystems, Inc.  All rights
> reserved.
> {/N0/SB5/P2} Use is subject to license terms.
> {/N0/SB5/P3} Copyright 2001-2003 Sun Microsystems, Inc.  All rights
> reserved.
> {/N0/SB5/P3} Use is subject to license terms.
> {/N0/SB5/P0} Running Domain Basic Tests
> {/N0/SB5/P0} Running Domain Advanced Tests
> {/N0/SB5/P0} Running Domain Stick Sync Tests
> {/N0/SB5/P0} Running Domain Verify Stick Sync Tests
> {/N0/SB5/P0} DCB_DECOMP_OBP command succeeded
> {/N0/SB5/P0} Committing retained memory 00000000.0096c000-00000000.0096dfff
> {/N0/SB5/P0} Retaining 00000000.0096c000-00000000.0096dfff
> {/N0/SB5/P0} Committing retained memory 00000000.00984000-00000000.00985fff
> {/N0/SB5/P0} Retaining 00000000.00984000-00000000.00985fff
> {/N0/SB5/P0}  CPU 21 clearing 00000000.00000000 to 00000000.0025b000
> {/N0/SB5/P0}  CPU 22 clearing 00000000.0025b000 to 00000000.004b6000
> {/N0/SB5/P0}  CPU 23 clearing 00000000.004b6000 to 00000000.00711000
> {/N0/SB5/P0}  CPU 20 clearing 00000000.00711000 to 00000000.0096c000
> {/N0/SB5/P0}  CPU 21 clearing 00000000.0096e000 to 00000000.00973800
> {/N0/SB5/P0}  CPU 22 clearing 00000000.00973800 to 00000000.00979000
> {/N0/SB5/P0}  CPU 23 clearing 00000000.00979000 to 00000000.0097e800
> {/N0/SB5/P0}  CPU 20 clearing 00000000.0097e800 to 00000000.00984000
> {/N0/SB5/P0}  CPU 21 clearing 00000000.00986000 to 00000002.00724800
> {/N0/SB5/P0}  CPU 22 clearing 00000002.00724800 to 00000004.004c3000
> {/N0/SB5/P0}  CPU 23 clearing 00000004.004c3000 to 00000006.00261800
> {/N0/SB5/P0}  CPU 20 clearing 00000006.00261800 to 00000008.00000000
> {/N0/SB5/P0} Decompress OBP done
> {/N0/SB5/P0} DCB_ENTER_OBP command succeeded
> {/N0/SB5/P1} DCB_ENTER_OBP command succeeded
> {/N0/SB5/P2} DCB_ENTER_OBP command succeeded
> {/N0/SB5/P3} DCB_ENTER_OBP command succeeded
>
>
> Sun Fire 6800
> OpenFirmware version 5.15.2 (08/04/03 10:27)
> Copyright 2001-2003 Sun Microsystems, Inc.  All rights reserved.
> Use is subject to license terms.
> SmartFirmware, Copyright (C) 1996-2001.  All rights reserved.
> 32768 MB memory installed, Serial #51339462.
> Ethernet address 0:3:ba:f:60:c6, Host ID: 830f60c6.
> <-------------------
>
> Thanks for any help!
>
> Pat
>
>
>
>
> Illegal instruction is quite vague, but the OBP does enter a debugging
> subsystem at the time of the error. I have seen people point fingers at
> exhausting all of the trap levels causing a similar error message, but
> without knowing more about what is actually happening i am not so sure. I
> have relatively easy access to the machine in question if anyone has any
> ideas at pin pointing the problem? This is quite a broad range of machines
> that seem to be affected, so i would very much like to work on getting at
> least SILO able to load a kernel. Whether or not the kernel has issues of
> it's own at that point is another matter.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
