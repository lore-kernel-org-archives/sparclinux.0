From: David Miller <davem@davemloft.net>
Date: Tue, 30 Dec 2008 02:36:52 +0000
Subject: Re: [patch 60/71] sparc64: Fix PCI error interrupt registry on
Message-Id: <20081229.183652.225223730.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081007002606.723632097@mini.kroah.org>
	<20081007004007.GI3055@suse.de>
	<Pine.LNX.4.64.0812291813010.1886@anakin>
In-Reply-To: <Pine.LNX.4.64.0812291813010.1886@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Dec 2008 18:14:31 +0100 (CET)

> On Mon, 6 Oct 2008, Greg KH wrote:
> > 2.6.26-stable review patch.  If anyone has any objections, please let us
> > know.
> > 
> > ------------------
> > From: David S. Miller <davem@davemloft.net>
> > 
> > [ Upstream commit 80a56ab626c70468be92e74cf3d288ffaed23fdb ]
> > 
> > We need to pass IRQF_SHARED, otherwise we get things like:
> 
> But you forgot to update the comment (see below)...
 ...
> > --- a/arch/sparc64/kernel/pci_psycho.c
> > +++ b/arch/sparc64/kernel/pci_psycho.c
> > @@ -744,16 +744,16 @@ static void psycho_register_error_handle
> >  	 * the second will just error out since we do not pass in
>                                           ^^^^^^^^^^^^^^^^^^^^^^^
> >  	 * IRQF_SHARED.
>            ^^^^^^^^^^^

Thanks a lot Geert, I'll fix this up.
