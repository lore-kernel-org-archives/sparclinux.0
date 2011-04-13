From: David Sterba <dave@jikos.cz>
Date: Wed, 13 Apr 2011 09:40:37 +0000
Subject: Re: Warning when mounting btrfs partition, kernel unaligned access
Message-Id: <20110413094037.GL31675@twin.jikos.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <4DA4DA5C.3050703@frankengul.org>
In-Reply-To: <4DA4DA5C.3050703@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?S=E9bastien?= Bernard <seb@frankengul.org>
Cc: linux-btrfs@vger.kernel.org, sparclinux@vger.kernel.org, debian-sparc@lists.debian.org

Hi

On Wed, Apr 13, 2011 at 01:03:56AM +0200, S=E9bastien Bernard wrote:
> Then, after writing on the disk, I got a lot of warning:
> [  822.515875] Kernel unaligned access at TPC[103c2204]
>=20
> I peeked a look at the btrf_csum_final and here's the function :
> void btrfs_csum_final(u32 crc, char *result)
> {
>         *(__le32 *)result =3D ~cpu_to_le32(crc);
> }

FYI, this has been fixed and is already merged into Linus' tree. Commit
7e75bf3ff3a716d7b21d8fb43bf823115801c1e9.

dave
