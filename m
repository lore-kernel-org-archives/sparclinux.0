From: rppt@kernel.org
Date: Fri, 01 Nov 2019 10:14:28 +0000
Subject: Re: [PATCH v2 12/13] um: add support for folded p4d page tables
Message-Id: <20191101101432.7998A2086D@mail.kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org> <1572597584-6390-13-git-send-email-rppt@kernel.org> <1435962204.69872.1572600009245.JavaMail.zimbra@nod.at>
In-Reply-To: <1435962204.69872.1572600009245.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Richard Weinberger <richard@nod.at>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, anton ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, davem <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vin

<linux-c6x-dev@linux-c6x.org>,linux-kernel <linux-kernel@vger.kernel.org>,l=
inux-m68k <linux-m68k@lists.linux-m68k.org>,linux-parisc <linux-parisc@vger=
.kernel.org>,linux-um <linux-um@lists.infradead.org>,sparclinux <sparclinux=
@vger.kernel.org>,Mike Rapoport <rppt@linux.ibm.com>
From: Mike Rapoport <rppt@kernel.org>
Message-ID: <E5D8BD4D-5286-427C-A347-D73AC26EC256@kernel.org>

On November 1, 2019 10:20:09 AM GMT+01:00, Richard Weinberger <richard@nod.=
at> wrote:
>----- Urspr=C3=BCngliche Mail -----
>> Von: "Mike Rapoport" <rppt@kernel.org>
>
>[...]
>
>> #define pte_page(x) pfn_to_page(pte_pfn(x))
>> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
>> index 417ff64..6fd17bc 100644
>> --- a/arch/um/kernel/mem.c
>> +++ b/arch/um/kernel/mem.c
>> @@ -92,10 +92,26 @@ static void __init one_md_table_init(pud_t *pud)
>> #endif
>> }
>>=20
>> +static void __init one_pud_table_init(p4d_t *p4d)
>> +{
>> +#if CONFIG_PGTABLE_LEVELS > 3
>
>Isn't this dead code?
>
>For uml we have:
>config PGTABLE_LEVELS
>        int
>        default 3 if 3_LEVEL_PGTABLES
>        default 2

It's kinda a provision for 4 levels support in UML :)
I can drop this in the next respin, no problem.

>Thanks,
>//richard


--=20
Sincerely yours,
Mike
