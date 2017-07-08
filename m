From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Sat, 08 Jul 2017 20:23:42 +0000
Subject: [PATCH 0/2] sparc64: Use low latency path to resume idle cpu
Message-Id: <1499545424-415240-1-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: rob.gardner@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org

cpu_poke is a low latency path to resume the target cpu if suspended
using cpu_yield. Use cpu poke to resume cpu if supported by hypervisor.

	     hackbench results (lower is better):
Number of		
Process:		w/o fix		with fix
1  			0.012		 0.010
10			0.021		 0.019
100			0.151		 0.148

Vijay Kumar (2):
  sparc64: Add a new hypercall CPU_POKE
  sparc64: Use cpu_poke to resume idle cpu

 arch/sparc/include/asm/hypervisor.h |   17 ++++++++
 arch/sparc/include/asm/smp_64.h     |    5 ++
 arch/sparc/kernel/hvapi.c           |    9 ++++
 arch/sparc/kernel/hvcalls.S         |   11 +++++
 arch/sparc/kernel/process_64.c      |    7 +++-
 arch/sparc/kernel/setup_64.c        |    1 +
 arch/sparc/kernel/smp_64.c          |   75 +++++++++++++++++++++++++++++++++-
 7 files changed, 121 insertions(+), 4 deletions(-)
--
