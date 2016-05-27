From: Nick Alcock <nix@esperi.org.uk>
Date: Fri, 27 May 2016 13:19:27 +0000
Subject: [4.1.x -- 4.6.x and probably HEAD] Reproducible unprivileged panic/TLB BUG on sparc via a stack-prot
Message-Id: <87twhj3ag0.fsf@esperi.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <87fut34unx.fsf@esperi.org.uk>
In-Reply-To: <87fut34unx.fsf@esperi.org.uk> (Nick Alcock's message of "Fri, 27
	May 2016 12:17:22 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>

[Resent with fixed address for sparclinux@; sorry!]

So I've been working on a patch series (see below) that applies GCC's
-fstack-protector{-all,-strong} to almost all of glibc bar the dynamic
linker. In trying to upstream it, one review commenter queried one
SPARC-specific patch in the series; the absence of this patch triggers a
BUG in the SPARC kernel when glibc is tested as an unprivileged user, on
all versions tested from Oracle UEK 4.1 right up to 4.6.0, at least on
the ldoms I have access to and presumably on bare hardware too.

This is clearly a bug, and equally clearly I think it needs fixing
before we can upstream the series, which it would be nice to do because
it would have prevented most of the recent spate of glibc stack
overflows from escalating to arbitrary code execution.

First, a representative sample of the BUG, as seen on 4.6.0:

ld-linux.so.2[36805]: segfault at 7ff ip           (null) (rpc           (null)) sp           (null) error 30001 in tst-kill6[100000+4000]
ld-linux.so.2[36806]: segfault at 7ff ip           (null) (rpc           (null)) sp           (null) error 30001 in tst-kill6[100000+4000]
ld-linux.so.2[36807]: segfault at 7ff ip           (null) (rpc           (null)) sp           (null) error 30001 in tst-kill6[100000+4000]
kernel BUG at arch/sparc/mm/fault_64.c:299!
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
ld-linux.so.2(36808): Kernel bad sw trap 5 [#1]
CPU: 1 PID: 36808 Comm: ld-linux.so.2 Not tainted 4.6.0 #34
task: fff8000303be5c60 ti: fff8000301344000 task.ti: fff8000301344000
TSTATE: 0000004410001601 TPC: 0000000000a1a784 TNPC: 0000000000a1a788 Y: 00000002    Not tainted
TPC: <do_sparc64_fault+0x5c4/0x700>
g0: fff8000024fc8248 g1: 0000000000db04dc g2: 0000000000000000 g3: 0000000000000001
g4: fff8000303be5c60 g5: fff800030e672000 g6: fff8000301344000 g7: 0000000000000001
o0: 0000000000b95ee8 o1: 000000000000012b o2: 0000000000000000 o3: 0000000200b9b358
o4: 0000000000000000 o5: fff8000301344040 sp: fff80003013475c1 ret_pc: 0000000000a1a77c
RPC: <do_sparc64_fault+0x5bc/0x700>
l0: 00000000000007ff l1: 0000000000000000 l2: 000000000000005f l3: 0000000000000000
l4: fff8000301347e98 l5: fff8000024ff3060 l6: 0000000000000000 l7: 0000000000000000
i0: fff8000301347f60 i1: 0000000000102400 i2: 0000000000000000 i3: 0000000000000000
i4: 0000000000000000 i5: 0000000000000000 i6: fff80003013476a1 i7: 0000000000404d4c
I7: <user_rtt_fill_fixup+0x6c/0x7c>
Call Trace:
 [0000000000404d4c] user_rtt_fill_fixup+0x6c/0x7c
Disabling lock debugging due to kernel taint
Caller[0000000000404d4c]: user_rtt_fill_fixup+0x6c/0x7c
Caller[0000000000000000]:           (null)
Instruction DUMP: 9210212b  7fe84179  901222e8 <91d02005> 90102002  92102001  94100018  7fecd033  96100010
Kernel panic - not syncing: Fatal exception
Press Stop-A (L1-A) to return to the boot prom
---[ end Kernel panic - not syncing: Fatal exception

The crash moves around, and can even be seen striking in completely
random userspace processes that aren't part of the glibc under test
(e.g. I've seen it happen inside awk and GCC). The backtrace is always
the same, though.

It seems this is an unexpected TLB fault from this BUG in
do_sparc64_fault():

	if ((fault_code & FAULT_CODE_ITLB) &&
            (fault_code & FAULT_CODE_DTLB))
                BUG();

which certainly explains the randomness to some extent.

Now, some details for replication. It's easy to replicate if you can
build and test glibc using a GCC that supports -fstack-protector-all on
Linux/SPARC: I used 4.9.3. (You don't need to *install* the glibc or
anything, and getting to the crash on reasonable hardware takes only a
few minutes.)

The patch series itself, in the hopefully-not-too-inconvenient form of a
pair of git bundles based on glibc commit
a5df3210a641c175138052037fcdad34298bfa4d (near the glibc-2.23 release),
though this happens on glibc trunk with these bundles merged in too:

<http://www.esperi.org.uk/~nix/src/glibc-crashes.bundle>

<http://www.esperi.org.uk/~nix/src/glibc-workaround.bundle>

You'll need to run autoconf-2.69 in the source tree after checkout,
since I haven't regenerated configure in either of them.

To configure/build/test, I used

../../glibc/configure --enable-stackguard-randomization \
    --enable-stack-protector=all --prefix=/usr --enable-shared \
    --enable-bind-now --enable-maintainer-mode --enable-obsolete-rpc \
    --enable-add-ons=libidn --enable-kernel=4.1 --enable-check-abi=warn \
    && make -j 5 && make -j 5 check TIMEOUTFACTOR=5

though most of the configure flags are probably unnecessary and you'll
probably want to adjust the -j numbers. The crucial one is
--enable-stack-protector=all; without it, the first patch series is
equivalent to the second.

The crash almost invariably happens during the make check run, usually
during or after string/; both 32-bit and 64-bit glibc builds are
affected (the above configure line is for 64-bit). I have not yet
completed as many as four runs without a crash, and it almost always
happens in one or two. You can probably trigger one reliably by simply
rerunning make check in a loop without doing any of the rest of the
rebuilding (but I was reconfiguring and rebuilding because all of that
was scripted).

The only difference between the two series above is that in the crashing
series, the ka_restorer stub functions __rt_sigreturn_stub and
__sigreturn_stub (on sparc32) and __rt_sigreturn_stub (on sparc64) get
stack-protected; in the non-crashing series, they do not; the same is
true without --enable-stack-protector=all, because the functions have no
local variables at all, so without -fstack-protector-all they don't get
stack-protected in any case. Passing such a stack-protected function in
as the ka_restorer stub seems to suffice to cause this crash at some
later date. I'm wondering if the stack canary is clobbering something
that the caller does not expect to be clobbered: we saw this cause
trouble on x86 in a different context (see upstream commit
7a25d6a84df9fea56963569ceccaaf7c2a88f161).

It is clearly acceptable to say "restorer stubs are incompatible with
stack-protector canaries: turn them off" -- there are plenty of places
that are incompatible with canaries for good reason, and quite a lot of
the glibc patch series has been identifying these and turning the stack-
protector off for them -- but it is probably less acceptable to crash
the kernel if they don't do that! So at least some extra armouring seems
to be called for.

But where that extra armouring needs to go, I don't know (probably not
in do_sparc64_fault(), since I guess the underlying bug is way upstream
of this somewhere). I really have no idea what the underlying bug might
*be*. setup_rt_frame() might be a good place to start looking, only of
course that can't on its own explain how the explosion happens at a
later date, or how TLB faults get involved.

Anyway, I hope this is enough to at least replicate the bug: if it's not
-- if I've forgotten some detail, or if there is an environmental
dependence beyond "it's a SPARC" that I don't know about -- feel free to
ask for more info. I'm a mere userspace guy, and barely know about any
variation that may exist in the SPARC world these days. It's quite
possible that the hardware I'm using to test this (on the other side of
the world) is some sort of weird preproduction silicon and I don't know
it and this only happens there: it's certain that its firmware is three
years old... if nobody else can reproduce it, I'll try to dig out some
more hosts with different characteristics and see if it happens on them
too.

Kernel .config for this host (it's huge because it's derived from an
enterprise distro config):

<http://www.esperi.org.uk/~nix/src/config-4.6-sparc>

Very few of those modules are loaded, to wit:

Module                  Size  Used by
ipt_REJECT              1853  2
nf_reject_ipv4          3645  1 ipt_REJECT
nf_conntrack_ipv4      11179  2
nf_defrag_ipv4          1849  1 nf_conntrack_ipv4
iptable_filter          2108  1
ip_tables              20683  1 iptable_filter
ip6t_REJECT             1857  2
nf_reject_ipv6          5205  1 ip6t_REJECT
nf_conntrack_ipv6      11359  2
nf_defrag_ipv6         26774  1 nf_conntrack_ipv6
xt_state                1570  4
nf_conntrack          100343  3 nf_conntrack_ipv4,nf_conntrack_ipv6,xt_state
ip6table_filter         2050  1
ip6_tables             19814  1 ip6table_filter
ipv6                  411857  153 nf_reject_ipv6,nf_conntrack_ipv6,nf_defrag_ipv6,[permanent]
openprom                6699  0
ext4                  608323  2
mbcache                 6913  3 ext4
jbd2                  108713  1 ext4
des_generic            20873  0
sunvnet                 6897  0
sunvdc                 10861  4
dm_mirror              14985  0
dm_region_hash         11360  1 dm_mirror
dm_log                 10973  2 dm_mirror,dm_region_hash
dm_mod                108820  9 dm_mirror,dm_log

... though I doubt the set of loaded modules is likely to affect
reproduction of this bug much.
