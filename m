From: David Miller <davem@davemloft.net>
Date: Thu, 08 Mar 2007 21:46:02 +0000
Subject: Re: Sunfire v880
Message-Id: <20070308.134602.55509213.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
In-Reply-To: <a728f9f90703061649i63c845a3o593040df1cd0760f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Thu, 8 Mar 2007 09:18:43 -0500

> On 3/7/07, Alex Deucher <alexdeucher@gmail.com> wrote:
> > Gentoo seems to be carrying this patch:
> > http://marc.theaimsgroup.com/?l=linux-sparc&m0314220200915&w=2
> >
> > I'm going to try and see if that is indeed what fixes the issue.  If
> > so perhaps it should go upstream?
> >
> 
> FWIW, this patch got 2.6.17 vanilla booting for us.  I hope that
> helping in tracking things down in the newer kernels.

It doesn't at all.

That patch modifies prom_gettree() which won't be called until
long after the machine boots up and /proc/openprom is mounted.

We're getting nowhere, we have patches to code that doesn't run
during bootup fixing the bootup, printk() statements that don't
actually print out anything, etc.

This is turning in a waste of time and I'm only going to be able to
fix this with physical access to an v880 machine that exhibits the
problem instead of going back and forth like this every day.
