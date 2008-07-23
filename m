From: David Miller <davem@davemloft.net>
Date: Wed, 23 Jul 2008 00:14:48 +0000
Subject: [GIT]: Sparc
Message-Id: <20080722.171448.05499825.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc updates, thanks a lot!

The following changes since commit e4f25060b87a627f5cda84b8134911d43c919458:
  David Howells (1):
        sparc: Remove Sparc's asm-offsets for sclow.S

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Bartlomiej Zolnierkiewicz (4):
      ide: <asm-sparc/ide_64.h>: use %r0 for outw_be()
      ide: <asm-sparc/ide_32.h>: use __raw_{read,write}w()
      ide: <asm-sparc/ide_64.h>: use __raw_{read,write}w()
      ide: merge <asm-sparc/ide_64.h> with <asm-sparc/ide_32.h>

David S. Miller (2):
      sparc64: Do not define BIO_VMERGE_BOUNDARY.
      sparc: Fixes the DRM layer build on sparc.

Stephen Rothwell (1):
      sparc32: pass -m32 when building vmlinux.lds

 arch/sparc/Makefile        |    1 +
 include/asm-sparc/ide.h    |  102 ++++++++++++++++++++++++++++++++++++--
 include/asm-sparc/ide_32.h |   95 -----------------------------------
 include/asm-sparc/ide_64.h |  118 --------------------------------------------
 include/asm-sparc/io_32.h  |    1 +
 include/asm-sparc/io_64.h  |    2 +-
 6 files changed, 100 insertions(+), 219 deletions(-)
 delete mode 100644 include/asm-sparc/ide_32.h
 delete mode 100644 include/asm-sparc/ide_64.h
