From: Ben Collins <bcollins@debian.org>
Date: Thu, 29 Jan 2004 20:30:39 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040129203039.GN532@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 29, 2004 at 02:34:02PM -0600, Otto Solares wrote:
> On Thu, Jan 29, 2004 at 01:29:54PM -0500, Ben Collins wrote:
> > I've tested and fixed initrd support for sparc64, so that's safe.
> > 
> > I've also cleaned up some things. Upon further testing, I was able to
> > boot a 6.8Meg image. Not sure why it didn't work the first time, but
> > beware it may be flakey.
> > 
> > I'm a little disappointed. I haven't gotten any feedback from people
> > testing this new version. So either no one cares, or it works good and
> > people don't want to waste their time sending "worked for me" emails :)
> > 
> > Usual place: http://www.sparc-boot.org/pub/silo/
> 
> You talk something about needed kernel changes to properly use this
> new silo, where are the patches or 2.6.2-rc2-bk3 is good for testing?

You didn't read everything I said then. I said to make use of the larger
kernel sizes, you need the kernel patches, but to use this silo, you
don't. I wanted to make sure it didn't break existing installs.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
