From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 26 Feb 2005 22:01:02 +0000
Subject: Re: DBRI fixes and improvements [2.4]
Message-Id: <20050226140102.43d96f39.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <421FA83B.2050901@wp.pl>
In-Reply-To: <421FA83B.2050901@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 26 Feb 2005 21:51:25 +0100
Krzysztof Helt <krzysztof.h1@wp.pl> wrote:

> There is a mistake in original patch. CS4215 does not support ADPCM and 
> little-endian formats. The corrected patch is attached.

Looks really good.  I've applied this to my tree and will push it to
Marcelo unless something major wrong is found.

Feel free to do a 2.6.x sound layer port of this driver if you
wish :-)  It's the only SBUS audio driver that no port attempt
was done for.

