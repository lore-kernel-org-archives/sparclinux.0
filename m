From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 20:58:11 +0000
Subject: Unify all exported SPARC headers
Message-Id: <20080606205811.GA4172@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

Following patches unify all exported sparc and sparc64 headers.

I have grouped the changes a bit.

Patch 1 to 7 are all trivial.
This is either sparc64 specific files that was verbatim
copied to asm-sparc (patch 1) or identical files.

	sparc: copy exported sparc64 specific header files to asm-sparc
	sparc: Merge asm-sparc{,64}/ioctl.h
	sparc: Merge asm-sparc{,64}/ioctls.h
	sparc: Merge asm-sparc{,64}/param.h
	sparc: Merge asm-sparc{,64}/poll.h
	sparc: Merge asm-sparc{,64}/socket.h
	sparc: Merge asm-sparc{,64}/sockios.h

The next batch had some editing so they could be unified
    O_NDELAY differs
	sparc: Merge asm-sparc{,64}/fcntl.h

    32 bit sparc had some padding that was made conditional
	sparc: Merge asm-sparc{,64}/msgbuf.h
	sparc: Merge asm-sparc{,64}/sembuf.h
	sparc: Merge asm-sparc{,64}/shmbuf.h

   Changed a name of a function to let them match
      sparc: Merge asm-sparc{,64}/mman.h

   Brought over a few sparc64 definitions
      sparc: copy asm-sparc64/fbio.h to asm-sparc
      sparc: Merge asm-sparc{,64}/fbio.h

   RLIM_INFINITY differs
      sparc: Merge asm-sparc{,64}/resource.h

   COMMAND_LINE_SIZE differs
      sparc: Merge asm-sparc{,64}/setup.h

   Type of tcflag_t differs
      sparc: Merge asm-sparc{,64}/termbits.h

   Functional change! Included sparc64 support for check of user access
      sparc: Merge asm-sparc{,64}/termios.h

   Merge of two small files
      sparc: Merge asm-sparc{,64}/types.h

The last batch were the files that differed too much
so I decided to create _32.h and _64.h variants to make
it easier to diff the two variants.
A simple script is included in the changelog.
# Whole file
      sparc: copy sparc64 header files to asm-sparc

And finally we could kill ALTARCH
      sparc: add sparc64 files to Kbuild

Build tested with a defconfig on sparc and sparc64

Patches follows and if you push your latest sparc patches
I can put them up in a git tree.
But I prefer that you reciew the lot before you apply the.

	Sam

