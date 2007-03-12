From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Mon, 12 Mar 2007 14:53:41 +0000
Subject: Re: Sunfire v880
Message-Id: <a728f9f90703120753p5d3810fcwc640dc4336182691@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/8/07, David Miller <davem@davemloft.net> wrote:
> From: "Alex Deucher" <alexdeucher@gmail.com>
> Date: Thu, 8 Mar 2007 16:58:12 -0500
>
> > Thanks for all your help with this.  I wish I could send you a v880.
> > If there's anything else you or anyone else would like me to try let
> > me know.  One last thing, I noticed this message when I create the
> > aout version of the kernel:
> >
> > PT 0 Entry: Loadable to 0x400000[0x39e918] from 0x0[0x32b788] align 0x100000
> > PT 1 Entry: unknown
> >
> > perhaps the additional size added by that patch changes something that
> > makes it happy when loading?
>
> The only working theory I can come up with is that yes, indeed,
> it makes the layout of the kernel different and for some reason
> that fixes the bootup failure.
>
> > If I figure out anything new I'll let you know.
>
> Thanks.
>

This may be a completely unrelated issue, but if I build a kernel with
sparc cpu i2c built in, I get this little gem:

[   79.718230] i2c-0: Regs at 000007fc7e00002e, 8 devices, own a0, clock 10.
[   79.798940] i2c-1: Regs at 000007fc7e000030, 8 devices, own a0, clock 10.
[   79.880198] i2c-2: Regs at 000007fc7e50002e, 0 devices, own a0, clock 10.
[   79.961441] i2c-3: Regs at 000007fc7e500030, 2 devices, own a0, clock 10.

ERROR: System Hardware FATAL RESET from  DAR/DCS/MDR CPU3

System State (CPU3 reporting)

WARNING: CPU0 extant (7) but not "Idle"; can't access CPU's registers

CPU1 Config/Control/Status registers:

  CPUVersion:  003e.0015.b100.0507
  SafConfig:   0caa.01bc.2002.0002
  SafBaseAdr:  0000.0400.0080.0000
  DCacheCtl:   0000.0000.0000.0000
  ECacheCtl:   0000.0000.0343.4c00
  ECErrEnable: 0000.0000.0000.000b

  AFAR:        0000.0000.0000.0000
  AFSR:        0000.0000.0000.0000 (no errors set)
  AFAR 2:      0000.0000.0000.0000
  AFSR 2:      0000.0000.0000.0000 (no errors set)

  DMMU SFAR:   0000.0000.f005.9d9b
  DMMU SFSR:   0000.0000.0080.8008 TM PR
  IMMU SFSR:   0000.0000.0080.8008 TM PR

CPU1 Trap registers:  Trap Level = 5

  TL=1 TT:     0000.0000.0000.004e
       TSTATE: 0000.0044.1100.1601 XCC:Z ICC:Z MM=TSO PEF PRIV IE
       TPC:    0000.0000.0041.7574
       TnPC:   0000.0000.0041.7578
  TL=2 TT:     0000.0000.0000.0068
       TSTATE: 0000.0099.5804.1403 XCC:NC ICC:NC MM=TSO PEF PRIV
       TPC:    0000.0000.f004.a270
       TnPC:   0000.0000.f004.a274
  TL=3 TT:     0000.0000.0000.0000
       TSTATE: 0000.0000.0000.0000 XCC:(clear) ICC:(clear) MM=TSO
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0000
  TL=4 TT:     0000.0000.0000.0000
       TSTATE: 0000.0000.0000.0000 XCC:(clear) ICC:(clear) MM=TSO
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0000
 *TL=5 TT:     0000.0000.0000.0001
       TSTATE: 0000.0099.1100.1601 XCC:NC ICC:NC MM=TSO PEF PRIV IE
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0004

