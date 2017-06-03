From: Aleksa Sarai <asarai@suse.de>
Date: Sat, 03 Jun 2017 13:51:09 +0000
Subject: [PATCH v3 0/2] tty: add TIOCGPTPEER ioctl
Message-Id: <20170603135111.5444-1-asarai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>, Aleksa Sarai <asarai@suse.de>

Changes in v3:
  * Defined a compat_ioctl callback for all pty ioctls, since they are
    all 32-bit and 64-bit compatible.
  * Made TIOCGPTPEER support 32-bit userspace.

Aleksa Sarai (2):
  tty: add compat_ioctl callbacks
  tty: add TIOCGPTPEER ioctl

 Makefile                               |  1 +
 arch/alpha/include/uapi/asm/ioctls.h   |  1 +
 arch/mips/include/uapi/asm/ioctls.h    |  1 +
 arch/parisc/include/uapi/asm/ioctls.h  |  1 +
 arch/powerpc/include/uapi/asm/ioctls.h |  1 +
 arch/sh/include/uapi/asm/ioctls.h      |  1 +
 arch/sparc/include/uapi/asm/ioctls.h   |  3 +-
 arch/xtensa/include/uapi/asm/ioctls.h  |  1 +
 drivers/tty/pty.c                      | 93 ++++++++++++++++++++++++++++++++--
 fs/compat_ioctl.c                      |  6 ---
 include/uapi/asm-generic/ioctls.h      |  1 +
 11 files changed, 99 insertions(+), 11 deletions(-)

-- 
2.13.0

