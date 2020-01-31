From: Anatoly Pugachev <matorola@gmail.com>
Date: Fri, 31 Jan 2020 15:06:52 +0000
Subject: [sparc64] stall on CPU with current git master
Message-Id: <CADxRZqy3LNu=DW2Mn8G6E-Ewrg2Q4gDXbxFqJXyfcDom4YW_oQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sparc kernel list <sparclinux@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel list <linux-kernel@vger.kernel.org>

Hello!

Current git master branch (at the time of writing
5.5.0-07763-gccaaaf6fe5a5 ) started to hang on my sparc64 ldom.
Bisected "stall on CPU" (which occasionally leads to machine hang) to
this patch:

$ git bisect bad
251ec1c159e4874fbede0c3c586e317e177c0c9b is the first bad commit
commit 251ec1c159e4874fbede0c3c586e317e177c0c9b
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Dec 11 21:07:23 2019 +0100

    y2038: sparc: remove use of struct timex

    'struct timex' is one of the last users of 'struct timeval' and is
    only referenced in one place in the kernel any more, to convert the
    user space timex into the kernel-internal version on sparc64, with a
    different tv_usec member type.

    As a preparation for hiding the time_t definition and everything
    using that in the kernel, change the implementation once more
    to only convert the timeval member, and then enclose the
    struct definition in an #ifdef.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 arch/sparc/kernel/sys_sparc_64.c | 33 +++++++++++++++++----------------
 include/uapi/linux/timex.h       |  2 ++
 2 files changed, 19 insertions(+), 16 deletions(-)

$ git desc 251ec1c159e4874fbede0c3c586e317e177c0c9b
v5.5-rc1-19-g251ec1c159e4

kernel 5.5.0-rc1-00018-g4f9fbd893fe8 - works perfectly (i.e. does not
hang or produce "stall on CPU" )

current master with the patch reverted -
5.5.0-07763-gccaaaf6fe5a5-dirty - works perfectly

current master 5.5.0-07763-gccaaaf6fe5a5 - stalls, hangs


Can someone look what is wrong with it and/or probably revert it ?!
Thanks.



bisect log:

$ git bisect log
# bad: [39bed42de2e7d74686a2d5a45638d6a5d7e7d473] Merge tag
'for-linus-hmm' of
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
# good: [b3a6082223369203d7e7db7e81253ac761377644] Merge branch
'for-v5.6' of git://git.kernel.org:/pub/scm/linux/kernel/git/jmorris/linux-=
security
# good: [aac96626713fe167c672f9a008be0f514aa3e237] Merge tag
'usb-5.6-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect start '39bed42de2e7d74686a2d5a45638d6a5d7e7d473'
'b3a608222336' 'aac96626713fe167c672f9a008be0f514aa3e237'
# skip: [7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838] Merge tag
'staging-5.6-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect skip 7ba31c3f2f1ee095d8126f4d3757fc3b2bc3c838
# good: [7a176c1079427194084eb169c554f0782ce6f0b4] staging: rtl8192u:
replace printk with natdev_<LEVEL> statements in ieee80211
git bisect good 7a176c1079427194084eb169c554f0782ce6f0b4
# good: [15d6632496537fa66488221ee5dd2f9fb318ef2e] Merge branch
'urgent-for-mingo' of
git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu
git bisect good 15d6632496537fa66488221ee5dd2f9fb318ef2e
# bad: [e9f8ca0ae7b7bc9a032b429929431c626a69dd5e] Merge tag
'for-5.6/dm-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
git bisect bad e9f8ca0ae7b7bc9a032b429929431c626a69dd5e
# bad: [22b17db4ea05561c7c8e4d770f10751e22e339f9] Merge tag
'y2038-drivers-for-v5.6-signed' of
git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground
git bisect bad 22b17db4ea05561c7c8e4d770f10751e22e339f9
# good: [587065dcac64e88132803cdb0a7f26bb4a79cf46] fs/adfs: bigdir:
Fix an error code in adfs_fplus_read()
git bisect good 587065dcac64e88132803cdb0a7f26bb4a79cf46
# good: [3893c2025fec6f0fa4b2d794f36bd56a55e46dec] Merge tag
'erofs-for-5.6-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
git bisect good 3893c2025fec6f0fa4b2d794f36bd56a55e46dec
# good: [38c4a4cf02513a7904b9db0a668b7e50145ea696] drm/etnaviv: avoid
deprecated timespec
git bisect good 38c4a4cf02513a7904b9db0a668b7e50145ea696
# good: [4f9fbd893fe83a1193adceca41c8f7aa6c7382a1] y2038: rename
itimerval to __kernel_old_itimerval
git bisect good 4f9fbd893fe83a1193adceca41c8f7aa6c7382a1
# bad: [c4e71212a245017d2ab05f322f7722f0b87a55da] Revert "drm/etnaviv:
reject timeouts with tv_nsec >=3D NSEC_PER_SEC"
git bisect bad c4e71212a245017d2ab05f322f7722f0b87a55da
# bad: [251ec1c159e4874fbede0c3c586e317e177c0c9b] y2038: sparc: remove
use of struct timex
git bisect bad 251ec1c159e4874fbede0c3c586e317e177c0c9b
# first bad commit: [251ec1c159e4874fbede0c3c586e317e177c0c9b] y2038:
sparc: remove use of struct timex



