From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 19 Apr 2014 13:53:01 +0000
Subject: Re: Time to let sun4m + sun4d RIP?
Message-Id: <CAGRGNgV-PgYmuNiSvnv35jZ+wDkoCS_Qt63gA7BEErPqYqkheA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140419114802.GA13716@ravnborg.org>
In-Reply-To: <20140419114802.GA13716@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sam,

On Sat, Apr 19, 2014 at 9:48 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi all sparc lovers/users.
>
> We all know that is is a long time ago that a sun4m or sun4d machine was produced,
> and I wonder if there are anyone using these today.
> The questions pops up as there are still stuff to do before the sparc32 port
> is in good shape.
>
> So the question to you guys...
> Shall we keep support for sun4d and sun4m?
> If yes then why?

I have three sun4m boxen, all of which are unbootable for various
reasons (no hdd being the most common issue).

The last time I attempted to get "modern" Linux booting on them, the
major issue I ran into was the lack of modern distro support for
sparc32. - Gentoo was the only viable option (They last supported it
in 2006, however the last time I checked, that version was upgradable,
pre-emerge world, to the latest version). The last HDD set I had died
before I could start actually building it, so I've not actually seen
if the Linux kernel actually works properly on that hardware anymore.
(All three boxen need narrow-SCSI HDDs. I no-longer have any which I
know work. Netboot is an option, but I've not explored it enough yet.)

Sadly, getting them running again has been stuck on the bottom of my
TODO list due to a lot of other factors. (Lack of time being the main
one.)

If it's dropped, I won't mourn it's loss, however my vote will always
be to let it bitrot a bit more before we kill it.

IIRC, CPU-wise, sun4{m,d} is not _that_ much different from LEON,
however all the hardware stuff is, of course, significantly different.
If that's not holding LEON back....

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
