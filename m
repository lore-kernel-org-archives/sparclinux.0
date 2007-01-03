From: David Miller <davem@davemloft.net>
Date: Wed, 03 Jan 2007 05:37:21 +0000
Subject: Re: Third Try: [PATCH] cs4231 alsa driver: Fix IRQ and
Message-Id: <20070102.213721.99553992.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <459593A2.2000600@hp.com>
In-Reply-To: <459593A2.2000600@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Chini, Georg" <georg.chini@hp.com>
Date: Fri, 29 Dec 2006 23:16:02 +0100

> I don't know what my mail program does to the patch. When I
> send it there is always a + sign too much in one line. So I attach
> it as a file now. I hope this works, and once again sorry for the
> confusion.

Thanks for your fix, I've applied your patch.

BTW, the period_bytes_min settings I simply copied over from the
existing ISA cs4231 driver at the time.

But it seems that nowadays the ISA CS4231 driver is using a value of
"64" for period_bytes_min.  Perhaps the Sparc driver should do that
too :-)

