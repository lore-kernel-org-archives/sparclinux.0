From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 28 Apr 2009 07:54:07 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090428075407.GB5602@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Apr 27, 2009 at 06:41:52PM -0700, David Miller wrote:
> I downloaded the tftpboot image provided from the Download
> section of the debian.org web site for Sparc.

Can you provide the exact URL? My worry is that you might have downloaded
one of the daily-built images, which may be in various states of brokenness.
The Lenny netboot image is at

http://ftp.nl.debian.org/debian/dists/lenny/main/installer-sparc/current/images/netboot/boot.img

The bug I've mentioned, and which should be resolved in this image, is 
http://bugs.debian.org/504721. I see, however, that we never got a
confirmation from the original reporter that the fix worked on his machine
(it did work for mine).
 
> > I've tested the lenny installer and it worked correctly with serial
> > console (I remember we pushed some fixes for it pretty late in lenny
> > release cycle).
> 
> It's not exactly a serial console, even though the niagara console is
> implemented using a driver that sits on top of the serial core layer.
> 
> If you test on a non-niagara system with serial console, it's not the
> same test.  Not even remotely.  The device name is different, it shows
> up differently in sysfs, etc.
> 
> > I believe we fixed it in Lenny r1 release, it would be great to it if
> > you could upgrade to it and confirm it (or install from scratch using
> > 5.0.1 media from http://www.debian.org/releases/lenny/debian-installer).
> 
> I'll give it a try and report back.

Thanks.
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
