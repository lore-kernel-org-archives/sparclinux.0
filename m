From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 02 May 2009 17:04:28 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090502170427.GA11653@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 02, 2009 at 09:53:50AM -0700, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sat, 2 May 2009 11:28:05 +0100
> 
> > + attachment for real.
> 
> It prints "serial"
> 
> I suspect that PROM console device driver is getting in the way.
> 
> Please take that out of the kernel configuration ASAP.

There is a bug filed for that (http://bugs.debian.org/525958), however
I don't know what effect removal of this driver will have on machines
which do not have another console (like no framebuffer device). I would
like to ask people to test this change before uploading it into the
archive. Unfortunately, the current kernel in instable is completely
broken, so the first step is to get it to boot again, kernel team should
be doing a new upload within the next few days.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
