From: Anatoly Pugachev <matorola@gmail.com>
Date: Sat, 29 Jul 2017 10:52:03 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <CADxRZqzcDswmJA=nESkkqS7PFym4NGFxAXTUrFybzvx9ALdNfw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <22906.17109.563338.559874@gargle.gargle.HOWL> <20170727.221009.2117810548718510128.davem@davemloft.net>
 <22906.63899.54749.700924@gargle.gargle.HOWL>
In-Reply-To: <22906.63899.54749.700924@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikael Pettersson <mikpelinux@gmail.com>
Cc: David Miller <davem@davemloft.net>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Fri, Jul 28, 2017 at 11:45 AM, Mikael Pettersson
<mikpelinux@gmail.com> wrote:
> It's an rpmbuild --rebuild of Fedora's strace-4.18-1.fc24.src.rpm, but according to the
> build log the following should do it:
>
> export CFLAGS='-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -grecord-gcc-switches  -m32 -mcpu=ultrasparc'
> ./configure --build=sparcv9-unknown-linux-gnu --host=sparcv9-unknown-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/u
> sr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib --libexecdir=/usr/libexec --local
> statedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info
> make -j2
> make -j2 -k check VERBOSE=1

cant' reproduce it here on debian sparc64 LDOM:

used git version of strace ( https://github.com/strace/strace )

strace$ make -j24 check VERBOSE=1
...
======================================
Testsuite summary for strace 4.18.0.134.805d
======================================
# TOTAL: 443
# PASS:  389
# SKIP:  40
# XFAIL: 0
# FAIL:  14
# XPASS: 0
# ERROR: 0


while in kernel logs (journalctl -k -f):

Jul 29 12:49:22 ttip kernel: mmap: remap_file_page (77341) uses
deprecated remap_file_pages() syscall. See
Documentation/vm/remap_file_pages.txt.
Jul 29 12:49:22 ttip kernel: capability: warning: `caps' uses
deprecated v2 capabilities in a way that may be insecure
Jul 29 12:49:22 ttip kernel: capability: warning: `caps' uses 32-bit
capabilities (legacy support in use)
Jul 29 12:49:22 ttip kernel: ------------[ cut here ]------------
Jul 29 12:49:22 ttip kernel: WARNING: CPU: 18 PID: 78388 at
arch/sparc/kernel/sys_sparc32.c:150
compat_SyS_sparc_sigaction+0x3c/0x60
Jul 29 12:49:22 ttip kernel: Modules linked in: tcp_diag inet_diag
xfrm_user xfrm_algo nfnetlink netlink_diag xt_tcpudp xt_multiport
xt_conntrack tun iptable_filter iptable_nat nf_conntrack_ipv4
nf_defrag_ipv4 nf_nat_ipv4 xfs camellia_sparc64 des_sparc64
des_generic aes_sparc64 n2_rng md5_sparc64 rng_core flash
sha512_sparc64 sha256_sparc64 sha1_sparc64 nf_nat_pptp
nf_nat_proto_gre nf_conntrack_pptp nf_conntrack_proto_gre nf_nat
nf_conntrack libcrc32c crc32c_generic ip_tables x_tables autofs4 ext4
crc16 mbcache jbd2 crc32c_sparc64
Jul 29 12:49:22 ttip kernel: CPU: 18 PID: 78388 Comm: sigaction Not
tainted 4.13.0-rc2-00220-g0a07b238e5f4 #376
Jul 29 12:49:22 ttip kernel: Call Trace:
Jul 29 12:49:22 ttip kernel:  [000000000046c074] __warn+0xb4/0xe0
Jul 29 12:49:22 ttip kernel:  [000000000046c120] warn_slowpath_null+0x20/0x40
Jul 29 12:49:22 ttip kernel:  [000000000044b7bc]
compat_SyS_sparc_sigaction+0x3c/0x60
Jul 29 12:49:22 ttip kernel:  [00000000004061d4] linux_sparc_syscall32+0x34/0x60
Jul 29 12:49:22 ttip kernel: ---[ end trace 1ad5184278304e6d ]---
Jul 29 12:49:25 ttip kernel: pc[83378]: segfault at 70000974 ip
0000000070000974 (rpc 000000007000096c) sp 00000000ffdd9438 error
30001 in pc[70010000+2000]
