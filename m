From: David Miller <davem@davemloft.net>
Date: Wed, 30 May 2007 20:01:40 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <20070530.130140.97293476.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200705301933.l4UJXIE0023913@alkaid.it.uu.se>
In-Reply-To: <200705301933.l4UJXIE0023913@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 30 May 2007 21:33:18 +0200 (MEST)

> You were spot on. 2.6.21 + patches up to but not including
> the first one above works. Adding that one gave me a kernel
> that wouldn't boot (hung after "uncompressing kernel").
> Adding the second one above gave me a kernel that booted, but
> where X failed to mmap() the frame buffer as I described.

Thanks for all of your testing.

I'll try to figure this out on one of my Ultra5's here.
