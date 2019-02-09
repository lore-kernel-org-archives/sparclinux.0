From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Sat, 09 Feb 2019 01:44:34 +0000
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Message-Id: <CABeXuvqpexo4g7xQihKPoOd4ce4rLq0Agy-jYMELYvOAnqmXJA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-13-deepa.kernel@gmail.com>
 <87r2clku4j.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2clku4j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arch <linux-arch@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Network Devel Mailing List <netdev@vger.kernel.org>, Helge Deller <deller@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org, cluster-devel <cluster-devel@redhat.com>, ccaulfie@redhat.com, Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Richard Henderson <rth@twiddle.net>

> You touched powerpc in the previous patch but not this one.
>
> That's because we use the asm-generic version I assume.

That is correct.

> Would be good to mention in the change log though to avoid any confusion.

I'm not sure how to do that now. It looks like the series has already
been applied to net-next with a couple of merge conflicts fixed.

-Deepa
