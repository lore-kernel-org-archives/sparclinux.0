From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 01 Mar 2004 23:39:42 +0000
Subject: Re: Fw: [Bugme-new]  [Bug 2205] New: compile failure, gcc 3.2.3, gentoo SPARC, Sun Ultra 5
Message-Id: <20040301233942.GA1257@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040301192235.GA4379@mars.ravnborg.org>
In-Reply-To: <20040301192235.GA4379@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is getting to be pretty off topic; if anything it's a Gentoo
problem.  That said, however, I test-build all sparc-dev-sources and
development-sources on sparc64 with gcc 3.2.3 and 3.3.2 before I
release them on sparc.  They work.

> There were a couple of small compile problems, such as the gcc version
> check in init/main.c deciding that gcc 3.2.3 was too old, having to

I don't buy it.  The checks in init/main.c are for old 2.x compilers.
Please be sure your system is up to date.  3.2.3 is fine; if there is
a check that is failing on it then something else is wrong.  My guess
is that you have:

gcc-3.2.3-r2
egcs64-1.1.2_whatever

and think that because gcc --version says 3.2.3 you're ok.  That's no
good on sparc64.  You need to update your 64-bit compiler to 3.2 or
higher to build 2.6.  So emerge -C egcs64; emerge gcc-sparc64.  If you
have any doubts, please do:

ld --version
sparc64-linux-gcc --version

If gentoo lets you install 2.6 without gcc-sparc64, that's my bug and
you should file it at bugs.gentoo.org.  If you're circumventing that
dependency yourself, don't.

> Try "emerge"ing sparc-dev-sources.

Please don't.  sparc-dev-sources is now deprecated; you should use
development-sources.  If you want people other than gentoo developers
to help you, you can also just use Linus 2.6.3, which works fine on
sparc64.

If you have current tools and it still doesn't work, please open a
Gentoo bug.

-- 
Keith M Wesolowski
