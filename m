From: David Miller <davem@davemloft.net>
Date: Sat, 25 Aug 2007 09:51:38 +0000
Subject: Re: GCC 4.2.1 produces broken 2.6.22.1 kernel.
Message-Id: <20070825.025138.124757333.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46B7600A.3060700@walrond.org>
In-Reply-To: <46B7600A.3060700@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Walrond <andrew@walrond.org>
Date: Sat, 25 Aug 2007 09:05:11 +0100

> David Miller wrote:
> > 
> > Just an update that I did look into this and I do know what is being
> > miscompiled and how.
> > 
> > I'll try to follow through on this and come up with a testcase
> > for the gcc folks to look into.  But it may need to wait until
> > after Kernel Summit and the Netfilter Workshop.
> > 
> 
> Thanks for the update; I've reverted to 4.1.* for kernel compiles in the
> meantime.
> 
> BTW, I have been configuring for SLUB and I noticed your message on LKML
> about it. Should I revert to SLAB? (I'm running 2.6.22.x on 2Gb T1000's)

Both should work fine, I happen to be using SLUB lately.
