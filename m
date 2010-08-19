From: David Miller <davem@davemloft.net>
Date: Thu, 19 Aug 2010 05:52:05 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <20100818.225205.02279858.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Aug 2010 14:03:37 -0400 (EDT)

> Simple microoptimizations for sparc64 atomic functions:
> Save one instruction by using a delay slot.
> Use %g1 instead of %g7, because %g1 is written earlier.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Actually after some more consideration and studying of this code I've
decided to apply your patch, thanks a lot Mikulas.

I'll then add the BACKOFF macro fixup for the UP case.
