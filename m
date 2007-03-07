From: David Miller <davem@davemloft.net>
Date: Wed, 07 Mar 2007 22:34:38 +0000
Subject: Re: Sunfire v880
Message-Id: <20070307.143438.112621119.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Wed, 7 Mar 2007 16:02:29 -0500

> On 3/7/07, David Miller <davem@davemloft.net> wrote:
> > From: "Alex Deucher" <alexdeucher@gmail.com>
> > Date: Wed, 7 Mar 2007 15:47:41 -0500
> >
> > > On 3/7/07, David Miller <davem@davemloft.net> wrote:
> > > > From: "Alex Deucher" <alexdeucher@gmail.com>
> > > > Date: Wed, 7 Mar 2007 11:55:53 -0500
> > > >
> > > > > Gentoo seems to be carrying this patch:
> > > > > http://marc.theaimsgroup.com/?l=linux-sparc&m0314220200915&w=2
> > > > >
> > > > > I'm going to try and see if that is indeed what fixes the issue.  If
> > > > > so perhaps it should go upstream?
> > > >
> > > > That code he is changing doesn't even exist in the tree any
> > > > longer.
> > > >
> > >
> > > d'oh!  well, It still seems to be in 2.6.17, FWIW.  Any ideas on the
> > > newer kernels?
> >
> > The newer kernels elimintated that code because the strings are computed
> > differently.
> >
> > Anyways, let's start backwards, have you tested 2.6.20 by chance?  It
> > should be easy for you to build test kernels out of the vanilla tree.
> > This could simply be a bug that has been fixed long since these older
> > distribution kernels.
> >
> 
> No not yet.  what's the best way to do that?  Can I just point the
> netboot to a kernel image?

You untar the vanilla 2.6.20 kernel source tree, you configure the
kernel, you build it, then you install the modules and the kernel
image.

Someone I suppose can help you if you can't figure out how to do
this yourself.
