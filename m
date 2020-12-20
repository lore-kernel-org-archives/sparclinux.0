From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 20 Dec 2020 08:54:30 +0000
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Message-Id: <CAGRGNgUxGY3wz5sDVJqO8hB=yw=-symr0tGXQeQ1ovqwb6-e9w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201219214054.GB3132151@ravnborg.org>
 <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com>
In-Reply-To: <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Romain Dolbeau <romain@dolbeau.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, David S Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, LKML <linux-kernel@vger.kernel.org>, debian-sparc <debian-sparc@lists.debian.org>, gentoo-sparc@lists.gentoo.org, info@temlib.org

Hi Romain, Sam,

On Sun, Dec 20, 2020 at 6:46 PM Romain Dolbeau <romain@dolbeau.org> wrote:
>
> Le sam. 19 déc. 2020 à 22:41, Sam Ravnborg <sam@ravnborg.org> a écrit :
> > Another said that it would be a shame to sunset sun4m and sun4d because
> > there are so many machines around, and netbsd is also active on the
> > sparc32 area.
>
> Yes, those were plentiful back in the day and there's still quite a few around.

I have three: two SparcStation 10s and a SparcStation LX.

If I want to run them, assuming the hardware still works, I need to
netboot them as I cannot find working, compatible HDDs for them as
everything has switched to SATA or SAS.

Then there's the issue of finding a monitor as they're not
electrically compatible with VGA and I'm pretty sure none of the VGA
compatible monitors I have or can lay hands on works with their
specific sync frequencies.

Ultimately it's one of those things where there's enough "stuff" in
the way that booting one up for fun is simply impractical and they're
old and slow enough that they're not useful for anything else.

Then we get to the not-so-significant issue of software...

> > The second mail also re-reminded me of an interesting project
> > implementing SPARC V8 and the sun4m platform in VHDL.
>
> There's also new hardware being developed for SBus systems :-)
> <https://github.com/rdolbeau/SBusFPGA>
> (disclaimer: work-in-progress and shameless self-promotion here!).

Interesting project!

Amusingly enough you're not the first to hook an FPGA up to sBus. I
had a card that was some form of high-speed sampling thing which was
effectively some electrically isolated front-end hooked to a Xylinx
FPGA. I ended up trashing it as it had no markings and I couldn't find
out anything about it.

> If there's still a distribution willing to build for Sparc v8, then I
> believe the kernel
> should try to keep support of the relevant machine architectures if at all
> possible...

And here's where the problem lies. The last (official) version of
Debian to support Sparc32 was Etch and I believe it was one of the
last ones to drop support.

I believe that Gentoo is architecture-neutral enough that it'd work,
but I believe that you'll have to compile everything - there'll be no
pre-built anything for sparc32 - and as it's fairly slow hardware by
today's standards, that's going to take a long time, however you could
probably use distcc and cross-compilers to speed it up.

Long painful story short, it's difficult to get the hardware running,
there's practically no Linux distros that support it, and the kernel
code has probably bitrotted due to lack of testing.

As much as it pains me to say this, I think this code's time has come
and it's time to get rid of it.

If there were more people using it or more testing, or more distros
supporting it - not just (theoretically?) working on it - then I'd be
fighting to keep it.

But there isn't.

I think it's time for it to go.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

On Sun, Dec 20, 2020 at 6:46 PM Romain Dolbeau <romain@dolbeau.org> wrote:
>
> Le sam. 19 déc. 2020 à 22:41, Sam Ravnborg <sam@ravnborg.org> a écrit :
> > Another said that it would be a shame to sunset sun4m and sun4d because
> > there are so many machines around, and netbsd is also active on the
> > sparc32 area.
>
> Yes, those were plentiful back in the day and there's still quite a few around.
>
> > The second mail also re-reminded me of an interesting project
> > implementing SPARC V8 and the sun4m platform in VHDL.
>
> There's also new hardware being developed for SBus systems :-)
> <https://github.com/rdolbeau/SBusFPGA>
> (disclaimer: work-in-progress and shameless self-promotion here!).
>
> If there's still a distribution willing to build for Sparc v8, then I
> believe the kernel
> should try to keep support of the relevant machine architectures if at all
> possible...
>
> Cordially,
>
> --
> Romain Dolbeau



-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
