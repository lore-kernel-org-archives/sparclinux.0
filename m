From: David Miller <davem@davemloft.net>
Date: Thu, 14 Aug 2008 00:21:13 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080813.172113.161885391.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080813.164520.86944543.davem@davemloft.net>
In-Reply-To: <20080813.164520.86944543.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 13 Aug 2008 16:45:20 -0700 (PDT)

> 3) Implement IRQ stacks to deal with very real deep stack code path
>    situations, as reported by Mikulas Patocka.  Also, fix a recursion
>    bug in stack overflow detection.

While further testing I noticed a bug which I've pushed into the
tree, please repull to fetch it if you haven't already, thanks!

The following changes since commit 4f70f7a91bffdcc39f088748dc678953eb9a3fbd:
  David S. Miller (1):
        sparc64: Implement IRQ stacks.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Handle stack trace attempts before irqstacks are setup.

 arch/sparc64/kernel/kstack.h     |   38 ++++++++++++++++++++------------------
 arch/sparc64/kernel/stacktrace.c |    3 +--
 2 files changed, 21 insertions(+), 20 deletions(-)
