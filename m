From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 04 May 2009 15:03:57 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090504150357.GA20942@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 04, 2009 at 02:15:01PM +0200, Florian Fainelli wrote:
> > > As far as I can tell, the main issue is that nobody's actively working
> > > on the debian sparc port in the first place.  And without active
> > > maintainers, that port is actually a disservice to users and the sparc
> > > linux community.
> >
> > Even if nobody is currently volunteering to explicitly state that they are
> > working on the port as a whole (which has always been a fairly vague
> > concept anyway), the software is generally working fine (yes, even if it
> > has bugs), the buildds are happily churning (and are actually actively
> > maintained), new users do actually regularly come through, so I fail to see
> > how it's a disservice to everyone.
> 
> A distribution developer should provide users with working kernels. Getting 
> software x.y.z to work on sparc is something different. So rather than 
> disservicing anyone it is just annoying not being able to boot a kernel or 
> having it partially working for something as stupid as enabling/disabling the 
> right kernel options.
> 
> >
> > What is that statement supposed to mean, anyway? Would you prefer if
> > the port didn't exist at all?
> 
> No as long as there are users for it, please maintain it, but focus your 
> attention on kernels rather than geting the whole Debian package set to work.

The released kernel should actually be working for a large majority of
machines, so that goal is almost accomplished. IIRC, in etch, we didn't
support a few older classes of Ultra Enterprise machines out of the box
because brokenness with some ESP controller, and in lenny we miss the
Ultra 45 series because of that fake PCI controller patch undoing (in turn
related to broken X on other Ultra workstations).

Overall I've had very similar experiences with x86 machines. I've had to
work around server installations several times because of lack of support
for RAID controllers, and even my current laptop's X driver reliably oopses
the kernel whenever I use the docking station, which is also a regression
from the last release. I would be nice to be able to cry about the general
state of things in those cases too, now wouldn't it...

-- 
     2. That which causes joy or happiness.
