From: Ben Collins <bcollins@debian.org>
Date: Tue, 03 Feb 2004 23:17:43 +0000
Subject: Re: Was:  Problems with bridging on Sparc64
Message-Id: <20040203231743.GU735@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200402031553.44155.crn@netunix.com>
In-Reply-To: <200402031553.44155.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Feb 03, 2004 at 11:02:40PM +0000, C.Newport wrote:
> On Tuesday 03 February 2004 9:21 pm, Ben Collins wrote:
> > > We should take pity on the developer of some nice 64 bit application
> > > who tries to get his install scripts to work on all common Linux
> > > distributions. Portability between distributions is a major headache
> > > for application developers.
> >
> > With Debian, I think the goal is to make dpkg recognize the ABI aswell
> > as the arch.  The binaries will go in standard places (/bin, etc..).
> > Packages that support this will have ABI independent files go in a
> > seperate package (config files, headers, gifs, etc...) if needed, and
> > supply binary packages that are built for each ABI (sparc32, v9,
> > sparc64, etc..same goes for x86, x86-64 and hppa/hppa64).
> 
> Thanks, the Debian method makes a lot of sense.
> BTW, you have just reminded me of another issue :-
> 
> You mention both sparc v9 and sparc64. 
> AIUI v9 is the Sun Ultrasparc and sparc64 is the slightly different
> Fujitsu processor. We seem to refer to both under the confusing
> sparc64 header, but I do not see much testing happening on Fujitsu
> stuff. Am I misunderstanding the situation or should we consider
> getting the naming sorted out ?.
> Does anyone even have a Sparc64 (Fujitsu) machine working ?.

You are speaking in the wrong context. v9 is the standard sparc
instruction set (version 9) as described on sparc.com.

Sun calls their system UltraSPARC, and Fujitsu calls theirs SPARC64.

What I was talking about above was 32-bit applications geared toward v9
instruction set, which is not the same as 64-bit applications. It's an
optimization similar to the difference between -march=i486 and
-march=i686.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
