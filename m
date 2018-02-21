From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Feb 2018 12:27:55 +0000
Subject: Re: [PATCH v7 03/37] sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h
Message-Id: <CAK8P3a19k92HhqEVBYO7wqx77k5PN6t_-9UbbU-DDYfZrnUUhA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1518505384.git.greentime@andestech.com> <4bb01fd533c66c357f3dc23a64f56414109a2aad.1518505384.git.greentime@andestech.com>
 <CAK8P3a1MYopHeyWAs974zHRmfe5z8RS7G1mVQyC+iJXqa28EfA@mail.gmail.com> <CAEbi=3eCfWYXZiN+5uaSqDKcEs1Kf3Av=ua6LCZmy2jAy5-Fdw@mail.gmail.com>
In-Reply-To: <CAEbi=3eCfWYXZiN+5uaSqDKcEs1Kf3Av=ua6LCZmy2jAy5-Fdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greentime Hu <green.hu@gmail.com>
Cc: sparclinux <sparclinux@vger.kernel.org>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>

On Wed, Feb 21, 2018 at 9:05 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2018-02-14 22:43 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> A commit for the nds32 architecture bootstrap("asm-generic/io.h: move
>>> ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU")
>>> will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
>>> in order to suppress re-definition errors we need to remove the #define
>>> in io_32.h.
>>>
>>> Also, the change adds a prototype for ioremap where size is size_t and
>>> offset is phys_addr_t so fix that as well.
>>>
>>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>>
>> This patch should have been addressed to the sparclinux mailing list to
>> the maintainers can see it, otherwise they are unlikely to notice.
>>
>> Added it to Cc now.
>>
>> Can you confirm that the patches are ordered correctly in your series so that
>> at no point, sparc is in a state that fails to be build cleanly?
>>
>> If not, this may have to get merged into the other patch.
>
> Hi, Arnd:
>
> These 2 patch will cause sparc building error in any order.


>
> Should I merge them together like this?
>
> asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of
> ifndef CONFIG_MMU
>
> It allows some architectures to use this generic macro instead of
> defining theirs.
>
> sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h
> It will move the ioremap_nocache out of the CONFIG_MMU ifdef. This means that
> in order to suppress re-definition errors we need to remove the #define
> in arch/sparc/include/asm/io_32.h. Also, the change adds a prototype for
> ioremap where size is size_t and offset is phys_addr_t so fix that as well.
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

That looks reasonable since both patches are fairly small, yes.

For a more complex patch that requires interdependent changes
in different areas of the kernel, it may be necessary instead to
come up with a way to stage out the changes differently so they
are truly independent. Getting that right requires a bit practice
but is usually possible.

       Arnd
