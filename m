From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2007 10:22:34 +0000
Subject: Re: [PATCH] fix sparc32 kdebug changes
Message-Id: <20070514.032234.126765699.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46444A9F.6040407@earthlink.net>
In-Reply-To: <46444A9F.6040407@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 11 May 2007 06:51:11 -0400

> Fix recent kdebug changes to compile on sparc32.
> 
> Compile tested only because recent smp.h changes also break sparc32.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied, thanks Robert.

I'll see if I can work out the SMP build breakage.
