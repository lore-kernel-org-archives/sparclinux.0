From: David Miller <davem@davemloft.net>
Date: Sun, 19 Nov 2017 06:54:14 +0000
Subject: Re: [PATCH] sparc64: Set possible and present masks based on nr_cpu_ids
Message-Id: <20171119.155414.106239434154655103.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
In-Reply-To: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


So, this is fixing a regression, right?

If so, you need to provide a proper "Fixes: " tag identifying
the commit that introduced the bug.

I'm also finding it hard to believe that forcing cpu 0 as a possible
cpu is required.  Have you considered contacting the timer subsystem
maintainers and asked them to remove this assumption?

Thank you.
