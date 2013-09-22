From: Bob Picco <bpicco@meloft.net>
Date: Sun, 22 Sep 2013 17:15:46 +0000
Subject: Re: [PATCH 2/6] sparc64: Use PAGE_OFFSET instead of a magic constant.
Message-Id: <20130922171546.GF29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20130921.011606.1110497485903037346.davem@davemloft.net>
In-Reply-To: <20130921.011606.1110497485903037346.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Sat Sep 21 2013, 01:16:06AM EDT]
> 
> This pertains to all of the computations of the kernel fast
> TLB miss xor values.
> 
> Based upon a patch by Bob Picco.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Acked-by: Bob Picco <bob.picco@oracle.com>
