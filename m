From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 08:16:42 +0000
Subject: Re: [PATCH 0/14]: Commonization of OF device tree code.
Message-Id: <20081207081642.GA11779@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081205.190455.152563946.davem@davemloft.net>
In-Reply-To: <20081205.190455.152563946.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Dec 06, 2008 at 11:33:43AM -0500, Robert Reif wrote:
> David Miller wrote:
> >All of this work has been build tested on both
> >ports and pushed out to sparc-next-2.6 on kernel.org
> >  
> Boots fine on sparc32.

Thanks for all your testing effort Robert.
It is great you catch it so early so sparc32 does not
bitrot in a non-bootable state.

I have an old patchset where all the final link of vmlinux
is moved from the top-level Makefile to a shell script.
When I did this I hit troubles with um and sparc32.

So when I put some effort back into that patchset
I will most likely need your assistance again as
I will need to fiddle with the btfixuf stuff.

But it will take a while..

	Sam
