From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Date: Mon, 17 May 2004 22:06:10 +0000
Subject: Re: [SPARC64] Need help..
Message-Id: <Pine.LNX.4.58L.0405180004490.984@alpha.zarz.agh.edu.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58L.0405171051230.1247@alpha.zarz.agh.edu.pl>
In-Reply-To: <Pine.LNX.4.58L.0405171051230.1247@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 17 May 2004, Mathieu Chouquet-Stringer wrote:

> Hi, you're cross-compiling I guess, no?
> 
> cieciwa@alpha.zarz.agh.edu.pl ("Wojciech 'Sas' Cieciwa") writes:
> > I try to build kernel 2.6.6 on my machine, but when I build module I got 
> > some strange message:
> > 
> >   Building modules, stage 2.
> >   MODPOST
> > *** Warning: "" [lib/zlib_inflate/zlib_inflate.ko] undefined!
> > *** Warning: "current_thread_info_reg" [lib/zlib_inflate/zlib_inflate.ko] undefined!
> > [...]
> > 
> > This message i teke from all modules which I build.
> > What's wrong ?
> > And how to repair this?
> 
> Nothing's wrong, it's a bug in scripts/modpost.c. I've sent a fix and it's
> in bk now. Here it is:

Nope, this patch is applayed in cset-20050517_*
and I still got this message.

Any sugestion ?

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
