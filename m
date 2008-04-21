From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Mon, 21 Apr 2008 23:18:15 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080421231815.GS27459@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net> <alpine.LFD.1.10.0804211608570.2779@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0804211608570.2779@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 21, 2008 at 04:10:00PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 21 Apr 2008, David Miller wrote:
> > 
> > This performs the scheduled removal of Solaris and SunOS
> > system call for sparc, much to the chagrin of Al Viro
> > and others :-) (in particular, that asm/namei.h crud can
> > now die)
> 
> Hmm. I think this is sad. The fact is, Solaris/SunOS is the de-facto 
> standard for Sparc. Which makes me think that not emulating them is a real 
> capability loss. 
> 
> I realize that the code may be painful, but still...

FWIW, two things I _really_ want dead and gone are
	* timod (or full rewrite of that animal; current one is badly racy
and plays fast and loose with way too many place in VFS guts)
	* altroot (use chroot, damnit, and bind whatever you need in there)

Other than that...  No preferences, really.
