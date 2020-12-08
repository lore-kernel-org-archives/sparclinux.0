From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 08 Dec 2020 21:48:23 +0000
Subject: [git pull] [brown paperbag] regression in sparc64 this cycle
Message-Id: <20201208214823.GJ3579531@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 4bbf439b09c5ac3f8b3e9584fe080375d8d0ad2d:

  fix return values of seq_read_iter() (2020-11-15 22:12:53 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 6220e48d9640538ff700f2e7d24c2f9277555fd6:

  [regression fix] really dumb fuckup in sparc64 __csum_partial_copy() changes (2020-12-08 16:37:47 -0500)

----------------------------------------------------------------
Al Viro (1):
      [regression fix] really dumb fuckup in sparc64 __csum_partial_copy() changes

 arch/sparc/lib/csum_copy.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