CPU1 General registers:

  %PIL:        0
  %PC:         0000.0000.0000.0000
  %nPC:        0000.0000.0000.0004
  %PSTATE:     0000.0000.0000.0035 TLE MM=TSO PEF
  %CCR:        0000.0000.0000.0000 XCC:(clear) ICC:(clear)
  %FPRS:       0000.0000.0000.0000

  %v0: 0000.0000.0000.0000  %v1: 0000.0000.0000.0040  %v2: 0000.0000.0000.0100
  %v3: 0000.0000.007a.7080  %v4: 0000.0000.0000.0020  %v5: 0000.0000.0000.0000
  %v6: 0000.0000.007b.2d40  %v7: 0000.0000.0000.0000

  %m0: 0000.0000.0000.0000  %m1: 0000.0000.0040.82c0  %m2: 0000.0000.0000.03c0
  %m3: 8000.00b0.ffc5.80b6  %m4: 0000.0000.f005.8000  %m5: 8000.00b0.ffc5.80b6
  %m6: 0000.0000.0000.03c0  %m7: 0000.0000.0000.0000

  %a0: 0000.0000.0000.0000  %a1: 0000.0000.0000.5800  %a2: 0000.0000.0000.0000
  %a3: 0000.0000.0000.0000  %a4: 0000.0000.0000.0000  %a5: 0000.0000.0000.0000
  %a6: 0000.0000.0041.7564  %a7: ffff.ffff.f001.f6bc

  %g0: 0000.0000.0000.0000  %g1: 0000.0000.006e.ac00  %g2: 0000.0000.0000.0100
  %g3: ffff.f8b0.ffaf.c000  %g4: ffff.f8a0.000a.c8c0  %g5: ffff.f8a0.0319.8000
  %g6: ffff.f8b0.ffaf.c000  %g7: 0000.0000.0000.0007

  %o0: 0000.0000.0000.000e  %o1: 0000.0000.0000.0000  %o2: 0000.0000.0000.0000
  %o3: 0000.0016.27f4.4510  %o4: 0000.0000.0000.0001  %o5: 0000.0000.0077.1000
  %o6: ffff.f8b0.ffaf.f681  %o7: 0000.0000.0041.7564

  %l0: 0000.0000.006f.0040  %l1: 0000.0000.0077.1000  %l2: 0000.0000.0000.0001
  %l3: 0000.0000.0000.0006  %l4: 0000.0000.0000.0001  %l5: 0000.0000.0000.000f
  %l6: 0000.0000.006f.1da0  %l7: 0000.0000.0081.4c00

  %i0: 0000.0000.0000.0000  %i1: 0000.0000.0077.1130  %i2: 0000.0000.0000.0002
  %i3: 0000.0000.0081.50b0  %i4: 0000.0000.006f.1da0  %i5: 0000.0000.0000.0000
  %i6: ffff.f8b0.ffaf.f741  %i7: 0000.0000.0043.1e8c

CPU1 Mem Ctrl registers:

  Mem Time Ctl1:  1098.03cc.3104.1902
  Mem Time Ctl2:  3e68.d82d.79af.0020
  Mem Time Ctl3:  1060.03c7.1c82.0360
  Mem Time Ctl4:  1d28.7ec0.38e7.0020
  Mem Addr Dec1:  8000.7e02.c002.0000
  Mem Addr Dec2:  8000.7e02.c002.0200
  Mem Addr Dec3:  8000.7e02.c002.0400
  Mem Addr Dec4:  8000.7e02.c002.0600
  Mem Addr Ctl:   7f04.1124.4221.1088

WARNING: CPU2 extant (7) but not "Idle"; can't access CPU's registers

CPU3 Config/Control/Status registers:

  CPUVersion:  003e.0015.b100.0507
  SafConfig:   1534.01bc.2006.0002
  SafBaseAdr:  0000.0400.0180.0000
  DCacheCtl:   0000.0000.0000.0000
  ECacheCtl:   0000.0000.0343.4c00
  ECErrEnable: 0000.0000.0000.000b

  AFAR:        0000.07ff.ec00.f800
  AFSR:        0004.0000.0000.0000 IERR
  AFAR 2:      0000.07ff.ec00.f800
  AFSR 2:      0004.0000.0000.0000 IERR

  DMMU SFAR:   0000.0000.f002.f364
  DMMU SFSR:   0000.0000.0080.8008 TM PR
  IMMU SFSR:   0000.0000.0080.8008 TM PR

CPU3 Trap registers:  Trap Level = 5

  TL=1 TT:     0000.0000.0000.004e
       TSTATE: 0000.0000.8000.9603 XCC:(clear) ICC:(clear) PEF PRIV IE
       TPC:    0000.0000.0041.7554
       TnPC:   0000.0000.0041.09d4
  TL=2 TT:     0000.0000.0000.0000
       TSTATE: 0000.0000.0000.0000 XCC:(clear) ICC:(clear) MM=TSO
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0000
  TL=3 TT:     0000.0000.0000.0000
       TSTATE: 0000.0000.0000.0000 XCC:(clear) ICC:(clear) MM=TSO
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0000
  TL=4 TT:     0000.0000.0000.0000
       TSTATE: 0000.0000.0000.0000 XCC:(clear) ICC:(clear) MM=TSO
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0000
 *TL=5 TT:     0000.0000.0000.0001
       TSTATE: 0000.0000.8000.9606 XCC:(clear) ICC:(clear) PEF PRIV IE
       TPC:    0000.0000.0000.0000
       TnPC:   0000.0000.0000.0004

