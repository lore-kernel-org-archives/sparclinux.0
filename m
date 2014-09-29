From: David Miller <davem@davemloft.net>
Date: Mon, 29 Sep 2014 21:33:17 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140929.173317.182030501483239299.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bob.picco@oracle.com>
Date: Mon, 29 Sep 2014 17:03:22 -0400

> My local T4-2 and T5-2 seem solid for THP "always" and large kernel parallel
> makes. I've seen no issues.

Ok, how about the T5-8?  Does it at least boot properly with
DEBUG_PAGEALLOC disabled?

