From: David Miller <davem@davemloft.net>
Date: Wed, 10 Oct 2012 01:26:55 +0000
Subject: [GIT] Sparc
Message-Id: <20121009.212655.1737552557576450658.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This is just the UAPI commits for sparc via David Howells.

Please pull, thanks a lot!

The following changes since commit 547b1e81afe3119f7daf702cc03b158495535a25:

  Fix staging driver use of VM_RESERVED (2012-10-09 21:06:41 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 9836d3458cde82626f2828ca6bd44c4a02b56e63:

  Merge tag 'disintegrate-sparc-20121009' of git://git.infradead.org/users/dhowells/linux-headers (2012-10-09 09:54:30 -0700)

----------------------------------------------------------------

David Howells (1):
      UAPI: (Scripted) Disintegrate arch/sparc/include/asm

David S. Miller (1):
      Merge tag 'disintegrate-sparc-20121009' of git://git.infradead.org/users/dhowells/linux-headers

 arch/sparc/include/asm/Kbuild                   |  16 ---
 arch/sparc/include/asm/fbio.h                   | 260 +---------------------------------
 arch/sparc/include/asm/ioctls.h                 | 129 +----------------
 arch/sparc/include/asm/mman.h                   |  25 +---
 arch/sparc/include/asm/psr.h                    |  36 +----
 arch/sparc/include/asm/ptrace.h                 | 347 +---------------------------------------------
 arch/sparc/include/asm/setup.h                  |  10 +-
 arch/sparc/include/asm/sigcontext.h             |   4 +-
 arch/sparc/include/asm/siginfo.h                |  23 +--
 arch/sparc/include/asm/signal.h                 | 185 +------------------------
 arch/sparc/include/asm/termbits.h               | 260 +---------------------------------
 arch/sparc/include/asm/termios.h                |  41 +-----
 arch/sparc/include/asm/traps.h                  | 111 +--------------
 arch/sparc/include/asm/unistd.h                 | 412 +-----------------------------------------------------
 arch/sparc/include/uapi/asm/Kbuild              |  46 ++++++
 arch/sparc/include/{ => uapi}/asm/apc.h         |   0
 arch/sparc/include/{ => uapi}/asm/asi.h         |   0
 arch/sparc/include/{ => uapi}/asm/auxvec.h      |   0
 arch/sparc/include/{ => uapi}/asm/bitsperlong.h |   0
 arch/sparc/include/{ => uapi}/asm/byteorder.h   |   0
 arch/sparc/include/{ => uapi}/asm/display7seg.h |   0
 arch/sparc/include/{ => uapi}/asm/envctrl.h     |   0
 arch/sparc/include/{ => uapi}/asm/errno.h       |   0
 arch/sparc/include/uapi/asm/fbio.h              | 259 ++++++++++++++++++++++++++++++++++
 arch/sparc/include/{ => uapi}/asm/fcntl.h       |   0
 arch/sparc/include/{ => uapi}/asm/ioctl.h       |   0
 arch/sparc/include/uapi/asm/ioctls.h            | 131 ++++++++++++++++++
 arch/sparc/include/{ => uapi}/asm/ipcbuf.h      |   0
 arch/sparc/include/{ => uapi}/asm/jsflash.h     |   0
 arch/sparc/include/{ => uapi}/asm/kvm_para.h    |   0
 arch/sparc/include/uapi/asm/mman.h              |  27 ++++
 arch/sparc/include/{ => uapi}/asm/msgbuf.h      |   0
 arch/sparc/include/{ => uapi}/asm/openpromio.h  |   0
 arch/sparc/include/{ => uapi}/asm/param.h       |   0
 arch/sparc/include/{ => uapi}/asm/perfctr.h     |   0
 arch/sparc/include/{ => uapi}/asm/poll.h        |   0
 arch/sparc/include/{ => uapi}/asm/posix_types.h |   0
 arch/sparc/include/uapi/asm/psr.h               |  47 +++++++
 arch/sparc/include/{ => uapi}/asm/psrcompat.h   |   0
 arch/sparc/include/{ => uapi}/asm/pstate.h      |   0
 arch/sparc/include/uapi/asm/ptrace.h            | 352 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/include/{ => uapi}/asm/resource.h    |   0
 arch/sparc/include/{ => uapi}/asm/sembuf.h      |   0
 arch/sparc/include/uapi/asm/setup.h             |  15 ++
 arch/sparc/include/{ => uapi}/asm/shmbuf.h      |   0
 arch/sparc/include/uapi/asm/siginfo.h           |  25 ++++
 arch/sparc/include/uapi/asm/signal.h            | 185 +++++++++++++++++++++++++
 arch/sparc/include/{ => uapi}/asm/socket.h      |   0
 arch/sparc/include/{ => uapi}/asm/sockios.h     |   0
 arch/sparc/include/{ => uapi}/asm/stat.h        |   0
 arch/sparc/include/{ => uapi}/asm/statfs.h      |   0
 arch/sparc/include/{ => uapi}/asm/swab.h        |   0
 arch/sparc/include/uapi/asm/termbits.h          | 263 +++++++++++++++++++++++++++++++++++
 arch/sparc/include/uapi/asm/termios.h           |  43 ++++++
 arch/sparc/include/uapi/asm/traps.h             | 120 ++++++++++++++++
 arch/sparc/include/{ => uapi}/asm/types.h       |   0
 arch/sparc/include/{ => uapi}/asm/uctx.h        |   0
 arch/sparc/include/uapi/asm/unistd.h            | 422 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/include/{ => uapi}/asm/utrap.h       |   0
 arch/sparc/include/{ => uapi}/asm/watchdog.h    |   0
 60 files changed, 1951 insertions(+), 1843 deletions(-)
 rename arch/sparc/include/{ => uapi}/asm/apc.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/asi.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/auxvec.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/bitsperlong.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/byteorder.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/display7seg.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/envctrl.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/errno.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/fbio.h
 rename arch/sparc/include/{ => uapi}/asm/fcntl.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/ioctl.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/ioctls.h
 rename arch/sparc/include/{ => uapi}/asm/ipcbuf.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/jsflash.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/kvm_para.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/mman.h
 rename arch/sparc/include/{ => uapi}/asm/msgbuf.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/openpromio.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/param.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/perfctr.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/poll.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/posix_types.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/psr.h
 rename arch/sparc/include/{ => uapi}/asm/psrcompat.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/pstate.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/ptrace.h
 rename arch/sparc/include/{ => uapi}/asm/resource.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/sembuf.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/setup.h
 rename arch/sparc/include/{ => uapi}/asm/shmbuf.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/sigcontext.h
 create mode 100644 arch/sparc/include/uapi/asm/siginfo.h
 create mode 100644 arch/sparc/include/uapi/asm/signal.h
 rename arch/sparc/include/{ => uapi}/asm/socket.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/sockios.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/stat.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/statfs.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/swab.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/termbits.h
 create mode 100644 arch/sparc/include/uapi/asm/termios.h
 create mode 100644 arch/sparc/include/uapi/asm/traps.h
 rename arch/sparc/include/{ => uapi}/asm/types.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/uctx.h (100%)
 create mode 100644 arch/sparc/include/uapi/asm/unistd.h
 rename arch/sparc/include/{ => uapi}/asm/utrap.h (100%)
 rename arch/sparc/include/{ => uapi}/asm/watchdog.h (100%)
