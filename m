From: Ben Collins <bcollins@debian.org>
Date: Wed, 14 Apr 2004 11:29:36 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <20040414112936.GR1947@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 13, 2004 at 10:04:40AM +0400, Alexey Nezhdanov wrote:
> 13/04/2004 09:21 David S. Miller wrote:
> > On Tue, 13 Apr 2004 09:09:16 +0400
> >
> > Alexey Nezhdanov <snake@penza-gsm.ru> wrote:
> > > This is sad but it seems that my box is too unlucky with current linux
> > > kernel.
> >
> > None of the developers have such a system, so it not working
> > is really not all that surprising. :-)
> I can provide all needed level of access if it will make difference (except of 
> physical of course) :) .

If you can setup serial console access to it from another box that I can
ssh into, I'll try to get it booting. You will also need tftp/rarp setup
on the ssh box, and give me enough access to put items on there for the
sb2k to netboot from.

Contact me privately if that's of interest to you. Would be best if the
sb2k had LOM (Lights Out Management) or you had a UPS that I could also
get to for doing power cycles to avoid long delays when the machine
locks solid and I need to get you to power cycle it.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
