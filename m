From: David Miller <davem@davemloft.net>
Date: Mon, 06 Aug 2007 01:09:30 +0000
Subject: Sparc-2.6.24 GIT tree
Message-Id: <20070805.180930.21926239.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I cut a 2.6.24 sparc development tree at:

	kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.24.git

merely because I wanted to dump some framebuffer driver changes
out of my inbox that were not appropriate for 2.6.23

The sparc32 asm-sparc/fcntl.h build fix isn't in there, but it's
easy for those interested to patch it in and it will show up there
next time I rebase.
