From: David Miller <davem@davemloft.net>
Date: Thu, 08 May 2008 01:16:06 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080507.181606.189746306.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080507.163917.104000894.davem@davemloft.net>
	<alpine.LFD.1.10.0805071705360.3024@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0805071705360.3024@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 May 2008 17:06:29 -0700 (PDT)

> On Wed, 7 May 2008, David Miller wrote:
> > 
> > 1) If fork/clone/etc. errors, argument register %o2 is clobbered
> >    breaking syscall restart.
> 
> Wow. Do we actually restart fork/clone/etc? That sounds suspicious. Maybe 
> there is some other bug here?

do_fork() checks for signals, and returns -ERESTARTNOINTR right
before fully committing itself to the operation.
