From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 27 Dec 2010 11:04:52 +0000
Subject: Re: Bleeding edge kernel booted on SPARC Classic (32bit/sun4m/v8/50Mhz/96MB
Message-Id: <AANLkTinSVd7Gqfhq-4okqR61XCKQv7EmJxy=5AaV0gd9@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20101227084057.GA31211@merkur.ravnborg.org>
In-Reply-To: <20101227084057.GA31211@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 27, 2010 at 19:40, Sam Ravnborg <sam@ravnborg.org> wrote:
> Some time ago I brought a SPARC Classic on ebay and
> this holiday I found some time to play around with it.

Snap! I have a SS LX, which is essentially a classic called "LX".

> I got the bleeding edge kernel booting on the box
> and no hicups in the process.
> [Lots of smaller issues getting netboot working etc.
> but thats another story].

Good work!

I'm having trouble getting my box to even netboot - the last time I
tried it (years ago) it wouldn't attempt to either net or disk boot.

> For now it is net booted and runs Linux only in a small
> RAM disk. I want to keep Solaris around until I have
> captued relevant info (prtconf etc).
>
> I have used buildroot as the base and userspace is
> only busybox for now - as it fits in my RAM disk.

I'll give this a go with my SS10s when I get them out next, and see what's what.

> I will try with regular intervals to boot bleeding edge
> kernels on this box to catch any regressions.
> I can assist in minimal testing of SPARC32 stuff,
> so just let me know if there is anything to look at.

If I can get it all running, I'll do the same.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
