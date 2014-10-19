From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 00:00:48 +0000
Subject: [PATCH 0/5] SILO: fix build issues with GNU11 mode
Message-Id: <1413676853-23942-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

GCC will switch to GNU11 default mode, and currently SILO
compilation is broken with GCC 4.9.1 and --std=gnu11 due to ext2fs
inline function declarations.

These cleanup patches should fix the build, while not making any
functional changes (same code is generated with current GNU89 default
mode with and without these patches).

Tested by running SILO installation + boot with versions compiled
with both GNU89 & GNU11 modes using GCC 4.9.1 on Ultrasparc.

Aaro Koskinen (5):
  silo: ext2fs: delete INCLUDE_INLINE_FUNCS ifdeffery
  silo: ext2fs: delete NO_INLINE_FUNCS ifdeffery
  silo: ext2fs: bitops: delete non-sparc code
  silo: ext2fs: delete forward declarations of inline functions
  silo: ext2fs: replace _INLINE_ with static inline

 include/ext2fs/bitops.h | 301 +++++++++---------------------------------------
 include/ext2fs/ext2fs.h |  80 +++----------
 2 files changed, 70 insertions(+), 311 deletions(-)

-- 
2.1.2

