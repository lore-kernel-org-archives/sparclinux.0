From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 09 Jun 2017 19:48:05 +0000
Subject: [PATCH v2 0/2] Define CPU_BIG_ENDIAN or warn for inconsistencies
Message-Id: <1497037687-107638-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, geert@linux-m68k.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, viro@zeniv.linux.org.uk
Cc: mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

Found this problem while enabling queued rwlock on SPARC.
The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
specific byte in qrwlock structure. Without this parameter,
we clear the wrong byte.
Here is the code in include/asm-generic/qrwlock.h

static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
  {
         return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
  }

Also found few more references of this parameter in
drivers/of/base.c
drivers/of/fdt.c
drivers/tty/serial/earlycon.c
drivers/tty/serial/serial_core.c

Here is our previous discussion.
https://lkml.org/lkml/2017/5/24/620

Based on the discussion, it was decided to add CONFIG_CPU_BIG_ENDIAN
for all the fixed big endian architecture(frv, h8300, m68k, openrisc,
parisc and sparc). And warn if there are inconsistencies in this definition.

v1 -> v2:
 Updated the commit messages and acks.

Babu Moger (2):
  arch: Define CPU_BIG_ENDIAN for all fixed big endian archs
  include: warn for inconsistent endian config definition

 arch/frv/Kconfig                        |    3 +++
 arch/h8300/Kconfig                      |    3 +++
 arch/m68k/Kconfig                       |    3 +++
 arch/openrisc/Kconfig                   |    3 +++
 arch/parisc/Kconfig                     |    3 +++
 arch/sparc/Kconfig                      |    3 +++
 include/linux/byteorder/big_endian.h    |    4 ++++
 include/linux/byteorder/little_endian.h |    4 ++++
 8 files changed, 26 insertions(+), 0 deletions(-)

