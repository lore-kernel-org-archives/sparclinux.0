From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Date: Tue, 26 Oct 2004 09:34:30 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20041026093430.GP17506@ruslug.rutgers.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Oct 25, 2004 at 11:46:30PM -0700, David S. Miller wrote:
> On Tue, 26 Oct 2004 02:11:28 -0400
> mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:
> 
> > Hey -- I can reduce the size, sure but that is besides the point. I want
> > to know the details of the size limitations of the kernel image for
> > sparc64. You told me last that there was no size limitations, that this
> > was fixed in the latest version of silo.
> 
> It should be ~8MB these days.
> 
> I bet if you just use arch/sparc64/defconfig as your kernel
> config the resulting image will work if you have working
> compiler tools.

Ah nice, I didn't know about that file. Will try it when I get home,
thanks :)

> I use just about every 2.6.x release on my Ultra60, SunBlade100
> and my SunBlade1000.

Cool, good to know it does indeed work :)

	Luis

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
