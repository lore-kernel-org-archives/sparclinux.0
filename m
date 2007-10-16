From: David Miller <davem@davemloft.net>
Date: Tue, 16 Oct 2007 22:38:27 +0000
Subject: Re: [Q] iSCSI on sparc64
Message-Id: <20071016.153827.68571102.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4714BCB7.5080607@systella.fr>
In-Reply-To: <4714BCB7.5080607@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 16 Oct 2007 15:29:27 +0200

> lot of messages like :
>=20
> Kernel unaligned access at TPC[1016b334]=20
> set_offset_and_length+0xdc/0x1a0 [iscsi_trgt]

The iSCSI code makes unaligned accesses for the data types
being dereferenced, and needs to be fixed.

I don't have the resources to do any of this work, please
report the problem to the iSCSI people.
