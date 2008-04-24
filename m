From: David Miller <davem@davemloft.net>
Date: Thu, 24 Apr 2008 15:41:44 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20080424.084144.01839530.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080424.040239.193699673.davem@davemloft.net>
	<alpine.LFD.1.10.0804240837120.2779@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0804240837120.2779@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Apr 2008 08:39:37 -0700 (PDT)

> Heh. This is what x86 has done since day#1. I wonder why other 
> architectures wouldn't have copied that part..

I passed it around in a register because nothing outside of the trap
return and signal handling path needed access to it :-)
