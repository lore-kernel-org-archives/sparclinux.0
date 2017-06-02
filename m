From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 02 Jun 2017 18:40:48 +0000
Subject: [v1 0/6] Early boot timestamp
Message-Id: <1496428854-936411-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch to enable early boot timestamps on SPARC. I have previously
submitted this patch together with console fixes, and now decoupled them
so they can be reviewed faster, and independently.

Differences from the previous submission is that I added an offset to
always show timestamps from 0, the same as it is done on other platforms.
And, there are also some performance optimizations in sched_clock().

The final performance of sched_clock() is even faster than now: the same
number of loads, but all of them are coming from the same cacheline.

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
sethi  %hi(0xb9b400), %g2
ldx  [ %g2 + 0x2d0 ], %g1
ldx  [ %g2 + 0x2c0 ], %l1
call  %g1
ldx  [ %g2 + 0x2c8 ], %l0
mulx  %o0, %l1, %l1
srlx  %l1, 0xa, %i0
sub  %i0, %l0, %i0
rett  %i7 + 8
nop

Pavel Tatashin (6):
  sparc64: remove trailing white spaces
  sparc64: access tick function from variable
  sparc64: show time stamps from zero
  sparc64: optimize loads in clock_sched()
  sparc64: improve modularity tick options
  sparc64: initialize time early

 arch/sparc/include/asm/setup.h    |    2 +-
 arch/sparc/include/asm/timer_64.h |    7 ++
 arch/sparc/kernel/kernel.h        |    3 +
 arch/sparc/kernel/setup_64.c      |    7 +-
 arch/sparc/kernel/time_64.c       |  121 ++++++++++++++++++++++++-------------
 5 files changed, 93 insertions(+), 47 deletions(-)

