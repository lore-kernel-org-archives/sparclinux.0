From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sun, 04 Jan 2004 16:54:00 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <1073235239.22653.52.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-etcl8Jiy7qexNBMySgGP"
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
To: sparclinux@vger.kernel.org


--=-etcl8Jiy7qexNBMySgGP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Output from ksymoops, although I suspect the serial noise is masking the
problem, since it panicked with no serial involvement as well.

[root@sunblade sparc32]# ksymoops -v vmlinux -m System.map Oops.txt
ksymoops 2.4.4 on sparc64 2.6.0-1.23sparc.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-1.23sparc/ (default)
     -m System.map (specified)
 
Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
PSR: 40901fc0 PC: f00f29f0 NPC: f00f29f4 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
PC: <serial_out+0x24/0x50>
Caller[f0207ac4]: uart_set_options+0xc8/0x12c
 
>>PC;  f00f29f0 <serial_out+24/50>   <=====
Trace; f0207ac4 <uart_set_options+c8/12c>
 
Caller[f0207cf4]: serial8250_console_setup+0xa0/0xb0
 
Trace; f0207cf4 <serial8250_console_setup+a0/b0>
 
Caller[f0032a60]: register_console+0x190/0x208
 
Trace; f0032a60 <register_console+190/208>
 
Caller[f0207d14]: serial8250_console_init+0x10/0x20
 
Trace; f0207d14 <serial8250_console_init+10/20>
 
Caller[f0206c28]: console_init+0x34/0x50
 
Trace; f0206c28 <console_init+34/50>
 
Caller[f01f5cd0]: start_kernel+0xcc/0x228
 
Trace; f01f5cd0 <start_kernel+cc/228>
 
Caller[f01f5790]: sun4c_continue_boot+0x314/0x324
 
Trace; f01f5790 <sun4c_continue_boot+314/324>
 
Caller[00000000]: 0x0
 
Trace; 00000000 Before first symbol
 
Instruction DUMP: 22800003  c2022004  c2020000 <d4284009> 30800008 
c20a2074  c6020000  82004009  82007fff
 
Code;  f00f29e4 <serial_out+18/50>
00000000 <_PC>:
Code;  f00f29e4 <serial_out+18/50>
   0:   22 80 00 03       be,a   c <_PC+0xc>
Code;  f00f29e8 <serial_out+1c/50>
   4:   c2 02 20 04       ld  [ %o0 + 4 ], %g1
Code;  f00f29ec <serial_out+20/50>
   8:   c2 02 00 00       ld  [ %o0 ], %g1
Code;  f00f29f0 <serial_out+24/50>
   c:   d4 28 40 09       stb  %o2, [ %g1 + %o1 ]
Code;  f00f29f4 <serial_out+28/50>
  10:   30 80 00 08       b,a   30 <_PC+0x30>
Code;  f00f29f8 <serial_out+2c/50>
  14:   c2 0a 20 74       ldub  [ %o0 + 0x74 ], %g1
Code;  f00f29fc <serial_out+30/50>
  18:   c6 02 00 00       ld  [ %o0 ], %g3
Code;  f00f2a00 <serial_out+34/50>
  1c:   82 00 40 09       add  %g1, %o1, %g1
Code;  f00f2a04 <serial_out+38/50>
  20:   82 00 7f ff       add  %g1, -1, %g1
 
Kernel panic: Attempted to kill the idle task!
 
1 error issued.  Results may not be reliable.

*****

When I boot it with a Monitor and keyboard, I can clearly see it oops
twice, but the first oops is pushed off screen. The oops I can see is
similar, but different from the one I got over the serial console.

I've attached the second oops (transcribed by hand) and the results from
ksymoops of that oops.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

--=-etcl8Jiy7qexNBMySgGP
Content-Disposition: attachment; filename=Oops-noserial.txt
Content-Type: text/plain; name=Oops-noserial.txt; charset=
Content-Transfer-Encoding: 7bit

tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#2]
PSR: 404010c1 PC: f0013b98 NPC: f0013b9c Y: 90000000    Not tainted
PC: <instruction_dump+0x18/0x64>
%G: f021e800 fffffff4  f01bfa08 40401fe1  f99326f4 404010e1  f01bca90 00000000
%O: f01bfa08 00000001  fffff8b8 f021e800  f021e800 f021e800  f01be668 f0032654
RPC: <printk+0x184/0x1xd0>
%L: fffffffd f0197c00  f01be5c8 00000010  00000020 00000000  00200200 00100100
%I: 76000000 00000000  f01bf800 f01bfa10  404010e2 f021a501  f01be6d0 f0013d00
Caller[f0013d00]: die_if_kernel+0x11c/0x144

Caller[f001cfd8]: unhandled_fault+0x64/0x90

Caller[f001d240]: do_sparc_fault+0x17c/0x3a8

Caller[f001274c]: srmmu_fault+0x58/0x68

Caller[f01f5d88]: start_kernel+0x184/0x228

Caller[f01f5790]: sun4c_continue_boot+0x314/0x324

Caller[00000000]: 0x0

Instruction DUMP: a0103ffd  233c065f  832c2002 <d4060001> 80a00010  90146028  92403fff  960a601e  920a601c
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Press L1-A to return to the boot prom

--=-etcl8Jiy7qexNBMySgGP
Content-Disposition: attachment; filename=ksymoops-noserial.txt
Content-Type: text/plain; name=ksymoops-noserial.txt; charset=
Content-Transfer-Encoding: 7bit

ksymoops 2.4.4 on sparc64 2.6.0-1.23sparc.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-1.23sparc/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#2]
PSR: 404010c1 PC: f0013b98 NPC: f0013b9c Y: 90000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
PC: <instruction_dump+0x18/0x64>
Caller[f0013d00]: die_if_kernel+0x11c/0x144

>>PC;  f0013b98 <instruction_dump+18/64>   <=====
Trace; f0013d00 <die_if_kernel+11c/144>

Caller[f001cfd8]: unhandled_fault+0x64/0x90

Trace; f001cfd8 <unhandled_fault+64/90>

Caller[f001d240]: do_sparc_fault+0x17c/0x3a8

Trace; f001d240 <do_sparc_fault+17c/3a8>

Caller[f001274c]: srmmu_fault+0x58/0x68

Trace; f001274c <srmmu_fault+58/68>

Caller[f01f5d88]: start_kernel+0x184/0x228

Trace; f01f5d88 <start_kernel+184/228>

Caller[f01f5790]: sun4c_continue_boot+0x314/0x324

Trace; f01f5790 <sun4c_continue_boot+314/324>

Caller[00000000]: 0x0

Trace; 00000000 Before first symbol

Instruction DUMP: a0103ffd  233c065f  832c2002 <d4060001> 80a00010  90146028  92403fff  960a601e  920a601c

Code;  f0013b8c <instruction_dump+c/64>
00000000 <_PC>:
Code;  f0013b8c <instruction_dump+c/64>
   0:   a0 10 3f fd       mov  -3, %l0
Code;  f0013b90 <instruction_dump+10/64>
   4:   23 3c 06 5f       sethi  %hi(0xf0197c00), %l1
Code;  f0013b94 <instruction_dump+14/64>
   8:   83 2c 20 02       sll  %l0, 2, %g1
Code;  f0013b98 <instruction_dump+18/64>
   c:   d4 06 00 01       ld  [ %i0 + %g1 ], %o2
Code;  f0013b9c <instruction_dump+1c/64>
  10:   80 a0 00 10       cmp  %g0, %l0
Code;  f0013ba0 <instruction_dump+20/64>
  14:   90 14 60 28       or  %l1, 0x28, %o0
Code;  f0013ba4 <instruction_dump+24/64>
  18:   92 40 3f ff       addx  %g0, -1, %o1
Code;  f0013ba8 <instruction_dump+28/64>
  1c:   96 0a 60 1e       and  %o1, 0x1e, %o3
Code;  f0013bac <instruction_dump+2c/64>
  20:   92 0a 60 1c       and  %o1, 0x1c, %o1

Kernel panic: Attempted to kill the idle task!

1 error issued.  Results may not be reliable.

--=-etcl8Jiy7qexNBMySgGP--

