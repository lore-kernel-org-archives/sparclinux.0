From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 28 Dec 2004 02:38:52 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to
Message-Id: <20041227183852.68bf6a87.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 11 Dec 2004 16:06:39 -0800
Jeremy Huddleston <eradicator@gentoo.org> wrote:

> > > Ok, here's the updated one.  It's much cleaner now, and I also did NOT
> > > do asm-x86_64's '#include <signal.h>' if we're !__KERNEL__.  I found
> > > that to be a rather ugly kludge.  It's the userland code that should
> > > change there, not us.
> > 
> > Applied, thanks Jeremy.
> 
> In changing from the glibc check to __KERNEL__, processor.h doesn't work
> for some userland code.  Here's an update to correct this.

I don't think this is too pleasant.

Actually, I can't see much of anything that userland needs to get
at inside of processor.h, so why don't you just __KERNEL__ ifdef
out nearly the entire file?
