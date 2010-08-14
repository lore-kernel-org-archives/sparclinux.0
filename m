From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Sat, 14 Aug 2010 13:26:03 +0000
Subject: Re: compiling silo with any gcc newer than 4.3 (4.4, 4.5)
Message-Id: <4C66996B.8070900@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 07/22/2010 12:17 PM, Rene Rebe wrote:
> Hi David,
>=20
> I got some problem compiling silo with gcc 4.4 or 4.5. This binary diff c=
reation fails due to too big chunks:
>=20
> ./util second.map second.aout second2.aout second.b second.b2
> Distance between two changes larger than 63K 3 116953 43805
>=20
> Anything else and the kernel do build just fine, silo appears to be my la=
st problem getting a new T2 ISO out, ...
>=20
> Do you get the same error, or just use very much older gcc versions? Then=
 again you may not compile silo to often at all, ...
>=20
> Any idea or feedback appreciated.
>=20
> Ren=E9
>=20

The latest silo revision on git builds and works fine for me with
gcc-4.4.4. And i think on debian builds too...
