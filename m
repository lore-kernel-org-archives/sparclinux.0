From: David Miller <davem@davemloft.net>
Date: Fri, 09 Mar 2007 05:22:09 +0000
Subject: Re: [PATCH]: fix section mismatch warning in cg14.c
Message-Id: <20070308.212209.96683042.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1173417373.7384.2.camel@dell>
In-Reply-To: <1173417373.7384.2.camel@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: 09 Mar 2007 00:16:13 -0500

> Fix section mismatch warning by moving data into __devinitdata section.
> Add __devinit to an initialization function.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied, thanks Robert.
