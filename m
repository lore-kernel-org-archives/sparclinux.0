From: Lijun Pan <lijunp213@gmail.com>
Date: Fri, 29 Jan 2021 19:08:45 +0000
Subject: Re: [PATCH] vio: make remove callback return void
Message-Id: <CAOhMmr4ZMXS+R3AcdKm3qcePfuaZeC-0dNWvsSzowbv5hXo2-Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20210127215010.99954-1-uwe@kleine-koenig.org>
In-Reply-To: <20210127215010.99954-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Haren Myneni <haren@us.ibm.com>, =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Steven Royer <seroyer@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cristobal Forno <cforno12@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Dany Madden <drt@linux.ibm.com>, Lijun Pan <ljp@linux.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Michael Cyr <mikecyr@linux.ibm.com>, Jiri Slaby <jirislaby@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org

On Wed, Jan 27, 2021 at 6:41 PM Uwe Kleine-König <uwe@kleine-koenig.org> wrote:
>
> The driver core ignores the return value of struct bus_type::remove()
> because there is only little that can be done. To simplify the quest to
> make this function return void, let struct vio_driver::remove() return
> void, too. All users already unconditionally return 0, this commit makes
> it obvious that returning an error code is a bad idea and makes it
> obvious for future driver authors that returning an error code isn't
> intended.
>
> Note there are two nominally different implementations for a vio bus:
> one in arch/sparc/kernel/vio.c and the other in
> arch/powerpc/platforms/pseries/vio.c. I didn't care to check which
> driver is using which of these busses (or if even some of them can be
> used with both) and simply adapt all drivers and the two bus codes in
> one go.
>
> Note that for the powerpc implementation there is a semantical change:
> Before this patch for a device that was bound to a driver without a
> remove callback vio_cmo_bus_remove(viodev) wasn't called. As the device
> core still considers the device unbound after vio_bus_remove() returns
> calling this unconditionally is the consistent behaviour which is
> implemented here.
>
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>

Acked-by: Lijun Pan <ljp@linux.ibm.com>
