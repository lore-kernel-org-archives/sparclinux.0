From: "John Belshaw" <jbelshaw@tiscali.nl>
Date: Sat, 17 Jan 2004 01:15:45 +0000
Subject: FW: qlogicpti on 2.6.1
Message-Id: <APELIDAFAFBEAPFEHPEOAEBDCBAA.jbelshaw@tiscali.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



-----Original Message-----
From: John Belshaw [mailto:jbelshaw@tiscali.nl]
Sent: Saturday, January 17, 2004 1:13 AM
To: David S. Miller
Subject: RE: qlogicpti on 2.6.1


Hi David,

I tried your qlogicpti patch on my e5000 with 2.6.1-bk1.
It allowed me to at boot on 2.6.1 which was great !
But I soon found a problem.

This is a 4 cpu box with a d1000 and 8 disks on 1 controller.

When building a raid 5 array across the 8 disks I get the following oops :

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000446
tsk->{mm,active_mm}->pgd = fffff80058916000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000009980f09606 TPC: 00000000005b6fec TNPC: 00000000005b6f60 Y:
000000d
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 00000000000000cb g1: 0000000000000000 g2: 00000000005b5740 g3:
00000000005bc
g4: 000000000066fcc0 g5: 0000000000000000 g6: 000000000066bcc0 g7:
0000000000000
o0: 0000000000000000 o1: 0000000000000000 o2: 0000000000000000 o3:
fffff800013c0
o4: 0000000000000010 o5: fffff800013f1b80 sp: 000000000066eec1 ret_pc:
000000000
l0: fffff8005f1bb340 l1: 0000000000000000 l2: 00000000000000ce l3:
0000000000000
l4: 00000000000000ce l5: 0000000000670c00 l6: 0000000000001018 l7:
0000000000008
i0: fffff800016802e0 i1: 0000000000000001 i2: 00000000006f51a0 i3:
0000000000000
i4: 0000000000001c18 i5: 0000000000001818 i6: 000000000066ef81 i7:
00000000005b0

>>PC;  005b6fec <qlogicpti_intr_handler+1cc/200>   <==>>O7;  00000000 Before first symbol
>>I7;  000005b0 Before first symbol

Instruction DUMP: 7fffff50  90100010  106fffde <d02461a8> 92042020  7ffe8e83
9
Error (Oops_code_values): invalid value 0x9 in Code line, must be 2, 4, 8 or
16
digits, value ignored

Code;  005b6fe0 <qlogicpti_intr_handler+1c0/200>
00000000 <_PC>:
Code;  005b6fe0 <qlogicpti_intr_handler+1c0/200>
   0:   7f ff ff 50       call  fffffd40 <_PC+0xfffffd40> 005b6d20
<qlogicpti_re
turn_status+0/100>
Code;  005b6fe4 <qlogicpti_intr_handler+1c4/200>
   4:   90 10 00 10       mov  %l0, %o0
Code;  005b6fe8 <qlogicpti_intr_handler+1c8/200>
   8:   10 6f ff de       unknown
Code;  005b6fec <qlogicpti_intr_handler+1cc/200>
   c:   d0 24 61 a8       st  %o0, [ %l1 + 0x1a8 ]
Code;  005b6ff0 <qlogicpti_intr_handler+1d0/200>
  10:   92 04 20 20       add  %l0, 0x20, %o1
Code;  005b6ff4 <qlogicpti_intr_handler+1d4/200>
  14:   7f fe 8e 83       call  fffa3a20 <_PC+0xfffa3a20> 0055aa00
<__memcpy+0/0
>
Code;  005b6ff8 <qlogicpti_intr_handler+1d8/200>
  18:   00 00 00 00       unimp  0

TSTATE: l panic: Aiee, killing interrupt handler!
<4>TSTATE: 0000004480009601 TPC: 00000000004182d0 TNPC: 00000000004182d4 Y:
000d
 g0: 0000000000000000 g1: 0000028000000400 g2: fffff800013d0aa0 g3:
