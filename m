From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 31 Oct 2009 16:48:06 +0000
Subject: Re: Sparc release requalification
Message-Id: <20091031164806.GA14747@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Oct 31, 2009 at 03:08:47PM +0000, Jurij Smakov wrote:
> > > >> I built my kernel using v2.6.30.x -stable FWIW.
> > > >> 
> > > >> I'll try straight 2.6.31 with your config.  I wonder if we're
> > > >> in the territory of some compiler issue.
> > > > 
> > > > I'm guessing that compile is finished by now :) can you please post the link
> > > > for me to try and boot?
> > > 
> > > I didn't get around to it, I have to run off now to LinuxCon and
> > > LinuxPlumbers so all of this will have to wait 2 weeks.
> > > 
> > > Sorry.
> > 
> > FWIW I've since compiled and tested latest stable .30, .29 and .28, just to
> > make sure I'm not hitting a heisenbug, but the symptoms are unchanged for
> > .30 and .29, while .28 works. The compiler is the Debian 'stable' sparc gcc,
> > nothing fancy there.
> 
> Josip, did you manage to figure out what's going on here? Did we conclude it is
> a toolchain issue?

No idea, I got stuck there and reverted to .28. Then the machine started
exhibiting some other issues so it was reverted to .26. :/

-- 
     2. That which causes joy or happiness.
