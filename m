From: Alex Mach <alexvm12e@mail.ru>
Date: Thu, 13 May 2010 10:18:58 +0000
Subject: =?koi8-r?Q?sun4v=5Fdata=5Faccess=5Fexception_during_access_to_hardware?=
Message-Id: <E1OCVVK-0007yy-00.alexvm12e-mail-ru@f252.mail.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I'd like use ethoc driver for OpenCores MAC under Linux (2.6.33). I'm using OpenSparc T1 on FPGA. I have hardware device (OpenCores MAC) at address 0xFFF0C2C100. So I added device to platform bus with IORESOURCE_MEM (io memory space) at 0xFFF0C2C100. 

devm_ioremap_nocache() return OK but during ethoc driver initialization I have following messages:

[   36.003607] sun4v_data_access_exception: ADDR[000000fff0c2c000] CTX[0000] TYPE[0004], going.
[   36.079528]               \|/ ____ \|/
[   36.079601]               "@'/ .. \`@"
[   36.079659]               /_| \__/ |_\
[   36.079717]                  \__U_/
[   36.211331] swapper(1): Dax [#1]
[   36.240124] TSTATE: 0000004480001604 TPC: 000000000057cb94 TNPC: 000000000057cb98 Y: 00000000    Not tainted
[   36.328731] TPC: <ethoc_probe+0x708/0x760>
[   36.365074] g0: fffff80001656a80 g1: fffff800014d3bd0 g2: 000000fff0c2c140 g3: 0000000000000000
[   36.443497] g4: fffff800014c8000 g5: 0000000000000000 g6: fffff800014cc000 g7: 0000000000000000
[   36.521552] o0: 0000000000000040 o1: 0000000000000000 o2: 000000000000a001 o3: 000000000000a001
[   36.599568] o4: 0000000000000000 o5: 0000000000000000 sp: fffff800014cf101 ret_pc: 000000000057c7fc
[   36.680836] RPC: <ethoc_probe+0x370/0x760>
[   36.717216] l0: fffff8000165e800 l1: fffff8000165ed00 l2: 0000000000000000 l3: fffff80001656a00
[   36.795558] l4: fffff80001656a80 l5: 0000000040004110 l6: 00000000fff4d701 l7: 00000000f025bfe8
[   36.873592] i0: 0000000000686360 i1: 0000000000686370 i2: 000000000069cf18 i3: 000000000057382c
[   36.951678] i4: 000000000063d278 i5: 000000000067be68 i6: fffff800014cf1b1 i7: 00000000005747cc
[   37.029857] I7: <platform_drv_probe+0xc/0x20>
[   37.068530] Disabling lock debugging due to kernel taint
[   37.116312] Caller[00000000005747cc]: platform_drv_probe+0xc/0x20
[   37.170984] Caller[00000000005736bc]: driver_probe_device+0x120/0x290
[   37.228763] Caller[0000000000573880]: __driver_attach+0x54/0x80
[   37.281840] Caller[0000000000572d60]: bus_for_each_dev+0x3c/0x84
[   37.335706] Caller[00000000005725d8]: bus_add_driver+0xec/0x27c
[   37.388815] Caller[0000000000573b78]: driver_register+0xb4/0x164
[   37.442688] Caller[0000000000426ac4]: do_one_initcall+0x44/0x164
[   37.496604] Caller[00000000006ae1a8]: kernel_init+0xac/0x110
[   37.547308] Caller[000000000042a8dc]: kernel_thread+0x30/0x48
[   37.598859] Caller[00000000005e7344]: rest_init+0x18/0x68
[   37.647113] Instruction DUMP: 81cfe008  01000000  8400a040 <c48083a0> c428600
5  8f30a018  8730a010  ce286002  8530a008
[   37.743862] Kernel panic - not syncing: Attempted to kill init!
[   37.797051] Call Trace:
[   37.818931]  [000000000044b4d0] do_exit+0x58/0x60c
[   37.861935]  [0000000000427990] die_if_kernel+0x264/0x28c
[   37.910365]  [0000000000428404] sun4v_data_access_exception+0x98/0x108
[   37.968998]  [0000000000406aa4] sun4v_dacc+0x28/0x34
[   38.013460]  [000000000057cb94] ethoc_probe+0x708/0x760
[   38.060318]  [00000000005747cc] platform_drv_probe+0xc/0x20
[   38.110275]  [00000000005736bc] driver_probe_device+0x120/0x290
[   38.163367]  [0000000000573880] __driver_attach+0x54/0x80
[   38.211752]  [0000000000572d60] bus_for_each_dev+0x3c/0x84
[   38.260954]  [00000000005725d8] bus_add_driver+0xec/0x27c
[   38.309362]  [0000000000573b78] driver_register+0xb4/0x164
[   38.358583]  [0000000000426ac4] do_one_initcall+0x44/0x164
[   38.407736]  [00000000006ae1a8] kernel_init+0xac/0x110
[   38.453805]  [000000000042a8dc] kernel_thread+0x30/0x48
[   38.500667]  [00000000005e7344] rest_init+0x18/0x68
[   38.500667]  [00000000005e7344] rest_init+0x18/0x68


Can anyone explain me how should I set address of hardware under Linux? Perhaps I need to add device to MD?

Thanks,
Alex.



