From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Dec 2004 07:46:56 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to
Message-Id: <20041208234656.1e091ef9.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 08 Dec 2004 22:00:42 -0800
Jeremy Huddleston <eradicator@gentoo.org> wrote:

> On Wed, 2004-12-08 at 21:25 -0800, David S. Miller wrote:
> > > Ok, I'll keep that in mind for next time.  I was just copying the same
> > > behavior from asm-x86_64.  Do you want me to update/resend the patch? 
> > 
> > Please do, I'd like to apply your patch and have this fixed. :-)
> 
> Ok, here's the updated one.  It's much cleaner now, and I also did NOT
> do asm-x86_64's '#include <signal.h>' if we're !__KERNEL__.  I found
> that to be a rather ugly kludge.  It's the userland code that should
> change there, not us.

Applied, thanks Jeremy.
