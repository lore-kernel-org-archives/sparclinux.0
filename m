From: Aleksa Sarai <asarai@suse.de>
Date: Fri, 02 Jun 2017 08:48:57 +0000
Subject: [PATCH v2 0/1] tty: add TIOCGPTPEER ioctl
Message-Id: <20170602084858.4299-1-asarai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Aleksa Sarai <asarai@suse.de>

Changes in v2:

  * Reordered addition to ioctls.h to follow correct hex ordering.

Aleksa Sarai (1):
  tty: add TIOCGPTPEER ioctl

 arch/alpha/include/uapi/asm/ioctls.h   |  1 +
 arch/mips/include/uapi/asm/ioctls.h    |  1 +
 arch/parisc/include/uapi/asm/ioctls.h  |  1 +
 arch/powerpc/include/uapi/asm/ioctls.h |  1 +
 arch/sh/include/uapi/asm/ioctls.h      |  1 +
 arch/sparc/include/uapi/asm/ioctls.h   |  3 +-
 arch/xtensa/include/uapi/asm/ioctls.h  |  1 +
 drivers/tty/pty.c                      | 71 ++++++++++++++++++++++++++++++++--
 include/uapi/asm-generic/ioctls.h      |  1 +
 9 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.13.0

