From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 04 Dec 2011 11:59:52 +0000
Subject: Re: [PATCH-RFC 10/10] sparc: switch to GENERIC_PCI_IOMAP
Message-Id: <20111204120004.GA18758@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20111204104916.GL15464@redhat.com>
In-Reply-To: <20111204104916.GL15464@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Sun, Dec 04, 2011 at 12:26:19PM +0100, Sam Ravnborg wrote:
>     > --- a/arch/sparc/include/asm/io_32.h
>     > +++ b/arch/sparc/include/asm/io_32.h
>     > @@ -8,6 +8,10 @@
>     > =A0#include <asm/page.h> =A0 =A0 =A0/* IO address mapping routines =
need this */
>     > =A0#include <asm/system.h>
>     >
>     > +#ifdef __KERNEL__
>     > +#include <asm-generic/pci_iomap.h>
>     > +#endif
>     > +
>=20
> This file is not exported to userspace - so the test for __KERNEL__ can be
> dropped.
> =A0
>=20
>     > diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/as=
m/
>     io_64.h
>     > index 9c89654..19cd51d 100644
>     > --- a/arch/sparc/include/asm/io_64.h
>     > +++ b/arch/sparc/include/asm/io_64.h
>     > @@ -9,6 +9,10 @@
>     > =A0#include <asm/system.h>
>     > =A0#include <asm/asi.h>
>     >
>     > +#ifdef __KERNEL__
>     > +#include <asm-generic/pci_iomap.h>
>     > +#endif
>=20
> Likewise
>=20
> =A0 =A0Sam
>=20
> =A0 =A0 Sam

Hmm.
Why is there an #ifdef __KERNEL__ a bit lower?
That's why I put the includes within ifdef __KERNEL__ - the
definitions pulled in were within ifdef __KERNEL__ originally.

--=20
MST
