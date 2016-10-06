From: David Miller <davem@davemloft.net>
Date: Thu, 06 Oct 2016 05:38:50 +0000
Subject: user probes patch
Message-Id: <20161006.013850.1300008206447553874.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I was reading the user probes sparc patch and I noticed that
it doesn't handle the 'y' register properly in the pt_regs
accessors because it assumes that all of the registers are
"unsigned long" in size.  The 'y' register is "unsinged int".
