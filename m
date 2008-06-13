From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:54:49 +0000
Subject: unify sparc and sparc64 headers
Message-Id: <20080613195449.GA9141@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

This is an updated set of patches that unify a number
of header files between sparc and sparc64 with the
intent to eliminate use of ALTARCH (and to help in the unification
of sparc and sparc64 a little).

There are a number of files that are not yet unified:

"openprom.h reg.h ipcbuf.h posix_types.h ptrace.h statfs.h"
"sigcontext.h siginfo.h signal.h stat.h unistd.h"

They vary too much to combine in a single file - at least for
my taste.
And I wanted to divide them in a _32 and a _64 file but that
broke "make headers_check".
So what I suggest is that you take this first batch and when
ALTARCH support is no longer present we can do the final
step.

This will result in a wrong "make headers_install" result
in the period "kbuild removes ALTARCH support" until "fix sparc".
But I hope this all happens in the same merge window so I
do not see this as a bigger sissue. The alternative was to
break the build by introducing a "make headers_check" bug 
which would affect bisect etc.

The full set can be pulled from:

   ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc.git

And will follow as mails too.

For all the "replace the sparc64 version with the sparc" version
patches I now included a diff of the files to document the
actual differences before the merge.

I have ran a testbuild of both sparc and sparc64 between most
commits (but not all as my UP 800 Mhz pentium is a tad slower
than a 32 way (my quad box is broken)).

	Sam

See also individual comments:

  sparc: copy exported sparc64 specific header files to asm-sparc
	- scripted

  sparc: Merge asm-sparc{,64}/ioctl.h
  sparc: Merge asm-sparc{,64}/ioctls.h
  sparc: Merge asm-sparc{,64}/param.h
  sparc: Merge asm-sparc{,64}/poll.h
  sparc: Merge asm-sparc{,64}/socket.h
  sparc: Merge asm-sparc{,64}/sockios.h
	- trivial merges

  sparc: Merge asm-sparc{,64}/fcntl.h
	- O_NDELAY differed

  sparc: Merge asm-sparc{,64}/msgbuf.h
  sparc: Merge asm-sparc{,64}/sembuf.h
  sparc: Merge asm-sparc{,64}/shmbuf.h
	- sparc had padding that sparc64 did not have.
	  made padding conditional

  sparc: Merge asm-sparc{,64}/mman.h
	- renamed a function to make them equal

  sparc: copy asm-sparc64/fbio.h to asm-sparc
  sparc: Merge asm-sparc{,64}/fbio.h
	- did some unification before the merge

  sparc: Merge asm-sparc{,64}/resource.h
	- RLIM_INFINITY differed

  sparc: Merge asm-sparc{,64}/setup.h
	- COMMAND_LINE_SIZE differed
	  I considered changing sparc to 2048 but sparc
	  is embedded so I kept the lower value

  sparc: Merge asm-sparc{,64}/termbits.h
	- type of tcflag_t differed. See changelog for some comments

  sparc: Merge asm-sparc{,64}/termios.h
	- merged the sparc64 version thus changing functionality on sparc
	  please see changelog comment

  sparc: Merge asm-sparc{,64}/types.h
	- joined the two files as they were small

  sparc: export openprom.h to userspace
	- openprom is exported by sparc64 so let sparc export it too
	  Had to do a few changes to allow this

  sparc: Merge asm-sparc{,64}/asi.h
	- Joined the two files

Full diffstat:

 arch/sparc/kernel/entry.S                        |    1 +
 arch/sparc64/kernel/sys_sparc.c                  |    6 +-
 arch/sparc64/kernel/sys_sparc32.c                |    4 +-
 include/asm-sparc/Kbuild                         |    8 +
 include/asm-sparc/asi.h                          |  153 ++++++++++-
 include/{asm-sparc64 => asm-sparc}/display7seg.h |    0 
 include/{asm-sparc64 => asm-sparc}/envctrl.h     |    0 
 include/asm-sparc/fbio.h                         |   37 +++-
 include/asm-sparc/fcntl.h                        |    4 +
 include/asm-sparc/ioctls.h                       |    4 +-
 include/asm-sparc/msgbuf.h                       |   23 +-
 include/asm-sparc/openprom.h                     |    2 -
 include/asm-sparc/pgtable.h                      |    7 +-
 include/{asm-sparc64 => asm-sparc}/psrcompat.h   |    0 
 include/{asm-sparc64 => asm-sparc}/pstate.h      |    0 
 include/asm-sparc/resource.h                     |    6 +-
 include/asm-sparc/sembuf.h                       |   12 +-
 include/asm-sparc/setup.h                        |    6 +-
 include/asm-sparc/shmbuf.h                       |   14 +-
 include/asm-sparc/termbits.h                     |    5 +
 include/asm-sparc/termios.h                      |   79 +++---
 include/asm-sparc/types.h                        |   32 ++-
 include/{asm-sparc64 => asm-sparc}/uctx.h        |    0 
 include/{asm-sparc64 => asm-sparc}/utrap.h       |    0 
 include/asm-sparc/vaddrs.h                       |    5 -
 include/{asm-sparc64 => asm-sparc}/watchdog.h    |    0 
 include/asm-sparc64/asi.h                        |  161 +-----------
 include/asm-sparc64/display7seg.h                |   80 +-----
 include/asm-sparc64/envctrl.h                    |  104 +-------
 include/asm-sparc64/fbio.h                       |  331 +---------------------
 include/asm-sparc64/fcntl.h                      |   36 +---
 include/asm-sparc64/ioctl.h                      |   68 +-----
 include/asm-sparc64/ioctls.h                     |  137 +---------
 include/asm-sparc64/mman.h                       |   32 +--
 include/asm-sparc64/msgbuf.h                     |   28 +--
 include/asm-sparc64/param.h                      |   24 +--
 include/asm-sparc64/poll.h                       |   13 +-
 include/asm-sparc64/psrcompat.h                  |   46 +---
 include/asm-sparc64/pstate.h                     |   92 +------
 include/asm-sparc64/resource.h                   |   20 +--
 include/asm-sparc64/sembuf.h                     |   23 +--
 include/asm-sparc64/setup.h                      |   11 +-
 include/asm-sparc64/shmbuf.h                     |   39 +---
 include/asm-sparc64/socket.h                     |   58 +----
 include/asm-sparc64/sockios.h                    |   15 +-
 include/asm-sparc64/termbits.h                   |  261 +-----------------
 include/asm-sparc64/termios.h                    |  187 +------------
 include/asm-sparc64/types.h                      |   35 +---
 include/asm-sparc64/uctx.h                       |   72 +-----
 include/asm-sparc64/utrap.h                      |   52 +----
 include/asm-sparc64/watchdog.h                   |   32 +--
 51 files changed, 360 insertions(+), 2005 deletions(-)
