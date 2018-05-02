From: James Hogan <jhogan@kernel.org>
Date: Wed, 02 May 2018 22:20:18 +0000
Subject: Re: [PATCH 11/13] mips,unicore32: swiotlb doesn't need sg->dma_length
Message-Id: <20180502222017.GC20766@jamesdev>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Izn7cH1Com+I3R9J"
List-Id: <sparclinux.vger.kernel.org>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-12-hch@lst.de>
In-Reply-To: <20180425051539.1989-12-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> swiotlb.  swiotlb itself never merges segements and doesn't accesses the
> dma_length field directly, so drop the dependency.

Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
suggest arch ports should enable it for IOMMUs?

Cheers
James

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuo5nwAKCRA1zuSGKxAj
8toFAQDILXOi2KhP1yoO3zabIiof3I/tmRomgzUgGA3ESVm5lgEA4elhmn7zDXhX
YG33reqJ7xyPenaOF8AX63cB5eqjOQ8=
=UDV2
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
