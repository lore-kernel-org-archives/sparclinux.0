From: Bob Breuer <breuerr@mc.net>
Date: Sun, 11 Jun 2006 06:15:00 +0000
Subject: [PATCH 0/4] sparc32: smp fixes
Message-Id: <448BB4E4.4060408@mc.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here's a set of patches to get sparc32 caught back up to the moving SMP
target:
 1 - add topology_init
 2 - setup cpu_possible_map
 3 - add missing rw can_lock macros
 4 - mark smp init functions as cpuinit

I have tested these successfully with 2.6.17-rc5.  With 2x
SuperSPARC-II, I can rebuild the kernel with "make -j6" while running
the SMP kernel.  I've verified that UP still builds and runs.  No luck
yet with dual hyperSPARC's, but it will fully boot when restricted to
just one.

Bob
