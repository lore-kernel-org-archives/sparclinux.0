From: Alex Mach <alexvm12e@mail.ru>
Date: Thu, 13 May 2010 11:38:37 +0000
Subject: =?koi8-r?Q?Re[2]=3A_sun4v=5Fdata=5Faccess=5Fexception_during_access_to_hardware?=
Message-Id: <E1OCWkP-0008St-00.alexvm12e-mail-ru@f211.mail.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> It's trying to call the dma_*() APIs with a NULL pointer.
> 
> That isn't supported.


If I use buffer memory with dma access I have messages

[   28.164095] Unable to handle kernel NULL pointer dereference


[   28.213969] tsk->{mm,active_mm}->context = 0000000000000000
[   28.263885] tsk->{mm,active_mm}->pgd = fffff80001acbc0c
[   28.310749]               \|/ ____ \|/
[   28.310821]               "@'/ .. \`@"
[   28.310880]               /_| \__/ |_\
[   28.310940]                  \__U_/
[   28.442898] swapper(1): Oops [#1]
[   28.472342] TSTATE: 0000004480001605 TPC: 000000000043422c TNPC: 0000000000434230 Y: 00000000    Not tainted
[   28.560914] TPC: <dma_4u_alloc_coherent+0x74/0x170>
[   28.604324] g0: 0000000000000001 g1: 0000000000000000 g2: 0000000000000040 g3: 0000000000000000
[   28.682622] g4: fffff800014c8000 g5: 0000000000000000 g6: fffff800014cc000 g7: 00000000000000e2
[   28.760785] o0: fffff80001680000 o1: 0000000000000000 o2: 0000000000000000 o3: fffff80001680000
[   28.838800] o4: 0000000000000080 o5: 0000000000000080 sp: fffff800014cf051 ret_pc: 0000000000434224
[   28.920060] RPC: <dma_4u_alloc_coherent+0x6c/0x170>
[   28.963491] l0: 0000000000000000 l1: 0000000000000002 l2: 0000000000000002 l3: 000000000069cc00
[   29.041815] l4: 0000000000000000 l5: 0000000040004110 l6: 00000000fff4d701 l7: 00000000f025bfe8
[   29.119853] i0: fffff80001680000 i1: 0000000000008000 i2: fffff8000165e830 i3: 00000000000000d0
[   29.197935] i4: fffff800014b25a8 i5: 0000000000000080 i6: fffff800014cf101 i7: 000000000057c584
[   29.276114] I7: <ethoc_probe+0x258/0x690>
[   29.311759] Disabling lock debugging due to kernel taint
[   29.359461] Caller[000000000057c584]: ethoc_probe+0x258/0x690
[   29.411026] Caller[00000000005746cc]: platform_drv_probe+0xc/0x20
[   29.465673] Caller[00000000005735bc]: driver_probe_device+0x120/0x290
[   29.523441] Caller[0000000000573780]: __driver_attach+0x54/0x80
[   29.576526] Caller[0000000000572c60]: bus_for_each_dev+0x3c/0x84
[   29.630394] Caller[00000000005724d8]: bus_add_driver+0xec/0x27c
[   29.683489] Caller[0000000000573a78]: driver_register+0xb4/0x164
[   29.737338] Caller[0000000000426ac4]: do_one_initcall+0x44/0x164
[   29.791223] Caller[00000000006ae1a8]: kernel_init+0xac/0x110
[   29.841980] Caller[000000000042a8dc]: kernel_thread+0x30/0x48
[   29.893536] Caller[00000000005e7104]: rest_init+0x18/0x68
[   29.941796] Instruction DUMP: 952a9011  40045191  90100018 <e25c20d0> a7520000  9190200e  b336700d  90100010  92100011 
[   30.038527] Kernel panic - not syncing: Attempted to kill init!
[   30.091775] Call Trace:
[   30.113606]  [000000000044b4a0] do_exit+0x58/0x60c
[   30.156598]  [0000000000427990] die_if_kernel+0x264/0x28c
[   30.205019]  [00000000005eb604] unhandled_fault+0x84/0x90
[   30.253436]  [0000000000407830] sparc64_realfault_common+0x10/0x20
[   30.308910]  [000000000043422c] dma_4u_alloc_coherent+0x74/0x170
[   30.362915]  [000000000057c584] ethoc_probe+0x258/0x690
[   30.409660]  [00000000005746cc] platform_drv_probe+0xc/0x20
[   30.459661]  [00000000005735bc] driver_probe_device+0x120/0x290
[   30.512791]  [0000000000573780] __driver_attach+0x54/0x80
[   30.561086]  [0000000000572c60] bus_for_each_dev+0x3c/0x84

but I don't use dma. Looks like the sun4v_data_access_exception() happens when ethoc driver try to access to 0xFFF0C2C100 address.

call tree:

ethoc_probe()
  ethoc_get_mac_address()
    ethoc_read()
      ioread32()

Thanks,
Alex.