server console log with 5.5.0-rc1-00019-g251ec1c159e4 :

ttip login: [   72.254126] rcu: INFO: rcu_sched self-detected stall on CPU
[   72.254254] rcu:     8-....: (2599 ticks this GP)
idle=0Fe/1/0x4000000000000002 softirq=1380/1380 fqs=1285
[   72.254407]  (t&00 jiffies g269 q$5)
[   72.254566] * CPU[  8]: TSTATE[0000004480001606]
TPC[00000000004d7524] TNPC[00000000004d7528] TASK[systemd-timesyn:739]
[   72.254722]              TPC[lock_is_held_type+0xc4/0xe0]
O7[lock_is_held_type+0x6c/0xe0] I7[rcu_read_lock_held+0x2c/0x40]
RPC[mem_cgroup_from_task+0x80/0xc0]
[   96.384129] watchdog: BUG: soft lockup - CPU#8 stuck for 22s!
[systemd-timesyn:739]
[   96.384213] Modules linked in: tun binfmt_misc md5_sparc64
sha512_generic sha512_sparc64 pktcdvd cdrom sha256_sparc64 n2_rng
rng_core flash sha1_sparc64 nft_ct nf_conntrack nf_defrag_ipv4
nft_counter nf_tables_set nf_tables nfnetlink ip_tables x_tables ipv6
crc_ccitt nf_defrag_ipv6 autofs4 ext4 crc16 mbcache jbd2 raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx
raid6_pq raid0 multipath linear raid1 md_mod crc32c_sparc64
[   96.384535] irq event stamp: 28104018
[   96.384581] hardirqs last  enabled at (28104017):
[<0000000000652da8>] handle_mm_fault+0x188/0x320
[   96.384649] hardirqs last disabled at (28104018):
[<0000000000427484>] sys_call_table+0x774/0x970
[   96.384718] softirqs last  enabled at (2561456):
[<0000000000b6ffc8>] __do_softirq+0x4a8/0x520
[   96.384783] softirqs last disabled at (2561409):
[<000000000042d094>] do_softirq_own_stack+0x34/0x60
[   96.384851] CPU: 8 PID: 739 Comm: systemd-timesyn Not tainted
5.5.0-rc1-00019-g251ec1c159e4 #2
[   96.384914] TSTATE: 0000009980001604 TPC: 00000000004dae1c TNPC:
00000000004dae20 Y: 00000000    Not tainted
[   96.384986] TPC: <lock_acquire+0x1bc/0x1e0>
[   96.385022] g0: 00000000004d7528 g1: 0000000000000002 g2:
00000000010c2000 g3: 000000000000000c
[   96.385085] g4: fff80024a0568800 g5: fff80024abedc000 g6:
fff8002498368000 g7: fff80024a0569098
[   96.385147] o0: 0000000000000001 o1: ffffffff8df65199 o2:
e41211d6c7b54aa1 o3: 0000000000000008
[   96.385210] o4: 480f667790deb947 o5: 0000000000000000 sp:
fff800249836b0d1 ret_pc: 00000000004dae0c
[   96.385275] RPC: <lock_acquire+0x1ac/0x1e0>
[   96.385311] l0: 0000000000e84c00 l1: 0000000000dbe410 l2:
0000000000000000 l3: 0000000000652c74
[   96.385373] l4: 0000000000000000 l5: 0000000000000003 l6:
0000000000000000 l7: 0000000000000008
[   96.385435] i0: 0000000000de94b0 i1: 0000000000000000 i2:
0000000000000000 i3: 0000000000000002
[   96.385497] i4: 0000000000000000 i5: 0000000000000000 i6:
fff800249836b1a1 i7: 0000000000652ca4
[   96.385561] I7: <handle_mm_fault+0x84/0x320>
[   96.385597] Call Trace:
[   96.385624]  [0000000000652ca4] handle_mm_fault+0x84/0x320
[   96.385668]  [0000000000b6f2bc] do_sparc64_fault+0x43c/0x820
[   96.385720]  [0000000000407754] sparc64_realfault_common+0x10/0x20
[   96.385769]  [000000000042fa28] __do_sys_sparc_clock_adjtime+0x28/0x80
[   96.385819]  [00000000004307f0] sys_sparc_clock_adjtime+0x10/0x20
[   96.385866]  [0000000000406294] linux_sparc_syscall+0x34/0x44
[  150.284130] rcu: INFO: rcu_sched self-detected stall on CPU
[  150.284201] rcu:     8-....: (10402 ticks this GP)
idle=0Fe/1/0x4000000000000002 softirq=1380/1380 fqsQ30
[  150.284277]  (t=10403 jiffies g269 q=1520)
[  150.284336] * CPU[  8]: TSTATE[0000000080001601]
TPC[000000000040774c] TNPC[0000000000407750] TASK[systemd-timesyn:739]
[  150.284435]              TPC[sparc64_realfault_common+0x8/0x20]
O7[rtrap_xcall+0x18/0x20] I7[__do_sys_sparc_clock_adjtime+0x1c/0x80]
RPC[sys_sparc_clock_adjtime+0x10/0x20]
[  176.384128] watchdog: BUG: soft lockup - CPU#8 stuck for 23s!
[systemd-timesyn:739]
[  176.384211] Modules linked in: tun binfmt_misc md5_sparc64
sha512_generic sha512_sparc64 pktcdvd cdrom sha256_sparc64 n2_rng
rng_core flash sha1_sparc64 nft_ct nf_conntrack nf_defrag_ipv4
nft_counter nf_tables_set nf_tables nfnetlink ip_tables x_tables ipv6
crc_ccitt nf_defrag_ipv6 autofs4 ext4 crc16 mbcache jbd2 raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx
raid6_pq raid0 multipath linear raid1 md_mod crc32c_sparc64
[  176.384512] irq event stamp: 73014502
[  176.384553] hardirqs last  enabled at (73014501):
[<0000000000652da8>] handle_mm_fault+0x188/0x320
[  176.384617] hardirqs last disabled at (73014502):
[<0000000000427484>] sys_call_table+0x774/0x970
[  176.384681] softirqs last  enabled at (2561456):
[<0000000000b6ffc8>] __do_softirq+0x4a8/0x520
[  176.384742] softirqs last disabled at (2561409):
[<000000000042d094>] do_softirq_own_stack+0x34/0x60
[  176.384807] CPU: 8 PID: 739 Comm: systemd-timesyn Tainted: G
     L    5.5.0-rc1-00019-g251ec1c159e4 #2
