From: Anatoly Pugachev <matorola@gmail.com>
Date: Sun, 21 Jan 2018 19:41:54 +0000
Subject: Re: [sparc64] kernel unaligned access at TPC aa_dfa_unpack
Message-Id: <CADxRZqyTE5xFm+Fs-iR2Xjb4JHiVdGma+iyKwtBoU-RtBFf0qg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwo8sL3RtEWRMcHkgkSAnWKeVibLRrtdXU2e8w2Q5KSTQ@mail.gmail.com>
In-Reply-To: <CADxRZqwo8sL3RtEWRMcHkgkSAnWKeVibLRrtdXU2e8w2Q5KSTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-security-module@vger.kernel.org

On Tue, Jan 2, 2018 at 12:11 AM, Anatoly Pugachev <matorola@gmail.com> wrote:
> Hello!
>
> Using latest git kernel (4.15.0-rc6) , getting the following messages
> on LDOM/kernel boot:
>
> [    7.693653] Kernel unaligned access at TPC[7496d8] aa_dfa_unpack+0x38/0x580
> [    7.693735] Kernel unaligned access at TPC[7496f8] aa_dfa_unpack+0x58/0x580
> [    7.693782] Kernel unaligned access at TPC[749708] aa_dfa_unpack+0x68/0x580
> [    7.693829] Kernel unaligned access at TPC[74973c] aa_dfa_unpack+0x9c/0x580
> [    7.693875] Kernel unaligned access at TPC[749758] aa_dfa_unpack+0xb8/0x580
> [    7.697135] audit: type00 audit(1514840016.480:2):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="/usr/sbin/tcpdump" pidP7 comm="apparmor_parser"

git bisect'ed to this:

~/linux-2.6$ git bisect bad
80c094a47dd4ea63375e3f60b5e076064f16e857 is the first bad commit
commit 80c094a47dd4ea63375e3f60b5e076064f16e857
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Oct 26 19:35:35 2017 +0200

    Revert "apparmor: add base infastructure for socket mediation"

    This reverts commit 651e28c5537abb39076d3949fb7618536f1d242e.

    This caused a regression:
     "The specific problem is that dnsmasq refuses to start on openSUSE Leap
      42.2.  The specific cause is that and attempt to open a PF_LOCAL socket
      gets EACCES.  This means that networking doesn't function on a system
      with a 4.14-rc2 system."

    Sadly, the developers involved seemed to be in denial for several weeks
    about this, delaying the revert.  This has not been a good release for
    the security subsystem, and this area needs to change development
    practices.

    Reported-and-bisected-by: James Bottomley
<James.Bottomley@hansenpartnership.com>
    Tracked-by: Thorsten Leemhuis <regressions@leemhuis.info>
    Cc: John Johansen <john.johansen@canonical.com>
    Cc: Vlastimil Babka <vbabka@suse.cz>
    Cc: Seth Arnold <seth.arnold@canonical.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 c431996039c7b63f7a58b881a65f4a7d21b452a9
ac6a6f38c0b189b4f822838fcab8a6af52169059 M      security



~/linux-2.6$ git bisect log
git bisect start
# good: [5771a8c08880cdca3bfb4a3fc6d309d6bba20877] Linux v4.13-rc1
git bisect good 5771a8c08880cdca3bfb4a3fc6d309d6bba20877
# bad: [dda3e15231b35840fe6f0973f803cc70ddb86281] Merge branch 'fixes'
of git://git.armlinux.org.uk/~rmk/linux-arm
git bisect bad dda3e15231b35840fe6f0973f803cc70ddb86281
# good: [4dce3c4b9b581c4e54d3de083e1a97cb8ebf8c16] Merge tag
'extcon-next-for-4.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into
usb-next
git bisect good 4dce3c4b9b581c4e54d3de083e1a97cb8ebf8c16
# bad: [5d352e69c60e54b5f04d6e337a1d2bf0dbf3d94a] Merge tag
'media/v4.15-1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad 5d352e69c60e54b5f04d6e337a1d2bf0dbf3d94a
# bad: [4008e6a9bcee2f3b61bb11951de0fb0ed764cb91] Merge branch
'i2c/for-4.15' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect bad 4008e6a9bcee2f3b61bb11951de0fb0ed764cb91
# bad: [3c073991eb417b6f785ddc6afbbdc369eb84aa6a] Merge tag
'devprop-4.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 3c073991eb417b6f785ddc6afbbdc369eb84aa6a
# bad: [d60a540ac5f2fbab3e6fe592717b445bd7343a91] Merge branch
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect bad d60a540ac5f2fbab3e6fe592717b445bd7343a91
# bad: [3fefc31843cfe2b5f072efe11ed9ccaf6a7a5092] Merge tag
'pm-final-4.14' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 3fefc31843cfe2b5f072efe11ed9ccaf6a7a5092
# bad: [2b7cda9c35d3b940eb9ce74b30bbd5eb30db493d] tcp: fix
tcp_mtu_probe() vs highest_sack
git bisect bad 2b7cda9c35d3b940eb9ce74b30bbd5eb30db493d
# bad: [22450e03acf18ef0dbdbbc155f0f97f105bf6878] Merge tag
'pci-v4.14-fixes-6' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect bad 22450e03acf18ef0dbdbbc155f0f97f105bf6878
# bad: [02c7dfc006a6e3f4a169f98b8f6c5703756d0072] Merge branch
'perf-urgent-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 02c7dfc006a6e3f4a169f98b8f6c5703756d0072
# good: [4ed590271a65b0fbe3eb1cf828ad5af16603c8ce] Merge tag
'xfs-4.14-fixes-7' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect good 4ed590271a65b0fbe3eb1cf828ad5af16603c8ce
# good: [832c6b18f904b96f494d43d6023db68c9f330cf0] Merge tag
'spi-fix-v4.14-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
git bisect good 832c6b18f904b96f494d43d6023db68c9f330cf0
# good: [3b5a9a8e654c3695e7b499b0784341f299adef48] Merge branch
'for-linus' of git://git.kernel.dk/linux-block
git bisect good 3b5a9a8e654c3695e7b499b0784341f299adef48
# bad: [15f859ae5c43c7f0a064ed92d33f7a5bc5de6de0] Merge tag
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma
git bisect bad 15f859ae5c43c7f0a064ed92d33f7a5bc5de6de0
# good: [567825502730b6bc108f926bdb1cf2de7ae436ca] Merge tag
'pm-4.14-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 567825502730b6bc108f926bdb1cf2de7ae436ca
# good: [b4d91aeb6e120b7e2f207021c31b914895c69bc4] RDMA/netlink: OOPs
in rdma_nl_rcv_msg() from misinterpreted flag
git bisect good b4d91aeb6e120b7e2f207021c31b914895c69bc4
# bad: [80c094a47dd4ea63375e3f60b5e076064f16e857] Revert "apparmor:
add base infastructure for socket mediation"
git bisect bad 80c094a47dd4ea63375e3f60b5e076064f16e857
# first bad commit: [80c094a47dd4ea63375e3f60b5e076064f16e857] Revert
"apparmor: add base infastructure for socket mediation"



where "bad" is dmesg with "Kernel unaligned access at TPC[xxx]
aa_dfa_unpack" message ,
and "good" where is no such messages.
