From: Tom Duffy <tomduffy@dslextreme.com>
Date: Fri, 14 Jan 2005 22:30:34 +0000
Subject: Re: [openib-general] Re: mmap(/dev/mem) causing sigbus
Message-Id: <1105741834.22751.17.camel@duffman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-UHPfF/Lv6HVTdA2dSq5s"
List-Id: <sparclinux.vger.kernel.org>
References: <1105657934.2527.96.camel@duffman>
In-Reply-To: <1105657934.2527.96.camel@duffman>
To: sparclinux@vger.kernel.org


--=-UHPfF/Lv6HVTdA2dSq5s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-01-13 at 15:29 -0800, David S. Miller wrote:
> It's not meant to be used at all.  We have abstracted out a way
> to portably mmap() pci devices by opening /proc/bus/pci/* nodes,
> running the appropriate ioctl() to choose I/O or MEM space,
> then mmap()'ing on the fd to mmap the PCI device resources.
>=20
> At the very least, i386 and ppc support this interface as well.

Dave, thanks for the info.  The maintainer of the tool has updated it to
use the /proc/bus/pci method.

-tduffy

--=-UHPfF/Lv6HVTdA2dSq5s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB6EgKdY502zjzwbwRAisVAJ468QfhR4CpRpTglAornqvclFgQfACfYbB1
k+aYDBb3s4jsmB3EhAGfBOM=
=Qyu+
-----END PGP SIGNATURE-----

--=-UHPfF/Lv6HVTdA2dSq5s--