[  176.384874] TSTATE: 0000004480001603 TPC: 00000000004dac50 TNPC:
0000000000652e28 Y: 00000000    Tainted: G             L
[  176.384949] TPC: <lock_release+0x310/0x320>
[  176.384983] g0: fff80024a0568801 g1: 7209ae8657c65af7 g2:
57d75456c49190af g3: d5519f907209ae86
[  176.385042] g4: fff80024a0568800 g5: fff80024abedc000 g6:
fff8002498368000 g7: fff80024a0569070
[  176.385101] o0: 0000000000de94b0 o1: 0000000000652e08 o2:
0000000000000002 o3: 0000000000000000
[  176.385160] o4: fff80024a0568800 o5: fff80024a0569098 sp:
fff800249836b1a1 ret_pc: 0000000000652e20
[  176.385222] RPC: <handle_mm_fault+0x200/0x320>
[  176.385257] l0: fff80024ace17780 l1: fff80024ace17898 l2:
fff80024ace17918 l3: fff80024ace17998
[  176.385316] l4: 0000000000000000 l5: 0000000000000003 l6:
0000000000000000 l7: 0000000000000008
[  176.385375] i0: fff80024a5fac600 i1: 000007feffa18000 i2:
0000000000000014 i3: 0000000000000000
[  176.385433] i4: 0000000000de9400 i5: 0000000000e84c00 i6:
fff800249836b261 i7: 0000000000b6f2bc
[  176.385493] I7: <do_sparc64_fault+0x43c/0x820>
[  176.385528] Call Trace:
[  176.385553]  [0000000000b6f2bc] do_sparc64_fault+0x43c/0x820
[  176.385604]  [0000000000407754] sparc64_realfault_common+0x10/0x20
[  176.385649]  [000000000042fa28] __do_sys_sparc_clock_adjtime+0x28/0x80
[  176.385697]  [00000000004307f0] sys_sparc_clock_adjtime+0x10/0x20
[  176.385742]  [0000000000406294] linux_sparc_syscall+0x34/0x44


