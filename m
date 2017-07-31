From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 31 Jul 2017 22:01:47 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <CADxRZqz+oQn8=Q3RDtfko9ctP1RE41XnsVP3H8RXJuE9m=VPLw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <22908.31076.708982.410201@gargle.gargle.HOWL> <22911.25997.495345.538443@gargle.gargle.HOWL>
 <CADxRZqzkUqWsHgw8eNHF4E_wi5a6d=hJnmEtm5omsw42tHAw+Q@mail.gmail.com> <20170731.145151.571917275997786929.davem@davemloft.net>
In-Reply-To: <20170731.145151.571917275997786929.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Mikael Pettersson <mikpelinux@gmail.com>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tue, Aug 1, 2017 at 12:51 AM, David Miller <davem@davemloft.net> wrote:
> From: Anatoly Pugachev <matorola@gmail.com>
> Date: Tue, 1 Aug 2017 00:48:07 +0300
>
>> Aug 01 00:35:11 v215 kernel: sched_xetattr(1527): Oops [#1]
>> Aug 01 00:35:11 v215 kernel: CPU: 1 PID: 1527 Comm: sched_xetattr Not
>> tainted 4.12.0 #365
>> Aug 01 00:35:11 v215 kernel: task: fff0001231d41340 task.stack: fff000123dfc4000
>> Aug 01 00:35:11 v215 kernel: TSTATE: 0000004411001604 TPC:
>> 0000000000a121fc TNPC: 0000000000a12210 Y: 00000000    Not tainted
>> Aug 01 00:35:11 v215 kernel: TPC: <__bzero+0x20/0xc0>
>> Aug 01 00:35:11 v215 kernel: g0: fff000123dfc7d20 g1: 0000000000000000
>> g2: 0000003000000000 g3: 0000000000000000
>> Aug 01 00:35:11 v215 kernel: g4: fff0001231d41340 g5: fff000123ed08000
>> g6: fff000123dfc4000 g7: 0000000000000030
>> Aug 01 00:35:11 v215 kernel: o0: 0000000000000030 o1: fff000123dfc7e70
>> o2: 0000000000000000 o3: 0000000000000030
>> Aug 01 00:35:11 v215 kernel: o4: fff000123dfc7e70 o5: 000000000000000a
>> sp: fff000123dfc75c1 ret_pc: 000000000049b294
>> Aug 01 00:35:11 v215 kernel: RPC: <SyS_sched_setattr+0x174/0x1a0>
>
> Please run gdb on this kernel image and tell it:
>
> (gdb) x/20i 0x49b294 - 16
>
> Thanks.
>
> I think perhaps one of Al Viro's changes in the bisected commit causes
> a branch to either have an overflowed offset field, or get mispatched
> to the wrong destination.

David,

I don't know how to run on a running kernel , but as I understood:

root@v215:strace# gzip -dc /boot/vmlinuz-4.12.0 > vmlinux
root@v215:strace# gdb -q vmlinux
Reading symbols from vmlinux...(no debugging symbols found)...done.
(gdb) x/20i 0x49b294 - 16
   0x49b284 <_start+619140>:    mov  -22, %o0
   0x49b288 <_start+619144>:    sub  %i5, %o0, %o0
   0x49b28c <_start+619148>:    mov  %i3, %o2
   0x49b290 <_start+619152>:    clr  %o1
   0x49b294 <_start+619156>:    call  0xa121b8 <_start+6349240>
   0x49b298 <_start+619160>:    add  %o0, 0x30, %o0
   0x49b29c <_start+619164>:    cmp  %i3, 0
   0x49b2a0 <_start+619168>:    be  %icc, 0x49b20c <_start+619020>
   0x49b2a4 <_start+619172>:    mov  -14, %i0
   0x49b2a8 <_start+619176>:    rett  %i7 + 8
   0x49b2ac <_start+619180>:    nop
   0x49b2b0 <_start+619184>:    b,a   %xcc, 0x49b2c0 <_start+619200>
   0x49b2b4 <_start+619188>:    nop
   0x49b2b8 <_start+619192>:    nop
   0x49b2bc <_start+619196>:    nop
   0x49b2c0 <_start+619200>:    save  %sp, -176, %sp
   0x49b2c4 <_start+619204>:    call  0xa136c0 <_start+6354624>
   0x49b2c8 <_start+619208>:    nop
   0x49b2cc <_start+619212>:    cmp  %i0, 0
   0x49b2d0 <_start+619216>:    bl,pn   %icc, 0x49b318 <_start+619288>
   0x49b2d4 <_start+619220>:    mov  -22, %o0
(gdb)
