From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 20 Apr 2018 14:35:52 +0000
Subject: [REVIEW][PATCH 00/22] Simplifying siginfo users
Message-Id: <87604mhrnb.fsf@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <878t9ilmhv.fsf@xmission.com>
In-Reply-To: <878t9ilmhv.fsf@xmission.com> (Eric W. Biederman's message of
        "Thu, 19 Apr 2018 20:01:16 -0500")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Albert Ou <albert@sifive.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Chris Zankel <chris@zankel.net>, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, James Bottomley <jejb@parisc-linux.org>, James Hogan <jhogan@kernel.org>, Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>, Ley Foon Tan <lftan@altera.com>, Mark Salter <msalter@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org


This patchset is almost completely updating the various pieces of
architecture code from filling out a struct siginfo and then calling
force_sig_info.  To using the helper force_sig_fault instead.  Which
takes the values that would have gone in siginfo as arguments.

As the diffstat below shows this noticeable reduces the amount of code.

There are a couple of minor and straight forward bug fixes as well
that I came across while working on the aforementioned changes.

This applies on my last round of siginfo changes simply to remove the
possibility of conflicts.  The changes should be semantically separate.

I intend to merge these changes through my siginfo tree.  If you have
any objections or would prefer to carry these changes in your
architecture trees please let me know.

The changes are also available at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-review2

Eric W. Biederman (22):
      signal/alpha: Use send_sig_fault where appropriate
      signal/alpha: Use force_sig_fault where appropriate
      signal/c6x: Use force_sig_fault where appropriate
      signal/hexagon: Use force_sig_fault as appropriate
      signal/m68k: Use force_sig_fault where appropriate
      signal/microblaze: Remove the commented out force_sig_info in do_page_fault
      signal/microblaze: Use force_sig_fault where appropriate
      signal/mips: Use force_sig_fault where appropriate
      signal/nds32: Use force_sig_fault where appropriate
      signal/nios2: Use force_sig_fault where appropriate
      signal/openrisc: Use force_sig_fault where appropriate
      signal/parisc: Use force_sig_mceerr where appropriate
      signal/parisc: Use force_sig_fault where appropriate
      signal/riscv: Use force_sig_fault where appropriate
      signal/s390: Use force_sig_fault where appropriate
      signal/sh: Use force_sig_fault where appropriate
      signal/sparc: Use send_sig_fault where appropriate
      signal/sparc: Use force_sig_fault where appropriate
      signal/um: Use force_sig_fault in relay_signal.
      signal/um: Use force_sig_fault where appropriate
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
      signal/xtensa: Use force_sig_fault where appropriate

 arch/alpha/kernel/osf_sys.c         |  10 +--
 arch/alpha/kernel/signal.c          |  22 +-----
 arch/alpha/kernel/traps.c           |  80 +++++---------------
 arch/alpha/mm/fault.c               |  15 +---
 arch/c6x/kernel/traps.c             |  10 +--
 arch/hexagon/kernel/traps.c         |  10 +--
 arch/hexagon/mm/vm_fault.c          |  21 ++----
 arch/m68k/kernel/traps.c            |  60 +++++++--------
 arch/m68k/mm/fault.c                |  25 +++----
 arch/microblaze/kernel/exceptions.c |   9 +--
 arch/microblaze/mm/fault.c          |  14 +---
 arch/mips/kernel/traps.c            |  65 +++++-----------
 arch/mips/mm/fault.c                |  19 ++---
 arch/nds32/kernel/traps.c           |  20 +----
 arch/nds32/mm/fault.c               |  19 ++---
 arch/nios2/kernel/traps.c           |   9 +--
 arch/openrisc/kernel/traps.c        |  33 +-------
 arch/openrisc/mm/fault.c            |  19 ++---
 arch/parisc/kernel/ptrace.c         |  11 +--
 arch/parisc/kernel/traps.c          |  63 +++++-----------
 arch/parisc/kernel/unaligned.c      |  16 +---
 arch/parisc/math-emu/driver.c       |   9 +--
 arch/parisc/mm/fault.c              |  55 +++++++-------
 arch/riscv/kernel/traps.c           |   9 +--
 arch/s390/kernel/traps.c            |  32 ++------
 arch/s390/mm/fault.c                |  23 ++----
 arch/sh/kernel/traps_32.c           |  19 ++---
 arch/sh/math-emu/math.c             |   9 +--
 arch/sh/mm/fault.c                  |  10 +--
 arch/sparc/kernel/process_64.c      |  10 +--
 arch/sparc/kernel/sys_sparc_32.c    |   9 +--
 arch/sparc/kernel/sys_sparc_64.c    |   8 +-
 arch/sparc/kernel/traps_32.c        | 114 +++++-----------------------
 arch/sparc/kernel/traps_64.c        | 145 +++++++-----------------------------
 arch/sparc/kernel/unaligned_32.c    |  12 +--
 arch/sparc/mm/fault_32.c            |  13 +---
 arch/sparc/mm/fault_64.c            |   9 +--
 arch/um/kernel/ptrace.c             |  13 +---
 arch/um/kernel/trap.c               |  54 ++++++--------
 arch/xtensa/kernel/traps.c          |  10 +--
 arch/xtensa/mm/fault.c              |  19 ++---
 41 files changed, 280 insertions(+), 852 deletions(-)

Eric
