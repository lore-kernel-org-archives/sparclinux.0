From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed, 02 Jan 2019 15:53:21 +0000
Subject: [PATCH 0/3] sparc: Unify the system call scripts
Message-Id: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org

System call table generation support is provided for
alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
sh, sparc and xtensa architectures. The implementat-
ions are almost similar across all the above archte-
ctures. In order to reduce the source code across all
the above architectures, create common ".sh" files and
keep it in the common directory, script/. This will 
be a generic scripts which can use for all the above
architectures.

This patch depends on;
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (3):
  sparc: remove nargs from __SYSCALL
  sparc: rename not implemented system call
  sparc: generate uapi header and system call table files

 arch/sparc/kernel/syscalls/Makefile      | 11 ++++++++--
 arch/sparc/kernel/syscalls/syscall.tbl   | 26 +++++++++++------------
 arch/sparc/kernel/syscalls/syscallhdr.sh | 36 --------------------------------
 arch/sparc/kernel/syscalls/syscalltbl.sh | 36 --------------------------------
 arch/sparc/kernel/systbls_32.S           |  3 ++-
 arch/sparc/kernel/systbls_64.S           |  4 +++-
 6 files changed, 27 insertions(+), 89 deletions(-)
 delete mode 100644 arch/sparc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/sparc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1
