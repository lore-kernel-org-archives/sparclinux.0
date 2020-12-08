From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 08 Dec 2020 00:09:47 +0000
Subject: [sparc64] current git kernel networking is broken
Message-Id: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sparc kernel list <sparclinux@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: debian-sparc <debian-sparc@lists.debian.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

Hello!

Sorry for the late report, being 5.10-rc7 is out, but current git
kernel (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
is broken with the networking. It affects my openvpn tunnel and even
internet networking.

ping to a local ethernet network (i.e. gateway ping) works, but i
cannot download files from the internet.
openvpn tunnel does not work.

bisected kernel to the following commit:

linux-2.6$ git bisect good
fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043 is the first bad commit
commit fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Jul 19 18:31:07 2020 -0400

    sparc64: propagate the calling convention changes down to
__csum_partial_copy_...()

    ... and rename them into csum_and_copy_...() - the wrappers become
pointless.
    [braino fixed]

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

 arch/sparc/include/asm/checksum.h    |  1 +
 arch/sparc/include/asm/checksum_32.h |  2 --
 arch/sparc/include/asm/checksum_64.h | 41 +++---------------------------------
 arch/sparc/lib/csum_copy.S           |  5 +++--
 arch/sparc/lib/csum_copy_from_user.S |  4 ++--
 arch/sparc/lib/csum_copy_to_user.S   |  4 ++--
 6 files changed, 11 insertions(+), 46 deletions(-)



full git bisect log:

$ git bisect log
git bisect start
# bad: [0477e92881850d44910a7e94fc2c46f96faa131f] Linux 5.10-rc7
git bisect bad 0477e92881850d44910a7e94fc2c46f96faa131f
# good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
git bisect good bbf5c979011a099af5dc76498918ed7df445635b
# bad: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add
failure injection to usercopy functions
git bisect bad 4d0e9df5e43dba52d38b251e3b909df8fa1110be
# bad: [f888bdf9823c85fe945c4eb3ba353f749dec3856] Merge tag
'devicetree-for-5.10' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad f888bdf9823c85fe945c4eb3ba353f749dec3856
# bad: [57218d7f2e87069f73c7a841b6ed6c1cc7acf616] Merge tag
'regmap-v5.10' of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect bad 57218d7f2e87069f73c7a841b6ed6c1cc7acf616
# bad: [39a5101f989e8d2be557136704d53990f9b402c8] Merge branch 'linus'
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 39a5101f989e8d2be557136704d53990f9b402c8
# good: [ed016af52ee3035b4799ebd7d53f9ae59d5782c4] Merge tag
'locking-core-2020-10-12' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good ed016af52ee3035b4799ebd7d53f9ae59d5782c4
# good: [50d228345a03c882dfe11928ab41b42458b3f922] Merge tag
'docs-5.10' of git://git.lwn.net/linux
git bisect good 50d228345a03c882dfe11928ab41b42458b3f922
# good: [0f5e8323777bfc1c1d2cba71242db6a361de03b6] crypto:
arm/sha512-neon - avoid ADRL pseudo instruction
git bisect good 0f5e8323777bfc1c1d2cba71242db6a361de03b6
# good: [c2fb644638ae45cc4a34aa51a18d687d4781f8a1] hwrng: npcm -
modify readl to readb
git bisect good c2fb644638ae45cc4a34aa51a18d687d4781f8a1
# bad: [85ed13e78dbedf9433115a62c85429922bc5035c] Merge branch
'work.iov_iter' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad 85ed13e78dbedf9433115a62c85429922bc5035c
# good: [1cd95ab85df730b140156baac92fd2640290a5e5] mips: propagate the
calling convention change down into __csum_partial_copy_..._user()
git bisect good 1cd95ab85df730b140156baac92fd2640290a5e5
# good: [598b3cec831fd6ccb3cbe4919a722e868c6364a8] fs: remove
compat_sys_vmsplice
git bisect good 598b3cec831fd6ccb3cbe4919a722e868c6364a8
# bad: [70d65cd555c5e43c613700f604a47f7ebcf7b6f1] ppc: propagate the
calling conventions change down to csum_partial_copy_generic()
git bisect bad 70d65cd555c5e43c613700f604a47f7ebcf7b6f1
# bad: [fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043] sparc64: propagate
the calling convention changes down to __csum_partial_copy_...()
git bisect bad fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043
# good: [2a5d2bd159f33ef34484ee14705dcf8634061f2c] xtensa: propagate
the calling conventions change down into csum_partial_copy_generic()
git bisect good 2a5d2bd159f33ef34484ee14705dcf8634061f2c
# first bad commit: [fdf8bee96f9aeaac4559725c2dfae6e1bd7b7043]
sparc64: propagate the calling convention changes down to
__csum_partial_copy_...()
