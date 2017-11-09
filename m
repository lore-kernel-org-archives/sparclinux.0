From: Christoph Hellwig <hch@infradead.org>
Date: Thu, 09 Nov 2017 08:34:52 +0000
Subject: Re: [PATCH v2 2/2] sparc: pass endianness info to sparse
Message-Id: <20171109083452.GA10787@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20171109061652.14948-1-luc.vanoostenryck@gmail.com>
 <20171109061652.14948-3-luc.vanoostenryck@gmail.com>
In-Reply-To: <20171109061652.14948-3-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 09, 2017 at 07:16:52AM +0100, Luc Van Oostenryck wrote:
> sparc is big-endian only but sparse assumes the same endianness
> as the building machine.
> This is problematic for code which expect __BYTE_ORDER__ being
> correctly predefined by the compiler which sparse can then
> pre-process differently from what gcc would, depending on the
> building machine endianness.
> 
> Fix this by letting sparse know about the architecture endianness.

You're posted patches for this for about half a dozen architectures
now, but we also now have generic Kconfig symbols for the byte order.

I'd much rather see this done in generic code than hacking it up
everywhere.
