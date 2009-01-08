From: David Miller <davem@davemloft.net>
Date: Thu, 08 Jan 2009 20:01:59 +0000
Subject: Re: make ARCH=sparc allmodconfig => 64BIT=y
Message-Id: <20090108.120159.253970868.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090108195057.GB1308@uranus.ravnborg.org>
In-Reply-To: <20090108195057.GB1308@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 8 Jan 2009 20:50:57 +0100

> After the patch that added a 64BIT menu I cannot
> generate a 32 bit allmodconfig.
> 
> I have not yet deeply looked at it but I assume this is
> because "64 bit" is a visible menu when we have
> arch equa sparc and then allmodconfig set it to
> the highest value (=y).
...
> What I do locally is that I created a file:
> 
> echo "CONFIG_64BIT=n" > 64bit
> make ARCH=sparc allmodconfig KCONFIG_ALLCONFIGdbit
> 
> This gives me an allmodconfig for 32 bit.

This is pretty crummy behavior.

I don't think people should need to know this clever trick
just to get an allmodconfig 32-bit kernel.  Is every automated
build tested going to do this?  No way.

We might need to revert unless an easy fix can be found.
