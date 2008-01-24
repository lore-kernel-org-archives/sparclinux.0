From: Meelis Roos <mroos@linux.ee>
Date: Thu, 24 Jan 2008 14:26:32 +0000
Subject: compile failure in Solaris emulation
Message-Id: <Pine.SOC.4.64.0801241625190.21771@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Tried to ompile todays 2.6.24-rc8+git on sparc64 and got this:

  CC [M]  arch/sparc64/solaris/socksys.o
arch/sparc64/solaris/socksys.c: In function 'init_socksys':
arch/sparc64/solaris/socksys.c:192: error: assignment of read-only variable 'socksys_file_ops'
arch/sparc64/solaris/socksys.c:195: error: assignment of read-only variable 'socksys_file_ops'
arch/sparc64/solaris/socksys.c:196: error: assignment of read-only variable 'socksys_file_ops'

-- 
Meelis Roos (mroos@linux.ee)
