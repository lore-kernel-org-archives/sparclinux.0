From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 21 Apr 2008 22:50:37 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <adak5iqakle.fsf@cisco.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net> (David Miller's
	message of "Mon, 21 Apr 2008 15:32:31 -0700 (PDT)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk

 > This performs the scheduled removal of Solaris and SunOS
 > system call for sparc, much to the chagrin of Al Viro
 > and others :-) (in particular, that asm/namei.h crud can
 > now die)

Maybe this is an inside joke I don't get, but why are we merging
something that causes Al Viro and others to feel chagrin?

 - R.
