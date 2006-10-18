From: David Miller <davem@davemloft.net>
Date: Wed, 18 Oct 2006 20:36:33 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <20061018.133633.41878515.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Per =D8yvind Karlsen <pkarlsen@mandriva.com>
Date: Wed, 18 Oct 2006 21:28:55 +0100

> okay, tried booting with display, got these errors:
>=20
> SABRE0: Uncorrectable Error, primary error type[DMA Write:Translation Err=
or]
> SABRE0: bytemask[00ff] dword_offset[0] was_block(0)
> SABRE0: UE AFAR [000000006fd7c000]
> SABRE0: UE Secondary errors [(none)]
> SABRE0: IOMMU Error, type[Invalid Error]
> SABRE0: IOMMU TAG(3)[RAW(0000000000c6f800)error(Invalid=20
> Error)wr(0)sz(8K)vpg(df000000)]
> SABRE0: IOMMU DATA(3)
> [RAW(000000006fe379ec)valid(1)used(1)cache(0)ppg(000000006f3d8000)
>=20
> makes any sense?

That's coming from a DMA transaction which your ATY video
card isn't going to do :-)

What kind of devices are in this computer?  Any add-in
network or storage PCI cards?
