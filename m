From: Romain Dolbeau <romain@dolbeau.org>
Date: Sun, 20 Dec 2020 07:43:59 +0000
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
Message-Id: <CADuzgbqBx7cajLg5-9+bqoUvHV4heoNjBH-cakU5YGV549Gdxg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201219214054.GB3132151@ravnborg.org>
In-Reply-To: <20201219214054.GB3132151@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc <debian-sparc@lists.debian.org>, gentoo-sparc@lists.gentoo.org, info@temlib.org

Le sam. 19 déc. 2020 à 22:41, Sam Ravnborg <sam@ravnborg.org> a écrit :
> Another said that it would be a shame to sunset sun4m and sun4d because
> there are so many machines around, and netbsd is also active on the
> sparc32 area.

Yes, those were plentiful back in the day and there's still quite a few around.

> The second mail also re-reminded me of an interesting project
> implementing SPARC V8 and the sun4m platform in VHDL.

There's also new hardware being developed for SBus systems :-)
<https://github.com/rdolbeau/SBusFPGA>
(disclaimer: work-in-progress and shameless self-promotion here!).

If there's still a distribution willing to build for Sparc v8, then I
believe the kernel
should try to keep support of the relevant machine architectures if at all
possible...

Cordially,

-- 
Romain Dolbeau
