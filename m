From: Rob Landley <rob@landley.net>
Date: Wed, 13 Jan 2021 13:25:25 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <ad9688cc-ef99-212e-103a-56d9cc32a334@landley.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
 <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
 <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
 <CAMuHMdUNe1A0RpkYdyRy9OJ+RDfUe_3KcAVnsCK+pP0jzJwtVA@mail.gmail.com>
In-Reply-To: <CAMuHMdUNe1A0RpkYdyRy9OJ+RDfUe_3KcAVnsCK+pP0jzJwtVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 1/13/21 2:21 AM, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Wed, Jan 13, 2021 at 8:58 AM Rob Landley <rob@landley.net> wrote:
>> On 1/12/21 4:46 PM, Linus Walleij wrote:
>>> On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>> Yeah, I have the same impression that's the strong commercial interest pushes
>>>> hobbyist use of the Linux kernel a bit down. A lot of these changes feel like
>>>> they're motivated by corporate decisions.
>>>>
>>>> There has to be a healthy balance between hobbyist and commercial use. I understand
>>>> that from a commercial point of view, it doesn't make much sense to run Linux
>>>> on a 30-year-old computer. But it's a hobbyist project for many people and hacking
>>>> Linux stuff for these old machines has a very entertaining and educational factor.
>>>
>>> This is actually one of the most interesting things written in this discussion.
>>>
>>> I have both revamped and deleted subarchitectures in the ARM tree. We
>>> never deleted anyone's pet project *unless* they were clearly unwilling to
>>> work on it (such as simply testning new patches) and agreed that it will
>>> not go on.
>>
>> Another fun aspect of old hardware is it serves as prior art for patents. The
>> j-core hardware implementation schedule has in part been driven by specific
>> patents expiring, as in "we can't do $FEATURE until $DATE".
> 
> Indeed, so that's why the release of j4 is postponed to 2016...
> /me runs date (again).

We renamed it J32 because although the patents have expired the trademarks have
not, and provoking Renesas' lawyers more than necessary seemed gratuitous.

It's actually been feature complete for years now, but we've never ported the
kernel to it. (Rich has been working on a kernel port since new year's though.
Jeff Garzik sponsored some engineering time in our 2021 budget to finally get
that done, which has been our blocker for publishing because the lab tests don't
guarantee we won't have to change bits of the API in response to real world loads.)

>> When I did an sh4 porting contract in 2018 I got that board updated to a
>> current-ish kernel (3 versions back from then-current it hit some intermittent
>> nor flash filesystem corruption that only occurred intermittently under
>> sustained load; had to ship so I backed off one version and never tracked it
>> down). But these days I'm not always on the same continent as my two actual sh4
>> hardware boards, have never gotten my physical sh2 board to boot, and $DAYJOB is
>> all j-core stuff not sh4.
> 
> Which is not upstream, investing in the future?

Alas I'm not in charge of what is cleared for public release. (I complain about
it on the weekly calls from time to time.) We have actual marketing people now
(Mike and Bunga) so I'm not supposed to do the website in raw stylesheet-less
html with vi anymore.

Unpublished stuff we _mean_ to publish is a form of technical debt. It
_shouldn't_ be (release early release often) but Jeff insists on doing
everything in Mercurial which makes dogfooding our github repos as part of our
normal process darn awkward, and once there a little out of sync with the rest
of the build it becomes a todo item...

Rob
