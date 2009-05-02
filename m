From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 02 May 2009 20:56:24 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090502205624.GA14370@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 02, 2009 at 01:14:49PM -0700, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sat, 2 May 2009 18:04:28 +0100
> 
> > There is a bug filed for that (http://bugs.debian.org/525958), however
> > I don't know what effect removal of this driver will have on machines
> > which do not have another console (like no framebuffer device). I would
> > like to ask people to test this change before uploading it into the
> > archive.
> 
> Would you stop with this?
> 
> We have a driver for every conceivable console device on sparc,
> framebuffer, serial, or otherwise.
> 
> We know this will fix real bugs and increase the bootup time on
> niagara by a factor of 10.
> 
> I can't believe discussion is even necessary for this. :-/

I'm doing an honest effort here to make sure that we don't upload
another broken kernel (and I have my reasons, because, for example,
we had XVR-500 and XVR-2500 drivers disabled in Debian kernels until
recently). As I'm doing it in my free time, I don't see why I should
tolerate your tantrums, which seem to happen every time you report
problems with Debian. Sorry for being a bit harsh, but from now on
I'm going to discard any email from you which does not exclusively
contain constructive comments, patches, or other information which
helps to advance our common goal.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
