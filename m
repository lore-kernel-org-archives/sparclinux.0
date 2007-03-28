From: David Miller <davem@davemloft.net>
Date: Wed, 28 Mar 2007 19:55:55 +0000
Subject: Re: [PATCH] fix section mismatch in cg3.c
Message-Id: <20070328.125555.34759153.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1174476168.22880.7.camel@dell>
In-Reply-To: <1174476168.22880.7.camel@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Wed, 28 Mar 2007 13:07:39 -0400

> Fix section mismatch warning by moving data into __devinitdata section.
> Add __devinit to initialization functions.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied, thanks Robert.

Can you please resend the a.out.h bitfield fix too?  sparc64
and sparc32 both have that same problem, so if you could
fix both cases in your patch that would be great.

Thanks again.