CPU3 General registers:

  %PIL:        15
  %PC:         0000.0000.0000.0000
  %nPC:        0000.0000.0000.0004
  %PSTATE:     0000.0000.0000.0035 TLE MM=TSO PEF
  %CCR:        0000.0000.0000.0000 XCC:(clear) ICC:(clear)
  %FPRS:       0000.0000.0000.0000

  %v0: 0000.0000.0000.0000  %v1: 0000.0000.0000.0000  %v2: 0000.0000.0000.1000
  %v3: 0000.0000.0043.9f8c  %v4: 0000.0000.0040.0000  %v5: 0000.0000.0000.0000
  %v6: 0000.0000.007b.2dc0  %v7: 0000.0000.0000.0000

  %m0: 0000.0000.0000.0000  %m1: 0000.0000.0040.8170  %m2: 0000.0000.0000.0000
  %m3: 8000.00b0.ffc0.00b6  %m4: 0000.0000.f002.e000  %m5: 8000.00b0.ffc2.e0b6
  %m6: 0000.0000.0000.03c0  %m7: 0000.0000.0000.0000

  %a0: 0000.0000.0000.0000  %a1: 0000.0000.0000.5800  %a2: 0000.0000.0000.0000
  %a3: 0000.0000.0000.0000  %a4: 0010.0800.0000.0000  %a5: 0000.07ff.ec00.f800
  %a6: 0000.0000.0045.4dec  %a7: ffff.ffff.f001.f6bc

  %g0: 0000.0000.0000.0000  %g1: 0000.0000.0000.028d  %g2: 0000.0000.006f.4000
  %g3: 0000.0000.006f.13a0  %g4: 0000.0000.006e.ac80  %g5: ffff.f8a0.031a.8000
  %g6: 0000.0000.006e.c040  %g7: 0000.0000.0000.0010

  %o0: 0000.0000.003d.09fa  %o1: 0000.0000.0000.0003  %o2: 0000.0000.006e.faf8
  %o3: 0000.0000.0000.0020  %o4: 0000.0000.1940.3ac6  %o5: 0000.0000.003d.09fa
  %o6: 0000.0000.006e.f251  %o7: 0000.0000.0045.4dec

  %l0: 0000.0000.0080.c280  %l1: 0000.0000.0080.c000  %l2: 0000.0000.0000.0001
  %l3: 0000.0000.0000.0000  %l4: 0000.0000.0080.e000  %l5: 0000.0000.0077.1000
  %l6: 0000.0000.0000.0000  %l7: 0000.0000.0000.0003

  %i0: 0000.0000.006e.fd50  %i1: ffff.f8a0.0394.5890  %i2: 0000.0000.0000.0000
  %i3: 0000.0000.0079.d800  %i4: 0000.0000.0077.1000  %i5: 0000.0000.ffff.180b
  %i6: 0000.0000.006e.f311  %i7: 0000.0000.0041.e09c

CPU3 Mem Ctrl registers:

  Mem Time Ctl1:  1098.03cc.3104.1902
  Mem Time Ctl2:  3e68.d82d.79af.0020
  Mem Time Ctl3:  1060.03c7.1c82.0360
  Mem Time Ctl4:  1d28.7ec0.38e7.0020
  Mem Addr Dec1:  8000.7e02.c002.0100
  Mem Addr Dec2:  8000.7e02.c002.0300
  Mem Addr Dec3:  8000.7e02.c002.0500
  Mem Addr Dec4:  8000.7e02.c002.0700
  Mem Addr Ctl:   7f04.1124.4221.1088

IO-Bridge 8 at 0000.0400.0400.0000
  Device ID  fc00.0000.0011.a957
  Ctl/Stat   0255.5554.0080.7e02
  Error Ctl  7c00.0000.0000.03e7
  Int Ctl    0000.0000.0000.0010
  Error Log  0000.0000.0000.0000
  ECC Ctl    0000.0000.0000.0000
  EStar Ctl  0000.0000.0000.0001
  Queue Ctl  0000.0000.0000.0000

                 Address Match       Address Mask
  PCIA Mem   0000.07fd.0000.0000 0000.07ff.0000.0000
  PCIA C/IO  0000.07ff.ec00.0000 0000.07ff.fe00.0000
  PCIB Mem   0000.07fe.0000.0000 0000.07ff.0000.0000
  PCIB C/IO  0000.07ff.ee00.0000 0000.07ff.fe00.0000

                    AFAR                AFSR
  UE         0000.0000.0000.0000 0000.0000.0000.0000
  CE         0000.0000.0000.0000 0000.0000.0000.0000
  PCI A      0000.0000.0000.0000 0000.0000.0000.0000
  PCI B      0000.0000.0000.0000 0000.0000.0000.0000

                Control/Status      Idle Check Diag       Diagnostic
  PCI A       0000.0002.0000.0000 0000.0000.0000.0000 0000.0000.0000.0000
  PCI B       0000.0000.0000.0000

Without it everything seems to work fine.

Alex
