From: Meelis Roos <mroos@linux.ee>
Date: Mon, 18 Nov 2019 09:48:20 +0000
Subject: 5.4-rc8 OOPS from path_openat->link_path_walk->inode_permission, on sparc64
Message-Id: <cf84521e-7b7e-570e-9850-1a5573e62786@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>

Just tried 5.3 and 5.4-rc8 on my revived Sun Netra 240 (Ultrasparc III).
gcc-8 was used to compile 5.3, then as a test, packages were upgraded so
gcc-9 was used to compile the 5.4-rc8 kernel in question. Did not see any problems with 5.3.

Started some more package upgrades with 5.4-rc8 with apt and got a crash:

[  294.269620] Kernel unaligned access at TPC[5a9e84] generic_permission+0x164/0x200
[  294.368107] Unable to handle kernel paging request in mna handler
[  294.368110]  at virtual address 91d0200591d02055
[  294.508933] current->{active_,}mm->context = 0000000000000001
[  294.584438] current->{active_,}mm->pgd = fff000133c930000
[  294.655439]               \|/ ____ \|/
[  294.655439]               "@'/ .. \`@"
[  294.655439]               /_| \__/ |_\
[  294.655439]                  \__U_/
[  294.848739] systemd(1): Oops [#1]
[  294.892191] CPU: 0 PID: 1 Comm: systemd Not tainted 5.4.0-rc8 #12
[  294.972257] TSTATE: 0000009111001600 TPC: 00000000005a9e84 TNPC: 00000000005a9e88 Y: 00000000    Not tainted
[  295.101497] TPC: <generic_permission+0x164/0x200>
[  295.163253] g0: 0000000000000000 g1: 91d0200591d02005 g2: 00000000000091d0 g3: 0000000000010000
[  295.277641] g4: fff000133c0ab760 g5: fff000133ec8a000 g6: fff000133c100000 g7: 0000000000000000
[  295.392015] o0: 0000000000000001 o1: fff000133c103d38 o2: fff000133c103a40 o3: fff000133c103a38
[  295.506381] o4: fff000133c103a34 o5: 0000000000040000 sp: fff000133c1030f1 ret_pc: 00000000005abc3c
[  295.625335] RPC: <lookup_fast+0x9c/0x2c0>
[  295.677938] l0: fff000133c9bde60 l1: 0000000000200008 l2: 0000010000284df0 l3: 000007feffd41088
[  295.792320] l4: 00000100000fb0a0 l5: 000001000026ac10 l6: 0000000000000000 l7: fff0000100a65d20
[  295.906690] i0: fff000132e001d08 i1: 0000000000000081 i2: fff000133c103a38 i3: fff000133c103a34
[  296.021068] i4: 0000000000000001 i5: 00000000000091d0 i6: fff000133c1031a1 i7: 00000000005a9f40
[  296.135438] I7: <inode_permission+0x20/0x1e0>
[  296.192623] Call Trace:
[  296.224647]  [00000000005a9f40] inode_permission+0x20/0x1e0
[  296.297851]  [00000000005ad8f4] link_path_walk.part.0+0x74/0x540
[  296.376770]  [00000000005ae498] path_openat+0x78/0x12e0
[  296.445420]  [00000000005b0608] do_filp_open+0x48/0xc0
[  296.512994]  [000000000059c168] do_sys_open+0x168/0x240
[  296.581716]  [0000000000406254] linux_sparc_syscall+0x34/0x44
[  296.657291] Disabling lock debugging due to kernel taint
[  296.727063] Caller[00000000005a9f40]: inode_permission+0x20/0x1e0
[  296.807121] Caller[00000000005ad8f4]: link_path_walk.part.0+0x74/0x540
[  296.892905] Caller[00000000005ae498]: path_openat+0x78/0x12e0
[  296.968388] Caller[00000000005b0608]: do_filp_open+0x48/0xc0
[  297.042734] Caller[000000000059c168]: do_sys_open+0x168/0x240
[  297.118218] Caller[0000000000406254]: linux_sparc_syscall+0x34/0x44
[  297.200570] Caller[fff0000100207200]: 0xfff0000100207200
[  297.270332] Instruction DUMP:
[  297.270334]  b8102000
[  297.309217]  c25e2028
[  297.340098]  07000040
[  297.370982] <c2586050>
[  297.401860]  82084003
[  297.432743]  22c04007
[  297.463623]  d0062008
[  297.494506]  8408a038
[  297.525384]  80a0a000
[  297.556264]
[  297.643992] printk: systemd: 15 output lines suppressed due to ratelimiting
[  297.735610] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[  297.836282] Press Stop-A (L1-A) from sun keyboard or send break
[  297.836282] twice on console to return to the boot prom
[  297.982667] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

-- 
Meelis Roos <mroos@linux.ee>
