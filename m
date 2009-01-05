From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jan 2009 08:54:33 +0000
Subject: Re: [PATCH] sparc: remove reg.h from Kbuild
Message-Id: <20090105.005433.248018263.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105085315.GA17530@uranus.ravnborg.org>
In-Reply-To: <20090105085315.GA17530@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 5 Jan 2009 09:53:15 +0100

> remove stale reference from Kbuild.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> The better solution would be to integrate this with the
> commit that remove the files - but this is only feasible
> if you have not yet pushed out the tree.

I don't get it, I thought I did this when I commited my
change. :-/

Indeed, git status on my local tree shows:

#	modified:   arch/sparc/include/asm/Kbuild

Ugh!

I'll commit my local forgotten change, thanks Sam.
