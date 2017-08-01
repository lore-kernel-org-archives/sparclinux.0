From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Tue, 01 Aug 2017 07:29:28 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <22912.11736.664315.645426@gargle.gargle.HOWL>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqzkUqWsHgw8eNHF4E_wi5a6d=hJnmEtm5omsw42tHAw+Q@mail.gmail.com>
        <20170731.145151.571917275997786929.davem@davemloft.net>
        <CADxRZqz+oQn8=Q3RDtfko9ctP1RE41XnsVP3H8RXJuE9m=VPLw@mail.gmail.com>
        <20170731.150632.885106324164202893.davem@davemloft.net>
In-Reply-To: <20170731.150632.885106324164202893.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: matorola@gmail.com, mikpelinux@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller writes:
 > From: Anatoly Pugachev <matorola@gmail.com>
 > Date: Tue, 1 Aug 2017 01:01:47 +0300
 > 
 > > I don't know how to run on a running kernel , but as I understood:
 > > 
 > > root@v215:strace# gzip -dc /boot/vmlinuz-4.12.0 > vmlinux
 > > root@v215:strace# gdb -q vmlinux
 > > Reading symbols from vmlinux...(no debugging symbols found)...done.
 > > (gdb) x/20i 0x49b294 - 16
 > 
 > Unfortunately you need to do this on the build kernel image before it
 > has been stripped of all of it's symbols.
 > 
 > Mikael, you built your kernels right?
 > 
 > Go into one of your OOPS's and extract the "RPC: " hex value, and run
 > the gdb command:
 > 
 > bash$ cd src/linux
 > bash$ gdb ./vmlinux
 > (gdb) x/10i 0x${RPC_HEX_VALUE} - 16
 > 
 > Thanks.

Ok, with 4.13-rc3 I got

[  240.085153] Unable to handle kernel NULL pointer dereference
[  240.142397] tsk->{mm,active_mm}->context = 000000000000044a
[  240.198531] tsk->{mm,active_mm}->pgd = fff000023c784000
[  240.250112]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[  240.374879] poll(724): Oops [#1]
[  240.400132] CPU: 0 PID: 724 Comm: poll Not tainted 4.13.0-rc3 #1
[  240.462002] task: fff000123cc71e00 task.stack: fff000123c894000
[  240.522717] TSTATE: 0000004411001605 TPC: 00000000007570fc TNPC: 0000000000757110 Y: 00000000    Not tainted
[  240.634921] TPC: <__bzero+0x20/0xc0>
[  240.664747] g0: fff000123c897081 g1: 0000000000000000 g2: 0000000000000000 g3: 00000000008ca100
[  240.762068] g4: fff000123cc71e00 g5: fff000023ef44000 g6: fff000123c894000 g7: 0000000000000008
[  240.859389] o0: 000000000000000c o1: fff000123c897a80 o2: 0000000000000000 o3: 000000000000000c
[  240.956718] o4: fff000123c897a7c o5: 00000000000000fb sp: fff000123c897181 ret_pc: 0000000000516ee0
[  241.058627] RPC: <do_sys_poll+0x80/0x3c0>
[  241.094166] l0: 0000000000000002 l1: 00000000014000c0 l2: 00000000000003fe l3: fff000123c897a7c
[  241.191506] l4: 0000000000000000 l5: 0000000000000000 l6: 000000000000006d l7: ffffffffffffffea
[  241.288822] i0: 00000000f7d93ff8 i1: 0000000000000002 i2: fff000123c897e90 i3: fff000123c897a70
[  241.386141] i4: 000fffedc3768590 i5: fff000123c897a70 i6: fff000123c8975e1 i7: 00000000005177f8
[  241.483468] I7: <SyS_poll+0x74/0xd0>
[  241.513292] Call Trace:
[  241.528265]  [00000000005177f8] SyS_poll+0x74/0xd0
[  241.574140]  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
[  241.634847] Disabling lock debugging due to kernel taint
[  241.687555] Caller[00000000005177f8]: SyS_poll+0x74/0xd0
[  241.740276] Caller[00000000004061b4]: linux_sparc_syscall32+0x34/0x60
[  241.807855] Caller[0000000000010a20]: 0x10a20
[  241.847983] Instruction DUMP:
[  241.847987]  c56a2000 
[  241.869824]  808a2003 
[  241.883651]  02480006 
[  241.897475] <d42a2000>
[  241.911207]  90022001 
[  241.925032]  808a2003 
[  241.938755]  1247fffd 
[  241.952484]  92226001 
[  241.966310]  808a2007 

so the RPC should be do_sys_poll+0x80 right?  Then gdb on the original vmlinux said:

(gdb) x/10i do_sys_poll+0x80-16
   0x516ed0 <do_sys_poll+112>:  brz  %o0, 0x5170fc <do_sys_poll+668>
   0x516ed4 <do_sys_poll+116>:  mov  %o0, %o2
   0x516ed8 <do_sys_poll+120>:  sub  %i4, %o0, %i4
   0x516edc <do_sys_poll+124>:  clr  %o1
   0x516ee0 <do_sys_poll+128>:  call  0x7570b8 <memset>
   0x516ee4 <do_sys_poll+132>:  add  %l3, %i4, %o0
   0x516ee8 <do_sys_poll+136>:  b  %xcc, 0x5170b0 <do_sys_poll+592>
   0x516eec <do_sys_poll+140>:  mov  -14, %l7
   0x516ef0 <do_sys_poll+144>:  mov  %l2, %o0
   0x516ef4 <do_sys_poll+148>:  movleu  %xcc, %l0, %o0
(gdb)

/Mikael
