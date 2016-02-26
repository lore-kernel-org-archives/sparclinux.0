From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 26 Feb 2016 13:58:13 +0000
Subject: Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc code
Message-Id: <20160226135813.GD15454@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
 <56D02FB8.90803@ti.com>
In-Reply-To: <56D02FB8.90803@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org

[Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc code] On 26/02/2016 (Fri 12:58) Tomi Valkeinen wrote:

> 
> 
> On 22/02/16 05:13, Paul Gortmaker wrote:
> > This series of commits is a part of a larger project to ensure
> > people don't reference modular support functions in non-modular
> > code.  Overall there was roughly 5k lines of dead code in the
> > kernel due to this.  So far we've fixed several areas, like tty,
> > x86, net, ... and we continue to work on other areas.
> > 
> > There are several reasons to not use module support for code that
> > can never be built as a module, but the big ones are:
> > 
> >  (1) it is easy to accidentally write unused module_exit and remove code
> >  (2) it can be misleading when reading the source, thinking it can be
> >      modular when the Makefile and/or Kconfig prohibit it
> >  (3) it requires the include of the module.h header file which in turn
> >      includes nearly everything else, thus adding to CPP overhead.
> >  (4) it gets copied/replicated into other code and spreads like weeds.
> 
> I think all the "normal" drivers should be compilable as modules. If
> they can't, it should be fixed. However, we have lots of old drivers for
> which it may be difficult to get anyone to fix them or test them.

A counter point would be that if an old driver has remained non-modular
for all these years, then clearly there is no demand for adding a new
modular implementation at this point in time.

> 
> Then again, with that kind of drivers it may be better to just let them
> be, if there's no big reason to start cleaning them up. In other words,
> if the driver is old and not actively developed/maintained, compiles
> fine, presumably works fine, doesn't obstruct any other development,
> then why touch it at all...

The main reason is listed as #4 above -- if we keep drivers around that
reflect a disconnect between Kconfig and code, the same mistake gets
copied into more and more new drivers as they are created.

If the argument was to not go in and rewrite core code for legacy
drivers, I'd agree with that, but that isn't what is happening here.
In a lot of these type changes, where the only change is to replace
module_init with device initcall, the object files are identical.

> While doing this, did you just go forward removing the module support,
> or did you check if it would be trivial to make the driver build as a
> module? I wouldn't be surprised if in some cases all that would need to
> be done is change the Kconfig's bool to tristate.

In some cases, where people have explicitly asked for it, indicating
that they (as author) intended it to be tristate, and support it as
such, yes.

But overall, with the number and diversity of the drivers involved, I
did not want to just go around enabling new functionality here and there
on hardware I don't know intimately.  So instead the changes are like
what you see here: the runtime and functionality remains faithful to
what it was, while resolving issues #1 through #4 above.

If subsystem maintainers would rather have blanket tristate coversions
and whatever changes are required to make it compile and modpost, and
are OK to assume things will just work, then that could be an option...

Paul.
--

> 
>  Tomi
> 



