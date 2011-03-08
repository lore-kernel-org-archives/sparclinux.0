From: David Miller <davem@davemloft.net>
Date: Tue, 08 Mar 2011 21:30:56 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <20110308.133056.102553642.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 8 Mar 2011 22:27:39 +0100

> /sbin/fsck.ext3 is there, it's used to check / in runlevel 1, i.e. every boot.
> 
> I can happily boot anything 2.6.32.27 or earlier.

One large possibility is that there is a missing cache flush somewhere,
and reverting the memcpy/memset change masks it.

Or, like I said yesterday, bad gcc code generation wrt. those routines.

Looking at ESP logs is not going to give much information as that driver
has been stressed heavily on sparc64 for years without any blips.
