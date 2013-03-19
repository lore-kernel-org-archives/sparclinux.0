From: David Miller <davem@davemloft.net>
Date: Tue, 19 Mar 2013 21:18:40 +0000
Subject: [GIT] Sparc
Message-Id: <20130319.171840.1173928147955486660.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just some minor fixups, a sunsu console setup panic cure, and
recognition of a Fujitsu sun4v cpu.

Please pull, thanks a lot!

The following changes since commit b0af9cd9aab60ceb17d3ebabb9fdf4ff0a99cf50:

  Merge tag 'lzo-update-signature-20130226' of git://github.com/markus-oberhumer/linux (2013-02-28 20:45:52 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to f58b20bd6bad48d6fc5633f003c3651115273fb2:

  sparc: remove unused "config BITS" (2013-03-19 16:23:51 -0400)

----------------------------------------------------------------
Allen Pais (1):
      sparc64: correctly recognize SPARC64-X chips

Daniel Hellstrom (1):
      sparc,leon: fix GRPCI2 device0 PCI config space access

Paul Bolle (2):
      sparc: delete "if !ULTRA_HAS_POPULATION_COUNT"
      sparc: remove unused "config BITS"

Tkhai Kirill (1):
      sunsu: Fix panic in case of nonexistent port at "console=ttySY" cmdline option

 arch/sparc/Kconfig                  |  8 +-------
 arch/sparc/include/asm/spitfire.h   |  1 +
 arch/sparc/kernel/cpu.c             |  6 ++++++
 arch/sparc/kernel/head_64.S         | 25 +++++++++++++++++++++++--
 arch/sparc/kernel/leon_pci_grpci2.c | 41 ++++++++++++++++++++++++++---------------
 drivers/tty/serial/sunsu.c          | 21 +++++++++------------
 6 files changed, 66 insertions(+), 36 deletions(-)
