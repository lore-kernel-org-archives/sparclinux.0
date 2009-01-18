From: David Miller <davem@davemloft.net>
Date: Sun, 18 Jan 2009 07:12:44 +0000
Subject: Re: [PATCH] sparc64: fix modpost failure
Message-Id: <20090117.231244.232105333.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090116101449.GA20332@uranus.ravnborg.org>
In-Reply-To: <20090116101449.GA20332@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Jan 2009 11:14:49 +0100

> Previously PeeCeeI.o was a library but it
> was always pulled in due to insw and friends being exported
> (at least for a modular kernel).
> 
> But this resulted in modpost failures if there where no in-kernel
> users because then insw & friends were not linked in.
> 
> Fix this by including PeeCeeI.o in the kernel unconditionally.
> 
> The only drawback for this solution is that a nonmodular kernel
> will always include insw & friends no matter if they are in use or not.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> I have no good suggestion how to fix this if we do not accept
> that they are always pulled in.

This is the correct way to fix this, for sure.

Applied, thanks Sam.
