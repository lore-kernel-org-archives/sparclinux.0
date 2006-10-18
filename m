From: David Miller <davem@davemloft.net>
Date: Wed, 18 Oct 2006 19:30:11 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <20061018.123011.18302107.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Watson <jim@amarooas.com.au>
Date: Wed, 18 Oct 2006 21:50:24 +1000

> David, thanks - I tried the patch on 2.6.18 but it still hangs up for  
> me. This is not conclusive however as I could not get my build of  
> 2.6.16 to run either. The output from the regs remains as before.

It should remain the same.

Are you sure you're enabling ATYFB video support in your kernel?
That's a common error when folks build their own kernels.
