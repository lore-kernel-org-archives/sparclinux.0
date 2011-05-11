From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 11 May 2011 09:46:20 +0000
Subject: Re: [RFC/PATCH] sparc32/LEON: Cache flush during context switch
Message-Id: <4DCA5AEC.7050200@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DC89ECB.6030309@googlemail.com>
In-Reply-To: <4DC89ECB.6030309@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Matthias Rosenfelder wrote:

> This seems very unlikely to me but I must admit that you have a point
> here. It is possible in theory, though very unlikely.
> 

In practice, unlikely thing do happen ...


> But I do. A cache set consists of all cache lines in a cache that can
> store data belonging to addresses that have the same index (i.e. the
> "middle" part of the cache address is the same for all cache lines in a
> cache set). 

Please feel free to send patches correcting the things you find confusing.

Best regards
Kristoffer Glembo
Aeroflex Gaisler

