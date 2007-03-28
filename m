From: David Miller <davem@davemloft.net>
Date: Wed, 28 Mar 2007 23:20:16 +0000
Subject: Re: [PATCH] fix sparse warning in of_device.c
Message-Id: <20070328.162016.19785339.davem@davemloft.net>
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

Robert, each and every one of these sparc sparse warnings
applies to 64-bit sparc as well, the code is nearly identical.

I'm been hitting the sparc64 side for each of your patches,
but you can help me out a lot by doing this yourself :-)

Thanks!
