From: David Miller <davem@davemloft.net>
Date: Mon, 22 May 2017 19:03:28 +0000
Subject: Re: [PATCH v2 1/7] kernel/locking: Fix compile error with qrwlock.c
Message-Id: <20170522.150328.1597262115447284483.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1495239421-441642-1-git-send-email-babu.moger@oracle.com>
        <1495239421-441642-2-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495239421-441642-2-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: babu.moger@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 19 May 2017 18:16:55 -0600

> Some architectures use the following guard in include file
>  "asm/spinlock_types.h" to discourage including the file directly.
>=20
> Saw these compile errors on SPARC when queued rwlock feature is enabled.
>=20
>   CC      kernel/locking/qrwlock.o
> In file included from ./include/asm-generic/qrwlock_types.h:5,
>                  from ./arch/sparc/include/asm/qrwlock.h:4,
>                  from kernel/locking/qrwlock.c:24:
> ./arch/sparc/include/asm/spinlock_types.h:5:3: error:
>         #error "please don't include this file directly"
>=20
> Re-arrange the includes in qrwlock_types.h and include spinlock.h
> in qrwlock.c to fix it.
>=20
> Also will be removing this stanza from SPARC. Stay tuned.
>=20
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Reviewed-by: H=E5kon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>

In my feedback I said to remove that check from
sparc's asm/spinlock_types.h header.

Which you do in patch #2

But that means this patch #1 here is no longer necessary, since we
conform to the hearder scheme used by other architectures using queued
locks.

So please remove this patch from the series.

Thank you.
