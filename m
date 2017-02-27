From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 27 Feb 2017 09:06:21 +0000
Subject: Re: git kernel (4.9.0-rc3) hard lockup on cpu
Message-Id: <CADxRZqyy=FUSf6ac3AKf58g_h9wh5m3zGXdjYEOWKGSdq0Tprw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxOUEaPExMNC9E5sUe777CxOsFmzmHC8EcwtHJO2OC5hQ@mail.gmail.com>
In-Reply-To: <CADxRZqxOUEaPExMNC9E5sUe777CxOsFmzmHC8EcwtHJO2OC5hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Another one....

looking from hypervisor side, it's currently spinning at 100% load.

Console log:

[3242997.705804] fib_no_return.e[88919]: segfault at fff8000100045a20
ip fff800010095c180 (rpc fff800010095cfb4) sp fff8000100045b10 error
30002 in
libc-2.24.so[fff80001008dc000+15e000]
[3242998.037056] Kernel unaligned access at TPC[4a94b0] source_load+0x30/0x80
[3242998.037106] Kernel unaligned access at TPC[4b57f0]
find_busiest_group+0x190/0x9c0
[3242998.037145] Kernel unaligned access at TPC[4b57f4]
find_busiest_group+0x194/0x9c0
[3242998.037153] ------------[ cut here ]------------
[3242998.037171] WARNING: CPU: 96 PID: 89282 at
kernel/sched/core.c:103 update_rq_clock+0x84/0xa0
[3242998.037173] Modules linked in: xt_tcpudp xt_multiport
xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_n
at nf_conntrack tun flash n2_rng rng_core camellia_sparc64 des_sparc64
des_generic aes_sparc64 md5_sparc64 sha512_sparc64[3242998.037232]
Kernel una
ligned access at TPC[4b5810] find_busiest_group+0x1b0/0x9c0
[3242998.037242] Kernel unaligned access at TPC[4b581c]
find_busiest_group+0x1bc/0x9c0
[3242998.037333]  sha256_sparc64 sha1_sparc64 ip_tables x_tables
autofs4 ext4 crc16 jbd2 fscrypto mbcache btrfs xor zlib_deflate
raid6_pq crc32c_spa
rc64 sunvnet sunvdc
[3242998.037454] CPU: 96 PID: 89282 Comm:  Not tainted 4.9.0-rc5+ #2
[3242998.037490] Call Trace:
[3242998.037513] ---[ end trace cf2c87b49379299d ]---
[3242998.037532] ------------[ cut here ]------------
[3242998.037560] WARNING: CPU: 96 PID: 89282 at
kernel/sched/sched.h:772 update_curr+0xe8/0x320
[3242998.037588] Modules linked in: xt_tcpudp xt_multiport
xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_n
at nf_conntrack tun flash n2_rng rng_core camellia_sparc64 des_sparc64
des_generic aes_sparc64 md5_sparc64 sha512_sparc64 sha256_sparc64
sha1_sparc6
4 ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto mbcache btrfs
xor zlib_deflate raid6_pq crc32c_sparc64 sunvnet sunvdc
[3242998.037812] CPU: 96 PID: 89282 Comm:  Tainted: G        W
4.9.0-rc5+ #2
[3242998.037852] Call Trace:
[3242998.037874] ---[ end trace cf2c87b49379299e ]---
[3242998.037894] ------------[ cut here ]------------
[3242998.037918] WARNING: CPU: 96 PID: 89282 at
kernel/sched/sched.h:772 update_curr+0xe8/0x320
[3242998.037947] Modules linked in: xt_tcpudp xt_multiport
xt_conntrack iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack tun flash n2_rng
rng_core camellia_sparc64 des_sparc64 des_generic aes_sparc64
md5_sparc64 sha512_sparc64 sha256_sparc64 sha1_sparc64 ip_tables
x_tables autofs4 ext4 crc16 jbd2 fscrypto mbcache btrfs xor
zlib_deflate raid6_pq crc32c_sparc64 sunvnet sunvdc
[3242998.038178] CPU: 96 PID: 89282 Comm:  Tainted: G        W
4.9.0-rc5+ #2
[3242998.038189] Unable to handle kernel paging request in mna handler
[3242998.038189]  at virtual address f80001006504d297
[3242998.038191] current->{active_,}mm->context = 0000000000000dd5
[3242998.038193] current->{active_,}mm->pgd = fff8001e0c85c000
[3242998.038195]               \|/ ____ \|/
[3242998.038195]               "@'/ .. \`@"
[3242998.038195]               /_| \__/ |_\
[3242998.038195]                  \__U_/
[3242998.038198] fib_no_sync.exe(89279): Oops [#1]
[3242998.038203] CPU: 45 PID: 89279 Comm: fib_no_sync.exe Tainted: G
     W       4.9.0-rc5+ #2
[3242998.038207] task: fff8001dc9af2900 task.stack: fff8001e15b9c000
[3242998.038211] TSTATE: 0000009911e01607 TPC: 00000000007a32e4 TNPC:
00000000007a32e8 Y: 00000129    Tainted: G        W
[3242998.038223] TPC: <atomic_add+0x4/0x54>
[3242998.038227] g0: 0000000000000001 g1: 0000000000dd0099 g2:
f8000100666860ff g3: f800010083ef20ff
[3242998.038230] Unable to handle kernel paging request in mna handler
[3242998.038230] g4: fff8001dc9af2900 g5: fff800207c7da000 g6:
fff8001e15b9c000 g7: f800010083ef20ff
[3242998.038231]  at virtual address f80001006504d297
[3242998.038232] o0: 0000000000000001 o1: f80001006504d297 o2:
0000000000000001 o3: 0000000000000000
[3242998.038234] current->{active_,}mm->context = 0000000000000dd5
[3242998.038236] o4: 0000000000000080 o5: 0000000000000080 sp:
fff8001e15b9ede1 ret_pc: 00000000004cbb18
[3242998.038237] current->{active_,}mm->pgd = fff8001e0c85c000
[3242998.038249] RPC: <__lock_acquire+0x78/0x1ca0>
[3242998.038254] l0: fff8001dc9af2900 l1: 0000000001a67400 l2:
0000000000dd00b9 l3: 0000000000cff400
[3242998.038255]               \|/ ____ \|/
[3242998.038255]               "@'/ .. \`@"
[3242998.038255]               /_| \__/ |_\
[3242998.038255]                  \__U_/
[3242998.038256] l4: f80001006504d0ff l5: 0000000000000001 l6:
0000000000000000 l7: 0000000000000000
[3242998.038258] fib_no_sync.exe(89308): Oops [#2]
[3242998.038259] i0: 0000000000dd0099 i1: 0000000000000000 i2:
0000000000000000 i3: 0000000000000000
[3242998.038262] CPU: 46 PID: 89308 Comm: fib_no_sync.exe Tainted: G
     W       4.9.0-rc5+ #2
[3242998.038264] i4: 0000000000000001 i5: 0000000000000001 i6:
fff8001e15b9ef01 i7: 00000000004cdb80
[3242998.038266] task: fff8001dd54503a0 task.stack: fff8001e0d7ec000
[3242998.038269] I7: <lock_acquire+0x80/0x240>
[3242998.038272] Call Trace:
[3242998.038274] TSTATE: 0000009911e01607 TPC: 00000000007a32e4 TNPC:
00000000007a32e8 Y: 00000129    Tainted: G        W
[3242998.038277]  [00000000004cdb80] lock_acquire+0x80/0x240
[3242998.038280] TPC: <atomic_add+0x4/0x54>
[3242998.038287]  [0000000000a6ffe4] _raw_spin_lock_irqsave+0x44/0x60
[3242998.038299]  [00000000004b62ec] load_balance+0x2cc/0xb20
[3242998.038301] g0: 0000000000000001 g1: 0000000000dd0099 g2:
f8000100666860ff g3: f800010083ef20ff
[3242998.038304]  [00000000004b7018] pick_next_task_fair+0x4d8/0x880
[3242998.038305] g4: fff8001dd54503a0 g5: fff800207c7fa000 g6:
fff8001e0d7ec000 g7: f800010083ef20ff
[3242998.038316]  [0000000000a69cd0] __schedule+0x190/0x4b4
[3242998.038317] o0: 0000000000000001 o1: f80001006504d297 o2:
0000000000000001 o3: 0000000000000000
[3242998.038320]  [0000000000a6a930] schedule+0x30/0xc0
[3242998.038321] o4: 0000000000000080 o5: 0000000000000080 sp:
fff8001e0d7eede1 ret_pc: 00000000004cbb18
[3242998.038324]  [0000000000a6f6d8] do_nanosleep+0xf8/0x160
[3242998.038327] RPC: <__lock_acquire+0x78/0x1ca0>
[3242998.038335]  [00000000005040b8] hrtimer_nanosleep+0xb8/0x140
[3242998.038337] l0: fff8001dd54503a0 l1: 0000000001a67400 l2:
0000000000dd00b9 l3: 0000000000cff400
[3242998.038341]  [0000000000504198] SyS_nanosleep+0x58/0x80
[3242998.038343] l4: f80001006504d0ff l5: 0000000000000001 l6:
0000000000000000 l7: 0000000000000000
[3242998.038352]  [0000000000406234] linux_sparc_syscall+0x34/0x44
[3242998.038355] Disabling lock debugging due to kernel taint
[3242998.038357] i0: 0000000000dd0099 i1: 0000000000000000 i2:
0000000000000000 i3: 0000000000000000
[3242998.038360] Caller[00000000004cdb80]: lock_acquire+0x80/0x240
[3242998.038361] i4: 0000000000000001 i5: 0000000000000001 i6:
fff8001e0d7eef01 i7: 00000000004cdb80
[3242998.038364] Caller[0000000000a6ffe4]: _raw_spin_lock_irqsave+0x44/0x60
[3242998.038367] I7: <lock_acquire+0x80/0x240>
[3242998.038369] Caller[00000000004b62ec]: load_balance+0x2cc/0xb20
[3242998.038370] Call Trace:
[3242998.038373] Caller[00000000004b7018]: pick_next_task_fair+0x4d8/0x880
[3242998.038376]  [00000000004cdb80] lock_acquire+0x80/0x240
[3242998.038380]  [0000000000a6ffe4] _raw_spin_lock_irqsave+0x44/0x60
[3242998.038384] Caller[0000000000a69cd0]: __schedule+0x190/0x4b4
[3242998.038386]  [00000000004b62ec] load_balance+0x2cc/0xb20
[3242998.038389] Caller[0000000000a6a930]: schedule+0x30/0xc0
[3242998.038392]  [00000000004b7018] pick_next_task_fair+0x4d8/0x880
[3242998.038394] Caller[0000000000a6f6d8]: do_nanosleep+0xf8/0x160
[3242998.038397]  [0000000000a69cd0] __schedule+0x190/0x4b4
[3242998.038401]  [0000000000a6a930] schedule+0x30/0xc0
[3242998.038404] Caller[00000000005040b8]: hrtimer_nanosleep+0xb8/0x140
[3242998.038406]  [0000000000a6f6d8] do_nanosleep+0xf8/0x160
[3242998.038409] Caller[0000000000504198]: SyS_nanosleep+0x58/0x80
[3242998.038411]  [00000000005040b8] hrtimer_nanosleep+0xb8/0x140
[3242998.038414] Caller[0000000000406234]: linux_sparc_syscall+0x34/0x44
[3242998.038416]  [0000000000504198] SyS_nanosleep+0x58/0x80
[3242998.038419] Caller[fff800010099382c]: 0xfff800010099382c
[3242998.038421]  [0000000000406234] linux_sparc_syscall+0x34/0x44
[3242998.038425] Instruction DUMP:
[3242998.038429]  01000000
[3242998.038429] Caller[00000000004cdb80]: lock_acquire+0x80/0x240
[3242998.038432]  01000000
[3242998.038433] Caller[0000000000a6ffe4]: _raw_spin_lock_irqsave+0x44/0x60
[3242998.038438]  94102001
[3242998.038438] Caller[00000000004b62ec]: load_balance+0x2cc/0xb20
[3242998.038441] <c2024000>
[3242998.038442] Caller[00000000004b7018]: pick_next_task_fair+0x4d8/0x880
[3242998.038445]  8e004008
[3242998.038445] Caller[0000000000a69cd0]: __schedule+0x190/0x4b4
[3242998.038449]  cfe25001
[3242998.038449] Caller[0000000000a6a930]: schedule+0x30/0xc0
[3242998.038452]  80a04007
[3242998.038452] Caller[0000000000a6f6d8]: do_nanosleep+0xf8/0x160
[3242998.038457]  12400004
[3242998.038457] Caller[00000000005040b8]: hrtimer_nanosleep+0xb8/0x140
[3242998.038460]  01000000
[3242998.038460] Caller[0000000000504198]: SyS_nanosleep+0x58/0x80
[3242998.038461]
[3242998.038463] Caller[0000000000406234]: linux_sparc_syscall+0x34/0x44
[3242998.038464] ------------[ cut here ]------------
[3242998.038466] Caller[fff800010099382c]: 0xfff800010099382c
[3242998.038480] WARNING: CPU: 45 PID: 89279 at
kernel/sched/core.c:7718 __might_sleep+0x7c/0xa0
[3242998.038484] Instruction DUMP:
[3242998.038484] do not call blocking ops when !TASK_RUNNING; state=1
set at [<0000000000a6f69c>] do_nanosleep+0xbc/0x160
[3242998.038486]  01000000
[3242998.038487] Modules linked in:
[3242998.038489]  01000000
[3242998.038490]  xt_tcpudp 94102001
[3242998.038492]  xt_multiport<c2024000>
[3242998.038494]  xt_conntrack 8e004008
[3242998.038495]  iptable_filter cfe25001
[3242998.038497]  iptable_nat
WARNING: Failed to send Mondo to CPU# 34

WARNING: Failed to send Mondo to CPU# 34

WARNING: Failed to send Mondo to CPU# 34

WARNING: Failed to send Mondo to CPU# 34
