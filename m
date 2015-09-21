From: Meelis Roos <mroos@linux.ee>
Date: Mon, 21 Sep 2015 11:43:15 +0000
Subject: Re: blk_mq_register_disk: kobject (00000000009f2dd8): tried to init an initialized object, something
Message-Id: <alpine.LRH.2.20.1509211338410.530@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1509141548050.31198@math.ut.ee> <CACVXFVN2fgG_rLTMby=bY+1sWzoGryKq_aCU2S0=chAX9MUvog@mail.gmail.com> <alpine.LRH.2.20.1509211024110.530@math.ut.ee> <CACVXFVNe5TrYr9gPrR4ggtg1cSbCcNt4_=vkBsGOv3fKocCzPg@mail.gmail.com>
In-Reply-To: <CACVXFVNe5TrYr9gPrR4ggtg1cSbCcNt4_=vkBsGOv3fKocCzPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>

> >> > [  106.370834] kobject (00000000009f2dd8): tried to init an initiali=
zed object, something is seriously wrong.
> >>
> >> Akinobu found there is one race between CPU hotplug and add_disk, maybe
> >> you can try the patch in the following link to see if it can fix your =
issue.
> >>
> >>                  https://lkml.org/lkml/2015/7/18/99
> >
> > What version is it against? Does not compile against 4.3-rc1:
> >
> >   CC      block/blk-mq-sysfs.o
> > block/blk-mq-sysfs.c: In function =A1blk_mq_unregister_disk=A2:
> > block/blk-mq-sysfs.c:401:3: error: =A1struct request_queue=A2 has no me=
mber named =A1mq_sysfs_init_done=A2
> >   q->mq_sysfs_init_done =3D false;
>=20
> I guess the patch is applied mistakenly because 'mq_sysfs_init_done' is j=
ust
> introduced from this patch.


Yes, sorry - I applied the last chunk by hand because it was mangled by=20
the web UI, and added ti to a wrong struct.

Now I tested it on top of 4.3.0-rc1. COmpiles, rebooted fine 6 times,=20
but now it hangs again, seems to be the same message:

[  107.143910] kobject (00000000009f2dd8): tried to init an initialized obj=
ect, something is seriously wrong.
[  107.258708] CPU: 0 PID: 1155 Comm: modprobe Not tainted 4.3.0-rc1-dirty =
#66
[  107.341957] Call Trace:
[  107.371099]  [0000000000654560] kobject_init+0x80/0xa0
[  107.432575]  [0000000000640cc4] blk_mq_register_disk+0xa4/0x180
[  107.503381]  [0000000000636550] blk_register_queue+0x70/0x120
[  107.572125]  [0000000000643b5c] add_disk+0x19c/0x460
[  107.631498]  [000000001003f800] loop_add+0x1a0/0x240 [loop]
[  107.698185]  [0000000010046168] loop_init+0x168/0x1b0 [loop]
[  107.765841]  [0000000000426c00] do_one_initcall+0x80/0x1c0
[  107.831456]  [00000000004de3c4] do_init_module+0x48/0x1e4
[  107.896022]  [00000000004c7654] load_module+0xf14/0x11e0
[  107.959565]  [00000000004c7ab4] SyS_finit_module+0x74/0xa0
[  108.025181]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  108.096517] Unable to handle kernel paging request at virtual address 00=
0000018f090000
[  108.190787] tsk->{mm,active_mm}->context =3D 00000000000003c4
[  108.257424] tsk->{mm,active_mm}->pgd =3D fffff800adcb0000
[  108.319909]               \|/ ____ \|/
[  108.319909]               "@'/ .. \`@"
[  108.319909]               /_| \__/ |_\
[  108.319909]                  \__U_/
[  108.496013] modprobe(1155): Oops [#1]
[  108.539669] CPU: 0 PID: 1155 Comm: modprobe Not tainted 4.3.0-rc1-dirty =
#66
[  108.622995] task: fffff800af3db400 ti: fffff800adbd4000 task.ti: fffff80=
0adbd4000
[  108.712592] TSTATE: 0000004411001607 TPC: 0000000000481384 TNPC: 0000000=
000481388 Y: 00000000    Not tainted
[  108.830299] TPC: <wake_up_process+0x4/0x40>
[  108.880250] g0: 0000000000908aba g1: 0000000000000000 g2: 00000000000000=
00 g3: 00000000009f2c00
[  108.984414] g4: fffff800af3db400 g5: fffff800aee1a000 g6: fffff800adbd40=
00 g7: fffff800ad576ee8
[  109.088582] o0: 0000000000919000 o1: 0000000000000040 o2: 00000000009190=
00 o3: 00000000000000d0
[  109.192717] o4: 000000000097ea00 o5: 0000000000000040 sp: fffff800adbd6c=
d1 ret_pc: 00000000005288a8
[  109.301074] RPC: <kmem_cache_alloc+0xe8/0x180>
[  109.354132] l0: fffff800af129dc4 l1: 000000000000343c l2: fffff800af129d=
c4 l3: 0000000000000001
[  109.458310] l4: 0000000000000171 l5: 0000000000000001 l6: 00000000000030=
00 l7: 0000000000000002
[  109.562452] i0: 000000018f090680 i1: 000000000097ea00 i2: 000000000097ea=
00 i3: 0000000000479530
[  109.666618] i4: 000000000096d800 i5: fffff800af005bc0 i6: fffff800adbd6d=
81 i7: 000000000047958c
[  109.770774] I7: <kthread_create_on_node+0x8c/0x140>
[  109.829057] Call Trace:
[  109.858224]  [000000000047958c] kthread_create_on_node+0x8c/0x140
[  109.931131]  [0000000000476874] __alloc_workqueue_key+0x274/0x460
[  110.004048]  [000000000062d68c] __bioset_create+0x20c/0x2a0
[  110.070703]  [0000000000631830] blk_alloc_queue_node+0x50/0x1e0
[  110.141565]  [000000000063e54c] blk_mq_init_queue+0xc/0x60
[  110.207153]  [000000001003f710] loop_add+0xb0/0x240 [loop]
[  110.272762]  [0000000010046168] loop_init+0x168/0x1b0 [loop]
[  110.340439]  [0000000000426c00] do_one_initcall+0x80/0x1c0
[  110.406073]  [00000000004de3c4] do_init_module+0x48/0x1e4
[  110.470630]  [00000000004c7654] load_module+0xf14/0x11e0
[  110.534163]  [00000000004c7ab4] SyS_finit_module+0x74/0xa0
[  110.599799]  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
[  110.670592] Disabling lock debugging due to kernel taint
[  110.734150] Caller[000000000047958c]: kthread_create_on_node+0x8c/0x140
[  110.813291] Caller[0000000000476874]: __alloc_workqueue_key+0x274/0x460
[  110.892453] Caller[000000000062d68c]: __bioset_create+0x20c/0x2a0
[  110.965358] Caller[0000000000631830]: blk_alloc_queue_node+0x50/0x1e0
[  111.042436] Caller[000000000063e54c]: blk_mq_init_queue+0xc/0x60
[  111.114309] Caller[000000001003f710]: loop_add+0xb0/0x240 [loop]
[  111.186198] Caller[0000000010046168]: loop_init+0x168/0x1b0 [loop]
[  111.260127] Caller[0000000000426c00]: do_one_initcall+0x80/0x1c0
[  111.331986] Caller[00000000004de3c4]: do_init_module+0x48/0x1e4
[  111.402806] Caller[00000000004c7654]: load_module+0xf14/0x11e0
[  111.472581] Caller[00000000004c7ab4]: SyS_finit_module+0x74/0xa0
[  111.544426] Caller[00000000004061d4]: linux_sparc_syscall32+0x34/0x60
[  111.621508] Caller[0000000070015738]: 0x70015738
[  111.676682] Instruction DUMP: 01000000  01000000  9de3bf50 <c25e0000> 82=
08600c  0ac04005  11002409  b2102003  1=20

--=20
Meelis Roos (mroos@linux.ee)
