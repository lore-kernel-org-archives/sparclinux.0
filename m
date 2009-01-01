From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 19:59:19 +0000
Subject: more header unification
Message-Id: <20090101200053.GA27333@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This set of patches includes:

- the fixed unification of ptrace.h
- unification of siginfo.h
- unification of openprom.h

Unification of openprom.h involved sevral smaller preparational steps
especially because it contained some unused stuff which was deleted in
individual patches.

Builds on sparc32 and sparc64.

arch/sparc/include/asm/Kbuild now only list reg.h as no unified.

I started to look at reg.h and was suprised to see that so much
in the file was not used. So I grepped where it is actually used
in the kernel and it is not used at all.
Two drivers included <asm/reg.h> but they were both powerpc specific.

So it looks like the trivial right thing would be to just delete the files.

But then this is part of our userspace ABI so maybe we do not use the
definitions in the kernel but userspace rel on them?

For now I left it as is awaiting someone with better knowledge to
say what to do with the reg*.h files.

	Sam


Sam Ravnborg (7):
      sparc: unify ptrace.h
      sparc: unify siginfo.h
      sparc: remove ebus definitions from openprom*.h
      sparc: remove linux_prom_pci_assigned_addresses from openprom_32.h
      sparc: prepare openprom for unification
      sparc64: delete unused linux_prom64_ranges from openprom_64.h
      sparc: unify openprom.h

 arch/sparc/include/asm/Kbuild                      |    7 -
 .../include/asm/{openprom_32.h => openprom.h}      |   64 +++--
 arch/sparc/include/asm/openprom_64.h               |  280 --------------------
 arch/sparc/include/asm/{ptrace_64.h => ptrace.h}   |  140 ++++++++--
 arch/sparc/include/asm/ptrace_32.h                 |  186 -------------
 arch/sparc/include/asm/{siginfo_64.h => siginfo.h} |   15 +-
 arch/sparc/include/asm/siginfo_32.h                |   17 --
 7 files changed, 169 insertions(+), 540 deletions(-)
