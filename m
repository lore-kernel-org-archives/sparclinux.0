From: David Miller <davem@davemloft.net>
Date: Tue, 02 Dec 2008 07:24:17 +0000
Subject: Re: [PATCH] sparc: fix boot regression
Message-Id: <20081201.232417.39288591.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081201185125.GA2379@uranus.ravnborg.org>
In-Reply-To: <20081201185125.GA2379@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Mon, 01 Dec 2008 20:21:40 -0500

> Sam Ravnborg wrote:
> > >From e3b6fc4081669054768f93ea2605d1eba8e1b256 Mon Sep 17 00:00:00 2001
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Mon, 1 Dec 2008 19:41:49 +0100
> > Subject: [PATCH] sparc: fix boot regression
> >
> > Robert reported that 21cb8a43216e0595b466e903e0f2a7ae615d9e11
> > ("sparc: refactor Makefile") caused a boot regression on sparc.
> > We tracked it down to the removal of the export of kallsyms.o.
> >
> > This patch adds back the export and the code that was removed
> > in a subsequent commit which uses the exported variable.
> > Why this caused a boot regression is not understood atm.
> >
> > Robert tested a simpler version of this patch and reported success.
> >
> > Reported-by: Robert Reif <reif@earthlink.net>
> > Tested-by: Robert Reif <reif@earthlink.net>
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > ---
> >
> > The patch is made on top of sparc-next.
> > Robert - I would appreciate if you could retest on top of
> > sparc-next and confirm that the boot regression is really
> > fixed there.
 ...
> This patch also works.

Applied, thanks everyone.
