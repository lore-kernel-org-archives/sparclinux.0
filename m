From: David Miller <davem@davemloft.net>
Date: Tue, 09 Dec 2008 23:35:43 +0000
Subject: [PATCH 0/4]: Assembler unification...
Message-Id: <20081209.153543.106486270.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is just an FYI patch posting, I won't push this out to the
sparc-next-2.6 GIT tree until I go over it some more and do some
testing.

This series starts unifying assembler code that is essentially the
same on 32-bit and 64-bit.

The differences are mostly in the branch instructions, since sparc
64-bit has prediction, and branch-on-register instructions.

We fabricate this using some helper macros in a new asm/asm.h header
file.  We'll add new stuff there, as needed.

I also took the opportunity to get these files using the proper
linux/linkage.h macros to define function boundaries.
