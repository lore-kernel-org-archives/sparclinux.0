From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 12 May 2020 17:15:24 +0000
Subject: [PATCH 0/3] sparc: port to copy_thread_tls() and struct kernel_clone_args
Message-Id: <20200512171527.570109-1-christian.brauner@ubuntu.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>

Hey Dave,

I've tested this series with qemu-system-sparc64 and a Debian Sid image
and it comes up no problem (Here's a little recording
https://asciinema.org/a/329510 ). Process creation works fine for
fork(), vfork(), and clone() afaict. For sparc 32bit I tried my best,
but couldn't get my hands on either a compiler or a useable distro image
for pure sparc32. The changes should be straightforward though but
anyone who can test I'd appreciate it.

This is more or less the explanation also present in the first patch:

This is part of ongoing work that aims at getting rid of the
copy_thread()/copy_thread_tls() split that makes the process creation
codepaths in the kernel more convoluted and error-prone than they need
to be.

This is the sparc specific bit and _if_ you agree with the changes here
it'd be nice if I could get your review, and if technically correct,
your ack so I can fold this into a larger series and move on to the next
arch.

It also unblocks implementing clone3() on architectures not support
copy_thread_tls(). Any architecture that wants to implement clone3()
will need to select HAVE_COPY_THREAD_TLS and thus need to implement
copy_thread_tls(). So both goals are connected but independently
beneficial.

HAVE_COPY_THREAD_TLS means that a given architecture supports
CLONE_SETTLS and not setting it should usually mean that the
architectures doesn't implement it but that's not how things are. In
fact all architectures support CLONE_TLS it's just that they don't
follow the calling convention that HAVE_COPY_THREAD_TLS implies. That
means all architectures can be switched over to select
HAVE_COPY_THREAD_TLS. Once that is done we can remove that macro (yay,
less code), the unnecessary do_fork() export in kernel/fork.c, and also
rename copy_thread_tls() back to copy_thread(). At this point
copy_thread() becomes the main architecture specific part of process
creation but it will be the same layout and calling convention for all
architectures. (Once that is done we can probably cleanup each
copy_thread() function even more but that's for the future.)

Since sparc does support CLONE_SETTLS there's no reason to not select
HAVE_COPY_THREAD_TLS. This brings us one step closer to getting rid of
the copy_thread()/copy_thread_tls() split we still have and ultimately
the HAVE_COPY_THREAD_TLS define in general. A lot of architectures have
already converted and sparc is one of the few hat haven't yet. This also
unblocks implementing the clone3() syscall on sparc which I will follow
up later (if no one gets there before me). Once that is done we can get
of another ARCH_WANTS_* macro.

This patch just switches sparc64 over to HAVE_COPY_THREAD_TLS but not
sparc32 which will be done in the next patch. Once Any architecture that
supports HAVE_COPY_THREAD_TLS cannot call the do_fork() helper anymore.
This is fine and intended since it should be removed in favor of the
new, cleaner _do_fork() calling convention based on struct
kernel_clone_args. In fact, most architectures have already switched.
With this patch, sparc joins the other arches which can't use the
fork(), vfork(), clone(), clone3() syscalls directly and who follow the
new process creation calling convention that is based on struct
kernel_clone_args which we introduced a while back. This means less
custom assembly in the architectures entry path to set up the registers
before calling into the process creation helper and it is easier to to
support new features without having to adapt calling conventions. It
also unifies all process creation paths between fork(), vfork(),
clone(), and clone3(). (We can't fix the ABI nightmare that legacy
clone() is but we can prevent stuff like this happening in the future.)

Note that sparc can't easily call into the syscalls directly because of
its return value conventions when a new process is created which
needs to clobber the UREG_I1 register in copy_thread{_tls()} and it
needs to restore it if process creation fails. That's not a big deal
since the new process creation calling convention makes things simpler.

This removes sparc_do_fork() and replaces it with 3 clean helpers,
sparc_fork(), sparc_vfork(), and sparc_clone(). That means a little more
C code until the next patch unifies sparc 32bit and sparc64. It has the
advantage that we can remove quite a bit of assembler and it makes the
whole syscall.S process creation bits easier to read.
The follow-up patch will remove the custom sparc_do_fork() helper for
32bi sparc and move sparc_fork(), sparc_vfork(), and sparc_clone() into
a common process.c file. This allows us to remove quite a bit of
custom assembly form 32bit sparc's entry.S file too and allows to remove
even more code because now all helpers are shared between 32bit sparc
and sparc64 instead of having to maintain two separate sparc_do_fork()
implementations.

For some more context, please see:
commit 606e9ad20094f6d500166881d301f31a51bc8aa7
Merge: ac61145a725a 457677c70c76
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Jan 11 15:33:48 2020 -0800

    Merge tag 'clone3-tls-v5.5-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux

    Pull thread fixes from Christian Brauner:
     "This contains a series of patches to fix CLONE_SETTLS when used with
      clone3().

      The clone3() syscall passes the tls argument through struct clone_args
      instead of a register. This means, all architectures that do not
      implement copy_thread_tls() but still support CLONE_SETTLS via
      copy_thread() expecting the tls to be located in a register argument
      based on clone() are currently unfortunately broken. Their tls value
      will be garbage.

      The patch series fixes this on all architectures that currently define
      __ARCH_WANT_SYS_CLONE3. It also adds a compile-time check to ensure
      that any architecture that enables clone3() in the future is forced to
      also implement copy_thread_tls().

      My ultimate goal is to get rid of the copy_thread()/copy_thread_tls()
      split and just have copy_thread_tls() at some point in the not too
      distant future (Maybe even renaming copy_thread_tls() back to simply
      copy_thread() once the old function is ripped from all arches). This
      is dependent now on all arches supporting clone3().

      While all relevant arches do that now there are still four missing:
      ia64, m68k, sh and sparc. They have the system call reserved, but not
      implemented. Once they all implement clone3() we can get rid of
      ARCH_WANT_SYS_CLONE3 and HAVE_COPY_THREAD_TLS.

Note that in the meantime, m68k has already switched to the new calling
convention.

Christian Brauner (3):
  sparc64: enable HAVE_COPY_THREAD_TLS
  sparc: share process creation helpers between sparc and sparc64
  sparc: unconditionally enable HAVE_COPY_THREAD_TLS

 arch/sparc/Kconfig                |   1 +
 arch/sparc/include/asm/syscalls.h |   7 +-
 arch/sparc/kernel/Makefile        |   1 +
 arch/sparc/kernel/entry.S         |  29 ++------
 arch/sparc/kernel/kernel.h        |   7 +-
 arch/sparc/kernel/process.c       | 111 ++++++++++++++++++++++++++++++
 arch/sparc/kernel/process_32.c    |  34 ++-------
 arch/sparc/kernel/process_64.c    |  41 ++---------
 arch/sparc/kernel/syscalls.S      |  23 ++++---
 9 files changed, 147 insertions(+), 107 deletions(-)
 create mode 100644 arch/sparc/kernel/process.c


base-commit: 0e698dfa282211e414076f9dc7e83c1c288314fd
-- 
2.26.2
