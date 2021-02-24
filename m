From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 24 Feb 2021 11:01:06 +0000
Subject: Re: [PATCH v2] vio: make remove callback return void
Message-Id: <CADxRZqzG7jtNwYsdnO1xm8FLes_+GqTB=2naxaUTP2MNkzGG3g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20210224072516.74696-1-uwe@kleine-koenig.org>
In-Reply-To: <20210224072516.74696-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Haren Myneni <haren@us.ibm.com>, =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Steven Royer <seroyer@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cristobal Forno <cforno12@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Dany Madden <drt@linux.ibm.com>, Lijun Pan <ljp@linux.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Michael Cyr <mikecyr@linux.ibm.com>, Jiri Slaby <jirislaby@kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Sparc kernel list <sparclinux@vger.kernel.org>, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:17 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
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

Applied over current git kernel, boots on my sparc64 LDOM (sunvdc
block driver which uses vio).
Linux ttip 5.11.0-10201-gc03c21ba6f4e-dirty #189 SMP Wed Feb 24
13:48:37 MSK 2021 sparc64 GNU/Linux
boot logs (and kernel config) on [1] for "5.11.0-10201-gc03c21ba6f4e-dirty".
Up to you to add "tested-by".
Thanks.

1. https://github.com/mator/sparc64-dmesg

PS: going to check with ppc64 later as well on LPAR (uses vio).
