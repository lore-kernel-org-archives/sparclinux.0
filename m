From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sun, 06 Aug 2006 21:09:38 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <200608062109.k76L9c1T017778@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, 1 Aug 2006 13:30:08 +0200 (MEST), Mikael Pettersson wrote:
>David Miller writes:
> > From: Mikael Pettersson <mikpe@it.uu.se>
> > Date: Fri, 28 Jul 2006 12:35:24 +0200 (MEST)
> > 
> > > FAULT: write(1) old_entry[e00001ffe1970f8a]
> > > FAULT: After, entry[e00001ffe1970f8a]
> > > FAULT: write(1) old_entry[e00001ffe1970f8a]
> > > FAULT: After, entry[e00001ffe1970f8a]
> > > 
> > > The last two lines then repeat semi-infinitely, and they
> > > were generated at an extremely high rate.
> > 
> > It looks like the TSB is never updated.
> > 
> > Do you have CONFIG_HUGETLB_PAGE disabled by chance?
> > I bet that's part of what helps trigger this bug.
>
>I'm away from my U5 right now and won't be able to check for
>certain until later this week, but I'm pretty sure CONFIG_HUGETLBFS
>and CONFIG_HUGETLB_PAGE are disabled in its kernel.

Correction, it turns out that all my 2.6 sparc64 kernels have
had CONFIG_HUGETLBFS and CONFIG_HUGETLB_PAGE enabled.

/Mikael
