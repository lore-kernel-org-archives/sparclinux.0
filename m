From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2018 04:19:43 +0000
Subject: [PATCH WIP 0/2] Sparc RSEQ support...
Message-Id: <20181010.211943.943997307813263418.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Some work in progress patches I've been working on to add rseq
support to sparc.

It currently works with one minor hack on sparc64.  The issue is that
__thread object alignment isn't working properly in the test cases so
I disable the alignment check in the rseq syscall implementation
whilst running the tests.  All the tests pass on sparc64 with this
hack.

I plan to look into why glibc isn't aligning TLS objects in threads
properly.

Sparc32 needs some fleshing out.  First, sparc32 needs
HAVE_REGS_AND_STACK_ACCESS_API support added, which isn't much work.
Second, the rseq testcase sparc code needs to be made wordsize
agnostic.  I just rushed the implementation to test the sparc64 kernel
bits out quickly.

Signed-off-by: David S. Miller <davem@davemloft.net>