kernel log with 5.5.0-07763-gccaaaf6fe5a5 :


ttip login: [   16.557894] systemd-journald[766]: File
/var/log/journal/c02366aaa6e44182ba0caa130d880aac/user-1000.journal
corrupted or uncleanly shut down, renaming and replacing.
[   63.887631] rcu: INFO: rcu_sched self-detected stall on CPU
[   63.887778] rcu:     29-....: (2599 ticks this GP)
idle=952/1/0x4000000000000002 softirqY8/598 fqs=1251
[   63.887942]  (t&00 jiffies g=3D-43 q!8)
[   63.888113] * CPU[ 29]: TSTATE[0000009980001606]
TPC[00000000004db5fc] TNPC[00000000004db600] TASK[systemd-timesyn:720]
[   63.888281]              TPC[lock_acquire+0x1bc/0x1e0]
O7[lock_acquire+0x1ac/0x1e0] I7[_raw_spin_lock+0x30/0x60]
RPC[__handle_mm_fault+0xd90/0xe80]
[   88.587624] watchdog: BUG: soft lockup - CPU#29 stuck for 22s!
[systemd-timesyn:720]
[   88.587718] Modules linked in: tun binfmt_misc md5_sparc64 nft_ct
nf_conntrack nf_defrag_ipv4 sha512_generic sha512_sparc64
sha256_sparc64 pktcdvd cdrom n2_rng flash sha1_sparc64 rng_core
nft_counter nf_tables_set nf_tables nfnetlink ip_tables x_tables ipv6
crc_ccitt nf_defrag_ipv6 autofs4 ext4 crc16 mbcache jbd2 raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx
raid6_pq raid0 multipath linear raid1 md_mod crc32c_sparc64
[   88.588021] irq event stamp: 28198072
[   88.588060] hardirqs last  enabled at (28198071):
[<0000000000658788>] handle_mm_fault+0x188/0x320
[   88.588126] hardirqs last disabled at (28198072):
[<00000000004274a4>] sys_call_table+0x784/0x960
[   88.588190] softirqs last  enabled at (836258):
[<0000000000b811c8>] __do_softirq+0x4a8/0x520
[   88.588251] softirqs last disabled at (836211):
[<000000000042d134>] do_softirq_own_stack+0x34/0x60
[   88.588315] CPU: 29 PID: 720 Comm: systemd-timesyn Not tainted
5.5.0-07763-gccaaaf6fe5a5 #5
[   88.588374] TSTATE: 0000009980001604 TPC: 00000000004db5fc TNPC:
00000000004db600 Y: 00000000    Not tainted
[   88.588443] TPC: <lock_acquire+0x1bc/0x1e0>
[   88.588477] g0: 00000000004d7d08 g1: 0000000000000001 g2:
00000000010d6000 g3: 000000000000000e
[   88.588537] g4: fff800007d56cc00 g5: fff80024ac408000 g6:
fff800249d338000 g7: fff800007d56d470
[   88.588597] o0: 0000000000000001 o1: ffffffff00000120 o2:
0003d3c3004967fd o3: 000000000000000a
[   88.588656] o4: 489a037ae4012785 o5: 0001200000000000 sp:
fff800249d33b0c1 ret_pc: 00000000004db5ec
[   88.588718] RPC: <lock_acquire+0x1ac/0x1e0>
[   88.588752] l0: 0000000000eaa400 l1: 0000000000dd2450 l2:
0000000000000000 l3: 0000000000b80254
[   88.588811] l4: 0000000000000000 l5: 0000000000000003 l6:
0000000000000000 l7: 0000000000000008
[   88.588871] i0: fff8002032371888 i1: 0000000000000000 i2:
0000000000000001 i3: 0000000000000001
[   88.588930] i4: 0000000000000001 i5: 0000000000000000 i6:
fff800249d33b191 i7: 00000000004cf5c0
[   88.588994] I7: <down_read_trylock+0x100/0x140>
[   88.589029] Call Trace:
[   88.589055]  [00000000004cf5c0] down_read_trylock+0x100/0x140
[   88.589099]  [0000000000b80254] do_sparc64_fault+0x1d4/0x820
[   88.589145]  [0000000000407754] sparc64_realfault_common+0x10/0x20
[   88.589191]  [000000000042fac8] __do_sys_sparc_clock_adjtime+0x28/0x80
[   88.589239]  [0000000000430890] sys_sparc_clock_adjtime+0x10/0x20
[   88.589284]  [0000000000406294] linux_sparc_syscall+0x34/0x44
[  141.917625] rcu: INFO: rcu_sched self-detected stall on CPU
[  141.917698] rcu:     29-....: (10402 ticks this GP)
idle=952/1/0x4000000000000002 softirqY8/598 fqsP34
[  141.917772]  (t=10403 jiffies g=3D-43 qA6)
[  141.917832] * CPU[ 29]: TSTATE[0000000080001601]
TPC[000000000040774c] TNPC[0000000000407750] TASK[systemd-timesyn:720]
[  141.917927]              TPC[sparc64_realfault_common+0x8/0x20]
O7[rtrap_xcall+0x18/0x20] I7[__do_sys_sparc_clock_adjtime+0x1c/0x80]
RPC[sys_sparc_clock_adjtime+0x10/0x20]
[  168.587624] watchdog: BUG: soft lockup - CPU#29 stuck for 23s!
[systemd-timesyn:720]
[  168.587720] Modules linked in: tun binfmt_misc md5_sparc64 nft_ct
nf_conntrack nf_defrag_ipv4 sha512_generic sha512_sparc64
sha256_sparc64 pktcdvd cdrom n2_rng flash sha1_sparc64 rng_core
nft_counter nf_tables_set nf_tables nfnetlink ip_tables x_tables ipv6
crc_ccitt nf_defrag_ipv6 autofs4 ext4 crc16 mbcache jbd2 raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx
raid6_pq raid0 multipath linear raid1 md_mod crc32c_sparc64
[  168.588026] irq event stamp: 72479182
[  168.588065] hardirqs last  enabled at (72479181):
[<0000000000658788>] handle_mm_fault+0x188/0x320
[  168.588130] hardirqs last disabled at (72479182):
[<00000000004274a4>] sys_call_table+0x784/0x960
[  168.588194] softirqs last  enabled at (836258):
[<0000000000b811c8>] __do_softirq+0x4a8/0x520
[  168.588254] softirqs last disabled at (836211):
[<000000000042d134>] do_softirq_own_stack+0x34/0x60
[  168.588317] CPU: 29 PID: 720 Comm: systemd-timesyn Tainted: G
      L    5.5.0-07763-gccaaaf6fe5a5 #5
