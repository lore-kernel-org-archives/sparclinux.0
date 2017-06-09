From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Jun 2017 14:11:18 +0000
Subject: Re: [PATCH 2/2] include: warn for inconsistent endian config definition
Message-Id: <CAMuHMdV7eC95C=jZdWoAHC2tHT8duoNxWkhO6jWQbzouLDZS4A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1496960243-196898-1-git-send-email-babu.moger@oracle.com>
 <1496960243-196898-3-git-send-email-babu.moger@oracle.com>
 <CAMuHMdX2u8vZGBVXitH+FcfeMwZ8a1-g2b-Dh7V9=HnqJpj=hw@mail.gmail.com>
 <CAMuHMdVia9Jkwz0eEbSG0OE-Sw5wMbdjA1o3F6m10NaSWXq_Vw@mail.gmail.com> <257e0d57-bf55-eb1b-26e2-ba50b1bd2676@oracle.com>
In-Reply-To: <257e0d57-bf55-eb1b-26e2-ba50b1bd2676@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uclinux-h8-devel@lists.sourceforge.jp, Linux/m68k <linux-m68k@vger.kernel.org>, openrisc@lists.librecores.org, Parisc List <linux-parisc@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

Hi Babu,

On Fri, Jun 9, 2017 at 3:55 PM, Babu Moger <babu.moger@oracle.com> wrote:
> On 6/9/2017 2:16 AM, Geert Uytterhoeven wrote:
>> On Fri, Jun 9, 2017 at 9:05 AM, Geert Uytterhoeven <geert@linux-m68k.org>
>> wrote:
>>>> Here is the original discussion
>>>> http://www.spinics.net/lists/devicetree/msg178101.html
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>

> Yes. Got it.  So patch #1 is fine.   But, patch #2 might cause regressions.
> Should I drop patch 2.

No, it should be applied, and regressions should be fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