Git diff:

 arch/sparc64/kernel/sys_sparc.c                    |    6 +-
 arch/sparc64/kernel/sys_sparc32.c                  |    4 +-
 include/asm-sparc/Kbuild                           |   10 +
 include/{asm-sparc64 => asm-sparc}/apb.h           |    0 
 include/asm-sparc/asi.h                            |  119 +------
 include/asm-sparc/{asi.h => asi_32.h}              |    0 
 include/{asm-sparc64/asi.h => asm-sparc/asi_64.h}  |    0 
 include/{asm-sparc64 => asm-sparc}/bbc.h           |    0 
 include/{asm-sparc64 => asm-sparc}/display7seg.h   |    0 
 include/{asm-sparc64 => asm-sparc}/envctrl.h       |    0 
 include/asm-sparc/fbio.h                           |   37 ++-
 include/asm-sparc/fcntl.h                          |    4 +
 include/asm-sparc/ioctls.h                         |    4 +-
 include/asm-sparc/ipcbuf.h                         |   39 +--
 include/asm-sparc/{ipcbuf.h => ipcbuf_32.h}        |    0 
 .../ipcbuf.h => asm-sparc/ipcbuf_64.h}             |    0 
 include/asm-sparc/msgbuf.h                         |   23 +-
 include/asm-sparc/openprom.h                       |  265 +-------------
 include/asm-sparc/{openprom.h => openprom_32.h}    |    0 
 .../openprom.h => asm-sparc/openprom_64.h}         |    0 
 include/asm-sparc/posix_types.h                    |  126 +------
 .../asm-sparc/{posix_types.h => posix_types_32.h}  |    0 
 .../posix_types.h => asm-sparc/posix_types_64.h}   |    0 
 include/{asm-sparc64 => asm-sparc}/psrcompat.h     |    0 
 include/{asm-sparc64 => asm-sparc}/pstate.h        |    0 
 include/asm-sparc/ptrace.h                         |  183 +---------
 include/asm-sparc/{ptrace.h => ptrace_32.h}        |    0 
 .../ptrace.h => asm-sparc/ptrace_64.h}             |    0 
 include/asm-sparc/reg.h                            |   87 +----
 include/asm-sparc/{reg.h => reg_32.h}              |    0 
 include/{asm-sparc64/reg.h => asm-sparc/reg_64.h}  |    0 
 include/asm-sparc/resource.h                       |    4 +
 include/asm-sparc/sembuf.h                         |   12 +-
 include/asm-sparc/setup.h                          |    6 +-
 include/asm-sparc/shmbuf.h                         |   14 +-
 include/asm-sparc/sigcontext.h                     |   70 +----
 .../asm-sparc/{sigcontext.h => sigcontext_32.h}    |    0 
 .../sigcontext.h => asm-sparc/sigcontext_64.h}     |    0 
 include/asm-sparc/siginfo.h                        |   25 +-
 include/asm-sparc/{siginfo.h => siginfo_32.h}      |    0 
 .../siginfo.h => asm-sparc/siginfo_64.h}           |    0 
 include/asm-sparc/signal.h                         |  215 +-----------
 include/asm-sparc/{signal.h => signal_32.h}        |    0 
 .../signal.h => asm-sparc/signal_64.h}             |    0 
 include/asm-sparc/stat.h                           |   84 +----
 include/asm-sparc/{stat.h => stat_32.h}            |    0 
 .../{asm-sparc64/stat.h => asm-sparc/stat_64.h}    |    0 
 include/asm-sparc/statfs.h                         |   12 +-
 include/asm-sparc/{statfs.h => statfs_32.h}        |    0 
 .../statfs.h => asm-sparc/statfs_64.h}             |    0 
 include/asm-sparc/termbits.h                       |    5 +
 include/asm-sparc/termios.h                        |   79 ++--
 include/asm-sparc/types.h                          |   32 ++-
 include/{asm-sparc64 => asm-sparc}/uctx.h          |    0 
 include/asm-sparc/unistd.h                         |  386 +-------------------
 include/asm-sparc/{unistd.h => unistd_32.h}        |    0 
 .../unistd.h => asm-sparc/unistd_64.h}             |    0 
 include/{asm-sparc64 => asm-sparc}/utrap.h         |    0 
 include/{asm-sparc64 => asm-sparc}/watchdog.h      |    0 
 include/asm-sparc64/Kbuild                         |   23 --
 include/asm-sparc64/apb.h                          |   37 +--
 include/asm-sparc64/asi.h                          |  161 +--------
 include/asm-sparc64/bbc.h                          |  226 +------------
 include/asm-sparc64/display7seg.h                  |   80 +----
 include/asm-sparc64/envctrl.h                      |  104 +------
 include/asm-sparc64/fbio.h                         |  331 +-----------------
 include/asm-sparc64/fcntl.h                        |   36 +--
 include/asm-sparc64/ioctl.h                        |   68 +----
 include/asm-sparc64/ioctls.h                       |  137 +-------
 include/asm-sparc64/ipcbuf.h                       |   29 +--
 include/asm-sparc64/mman.h                         |   32 +--
 include/asm-sparc64/msgbuf.h                       |   28 +--
 include/asm-sparc64/openprom.h                     |  281 +--------------
 include/asm-sparc64/param.h                        |   24 +--
 include/asm-sparc64/poll.h                         |   13 +-
 include/asm-sparc64/posix_types.h                  |  123 +------
 include/asm-sparc64/psrcompat.h                    |   46 +---
 include/asm-sparc64/pstate.h                       |   92 +-----
 include/asm-sparc64/ptrace.h                       |  347 +------------------
 include/asm-sparc64/reg.h                          |   57 +---
 include/asm-sparc64/resource.h                     |   20 +-
 include/asm-sparc64/sembuf.h                       |   23 +--
 include/asm-sparc64/setup.h                        |   11 +-
 include/asm-sparc64/shmbuf.h                       |   39 +--
 include/asm-sparc64/sigcontext.h                   |   88 +-----
 include/asm-sparc64/siginfo.h                      |   33 +--
 include/asm-sparc64/signal.h                       |  195 +----------
 include/asm-sparc64/socket.h                       |   58 +---
 include/asm-sparc64/sockios.h                      |   15 +-
 include/asm-sparc64/stat.h                         |   48 +---
 include/asm-sparc64/statfs.h                       |   55 +---
 include/asm-sparc64/termbits.h                     |  261 +-------------
 include/asm-sparc64/termios.h                      |  187 +----------
 include/asm-sparc64/types.h                        |   35 +--
 include/asm-sparc64/uctx.h                         |   72 +----
 include/asm-sparc64/unistd.h                       |  374 +-------------------
 include/asm-sparc64/utrap.h                        |   52 +---
 include/asm-sparc64/watchdog.h                     |   32 +--
 98 files changed, 310 insertions(+), 5414 deletions(-)
