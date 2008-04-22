From: David Miller <davem@davemloft.net>
Date: Tue, 22 Apr 2008 00:16:19 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080421.171619.126408955.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.1.10.0804211608570.2779@woody.linux-foundation.org>
	<20080421231815.GS27459@ZenIV.linux.org.uk>
	<20080421232534.GT27459@ZenIV.linux.org.uk>
In-Reply-To: <20080421232534.GT27459@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ZenIV.linux.org.uk
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 22 Apr 2008 00:25:34 +0100

> On Tue, Apr 22, 2008 at 12:18:15AM +0100, Al Viro wrote:
> 
> > FWIW, two things I _really_ want dead and gone are
> > 	* timod (or full rewrite of that animal; current one is badly racy
> > and plays fast and loose with way too many place in VFS guts)
> > 	* altroot (use chroot, damnit, and bind whatever you need in there)
> 
> BTW, the part about altroot goes for other architectures too; it's badly
> broken and it's one hell of an obstacle to fs/namei.c work of any kind.
> 
> As absolute minimum we _must_ lose the "if we hadn't found what we wanted
> in that subtree, repeat lookup starting at real root"; that's causing
> nightmares in pathname resolution and there's no excuse whatsoever for
> that since we have bindings.

The only platforms defining a non-NOP __emul_prefix() after this
sparc changeset are:

1) IA-64 for PER_LINUX32 --> /emul/ia32-linux/
2) MIPS for riscos and IRIX compat support
3) ARM for ARM_BSD_EMUL --> "usr/gnemul/bsd", yikes no leading slash
   in that path!

I bet if we really tried we could get rid of these things.
