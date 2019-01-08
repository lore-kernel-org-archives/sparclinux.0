From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 08 Jan 2019 21:29:09 +0000
Subject: Re: [PATCH] socket: move compat timeout handling into sock.c
Message-Id: <CABeXuvpprn_AXF0ama9CsHyZ1yb8FuUH25MXauLzHyahxr+Vwg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
 <20190108200959.1686520-1-arnd@arndb.de>
In-Reply-To: <20190108200959.1686520-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Miller <davem@davemloft.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, ccaulfie@redhat.com, Helge Deller <deller@gmx.de>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, cluster-devel <cluster-devel@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Tue, Jan 8, 2019 at 12:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This is a cleanup to prepare for the addition of 64-bit time_t
> in O_SNDTIMEO/O_RCVTIMEO. The existing compat handler seems
> unnecessarily complex and error-prone, moving it all into the
> main setsockopt()/getsockopt() implementation requires half
> as much code and is easier to extend.
>
> 32-bit user space can now use old_timeval32 on both 32-bit
> and 64-bit machines, while 64-bit code can use
> __old_kernel_timeval.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This will make the other series so much nicer. Thank you.

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
