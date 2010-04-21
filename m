From: David Miller <davem@davemloft.net>
Date: Wed, 21 Apr 2010 10:23:50 +0000
Subject: [PATCH 0/2] sparc64 backtrace fixups...
Message-Id: <20100421.032350.161189672.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Frederic, I didn't forget what you mentioned about how x86 reports the
translated function_graph return addresses.

These two patches (mainly the second one, the first just does
a small change to make show_regs() be more in line with other
architectures) implement that.

As hinted in the second patch's commit message, we should
consolidate the stack walking logic into a single function
that uses callbacks and such to genericize the operation
and eliminate duplicate code.

Let me know how these patches work for you, thanks!