[  168.588383] TSTATE: 0000004480001606 TPC: 00000000004db42c TNPC:
00000000004db430 Y: 00000000    Tainted: G             L
[  168.588459] TPC: <lock_release+0x30c/0x320>
[  168.588493] g0: 000000000000000e g1: e4012785416a8d24 g2:
57777de2ab0aa83d g3: dff36f5ae4012785
[  168.588552] g4: fff800007d56cc00 g5: fff80024ac408000 g6:
fff800249d338000 g7: fff800007d56d470
[  168.588611] o0: fff800007d56cc00 o1: 00000000013103a0 o2:
0000000000000000 o3: 0000000000000001
[  168.588670] o4: 0000000000000001 o5: fff800007d56d498 sp:
fff800249d33af11 ret_pc: 00000000004db41c
[  168.588732] RPC: <lock_release+0x2fc/0x320>
[  168.588766] l0: 0000000000000002 l1: 0000000000dd2450 l2:
0000000000000000 l3: 0000000000658510
[  168.588825] l4: 0000000000d13b98 l5: 00000000ffffffff l6:
0000000000d137c0 l7: 0000000000cfb6b8
[  168.588884] i0: fff80024ad8394e0 i1: 00000000006585b8 i2:
0000000000000002 i3: 0000000000000000
[  168.588942] i4: fff800007d56cc00 i5: fff800007d56d498 i6:
fff800249d33afd1 i7: 0000000000b7e8f0
[  168.589003] I7: <_raw_spin_unlock+0x10/0x40>
[  168.589037] Call Trace:
[  168.589063]  [0000000000b7e8f0] _raw_spin_unlock+0x10/0x40
[  168.589104]  [00000000006585b8] __handle_mm_fault+0xe38/0xe80
[  168.589147]  [0000000000658898] handle_mm_fault+0x298/0x320
[  168.589189]  [0000000000b804bc] do_sparc64_fault+0x43c/0x820
[  168.589234]  [0000000000407754] sparc64_realfault_common+0x10/0x20
[  168.589280]  [000000000042fac8] __do_sys_sparc_clock_adjtime+0x28/0x80
[  168.589329]  [0000000000430890] sys_sparc_clock_adjtime+0x10/0x20
[  168.589374]  [0000000000406294] linux_sparc_syscall+0x34/0x44
