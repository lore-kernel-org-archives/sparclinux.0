From: David Miller <davem@davemloft.net>
Date: Wed, 08 Aug 2007 05:44:38 +0000
Subject: Re: GCC 4.2.1 produces broken 2.6.22.1 kernel.
Message-Id: <20070807.224438.45876988.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46B7600A.3060700@walrond.org>
In-Reply-To: <46B7600A.3060700@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Walrond <andrew@walrond.org>
Date: Mon, 06 Aug 2007 18:53:14 +0100

> Confirmed; GCC 4.2.1 (vanilla) produces a broken 2.6.22.1 kernel. I
> don't know why, or whether GCC or the kernel is at fault, but the exact
> same kernel and config builds and boots fine with GCC 4.1.2.

Thanks for tracking this down, if I get some time I'll
reproduce it here and try to figure out if it could
be a kernel side issue of some sort.
