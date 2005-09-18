From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 18 Sep 2005 06:45:19 +0000
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
Message-Id: <20050917.234519.130676096.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050916.155919.41629794.davem@redhat.com>
	<Pine.BSO.4.62.0509171707410.5000@rudy.mif.pg.gda.pl>
	<Pine.BSO.4.62.0509171945280.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509171945280.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: kloczek@rudy.mif.pg.gda.pl
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org

From: Tomasz K=B3oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Sat, 17 Sep 2005 19:49:17 +0200 (CEST)

> Something new.
> I'm just finish rewrite backup procedure from dumping to NFS volume to
> using piped dump|ssh|dd.
> During this happens:
>=20
> PSYCHO0: Uncorrectable Error, primary error type[DMA Write]
> PSYCHO0: bytemask[0000] dword_offset[7] UPA_MID[1f] was_block(1)
> PSYCHO0: UE AFAR [000000005c8bc040]
> PSYCHO0: UE Secondary errors [(DMA Write)]
> PSYCHO0: IOMMU Error, type[Protection Error]

A driver unmapped a DMA area while the device is still
accessing it.  If you're still using the cassini card,
it's driver is the most likely suspect.
