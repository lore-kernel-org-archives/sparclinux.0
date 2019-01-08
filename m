From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 08 Jan 2019 05:22:52 +0000
Subject: [PATCH 0/3] net: y2038-safe socket timeout options
Message-Id: <20190108052255.10699-1-deepa.kernel@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, ccaulfie@redhat.com, cluster-devel@redhat.com, deller@gmx.de, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org, ralf@linux-mips.org, rth@twiddle.net, sparclinux@vger.kernel.org

The series is aimed at adding y2038-safe timeout options:
SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW.

This is similar to the previous series adding y2038-safe
SO_TIMESTAMP* options.

The series needs to be applied after the socket timestamp series:
https://lore.kernel.org/lkml/20190108032657.8331-1-deepa.kernel@gmail.com

Deepa Dinamani (3):
  socket: Use old_timeval types for socket timeouts
  socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
  sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW

 arch/alpha/include/uapi/asm/socket.h   | 13 ++++-
 arch/mips/include/uapi/asm/socket.h    | 13 ++++-
 arch/parisc/include/uapi/asm/socket.h  | 13 ++++-
 arch/powerpc/include/uapi/asm/socket.h |  4 +-
 arch/sparc/include/uapi/asm/socket.h   | 13 ++++-
 fs/dlm/lowcomms.c                      |  4 +-
 include/uapi/asm-generic/socket.h      | 13 ++++-
 net/compat.c                           | 14 ++---
 net/core/sock.c                        | 78 +++++++++++++++++++-------
 net/vmw_vsock/af_vsock.c               |  4 +-
 10 files changed, 126 insertions(+), 43 deletions(-)


base-commit: a4983672f9ca4c8393f26b6b80710e6c78886b8c
prerequisite-patch-id: a03ec6afbdd328cd90557f7ee6675016a5f5c653
prerequisite-patch-id: 724d26c3036e6f3a38f810c2f10db3f7ddbf843b
prerequisite-patch-id: 14017867b6eb4d5231eec1b563edcd840a1be26e
prerequisite-patch-id: 8df0edfd9b973ff5aae91c7709c8223be096a5bc
prerequisite-patch-id: 9850ad48d41bf068f074c0dd3c7610fb7177c89f
prerequisite-patch-id: bd31f35bba11902d1cc3e8726492b54df34b5c59
prerequisite-patch-id: ea4b005c5ad188a4e0899d728357c114710a3a8e
prerequisite-patch-id: cc3ee912c1ee1ea502ca079de81236a467950501
-- 
2.17.1

Cc: ccaulfie@redhat.com
Cc: cluster-devel@redhat.com
Cc: davem@davemloft.net
Cc: deller@gmx.de
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: sparclinux@vger.kernel.org
