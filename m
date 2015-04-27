From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Apr 2015 18:23:11 +0000
Subject: Re: Build regressions/improvements in v4.1-rc1
Message-Id: <20150427182311.GA10136@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
In-Reply-To: <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Rusty Russell <rusty@rustcorp.com.au>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, sparclinux <sparclinux@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, MarkBrown@roeck-us.net

On Mon, Apr 27, 2015 at 12:03:32PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 27, 2015 at 11:51 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.1-rc1[1] compared to v4.0[2].
> >
> > Summarized:
> >   - build errors: +34/-11
> >   - build warnings: +135/-163
> >
> > As I haven't mastered kup yet, there's no verbose summary at
> > http://www.kernel.org/pub/linux/kernel/people/geert/linux-log/v4.1-rc1.summary.gz
> >
> > Happy fixing! ;-)
> >
> > Thanks to the linux-next team for providing the build service.
> >
> > [1] http://kisskb.ellerman.id.au/kisskb/head/8779/ (254 out of 257 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/head/8710/ (254 out of 257 configs)
> >
> >
> > *** ERRORS ***
> >
> > 34 regressions:
> 
> The quiet days are over...
> 
Is it just my impression, or is the code quality in this commit window
a bit lower than usual (very politely said) ?

Guenter
