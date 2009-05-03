From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 03 May 2009 13:35:24 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090503133524.GA28609@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 03, 2009 at 01:41:40PM +0200, Josip Rodin wrote:
> On Sat, May 02, 2009 at 05:06:04PM -0700, David Miller wrote:
> > From: Josip Rodin <joy@entuzijast.net>
> > Date: Sun, 3 May 2009 00:54:15 +0200
> > 
> > > So I suggest that we get some simple diffing done between the two
> > > pieces of software as a basis for documenting any differences, or
> > > making modifications so that they converge.
> > 
> > If I had just once seen a "Dave, can you test this image out to make
> > sure this Niagara bug is fixed?", I would have been happy with any
> > result whatsoever.
> > 
> > But because that did not happen, I'm understandably irked that things
> > are broken the way that they are.
> > 
> > I have tons of machines to test on, and the knowledge to fix just
> > about anything, I just have to be asked.
> 
> OK, but each distribution lives in a little (or large) ecosystem of their
> own, and even in the case of Debian where the system is open for everyone to
> enter, the actual act of entering the system is necessary in order for
> anyone to participate.
> 
> In this case, where you want to be informed when there's new stuff in
> Debian's sparc kernel, you might want to subscribe yourself to the
> debian-sparc list[1] which is the only Debian sparc port mailing list and
> the place where e.g. calls for testing new kernel images are sent to,
> and maybe to the linux-2.6 package tracking system[2] where you can read
> Debian's Linux kernel package changelogs, which will have references to
> any sparc patches.

This solution does not scale at all. The distribution ecosystem
that integrate sparc kernel should contact the sparc maintainer.
We cannot expect the saprc maintainer to monitor the traffic
all relevant mailing lists - yet expect him to know them.

This simply does not scale neither work in practice.

Yes - you provided pointers to the debian lists but there is
a few more distributions around than just debian.

We could assume that the debian folks handling sparc are capable
of judging when to ask for help/advice from the sparc kernel maintainer.

	Sam
