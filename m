From: Richard Weinberger <richard@nod.at>
Date: Fri, 01 Nov 2019 09:12:55 +0000
Subject: Re: [PATCH v2 11/13] um: remove unused pxx_offset_proc() and addr_pte() functions
Message-Id: <1156525130.69849.1572599575743.JavaMail.zimbra@nod.at>
List-Id: <sparclinux.vger.kernel.org>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org> <1572597584-6390-12-git-send-email-rppt@kernel.org>
In-Reply-To: <1572597584-6390-12-git-send-email-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, anton ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, davem <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo42>

----- Urspr=C3=BCngliche Mail -----
> Von: "Mike Rapoport" <rppt@kernel.org>
> An: linux-mm@kvack.org
> CC: "Andrew Morton" <akpm@linux-foundation.org>, "anton ivanov" <anton.iv=
anov@cambridgegreys.com>, "Arnd Bergmann"
> <arnd@arndb.de>, "davem" <davem@davemloft.net>, "Geert Uytterhoeven" <gee=
rt@linux-m68k.org>, "Greentime Hu"
> <green.hu@gmail.com>, "Greg Ungerer" <gerg@linux-m68k.org>, "Helge Deller=
" <deller@gmx.de>, "James E.J. Bottomley"
> <James.Bottomley@HansenPartnership.com>, "Jeff Dike" <jdike@addtoit.com>,=
 "Kirill A. Shutemov" <kirill@shutemov.name>,
> "torvalds" <torvalds@linux-foundation.org>, "Mark Salter" <msalter@redhat=
.com>, "Matt Turner" <mattst88@gmail.com>,
> "Michal Simek" <monstr@monstr.eu>, "Peter Rosin" <peda@axentia.se>, "rich=
ard" <richard@nod.at>, "Rolf Eike Beer"
> <eike-kernel@sf-tec.de>, "Russell King" <linux@armlinux.org.uk>, "Sam Cre=
asey" <sammy@sammy.net>, "Vincent Chen"
> <deanbo422@gmail.com>, "Vineet Gupta" <Vineet.Gupta1@synopsys.com>, "Mike=
 Rapoport" <rppt@kernel.org>,
> linux-alpha@vger.kernel.org, "linux-arch" <linux-arch@vger.kernel.org>, "=
linux-arm-kernel"
> <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, "lin=
ux-kernel" <linux-kernel@vger.kernel.org>,
> linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, "linux-um"=
 <linux-um@lists.infradead.org>,
> sparclinux@vger.kernel.org, "Mike Rapoport" <rppt@linux.ibm.com>
> Gesendet: Freitag, 1. November 2019 09:39:42
> Betreff: [PATCH v2 11/13] um: remove unused pxx_offset_proc() and addr_pt=
e() functions

> From: Mike Rapoport <rppt@linux.ibm.com>
>=20
> The pxx_offset_proc() and addr_pte() functions are never used.
> Remove them.
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
