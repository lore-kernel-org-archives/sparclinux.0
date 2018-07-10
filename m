From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 10 Jul 2018 07:52:27 +0000
Subject: FreePascal testsuite still triggers sparc64 kernel issues
Message-Id: <2fc3b653-d564-1013-6108-fe64fdd8122a@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

FreePascal is using one of Debian's sparc64 machines to do CI for
the development of their compiler FPC.

The testsuite of FPC has been known to cause kernel issues and even
crash the machine when running on Debian sparc64. While the number of
crashes has been reduced in the past, we're still seeing some kernel
issues from time to time:

[285818.656472] usercopy: Kernel memory exposure attempt detected from null address (offset 0, size 128)!
[285818.656650] kernel BUG at /build/linux-UzksCq/linux-4.17.3/mm/usercopy.c:100!
[285818.656662]               \|/ ____ \|/
                              "@'/ .. \`@"
                              /_| \__/ |_\
                                 \__U_/
[285818.656671] ld-linux.so.2(18698): Kernel bad sw trap 5 [#3]
[285818.656689] CPU: 0 PID: 18698 Comm: ld-linux.so.2 Tainted: G      D           4.17.0-1-sparc64-smp #1 Debian 4.17.3-1
[285818.656702] TSTATE: 0000004411001602 TPC: 0000000000634500 TNPC: 0000000000634504 Y: 00000001    Tainted: G      D          
[285818.656728] TPC: <usercopy_abort+0x80/0xa0>
[285818.656738] g0: ffff80052a534000 g1: 0000000000000000 g2: 0000000000000007 g3: 0000000000000000
[285818.656747] g4: ffff80050734f080 g5: ffff8007fe67e000 g6: ffff80052a534000 g7: 000000000000000e
[285818.656756] o0: 0000000000b94780 o1: 0000000000000064 o2: 0000000000bd5d10 o3: 0000000000b94818
[285818.656765] o4: 0000000000baac80 o5: 0000000000baac80 sp: ffff80052a537061 ret_pc: 00000000006344f8
[285818.656778] RPC: <usercopy_abort+0x78/0xa0>
[285818.656789] l0: ffff80052a534018 l1: 0000000000000003 l2: ffff80052a534000 l3: ffff80052a5343c8
[285818.656799] l4: 0000000000000000 l5: 000007feffa82000 l6: ffff80052a534000 l7: 0000000011001001
[285818.656808] i0: 0000000000b94818 i1: 0000000000baac80 i2: 0000000000000001 i3: 0000000000000000
[285818.656818] i4: 0000000000000080 i5: 000007feffa83671 i6: ffff80052a537131 i7: 00000000006346e0
[285818.656832] I7: <__check_object_size+0x1c0/0x220>
[285818.656837] Call Trace:
[285818.656852]  [00000000006346e0] __check_object_size+0x1c0/0x220
[285818.656874]  [000000000042dfb0] synchronize_user_stack+0xb0/0x180
[285818.656889]  [000000000042dfc4] synchronize_user_stack+0xc4/0x180
[285818.656904]  [000000000042dfc4] synchronize_user_stack+0xc4/0x180
[285818.656918]  [000000000042dfc4] synchronize_user_stack+0xc4/0x180
[285818.656934]  [000000000042dfc4] synchronize_user_stack+0xc4/0x180
[285818.656949]  [000000000042e600] do_signal+0x60/0x480
[285818.656963]  [000000000042f270] do_notify_resume+0x50/0xa0
[285818.656978]  [0000000000404b44] __handle_signal+0xc/0x2c
[285818.656996] Caller[00000000006346e0]: __check_object_size+0x1c0/0x220
[285818.657013] Caller[000000000042dfb0]: synchronize_user_stack+0xb0/0x180
[285818.657028] Caller[000000000042dfc4]: synchronize_user_stack+0xc4/0x180
[285818.657042] Caller[000000000042dfc4]: synchronize_user_stack+0xc4/0x180
[285818.657056] Caller[000000000042dfc4]: synchronize_user_stack+0xc4/0x180
[285818.657071] Caller[000000000042dfc4]: synchronize_user_stack+0xc4/0x180
[285818.657085] Caller[000000000042e600]: do_signal+0x60/0x480
[285818.657099] Caller[000000000042f270]: do_notify_resume+0x50/0xa0
[285818.657111] Caller[0000000000404b44]: __handle_signal+0xc/0x2c
[285818.657123] Caller[ffff8001001296dc]: 0xffff8001001296dc
[285818.657128] Instruction DUMP:
[285818.657134]  92102064 
[285818.657140]  7ff7d142 
[285818.657145]  90122380 
[285818.657151] <91d02005>
[285818.657157]  33002eab 
[285818.657162]  b2166080 
[285818.657168]  98100019 
[285818.657173]  106ffff0 
[285818.657179]  82100019 

[309379.910290] Unable to handle kernel NULL pointer dereference
[309379.910457] tsk->{mm,active_mm}->context = 00000000000009d2
[309379.910554] tsk->{mm,active_mm}->pgd = ffff80067e2e4000
[309379.910601]               \|/ ____ \|/
                              "@'/ .. \`@"
                              /_| \__/ |_\
                                 \__U_/
[309379.910610] ppcsparc(8458): Oops [#4]
[309379.910628] CPU: 10 PID: 8458 Comm: ppcsparc Tainted: G      D           4.17.0-1-sparc64-smp #1 Debian 4.17.3-1
[309379.910640] TSTATE: 0000004423001603 TPC: 0000000000a6cccc TNPC: 0000000000a6ccd0 Y: 00000000    Tainted: G      D          
[309379.910659] TPC: <NGcopy_to_user+0x28c/0x4c0>
[309379.910668] g0: 000000000044d044 g1: 0000000000000080 g2: 0000000000000020 g3: 0000000000000030
[309379.910677] g4: ffff8007e10aa680 g5: ffff8007fe7be000 g6: ffff80052a3ec000 g7: fffffffffffffff2
[309379.910686] o0: ffff80052a3ec500 o1: 0000000000000040 o2: 0000000000000050 o3: 00000000ffaabfd0
[309379.910694] o4: 000000000000002f o5: fffffffffffffff2 sp: ffff80052a3ef171 ret_pc: 0000000000000010
[309379.910703] RPC: <0x10>
[309379.910813] l0: 00000000ffaabfd0 l1: 00000000ffaabf68 l2: 00000000004076ac l3: 0000000000000000
[309379.910847] l4: 0000000000000000 l5: 00000000f4092000 l6: ffff80052a3ec000 l7: 0000000011001005
[309379.910866] i0: ffff80052a3ec500 i1: 0000000000000550 i2: 0000000000000000 i3: ffff80052a3ec550
[309379.910885] i4: 0000000000000000 i5: 0000000000000005 i6: ffff80052a3ef1f1 i7: 000000000042f304
[309379.910928] I7: <save_fpu_state+0x44/0xa0>
[309379.910944] Call Trace:
[309379.910975]  [000000000042f304] save_fpu_state+0x44/0xa0
[309379.911000]  [000000000042f2e8] save_fpu_state+0x28/0xa0
[309379.911031]  [000000000044d640] do_signal32+0x880/0x980
[309379.911055]  [000000000042e714] do_signal+0x174/0x480
[309379.911078]  [000000000042f270] do_notify_resume+0x50/0xa0
[309379.911097]  [0000000000404b44] __handle_signal+0xc/0x2c
[309379.911113] Caller[000000000042f304]: save_fpu_state+0x44/0xa0
[309379.911125] Caller[000000000042f2e8]: save_fpu_state+0x28/0xa0
[309379.911142] Caller[000000000044d640]: do_signal32+0x880/0x980
[309379.911156] Caller[000000000042e714]: do_signal+0x174/0x480
[309379.911169] Caller[000000000042f270]: do_notify_resume+0x50/0xa0
[309379.911180] Caller[0000000000404b44]: __handle_signal+0xc/0x2c
[309379.911189] Caller[0000000000030730]: 0x30730
[309379.911194] Instruction DUMP:
[309379.911199]  84102020 
[309379.911205]  86102030 
[309379.911210]  92102040 
[309379.911215] <d89e5c40>
[309379.911220]  d49e5c4f 
[309379.911226]  c36e4009 
[309379.911232]  d8f22000 
[309379.911238]  daf22008 
[309379.911244]  d89e5c42

Does anyone have a suggestion on how to debug this?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
