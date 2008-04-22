From: David Miller <davem@davemloft.net>
Date: Tue, 22 Apr 2008 00:06:40 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080421.170640.181023820.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
	<alpine.LFD.1.10.0804211608570.2779@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0804211608570.2779@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Apr 2008 16:10:00 -0700 (PDT)

> Hmm. I think this is sad. The fact is, Solaris/SunOS is the de-facto 
> standard for Sparc. Which makes me think that not emulating them is a real 
> capability loss. 

There is no capability loss, the code we have hasn't worked on
anything other than extremely trivial Solaris cases, and that's
when it was working.

Nobody has tested or tried to use it at all for years, and as a result
even something as simple as a modern compiled Solaris binary doing:

	int main(void) { return 0; }

won't even work because things the dynamic linker does are
unsupported.

It's not like I've removed the capability for people to run something
like Oracle/Solaris under Linux, nothing even half-way approaching
that ever worked, and so I just wanted to make that clear :-)
