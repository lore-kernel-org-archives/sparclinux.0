From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 04 Jan 2011 21:38:00 +0000
Subject: [PATCH v3 00/10] sparc: unify piggyback - and fix tftpboot.img on
Message-Id: <20110104213800.GA14732@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following set of 10 patches unify piggyback for
sparc32 and sparc64.
This has the side effect that we fix a longstanding bug in
sparc64 so we can now generate tftpboot.img on a x86 box.

The patch is test on a sparc32 system where I got a
ext2 image mounted and working.

On sparc64 I managed to boot a kernel on my Sun Blade 100
but the kernel stopped with a message:

	"console [tty0] enabled, bootconsole disabled"

So I did not reach the point where it try to mount 
the appended image.
Any hints what is wrong is appreciated!
[I guess I have the wrong framebuffer driver - but I do not know which is the right one]

This was anyway enough that I have concluded that it works
better than before.
I have only tested this using my x86 build host.

Changes since v1:
- Updated copyrights (from from Josip Rodin)
- Fixed algorithm to locate "HdrS" (from Josip Rodin)
- Verified the endian fixes (based on code received from Julian Calaby)

Please apply.

	Sam


Sam Ravnborg (10):
      sparc: refactor piggy_32.c
      sparc: use trapbase in setup_arch
      sparc: use _start for the start entry (like 64 bit does)
      sparc: additional comments to piggyback_32.c
      sparc: remove obsolete ELF support in piggyback_32.c
      sparc: add $BITS to piggyback arguments
      sparc: fix tfptboot.img for sparc64 on little-endian host
      sparc: rename piggyback_32 to piggyback
      sparc: unify strip command in boot/Makefile
      sparc: update copyright in piggyback.c

 arch/sparc/boot/Makefile       |   28 ++---
 arch/sparc/boot/piggyback.c    |  272 ++++++++++++++++++++++++++++++++++++++++
 arch/sparc/boot/piggyback_32.c |  137 --------------------
 arch/sparc/boot/piggyback_64.c |  110 ----------------
 arch/sparc/kernel/head_32.S    |    3 +-
 arch/sparc/kernel/setup_32.c   |    3 +-
 arch/sparc/mm/sun4c.c          |    8 +-
 7 files changed, 286 insertions(+), 275 deletions(-)
