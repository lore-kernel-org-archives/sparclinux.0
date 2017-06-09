From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Jun 2017 07:03:18 +0000
Subject: Re: [PATCH 1/2] arch: Define CPU_BIG_ENDIAN for all fixed big endian archs
Message-Id: <CAMuHMdXke2z5YuVfGU-wQ-PawwrGRP5_TyDN0qH8zah-iidNUQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496960243-196898-1-git-send-email-babu.moger@oracle.com> <1496960243-196898-2-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1496960243-196898-2-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uclinux-h8-devel@lists.sourceforge.jp, Linux/m68k <linux-m68k@vger.kernel.org>, openrisc@lists.librecores.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Fri, Jun 9, 2017 at 12:17 AM, Babu Moger <babu.moger@oracle.com> wrote:
> While working on enabling queued rwlock on SPARC, found
> this following code in include/asm-generic/qrwlock.h
> which uses CONFIG_CPU_BIG_ENDIAN to clear a byte.
>
> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>  {
>         return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>  }
>
> Problem is many of the fixed big endian architectures dont define
> CPU_BIG_ENDIAN and clears the wrong byte.
>
> Define CPU_BIG_ENDIAN for all the fixed big endian architecture.
>
> Here is the orinal discussion
> http://www.spinics.net/lists/devicetree/msg178101.html
>
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Hmm, the link above refers to a mail from me? ;-)

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
