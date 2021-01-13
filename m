From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Jan 2021 08:21:10 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CAMuHMdUNe1A0RpkYdyRy9OJ+RDfUe_3KcAVnsCK+pP0jzJwtVA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com> <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
In-Reply-To: <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Rob,

On Wed, Jan 13, 2021 at 8:58 AM Rob Landley <rob@landley.net> wrote:
> On 1/12/21 4:46 PM, Linus Walleij wrote:
> > On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >> Yeah, I have the same impression that's the strong commercial interest pushes
> >> hobbyist use of the Linux kernel a bit down. A lot of these changes feel like
> >> they're motivated by corporate decisions.
> >>
> >> There has to be a healthy balance between hobbyist and commercial use. I understand
> >> that from a commercial point of view, it doesn't make much sense to run Linux
> >> on a 30-year-old computer. But it's a hobbyist project for many people and hacking
> >> Linux stuff for these old machines has a very entertaining and educational factor.
> >
> > This is actually one of the most interesting things written in this discussion.
> >
> > I have both revamped and deleted subarchitectures in the ARM tree. We
> > never deleted anyone's pet project *unless* they were clearly unwilling to
> > work on it (such as simply testning new patches) and agreed that it will
> > not go on.
>
> Another fun aspect of old hardware is it serves as prior art for patents. The
> j-core hardware implementation schedule has in part been driven by specific
> patents expiring, as in "we can't do $FEATURE until $DATE".

Indeed, so that's why the release of j4 is postponed to 2016...
/me runs date (again).

> When I did an sh4 porting contract in 2018 I got that board updated to a
> current-ish kernel (3 versions back from then-current it hit some intermittent
> nor flash filesystem corruption that only occurred intermittently under
> sustained load; had to ship so I backed off one version and never tracked it
> down). But these days I'm not always on the same continent as my two actual sh4
> hardware boards, have never gotten my physical sh2 board to boot, and $DAYJOB is
> all j-core stuff not sh4.

Which is not upstream, investing in the future?

> Testing that a basic superh system still builds and boots under qemu and j-core
> I can commit to doing regularly. Testing specific hardware devices on boards I
> don't regularly use is a lot harder.

I have the sh7751-based landisk in my board farm, so it's receiving
regular boot testing.  That's one of the simpler SH-based platforms,
though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
