From: David Miller <davem@davemloft.net>
Date: Sat, 27 Dec 2008 08:35:32 +0000
Subject: Re: [PATCH] sparc: unify sections.h
Message-Id: <20081227.003532.185646321.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081222181412.GA29264@uranus.ravnborg.org>
In-Reply-To: <20081222181412.GA29264@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 19:14:12 +0100

> While doing this use standard names for start/end
> so we could use definitions straight from asm-generic
> for all the typical symbols.
> 
> This also allowed us to drop the use of PROVIDE in the linker
> script so sprc is less non-standard on this area.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Also applied, thanks Sam!
