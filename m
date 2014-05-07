From: Meelis Roos <mroos@linux.ee>
Date: Wed, 07 May 2014 20:11:43 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <alpine.SOC.1.00.1405072304340.15220@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> I think I found the bug and it's been there forever, please try this patc=
h:

  CC      arch/sparc/mm/tsb.o
arch/sparc/mm/tsb.c: In function =A1setup_tsb_params=A2:
arch/sparc/mm/tsb.c:140:7: error: =A1MM_TSB_HUGE=A2 undeclared (first use i=
n this function)
arch/sparc/mm/tsb.c:140:7: note: each undeclared identifier is reported onl=
y once for each function it appears in
make[2]: *** [arch/sparc/mm/tsb.o] Error 1

#include <asm/mmu_64.h> defines it only for CONFIG_HUGETLB_PAGE or=20
CONFIG_TRANSPARENT_HUGEPAGE case so it does not compile on my !THP=20
machines.

However, this invalidates my V440 and U5 tests. For now I set these to=20
THP and try again.

--=20
Meelis Roos (mroos@linux.ee)
