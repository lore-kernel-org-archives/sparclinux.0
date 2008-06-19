From: David Miller <davem@davemloft.net>
Date: Thu, 19 Jun 2008 03:59:48 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <20080618.205948.107681537.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806171954060.2560@engineering.redhat.com>
	<20080617.210159.141238856.davem@davemloft.net>
	<Pine.LNX.4.64.0806182318170.27388@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806182318170.27388@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 18 Jun 2008 23:24:20 -0400 (EDT)

> BTW. what's the purpose of having 192-byte stack frame? There are 16 
> 8-byte registers being saved per function call, so 128-byte frame should 
> be sufficient, shoudn't? The ABI specifies that some additional entries 
> must be present even if unused, but I don't see reason for them. Would 
> something bad happen if GCC started to generate 128-byte stacks?

The callee can pop the arguments into the area past the
register window.

So you have the 128 byte register window save area, 6
slots for incoming arguments, which gives us 176 bytes.
The rest is for some miscellaneous stack frame state,
which I don't remember the details of at the moment.
I'd have to read the sparc backend of gcc to remember.
