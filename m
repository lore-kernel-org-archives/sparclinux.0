From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 03 Feb 2011 22:28:57 +0000
Subject: Re: sparc32 community [Was: sparc32: unaligned memory access (MNA)
Message-Id: <AANLkTindBEp9BFWBeyjN446JQKhRZUyggQVcyMe87H+G@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110203165821.GA14776@merkur.ravnborg.org>
In-Reply-To: <20110203165821.GA14776@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Feb 4, 2011 at 03:58, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> I really hope that the sparc community can take benefit of the time we
>> invested in this.
>
> Sometimes I have asked myself what is the size of the sparc32 community?

Raises hand =)

> Personally I got more involved in sparc development because I wanted
> to simplify the way we handled our headers and a natural step forward
> was to get the remaining architectures merged where sparc & sparc64
> was one of the outstanding architectures.

My motivation was that Debian dropped SPARC32 support and subsequently
broke my first SS10. (Linux doesn't run well when libc6 won't load)
Reading up on the lists indicated that their decision was due to there
being no active kernel contributors. My immediate thought was "That
sounds interesting, I could help with that", leading to the small
amount of work I've done so far.

> I have looked around for a decent distribution that claim up-to-date
> support for sparc. But they all seem to be dropping sparc support.
> And here sparc64 is in focus - not sparc32.

At the moment, the only way I've found to get sparc32 support with
modern packages involves installing Gentoo 2006.1 then upgrading it.
Annoyingly, I'm yet to complete an installation as I ran out of disk
space on my SSLX and both disks in my first SS10 died. I'm currently
trying to set up some form of NFS root environment for installing that
on them, but I'm running into issues involving shiny new hardware and
glacial ARM development. (Rant: people have patches to add full
support for the GoFlex Net, why haven't they been waved under the
noses of the relevant maintainers?)

I've never investigated sparc64 support as my Ultra 1e runs fine on
bleeding edge Debian.

> And I understand that sparc32 does not work well for many people.
> I know that recent kernels only can run on SparcServer 1000 for
> a few minutes before it locks hard. And I expect we see similar
> problems on sun4m boxes with > 1 CPU.

Both of my SS10s have > 1 CPU, so my focus, once I get them working,
will be to thoroughly test them. I'm thinking of using the Phoronix
Test Suite as a general hardware stresser, but I'll have to see if it
will actually run on them.

> The bug you have fixed (with great effort) in the unaligned
> trap handler further confirm to me that that not many users
> are running recent kernels on sparc32 hardware.
> I also recall that I broke sparc32 during the unification,
> which took months to e detected.
>
> Personally I run sparc only to test my kernel contributions,
> as the hw I have available is too noisy / too slow to
> be used for anything else.

I'm in the exact same boat. There was a time when I'd leave my Ultra1E
running overnight doing sparc32 / sparc64 randconfig builds (and I
found a couple of minor bugs with that) but my goal at the moment is
to come up with some way to do automated testing on my machines.

> It also looks better on the CV when I can say that I have refactored
> the IRQ support on sparc compared to some random kbuild hacking :-)

I put that I am active within the open source community, and I can
always boast that I've (indirectly^3) helped the ESA =)

> So Gaislers contributions helps the sparc32 community.
> And I expect that the combined effort will allow more people to
> use a recent kernel on sparc32 and thus will increase the community.
> But how big the community is - is an open question to me.

My estimates, based upon mailing list contributions and the general
attitude of distros is that the Linux sparc32 community that's vocally
interested in modern software consists of 5-10 people. That said,
Gaisler is changing things considerably. I was surprised to download
the source of u-boot the other day and see that there was a sparc32
directory in there with their code in it. I was more surprised when I
saw that it was listed as supported in their architecture list.

Leon seems to be really re-igniting the sparc32 kernel effort, and I
can only praise them for that.

> Note: If someone has - or knows about - a SS1000 that I can use
> for Linux testing I am all ears. (I live in Scandinavia / Denmark)
> Contact me in private as this in not relevant on the list.

If anyone has one in south-eastern Australia, I would be happy to
provide it with power, accommodation and occasional kernel builds.
Again, contact me in private as this is not relevant to the list.

Sam, if I do end up with one, I'm happy to be your hands / give you
whatever access to it that you want.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
