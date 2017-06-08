From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 08 Jun 2017 22:17:21 +0000
Subject: [PATCH 0/2] Define CPU_BIG_ENDIAN or warn for inconsistencies
Message-Id: <1496960243-196898-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, geert@linux-m68k.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, viro@zeniv.linux.org.uk
Cc: mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

Found this problem while enabling queued rwlock on SPARC.
The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
specific byte in qrwlock structure. Without this parameter,
we clear the wrong byte. Here is the code.

static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
  {
         return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
  }

Here is the previous discussion.
http://www.spinics.net/lists/devicetree/msg178101.html

Based on the discussion, it was decided to add CONFIG_CPU_BIG_ENDIAN
for all the fixed big endian architecture(frv, h8300, m68k, openrisc,
parisc and sparc). And warn if there are inconsistencies in this definition.

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

