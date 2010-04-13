From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:42:32 +0000
Subject: [PATCH 0/7] sparc64 function graph tracer support and tidy ups
Message-Id: <20100412.234232.149823029.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This patch set adds function graph tracer support to sparc64.
It was actually pretty easy.

It also gets rid of the stack overflow detector we had hard
coded into mcount, the stack tracer does just as good with
generic facilities.
