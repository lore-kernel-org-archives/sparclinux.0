From: Meelis Roos <mroos@linux.ee>
Date: Fri, 28 May 2004 08:07:04 +0000
Subject: hme hang in SMP (was: 2.6.6 SMP on UE2 hangs consistently)
Message-Id: <Pine.GSO.4.44.0405280942530.12976-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Did you try booting with maxcpus=1 or building without SMP ?

I did try maxcpus=1 now, this works too in addition to UP. So it's two
CPU-s that's showing the bug, not just SMP kernel.

Additionally I found out that keyboard is actually OK, I just have to
use the right keymap for 2.6 (duh). So only hme is dieing in real SMP.

-- 
Meelis Roos (mroos@linux.ee)


