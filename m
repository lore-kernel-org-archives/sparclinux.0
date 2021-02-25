From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 25 Feb 2021 14:01:25 +0000
Subject: Re: [PATCH v2] vio: make remove callback return void
Message-Id: <CAK8P3a1q=zqyOxBgV-nprpN3jBczZWexupkA1Wy6g+AEW6rQqw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20210224072516.74696-1-uwe@kleine-koenig.org> <87sg5ks6xp.fsf@mpe.ellerman.id.au>
In-Reply-To: <87sg5ks6xp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Haren Myneni <haren@us.ibm.com>, =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Steven Royer <seroyer@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cristobal Forno <cforno12@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Dany Madden <drt@linux.ibm.com>, Lijun Pan <ljp@linux.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Michael Cyr <mikecyr@linux.ibm.com>, Jiri Slaby <jirislaby@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, linux-integrity@vger.kernel.org, Networking <netdev@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, target-devel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:52 PM Michael Ellerman <mpe@ellerman.id.au> wrot=
e:
>
> Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org> writes:
> > The driver core ignores the return value of struct bus_type::remove()
> > because there is only little that can be done. To simplify the quest to
> > make this function return void, let struct vio_driver::remove() return
> > void, too. All users already unconditionally return 0, this commit makes
> > it obvious that returning an error code is a bad idea and makes it
> > obvious for future driver authors that returning an error code isn't
> > intended.
> >
> > Note there are two nominally different implementations for a vio bus:
> > one in arch/sparc/kernel/vio.c and the other in
> > arch/powerpc/platforms/pseries/vio.c. I didn't care to check which
> > driver is using which of these busses (or if even some of them can be
> > used with both) and simply adapt all drivers and the two bus codes in
> > one go.
>
> I'm 99% sure there's no connection between the two implementations,
> other than the name.
>
> So splitting the patch by arch would make it easier to merge. I'm
> reluctant to merge changes to sparc code.

The sparc subsystem clearly started out as a copy of the powerpc
version, and serves roughly the same purpose, but the communication
with the hypervisor is quite different.

As there are only four drivers for the sparc vio subsystem:
drivers/block/sunvdc.c
drivers/net/ethernet/sun/ldmvsw.c
drivers/net/ethernet/sun/sunvnet.c
drivers/tty/vcc.c
maybe it would make sense to rename those to use distinct
identifiers now?

       Arnd
