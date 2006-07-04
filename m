From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 04 Jul 2006 10:03:19 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <200607041003.k64A3JEL029677@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se, rene@exactcode.de
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, 4 Jul 2006 11:32:31 +0200, Rene Rebe wrote:
> On Tuesday 04 July 2006 09:41, Rene Rebe wrote:
> 
> > On Monday 03 July 2006 13:17, Mikael Pettersson wrote:
> > > In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with
> > > frequent lock-up like behaviour on my Ultra5 (ATI Mach64).
> > > I finally managed to trace the cause to this change in 2.6.16-git6:
> > 
> > I can confirm this behaviour, on a U5 with ATi onboard, but for me it
> > happens also on the Creator 3D of a U30, likewise.
> > 
> > I'll try to test if this changeset makes a difference for me as well
> > as soon as possible.
> 
> I can confirm that backing out this changeset fixes X on ATi@U5 as
> well as Creator3D@U30 to not stall and hang every few seconds for
> many more seconds/minutes.

Thanks.

/Mikael
