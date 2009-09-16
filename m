From: Josip Rodin <joy@debbugs.entuzijast.net>
Date: Wed, 16 Sep 2009 08:03:46 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090916080346.GA23083@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Sep 15, 2009 at 08:38:22PM +0100, Jurij Smakov wrote:
> > > > If the PROM console driver still has some utility, maybe the boot option is
> > > > the way to go... does it? Does anyone still manufacture new machines with
> > > > new and strange console types that we don't support? :)
> > > 
> > > The PROM console driver has no relevance today at all.
> > > 
> > > It should simply never be used.
> > 
> > OK, cool, please remove it, and also please propagate that to the stable
> > branches so we don't miss anyone who's not on the bleeding edge.
> 
> Please feel free to follow up on http://bugs.debian.org/525958 which I've
> filed in April to have the CONFIG_PROM_CONSOLE removed.

Yeah, definitely, Cc:ed. Dave has in the meantime killed it completely in
his stable tree:

http://git.kernel.org/?p=linux/kernel/git/davem/sparc-2.6.git;a=commit;h	d3f3f0e02c8a900d076c302c5c02227f33572d

There's another commit that takes it out of the defconfigs completely - it
was already unset there for a while now. So it's pretty much official now
(well, Linus still has to take it in, but that should be a formality).

-- 
     2. That which causes joy or happiness.
