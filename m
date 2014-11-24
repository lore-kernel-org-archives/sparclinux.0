From: David Drysdale <drysdale@google.com>
Date: Mon, 24 Nov 2014 11:23:18 +0000
Subject: [PATCHv2 0/1] vfs: renumber FMODE_NONOTIFY and add to uniqueness check
Message-Id: <1416828199-3414-1-git-send-email-drysdale@google.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Eric Paris <eparis@redhat.com>, David Miller <davem@davemloft.net>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, David Drysdale <drysdale@google.com>

Changes since v1:
 - reword commit to indicate origin of clash [Heinrich Schuchardt]
 - remove comment fix [Heinrich Schuchardt]
 - acked-by [David S. Miller]

Against v3.18-rc5.

Tested by running fatrace on x86_64, and by cross-compiling against
sparc, arm, arm64, m68k, mips, powerpc, alpha, parisc, blackfin.


David Drysdale (1):
  vfs: renumber FMODE_NONOTIFY and add to uniqueness check

 fs/fcntl.c                       | 5 +++--
 include/linux/fs.h               | 2 +-
 include/uapi/asm-generic/fcntl.h | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

