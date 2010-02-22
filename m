From: David Miller <davem@davemloft.net>
Date: Mon, 22 Feb 2010 02:24:19 +0000
Subject: Re: SILO problems
Message-Id: <20100221.182419.104047380.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 1 Feb 2010 21:30:40 +0000

> I have confirmed that the "silo: move second to make room for larger 
> kernel" commit [1] is causing the breakage, excluding this commit 
> makes the system boot normally:
 ...
> On a related note, I had to apply the attached patch (Signed-off-by: 
> Jurij Smakov <jurij@debian.org>) to make SILO build with 2.6.32 kernel 
> headers (which, apparently, are defining _LINUX_TYPES_H again).

I've commited the revert and your build fix to the GIT tree
on kernel.org, thanks!
