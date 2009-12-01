From: Josip Rodin <joy@entuzijast.net>
Date: Tue, 01 Dec 2009 22:57:45 +0000
Subject: Re: Sparc release requalification
Message-Id: <20091201225745.GA24500@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 01, 2009 at 09:42:12PM +0000, Jurij Smakov wrote:
> > > http://www.backports.org/debian/pool/main/l/linux-2.6/linux-image-2.6.30-bpo.2-sparc64-smp_2.6.30-8~bpo50+1_sparc.deb
> > 
> > I've tried everything to reproduce this.
> > 
> > I've tried building 2.6.31.6 -stable from Josip's config using
> > Debian stable's compiler (gcc-4.3.2)
> 
> I think you need to build with the gcc from unstable to reproduce the
> failure. Lenny kernels have been booting fine on my box (SunBlade 1000),
> unstable kernels started failing about 3 months ago.

Hm, OK, but that doesn't help explain why that exact image, a lenny
backport, didn't work here...

JFTR the difference would be 4.3.2 vs. 4.3.4 per
http://packages.debian.org/gcc-4.3

-- 
     2. That which causes joy or happiness.
