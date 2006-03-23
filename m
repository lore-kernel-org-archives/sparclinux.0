From: Lamar Owen <lowen@pari.edu>
Date: Thu, 23 Mar 2006 20:30:10 +0000
Subject: Re: Sun Enterprise 6500. 10xUltraSPARC/400MHz, 10Gb mem
Message-Id: <200603231530.11060.lowen@pari.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <87d5gegxf3.fsf@pumba.bayour.com>
In-Reply-To: <87d5gegxf3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 23 March 2006 15:11, David S. Miller wrote:
> From: Lamar Owen <lowen@pari.edu>
> Date: Thu, 23 Mar 2006 14:29:38 -0500
>
> > but having to netboot and netinstall
> > means to me that it's probably not ready for production

> The CDROM images boot just fine and I absolutely challenge you find a
> way to crash a Niagara machine running the current Dapper release.

Certainly no offense intended, David, as to the kernel's stability.  But a 
distribution is far more than a kernel, and the whole system's stability 
depends on the whole distribution, and particularly on the compiler chain and 
glibc.

Unless you have access to some images that are not public, the latest Dapper 
on ports.ubuntu.com, dated yesterday, does not include full installer CDROMS;  
you have the choice to either netboot and netinstall, or boot the mini.iso 
and netinstall.  I'll consider it for production when two things happen:
1.) Dapper Drake itself is fully released in non-alpha non-beta form;
2.) The SPARC port is released in non-alpha non-beta full installer form.

From my vantage point, there are very few SPARC Linux distributions that 
qualify for production.  The current Debian STABLE is one of them, as is 
Aurora 1.0.  I have not had the time to do any stage Gentoo to comment on its 
stability.  Out of sheer necessity I am running a box in production on Aurora 
1.92, and it has proven stable; Aurora 2.0 looks promising as well.  And, 
again, once Ubuntu SPARC has its non-beta release it will likewise be 
considered; although I might grab it to experiment.

As far as the kernel is concerned, you are almost assuredly completely correct 
as to its stability (you would be the one person who could be that sure); but 
there's more than a kernel I have to think about.

I'm not as nearly concerned with Niagara stability as I am with sun4u Ex500 
stability, since I have the latter and depend upon the latter.  However, this 
is very good to know for those using any SPARC box with a large number of 
processors, and it is absolutely wonderful that you have it working that well 
on that processor.
-- 
Lamar Owen
Director of Information Technology
Pisgah Astronomical Research Institute
1 PARI Drive
Rosman, NC  28772
(828)862-5554
www.pari.edu
