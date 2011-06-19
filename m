From: Meelis Roos <mroos@linux.ee>
Date: Sun, 19 Jun 2011 16:33:08 +0000
Subject: reorganized struct inode results in unaligned accesses
Message-Id: <alpine.SOC.1.00.1106191927250.4844@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

A week ago I noticed that in 3.0.0-rc3, sparc64 machines log a lot of 
unaligned accesses in different vfs functions in dmesg. I reported but 
obviously not well enough. Today I had a look at it and found the 
reason.

Commit 13e12d14e2dccc7995b8f15a5678a338ab4e6a8c (vfs: reorganize 'struct 
inode' layout a bit) changes i_state to be unsigned int instead of 
unsigned long. This is the cause of unaligned accesses on sparc64 and 
maybe others. Changing it back to unsigned long fixes the warnings but I 
did not look at the layout of the resulting struct - might leave a hole 
there.

-- 
Meelis Roos (mroos@linux.ee)
