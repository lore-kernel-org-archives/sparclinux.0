From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri, 21 Jul 2017 16:23:55 +0000
Subject: [PATCH v2 0/2] sparc64: Use low latency path to resume idle cpu
Message-Id: <1500654237-23326-1-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CPU_POKE is a low latency path to resume the target cpu if suspended
using CPU_YIELD. Use CPU_POKE to resume cpu if supported by hypervisor.

	     Hackbench results (lower is better):
Number of		
Process:		w/o fix		with fix
1  			0.012		 0.010
10			0.021		 0.019
100			0.151		 0.148

Changelog:
v2:
  - Fixed comments and spacing (2/2)

Vijay Kumar (2):
  sparc64: Add a new hypercall CPU_POKE
  sparc64: Use cpu_poke to resume idle cpu

 arch/sparc/include/asm/hypervisor.h |   18 ++++++++
 arch/sparc/include/asm/smp_64.h     |    5 ++
 arch/sparc/kernel/hvapi.c           |    2 +-
 arch/sparc/kernel/hvcalls.S         |   11 +++++
 arch/sparc/kernel/process_64.c      |    7 +++-
 arch/sparc/kernel/setup_64.c        |    1 +
 arch/sparc/kernel/smp_64.c          |   80 +++++++++++++++++++++++++++++++++-
 7 files changed, 119 insertions(+), 5 deletions(-)

