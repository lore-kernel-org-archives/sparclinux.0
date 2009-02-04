From: David Miller <davem@davemloft.net>
Date: Wed, 04 Feb 2009 07:27:31 +0000
Subject: [GIT]: Sparc
Message-Id: <20090203.232731.09107598.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Some build fixups from Stephen Rothwell, and some debugging
helpers to assist with some of the crashes and hangs we've
been seeing on sparc64 lately.

In particular sparc64 has an NMI watchdog now.

Please pull, thanks a lot!

The following changes since commit dcf6a79dda5cc2a2bec183e50d829030c0972aaa:
  Artem Bityutskiy (1):
        write-back: fix nr_to_write counter

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (6):
      sparc64: Move generic PCR support code to seperate file.
      sparc: Probe PMU type and record in sparc_pmu_type.
      sparc64: Implement NMI watchdog on capable cpus.
      sparc64: On non-Niagara, need to touch NMI watchdog in NOHZ mode.
      sparc64: Validate kernel generated fault addresses on sparc64.
      sparc64: Kill bogus TPC/address truncation during 32-bit faults.

Stephen Rothwell (1):
      sparc: fixup for sparseirq changes

 arch/sparc/include/asm/cpudata_64.h |    2 +-
 arch/sparc/include/asm/irq_64.h     |    4 +-
 arch/sparc/include/asm/kdebug_64.h  |    2 +
 arch/sparc/include/asm/nmi.h        |   10 ++
 arch/sparc/include/asm/pcr.h        |   46 +++++++
 arch/sparc/include/asm/pil.h        |    1 +
 arch/sparc/kernel/Makefile          |    2 +
 arch/sparc/kernel/cpu.c             |   33 ++++--
 arch/sparc/kernel/irq_64.c          |   68 +----------
 arch/sparc/kernel/kernel.h          |    1 +
 arch/sparc/kernel/nmi.c             |  224 +++++++++++++++++++++++++++++++++
 arch/sparc/kernel/pcr.c             |  153 +++++++++++++++++++++++
 arch/sparc/kernel/process_64.c      |    5 +-
 arch/sparc/kernel/setup_64.c        |    2 +
 arch/sparc/kernel/ttable.S          |    3 +-
 arch/sparc/mm/fault_64.c            |   44 ++++++-
 arch/sparc/oprofile/init.c          |  232 +++++-----------------------------
 17 files changed, 548 insertions(+), 284 deletions(-)
 create mode 100644 arch/sparc/include/asm/nmi.h
 create mode 100644 arch/sparc/include/asm/pcr.h
 create mode 100644 arch/sparc/kernel/nmi.c
 create mode 100644 arch/sparc/kernel/pcr.c
