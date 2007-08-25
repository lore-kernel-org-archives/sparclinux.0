From: David Miller <davem@davemloft.net>
Date: Sat, 25 Aug 2007 05:18:21 +0000
Subject: Re: GCC 4.2.1 produces broken 2.6.22.1 kernel.
Message-Id: <20070824.221821.69226332.davem@davemloft.net>
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
> 
> This is on a Sun T1000 niagra box. Anything I can do? let me know.

Just an update that I did look into this and I do know what is being
miscompiled and how.

I'll try to follow through on this and come up with a testcase
for the gcc folks to look into.  But it may need to wait until
after Kernel Summit and the Netfilter Workshop.

