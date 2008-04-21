From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Apr 2008 23:10:00 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <alpine.LFD.1.10.0804211608570.2779@woody.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk



On Mon, 21 Apr 2008, David Miller wrote:
> 
> This performs the scheduled removal of Solaris and SunOS
> system call for sparc, much to the chagrin of Al Viro
> and others :-) (in particular, that asm/namei.h crud can
> now die)

Hmm. I think this is sad. The fact is, Solaris/SunOS is the de-facto 
standard for Sparc. Which makes me think that not emulating them is a real 
capability loss. 

I realize that the code may be painful, but still...

		Linus
