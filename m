From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 13 Oct 2010 18:32:12 +0000
Subject: Re: [2.6.36-rc regression] occasional complete system hangs on
Message-Id: <19637.64300.446447.318000@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <19611.34846.813757.309183@pilspetsen.it.uu.se>
	<19624.63312.156073.410319@pilspetsen.it.uu.se>
	<20101012.104238.104051243.davem@davemloft.net>
In-Reply-To: <20101012.104238.104051243.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller writes:
 > From: Mikael Pettersson <mikpe@it.uu.se>
 > Date: Sun, 3 Oct 2010 23:36:16 +0200
 > 
 > > I've been testing older kernels and can now say that 2.6.35-git5
 > > and newer kernels are definitely affected, but 2.6.35-git4 seems
 > > solid.  I'll dig deeper into the .35-git4->git5 changes towards
 > > the end of next week.
 > > 
 > > I never got any data out of sysrq-y or any other sysrq when a hang
 > > occurs; usually they'd just print the name of the command but no data,
 > > sometimes they'd oops and crash the kernel even harder.
 > 
 > So I haven't been ignoring this report, but I cannot reproduce
 > it on the SB2500 I have access to right now.
 > 
 > I've been doing gcc builds and testsuite runs in a loop for
 > several days.
 > 
 > Occaisionally I get a dying 'as' which I have seen before and
 > plan to investigate, but no hard hangs and no crashes.
 > 
 > I'll keep prodding, but if you can narrow it down further
 > please let us know.

I've looked at the .35-git4 to -git5 changes, and unfortunately
they cannot be relevant for the sparc64 hangs: the bulk of the
changes are x86-only, and the remaining few are totally harmless.

So either .35-git4 is also broken, even though I haven't been
able to break it after a week of gcc bootstraps and test runs,
or some of the hangs I've seen in later kernels have been caused
by some other bug.  Either way, I don't think I can make progress
bisecting & testing older kernels.
