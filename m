From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 20:41:40 +0000
Subject: [v3 0/8] Early boot timestamp
Message-Id: <1497300108-158125-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Changelog:
	v2 - v3:
		- __aligned(64) -> __cacheline_aligned
		- Replaced in sched_clock() wmb() with barrier()
	v1 - v2:
		- Early boot timestamps are now available on all 64-bit
		  sparc processors
		- New hot-patched get_tick() function.

This patch set:
- enables early boot timestamps on SPARC,
- adds offset so we count time from zero, the same as it is done on other
  platforms
- improves the performance by inling, hot patching, and combining loads
  into the same cacheline. (and few other optimizations).

So, the final performance of sched_clock() is faster than now: the fewer
number of loads, and all of them are coming from the same cacheline. Loads
can run while we are reading tick value, and we do not do function call.

Current sched_clock():
sethi  %hi(0xb9b400), %g1
ldx  [ %g1 + 0x250 ], %g1
ldx  [ %g1 ], %g1
call  %g1
nop
sethi  %hi(0xb9b400), %g1
ldx  [ %g1 + 0x300 ], %g1
mulx  %o0, %g1, %g1
rett  %i7 + 8
srlx  %g1, 0xa, %o0

Final sched_clock():
sethi  %hi(0xb9b400), %g1
ldx  [ %g1 + 0x2c8 ], %g2
ldx  [ %g1 + 0x2c0 ], %g1
b  42f638 <sched_clock+0x44>
rd  %asr24, %i0
...
sllx  %i0, 1, %i0
srlx  %i0, 1, %i0
mulx  %i0, %g1, %i0
srlx  %i0, 0xa, %i0
rett  %i7 + 8
sub  %o0, %g2, %o0

Pavel Tatashin (8):
  sparc64: remove trailing white spaces
  sparc64: access tick function from variable
  sparc64: show time stamps from zero
  sparc64: optimize loads in clock_sched()
  sparc64: improve modularity tick options
  sparc64: initialize time early
  sparc64: add hot-patched and inlined get_tick()
  sparc64: optimize functions that access tick

 arch/sparc/include/asm/setup.h    |    2 +-
 arch/sparc/include/asm/timer_64.h |   67 ++++++++++++++++
 arch/sparc/kernel/kernel.h        |    3 +
 arch/sparc/kernel/setup_64.c      |    7 +-
 arch/sparc/kernel/time_64.c       |  155 ++++++++++++++++++++++++-------------
 arch/sparc/kernel/vmlinux.lds.S   |    5 +
 6 files changed, 181 insertions(+), 58 deletions(-)

