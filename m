From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 09 Nov 2017 13:13:07 +0000
Subject: Re: [PATCH v2 2/2] sparc: pass endianness info to sparse
Message-Id: <CAMHZB6H4dGwMM+nPbDg0SEDBkRF7_R_LZ-bMWUzreBYDj3U3Sg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171109061652.14948-1-luc.vanoostenryck@gmail.com>
 <20171109061652.14948-3-luc.vanoostenryck@gmail.com> <20171109083452.GA10787@infradead.org>
In-Reply-To: <20171109083452.GA10787@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: "David S . Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Babu Moger <babu.moger@oracle.com>

On Thu, Nov 9, 2017 at 9:34 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Nov 09, 2017 at 07:16:52AM +0100, Luc Van Oostenryck wrote:
>> sparc is big-endian only but sparse assumes the same endianness
>> as the building machine.
>> This is problematic for code which expect __BYTE_ORDER__ being
>> correctly predefined by the compiler which sparse can then
>> pre-process differently from what gcc would, depending on the
>> building machine endianness.
>>
>> Fix this by letting sparse know about the architecture endianness.
>
> You're posted patches for this for about half a dozen architectures
> now, but we also now have generic Kconfig symbols for the byte order.
>
> I'd much rather see this done in generic code than hacking it up
> everywhere.

OK, when I wrote these patch (in June, IIRC) there wasn't yet the
generic Kconfig symbol. I'll see what can now be generic and what
need to stay specific (for example, ARM need __ARME{L,B}__,
ARM64 & MIPS are in the same situation as are a few others archs).

-- Luc Van Oostenryck
