From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 11:57:35 +0000
Subject: [PATCH v2 0/2] SILO: fix build issues with GNU11 mode
Message-Id: <1413719857-9838-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

GCC will switch to GNU11 default mode, and currently SILO
compilation is broken with GCC 4.9.1 and--std=gnu11 due to ext2fs
inline function declarations.

These cleanup patches should fix the build, while not making any
functional changes (same code is generated with current GNU89 default
mode with and without these patches).

Tested by running SILO installation + boot with versions compiled
with both GNU89 & GNU11 modes using GCC 4.9.1 on Ultrasparc.

v2: Just delete code instead of trying to clean it up.

Aaro Koskinen (2):
  silo: ext2fs: delete bitops.h
  silo: ext2fs: delete _INLINE_ functions

 include/ext2fs/bitops.h | 608 ------------------------------------------------
 include/ext2fs/ext2fs.h | 191 ---------------
 2 files changed, 799 deletions(-)
 delete mode 100644 include/ext2fs/bitops.h

-- 
2.1.2

