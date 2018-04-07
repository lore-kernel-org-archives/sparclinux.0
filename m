From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sat, 07 Apr 2018 20:44:14 +0000
Subject: [git pull] sparc syscall stuff
Message-Id: <20180407204414.GC30522@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>

	sparc syscall stuff - killing pointless wrappers, conversions to
{COMPAT_,}SYSCALL_DEFINE.

	Conflicts in arch/sparc/kernel/sys_sparc32.c are not hard to resolve,
but keep in mind that casts to u64 are needed there.  I'd pushed a variant of
resolution into #test-merge.

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git misc.sparc

for you to fetch changes up to 47db69752b22de2ac315d094fd09fac31b0d3bfc:

  sparc: get rid of asm wrapper for nis_syscall() (2018-03-20 12:05:17 -0400)

----------------------------------------------------------------
Al Viro (11):
      sparc: get rid of sys_sparc_pipe() wrappers
      sparc: kill useless SIGN... wrappers
      sparc: get rid of remaining SIGN... wrappers
      sparc: bury a zombie extern that had been that way for twenty years
      sparc: trivial conversions to {COMPAT_,}SYSCALL_DEFINE()
      sparc: get rid of memory_ordering(2) wrapper
      switch sparc_remap_file_pages() to SYSCALL_DEFINE
      convert compat sync_file_range() to COMPAT_SYSCALL_DEFINE
      sparc: switch compat pread64 and pwrite64 to COMPAT_SYSCALL_DEFINE
      sparc: switch compat {f,}truncate64() to COMPAT_SYSCALL_DEFINE
      sparc: get rid of asm wrapper for nis_syscall()

 arch/sparc/kernel/entry.S        | 15 -------
 arch/sparc/kernel/sys32.S        | 38 ------------------
 arch/sparc/kernel/sys_sparc32.c  | 87 ++++++++++++++++------------------------
 arch/sparc/kernel/sys_sparc_32.c | 31 +++++++-------
 arch/sparc/kernel/sys_sparc_64.c | 18 ++++-----
 arch/sparc/kernel/syscalls.S     |  9 -----
 arch/sparc/kernel/systbls.h      | 53 ++++++++++++------------
 arch/sparc/kernel/systbls_32.S   |  2 +-
 arch/sparc/kernel/systbls_64.S   | 24 +++++------
 9 files changed, 97 insertions(+), 180 deletions(-)
