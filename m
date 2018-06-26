From: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 26 Jun 2018 17:43:10 +0000
Subject: Re: [PATCH] sys: don't hold uts_sem while accessing userspace memory
Message-Id: <d23cd44b1e2e1521cedb1c514d392263ed976dca.camel@decadent.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-cEEqpFC4a1Cfx+GixbOI"
List-Id: <sparclinux.vger.kernel.org>
References: <20180625163410.216168-1-jannh@google.com>
         <20180625164109.GF30522@ZenIV.linux.org.uk>
         <CAG48ez2i2Dpy5TLTjtLiGKdkFDYLGURqAGoTDbETaBGf5SgxPw@mail.gmail.com>
In-Reply-To: <CAG48ez2i2Dpy5TLTjtLiGKdkFDYLGURqAGoTDbETaBGf5SgxPw@mail.gmail.com>
To: Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, "David S. Miller" <davem@davemloft.net>, kernel list <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, security@kernel.org, Christoph Hellwig <hch@infradead.org>, "Serge E. Hallyn" <serge@hallyn.com>


--=-cEEqpFC4a1Cfx+GixbOI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-06-25 at 20:16 +0200, Jann Horn wrote:
> On Mon, Jun 25, 2018 at 6:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >=20
> > On Mon, Jun 25, 2018 at 06:34:10PM +0200, Jann Horn wrote:
> >=20
> > > +     char tmp[32];
> > >=20
> > > -     if (namelen > 32)
> > > +     if (namelen < 0 || namelen > 32)
> > >               namelen =3D 32;
> > >=20
> > >       down_read(&uts_sem);
> > >       kname =3D utsname()->domainname;
> > >       len =3D strnlen(kname, namelen);
> > > -     if (copy_to_user(name, kname, min(len + 1, namelen)))
> > > -             err =3D -EFAULT;
> > > +     len =3D min(len + 1, namelen);
> > > +     memcpy(tmp, kname, len);
> > >       up_read(&uts_sem);
> > >=20
> > > -     return err;
> > > +     if (copy_to_user(name, tmp, len))
> > > +             return -EFAULT;
> >=20
> > Infoleak, and similar in a lot of other places.
>=20
> I don't see a problem. copy_to_user() copies "len" bytes from "tmp".
[...]
> Can you please explain why there is an infoleak here?

I think you're *fixing* information leaks in the Alpha syscalls,
because a negative value of namelen used to result in a huge length
argument to copy_to_user().

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.


--=-cEEqpFC4a1Cfx+GixbOI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlsyey4ACgkQ57/I7JWG
EQmGfBAAkJ8kvkN4ILTBveOXPzElFepd1FUG5pMwo5IfJw5Oq8f2/GbfGXDZ14Tj
abmu/OVqgeJZ/T1/Kqq96FGuz6uT61SB+eX5ncTu52xA9mWfPWVG/0wR3eplSvPY
kxsxJ61Wtdd9WjHtt4u5/OeKR6HmuxSF5b+Rfhzs5U1iJCVwxdswTnPwXqFQpS+T
YutNUFhxnI5gOvKaWuRa0v0L60v5Bah8tVICEwl+g5UqDCfarjLgIpLuoc6iNABK
UOVg9jw8wC64KQrOrUiDItG5T9E+FY4FnnRDekm2WZwbKNpW0wRM6dFmJSjeuXAT
moSF+Yws0iRyhMpUD0Ysk04gHZLZO0T40wRKfWBEa9I4Z8kMEKsTpGqltyKuU7aE
d9hICe8xpdWYYYV0bRWkDa53eQzmkHp6mfKmcnWqksuXK6887qBArslvEmHFWS1K
kvCDsVjyWTUTWNcRD0mVZ8DwpBGG/+vvf0rdUiX+EMmi8721df6mdZvRLknftsBb
gKejdzYugladdM3L36Tch/+PqDTHvvOxYW6XKVb/NxH/tkL8wMv3+jS4y2Xf5Lhi
Zk1B9mN836ZW8v9QgiFc8vYyp+4RioBSMqXEAFeWt5GJU/eyWxSqpZuIeFto/acw
1AIxwXBM7lg4ctxenK673epS+L3sQMolh6SXar7P9sjcAAp28xM=
=a19a
-----END PGP SIGNATURE-----

--=-cEEqpFC4a1Cfx+GixbOI--
