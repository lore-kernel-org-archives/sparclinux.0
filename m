From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Dec 2008 20:47:28 +0000
Subject: Re: [PATCH-2.6.28 final] byteorder: fix new headers for userspace
Message-Id: <alpine.LFD.2.00.0812181246420.14014@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <4943DAD6.7070402@gentoo.org>  <20081216.011334.124918024.davem@davemloft.net> <1229564779.6481.26.camel@brick> <alpine.LFD.2.00.0812181208070.14014@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0812181208070.14014@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, bluebird@gentoo.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>



On Thu, 18 Dec 2008, Linus Torvalds wrote:
> 
> I think it would be better to just make it a config option, call it 
> CONFIG_[LITTLE|BIG]_ENDIAN and set it up in the architecture Kconfig file. 
> I think some of the people who can set it dynamically (or where it depends 
> on the target machine) already effectively do that.

Never mind, since we end up having to export it to user space (do we?) we 
can't depend on the config.h file, nor can we pollute the name space.

Oh well.

		Linus
