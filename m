From: David Miller <davem@davemloft.net>
Date: Sat, 02 May 2009 20:14:49 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090502.131449.01795010.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 2 May 2009 18:04:28 +0100

> There is a bug filed for that (http://bugs.debian.org/525958), however
> I don't know what effect removal of this driver will have on machines
> which do not have another console (like no framebuffer device). I would
> like to ask people to test this change before uploading it into the
> archive.

Would you stop with this?

We have a driver for every conceivable console device on sparc,
framebuffer, serial, or otherwise.

We know this will fix real bugs and increase the bootup time on
niagara by a factor of 10.

I can't believe discussion is even necessary for this. :-/

