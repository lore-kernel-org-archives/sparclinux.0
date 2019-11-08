From: Michael Schmitz <schmitzmic@gmail.com>
Date: Fri, 08 Nov 2019 04:29:58 +0000
Subject: Re: [PATCH v3 05/13] m68k: mm: use pgtable-nopXd instead of 4level-fixup
Message-Id: <3d908bbf-0469-c53b-dd86-87df98f40ee7@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-6-git-send-email-rppt@kernel.org>
 <CAMuHMdUG3V7uxzhbetw75vVeobeP0-bQySb3r=0V5XujUF123g@mail.gmail.com>
 <20191104094748.GB23288@rapoport-lnx>
 <CAMuHMdVHsNyLxhaxZcVdLvQ1PUnb=2_+ECPWVD0234V+qu+kOw@mail.gmail.com>
In-Reply-To: <CAMuHMdVHsNyLxhaxZcVdLvQ1PUnb=2_+ECPWVD0234V+qu+kOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Mike Rapoport <rppt@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Linux MM <linux-mm@kvack.org>, sparclinux <sparclinux@vger.kernel.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Vincent Chen <deanbo422@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Linux-Arch <linux-arch@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, "Kirill A. Shutemov" <kirill@shutemov.name>

Hi Geert,

Am 04.11.2019 um 22:53 schrieb Geert Uytterhoeven:
>>> This indeed boots fine on ARAnyM, which emulates on 68040.
>>> It would be good to have some boot testing on '020/030, too.
>>
>> To be honest, I have no idea how to to that :)
>
> Sure. This was more a request for the fellow m68k users.
> But don't worry too much about it.  If it breaks '020/'030, we can fix
> that later.

Boots fine on 030, too.

Cheers,

	Michael
