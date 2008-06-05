From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 05 Jun 2008 20:25:18 +0000
Subject: Re: [RFC] unify exported sparc header files?
Message-Id: <20080605202518.GA2233@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080601072044.GA16220@uranus.ravnborg.org>
In-Reply-To: <20080601072044.GA16220@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jun 05, 2008 at 11:48:59AM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 1 Jun 2008 09:20:45 +0200
> 
> > For all sparc32 specific files:
> >  - nothing
> > 
> > For all the sparc64 specific files:
> >  - copy file to asm-sparc
> >  - wrap the copied file in
> >    #if defined(__sparc_v9__) || defined(CONFIG_SPARC64)
> >       ... file content ...
> >    #endif
> >  - straight include from asm-sparc64 of the asm-sparc file
> > - Or I could just drop the wrapping?
> > 
> > For the non-unified files:
> > - Add content to asm-sparc file and wrap it into:
> >    #if defined(__sparc_v9__) || defined(CONFIG_SPARC64)
> > 	... sparc64 file content
> >    #else
> > 	... sparc32 file content
> >    #endif
> 
> This sounds fine to me.
I just realised we have a common set of files specified in
asm-generic/Kbuild.asm

The diff alone looks like this for these files:
 byteorder.h   |   58 -------------
 errno.h       |  114 ---------------------------
 fcntl.h       |    9 --
 ioctl.h       |    6 -
 ioctls.h      |   10 +-
 ipcbuf.h      |   33 +++----
 kvm.h         |    6 -
 mman.h        |   10 +-
 msgbuf.h      |    6 -
 param.h       |    7 -
 poll.h        |    4
 posix_types.h |   42 +++++-----
 ptrace.h      |  241 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 resource.h    |   15 ---
 sembuf.h      |   11 --
 setup.h       |    8 -
 shmbuf.h      |   14 +--
 sigcontext.h  |   77 ++++++++++++------
 siginfo.h     |   23 ++++-
 signal.h      |  103 ++++++++++--------------
 socket.h      |    3
 sockios.h     |    6 -
 stat.h        |   91 +++++++--------------
 statfs.h      |   54 ++++++++++++
 termbits.h    |   13 +--
 termios.h     |   93 +++++++++++-----------
 types.h       |   14 +--
 unistd.h      |   77 ++++++++----------

Half of this is trivial differences but anyway more work than
I initially anticipated :-(

	Sam
