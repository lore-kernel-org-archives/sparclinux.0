From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <mt1@systella.fr>
Date: Fri, 23 Jun 2006 11:48:06 +0000
Subject: Re: [PATCH] sparc32: fix iommu_flush_iotlb end address
Message-Id: <449BD4F6.6060006@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <449774DB.6090201@mc.net>
In-Reply-To: <449774DB.6090201@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Martin Habets a =E9crit :
> Hi Bob,
>=20
> On Mon, Jun 19, 2006 at 11:08:59PM -0500, Bob Breuer wrote:
>=20
>>Fix the calculation of the end address when flushing iotlb entries to
>>ram.  This bug has been a cause of esp dma errors, and it affects
>>HyperSPARC systems much worse than SuperSPARC systems.
>=20
>=20
> Thanks for this patch! I was going cross-eyed trying to figure this
> out. I have updated kernel bug 6344 with this info. Can no longer reprodu=
ce
> any esp dma errors.

	Thanks for this patch. I shall test it in smp configuration. Do you=20
know the release of the official kernel that supports sparc32 smp mode ?=20
I have tested the 2.6.17.1 kernel without success (ot doesn't build due=20
to a undefined symbol...).

	Regards,

	JKB

