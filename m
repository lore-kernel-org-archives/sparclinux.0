From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 13 Jan 2021 10:39:29 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CAK8P3a3hKSVXZEjQEbkOLhtAO0oR0+UP1dL10S3jQM72EsmsWA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
In-Reply-To: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jan 12, 2021 at 11:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>
> > Yeah, I have the same impression that's the strong commercial interest pushes
> > hobbyist use of the Linux kernel a bit down. A lot of these changes feel like
> > they're motivated by corporate decisions.
> >
> > There has to be a healthy balance between hobbyist and commercial use. I understand
> > that from a commercial point of view, it doesn't make much sense to run Linux
> > on a 30-year-old computer. But it's a hobbyist project for many people and hacking
> > Linux stuff for these old machines has a very entertaining and educational factor.
>
> This is actually one of the most interesting things written in this discussion.
>
> I have both revamped and deleted subarchitectures in the ARM tree. We
> never deleted anyone's pet project *unless* they were clearly unwilling to
> work on it (such as simply testning new patches) and agreed that it will
> not go on.
>
> At multiple occasions I actually found it easier to fix stuff than
> delete it, both because it is a nicer thing to do and because it
> simply creates less social problems, often to the point that the time
> (man hours) spent trying to solve the resulting social problems from
> deleting a platform would be longer than the time spent actually acquiring
> the physical platform and fixing it.
>
> Corporate entities can be a bit deletionist (using Wikipedia terminology)
> and as in this thread there is always a strong inclusionist stance pushing
> back to that.

It's usually one of two things that happened before a platform gets
deleted for good:

* The platform port was (almost) exclusively done by one company
   with a commercial interest in it, and the company shifts its priorities
   for some reason (acquisition, bankruptcy, product cancellation,
   accidentally laying off all competent developers, ...) that causes it to
   stop working on it. Sometimes the previously paid maintainers
   keep up their upstream position, but without someone pushing the
   last missing bits into an official release, users are stuck on an old
   BSP kernel.

* A platform port is done in the open and actually works for upstream
  users, but over time the last active maintainers move on in their
  lives. Complex platforms inevitably break when a treewide change
  goes wrong, so we rely on users that are able to bisect and report
  bugs when they happen. After a platform has been broken for
  too long, even competent users may decide to just give up and
  stay on their last working kernel. Some of these platforms eventually
  recover when a new maintainer steps up or someone discovers they
  depend on newer kernels for products, but after a few years it's
  usually beyond repair.

      Arnd
