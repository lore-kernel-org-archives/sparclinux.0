From: David Miller <davem@davemloft.net>
Date: Sun, 12 Apr 2009 08:30:13 +0000
Subject: Re: sparc32 fails to boot
Message-Id: <20090412.013013.196490290.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49E0BFB5.7050401@earthlink.net>
In-Reply-To: <49E0BFB5.7050401@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Sat, 11 Apr 2009 12:05:09 -0400

> I just tried booting RC1 and I am getting the following repeating
> errors.
> 
> The last kernel I tried was 2.6.29-rc4 so that's a lot to bisect so
> any ideas before I start bisecting?
> 
> I also had a very hard time getting a kernel small enough to boot.
> I had to throw away virtually everything to finally get it to boot.
> I don't know if that's related.

Unfortunately, I think you will need to fully bisect this one.

I haven't touched anything non-trivial that would effect
sparc 32-bit myself, so I could even point at potentially
interesting sparc specific commits for you :-/
