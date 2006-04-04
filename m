From: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
Date: Tue, 04 Apr 2006 15:20:42 +0000
Subject: Building a small sparc32 kernel
Message-Id: <20060404151927.GC2358@cassis>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I'm trying to build a 2.6.11 kernel with Bob Breuer's sparc32 SMP
patch[0] for a bi-processor SS20 (currently running a 2.4 SMP kernel).
I'm having a hard time trying to figure out an appropriate build
configuration such that the resulting kernel image is small enough
(i.e., avoiding the "uncompressed image too long" message at boot time).

Does anyone have an appropriate `.config' that may be posted?

Thanks,
Ludovic.

[0] http://article.gmane.org/gmane.linux.ports.sparc/5650/

