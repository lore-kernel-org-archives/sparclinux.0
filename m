From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Tue, 28 Dec 2004 03:33:51 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to
Message-Id: <1104204831.22109.13.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-oKhGZM0a9u+NwoCj0wW+"
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
To: sparclinux@vger.kernel.org


--=-oKhGZM0a9u+NwoCj0wW+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-12-27 at 19:27 -0800, David S. Miller wrote:
> On Mon, 27 Dec 2004 19:06:57 -0800
> William Lee Irwin III <wli@holomorphy.com> wrote:
>=20
> > By and large I'd prefer to discourage userspace code from using
> > kernel headers. Does this work in a significant number of other
> > arches as things stand now?
>=20
> Glibc includes them.  It works for sparc64 and a lot of this
> is painless stuff to include.

Yeah, that patch was specifically for glibc.  Some other things include
them as well... samba comes to mind.  I agree that it's good to
discourage userland code from using the kernel headers, but in some
cases, it's unavoidable.

--=20
Jeremy Huddleston <eradicator@gentoo.org>

--=-oKhGZM0a9u+NwoCj0wW+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB0NQfOpjtAl+gMRURAqB+AJ9hgYmsW/PVfCg/LsL7l8wW8r7OcgCgucwB
ASouj1qDjNysyDiaihjQ4RU=
=GGMp
-----END PGP SIGNATURE-----

--=-oKhGZM0a9u+NwoCj0wW+--