fffff8000148
g4: fffff8005fcce640 g5: 0000000000000001 g6: fffff800014a4000 g7:
00000000006f0
o0: 000000000000000a o1: fffff800014a4008 o2: 00000000006f51a0 o3:
000000007461e
o4: 000000000000006c o5: 0000000000000001 sp: fffff800014a7681 ret_pc:
000000008
l0: 00000000006f40c0 l1: 00000000006fa020 l2: 00000000006f40c0 l3:
0000000000720
l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000000f l7:
fffff800014a0
i0: 0000000000000000 i1: 00000000007110e0 i2: 0000000000000001 i3:
0000000000728
i4: fffff800014a7fd8 i5: 0000000000000001 i6: fffff800014a7741 i7:
000000000042c

>>PC;  004182d0 <cpu_idle+30/c0>   <==>>O7;  00000008 Before first symbol
>>I7;  0000042c Before first symbol

TSTATE: 0000004480009601 TPC: 00000000004182ec TNPC: 00000000004182f0 Y:
000000d
g0: fffff80001617000 g1: 0000000000000028 g2: fffff800013f0aa0 g3:
fffff8005fc98
g4: fffff8005f68a060 g5: 0000000000000005 g6: fffff8005fc9c000 g7:
00000000006f0
o0: 000000000000000a o1: fffff8005fc9c008 o2: fffff8005c4d7d50 o3:
0000000000006
o4: fffff8005c4d7bc0 o5: 0000000000000000 sp: fffff8005fc9f681 ret_pc:
000000008
l0: 00000000006f40c0 l1: 00000000006fa020 l2: 00000000006f40c0 l3:
0000000000720
l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000000f l7:
fffff8005fc90
i0: 0000000000000000 i1: 00000000007110e0 i2: 0000000000000001 i3:
0000000000728
i4: fffff8005fc9ffd8 i5: 0000000000000001 i6: fffff8005fc9f741 i7:
000000000042c

>>PC;  004182ec <cpu_idle+4c/c0>   <==>>O7;  00000008 Before first symbol
>>I7;  0000042c Before first symbol

TSTATE: 0000004480009601 TPC: 00000000004182d0 TNPC: 00000000004182d4 Y:
000000d
g0: 0000000000000000 g1: 0000028000000400 g2: fffff800013e8aa0 g3:
fffff8005fcb8
g4: fffff8005f68b260 g5: 0000000000000004 g6: fffff8005fcb8000 g7:
00000000006f0
o0: 000000000000000a o1: fffff8005fcb8008 o2: 00000000006fa000 o3:
fffff80057d68
o4: fffff8005ef90000 o5: 00000000000003df sp: fffff8005fcbb681 ret_pc:
000000008
l0: 00000000006f40c0 l1: 00000000006fa020 l2: 00000000006f40c0 l3:
0000000000720
l4: 0000000000000001 l5: 0000000000000000 l6: 000000000000000f l7:
fffff8005fcb0
i0: 0000000000000000 i1: 00000000007110e0 i2: 0000000000000001 i3:
0000000000728
i4: fffff8005fcbbfd8 i5: 0000000000000001 i6: fffff8005fcbb741 i7:
000000000042c

>>PC;  004182d0 <cpu_idle+30/c0>   <==>>O7;  00000008 Before first symbol
>>I7;  0000042c Before first symbol


1 warning and 2 errors issued.  Results may not be reliable.

-----Original Message-----
From: sparclinux-owner@vger.kernel.org
[mailto:sparclinux-owner@vger.kernel.org]On Behalf Of David S. Miller
Sent: Friday, January 16, 2004 8:33 PM
To: Chris Ricker
Cc: sparclinux@vger.kernel.org
Subject: Re: qlogicpti on 2.6.1


On Fri, 16 Jan 2004 09:29:41 -0500 (EST)
Chris Ricker <kaboom@gatech.edu> wrote:

> That's been running overnight without problems on 2.6.1-SMP. Thanks much!

Thanks a ton for your report and testing Christ.

I'll push this fix to Linus.

-
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

