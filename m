From: Meelis Roos <mroos@linux.ee>
Date: Sun, 20 May 2012 16:07:03 +0000
Subject: Best userland for sparc32?
Message-Id: <alpine.SOC.1.00.1205201859120.3202@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have not tested any sparc32 configs since Debian dropped sparc32. 
However, I do have some hardware that I'd like to put to good use for 
testing the sparc32 changes (SS10 SP, SS10 MP, SS10 4x100 Ross, SS20 
(maybe SMP too), SS5 70 MHz stock CPU, SS5 with 170 MHz Fujitsu(?) CPU), 
SS4, probably some lunchboxes too if I find some big enough working 
HDD-s (LX, CLassic), ADEE S10Station (SS10 clone).

That leads to the question, what is the best userland to compile and run 
sparc32 kernels? This probably means recent gcc & binutils, and that 
they are routinely updated. I can ocassionally compile a binutils or a 
gcc if it has been automated by someone else (like in gentoo), or better 
use binary packages and update these. And I want to compile the kernels 
on these machines themselves (as all my tect machines do), to have 
better testing.

So, what distros do people suggest?

-- 
Meelis Roos (mroos@linux.ee)
