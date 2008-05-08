From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 08 May 2008 00:06:29 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <alpine.LFD.1.10.0805071705360.3024@woody.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080507.163917.104000894.davem@davemloft.net>
In-Reply-To: <20080507.163917.104000894.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On Wed, 7 May 2008, David Miller wrote:
> 
> 1) If fork/clone/etc. errors, argument register %o2 is clobbered
>    breaking syscall restart.

Wow. Do we actually restart fork/clone/etc? That sounds suspicious. Maybe 
there is some other bug here?

		Linus
