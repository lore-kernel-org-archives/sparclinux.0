From: David Miller <davem@davemloft.net>
Date: Thu, 29 Mar 2007 02:40:36 +0000
Subject: Re: [PATCH] fix sparse warning in of_device.c
Message-Id: <20070328.194036.41629823.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <460AF52F.1080204@earthlink.net>
In-Reply-To: <460AF52F.1080204@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Wed, 28 Mar 2007 19:07:27 -0400

> Fix sparse warning:
> 
> arch/sparc/kernel/of_device.c:439:46: warning: incorrect type in 
> argument 3 (different signedness)
> arch/sparc/kernel/of_device.c:439:46:    expected int *lenp
> arch/sparc/kernel/of_device.c:439:46:    got unsigned int *<noident>
> 
> Signed-off-by: Robert Reif <reif@erathlink.net>

This patch is not correct.

The loop at the end of this function depends upon the signedness of
'rlen' to handle underflow situations.

With your change to make it unsigned, the loop can possibly not
terminate because if 'rlen' gets decremented below zero it will become
a "very large positive number" instead of a negative one.
