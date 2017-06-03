From: Aleksa Sarai <asarai@suse.de>
Date: Sat, 03 Jun 2017 14:15:13 +0000
Subject: [PATCH v4 0/2] tty: add TIOCGPTPEER ioctl
Message-Id: <20170603141515.9529-1-asarai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>, Aleksa Sarai <asarai@suse.de>

Changes in v4:
  * Dropped an accidental change to Makefile.

Aleksa Sarai (2):
  tty: add compat_ioctl callbacks
  tty: add TIOCGPTPEER ioctl

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
 10 files changed, 98 insertions(+), 11 deletions(-)

-- 
2.13.0

