From: David Miller <davem@davemloft.net>
Date: Wed, 18 Aug 2010 20:22:36 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <20100818.132236.189705111.davem@davemloft.net>
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

Does it really make things faster?  What timings have you
done on these code sequences?
