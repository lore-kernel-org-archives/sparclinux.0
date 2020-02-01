From: Anatoly Pugachev <matorola@gmail.com>
Date: Sat, 01 Feb 2020 11:57:41 +0000
Subject: Re: [sparc64] stall on CPU with current git master
Message-Id: <CADxRZqwBPJVa9EBeP2++bojgiJ-K1s+3LCm_Y2_KT4wDcUGZeg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqy3LNu=DW2Mn8G6E-Ewrg2Q4gDXbxFqJXyfcDom4YW_oQ@mail.gmail.com>
 <CAK8P3a0eqbczcNJhNf9hXPBhUoscZD51d9PSs=vwH564u=7XSQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0eqbczcNJhNf9hXPBhUoscZD51d9PSs=vwH564u=7XSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Fri, Jan 31, 2020 at 7:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jan 31, 2020 at 4:07 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> >
> > $ git desc 251ec1c159e4874fbede0c3c586e317e177c0c9b
> > v5.5-rc1-19-g251ec1c159e4
> >
> > kernel 5.5.0-rc1-00018-g4f9fbd893fe8 - works perfectly (i.e. does not
> > hang or produce "stall on CPU" )
> >
> > current master with the patch reverted -
> > 5.5.0-07763-gccaaaf6fe5a5-dirty - works perfectly
> >
> > current master 5.5.0-07763-gccaaaf6fe5a5 - stalls, hangs
> >
> >
> > Can someone look what is wrong with it and/or probably revert it ?!
> > Thanks.
>
> Thanks for the report, I think I found the problem! Can you try this patch?

Arnd,

this patch fixed issue for me. Thanks.
