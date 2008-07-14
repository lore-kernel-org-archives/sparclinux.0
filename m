From: David Miller <davem@davemloft.net>
Date: Mon, 14 Jul 2008 03:20:35 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080713.202035.172246136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <487A61DD.6090304@firstfloor.org>
	<20080713.174119.71992292.davem@davemloft.net>
	<20080714111917S.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20080714111917S.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fujita.tomonori@lab.ntt.co.jp
Cc: andi@firstfloor.org, mpatocka@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 14 Jul 2008 11:19:02 +0900

> Now IOMMUs don't ignore the max_segment_size. We hit this problem.

It seems simply that max_segment_size needs to propagate
down into the block layer VMERGE code so that it can
act accordingly.
