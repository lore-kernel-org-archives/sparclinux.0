From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Thu, 02 Apr 2020 18:53:37 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <7729f1c1-4976-c523-76ef-7ca618948db3@linaro.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9JDqiozpONwf8mh0mKeivkpGuUwdJdQeK"
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9JDqiozpONwf8mh0mKeivkpGuUwdJdQeK
Content-Type: multipart/mixed; boundary="oulfAWPUgYvDlunAb7RpSLxWZJ0Qy6p13";
 protected-headers="v1"
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 sparclinux@vger.kernel.org
Message-ID: <7729f1c1-4976-c523-76ef-7ca618948db3@linaro.org>
Subject: Re: Suspected bug in wait syscall or similar
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
 <1ce66ac3-17cf-0b74-8111-ae0b917e65b3@physik.fu-berlin.de>
 <31e71908-3508-5f71-01c8-49f861257835@linaro.org>
 <2790388.WAhmubx6ku@daneel.sf-tec.de>
In-Reply-To: <2790388.WAhmubx6ku@daneel.sf-tec.de>

--oulfAWPUgYvDlunAb7RpSLxWZJ0Qy6p13
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable



On 02/04/2020 11:57, Rolf Eike Beer wrote:
>> The only recent change prior the move to assembly was on 2.25 where we=
 had
>> to disable the stack protector.  For 2.31 release, for instance, I use=
d the
>> gcc 7.5.0 since it didn't trigger this issue.
>=20
> I recently tried rebuilding 2.29 on Gentoo with 9.2 and things started =

> breaking, may that still be an issue?

Unfortunately it is, I don't why recent version of gcc stated to generate=
d
a stack frame for the sa_restore function on sparc.=20

>=20
>>> I know that there have been some stability issues with the Linux kern=
el on
>>> SPARC with older hardware like the UltraSPARC IIIi. The T5120 we have=
 and
>>> newer machines seem to run relatively fine with a 64-bit userland.
>>
>> Not only stability issues, but I noticed that kernel developers had
>> fixed a SysV IPC kernel issue on 32-bits kernels that has been
>> lingering for years.  So I am not sure how well maintained is
>> 32-bit sparc is in general.
>=20
> This seems generally be an option, but noone has a clue of LDOM at the =
moment.=20
> You way come to #gentoo-sparc on Freenode if you want to give a helping=
 hand.
>=20
>> [1] https://sourceware.org/glibc/wiki/Release/2.31
>=20
> That only lists known test failures regarding sparc?
>=20
> Eike
>=20


--oulfAWPUgYvDlunAb7RpSLxWZJ0Qy6p13--

--9JDqiozpONwf8mh0mKeivkpGuUwdJdQeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUMEGt8/rO2QSpplaqrHsFKeUiO8FAl6GNLEACgkQqrHsFKeU
iO/+jBAAubHG45KxlGu6/8azKnttVq0dkY0Wpr8q2IpF+AoVdlvq6nqbH1dAtgb6
EvWO1rneMkZ0pdTWeMdzF95z8UiJlnOiqMz14SAUB3whUcABpo2WDhS0kXbje6ao
R6QlPr9UupfVBqp2Y23ftKge3Fd/mZYseYU5Exy2/+mnVUbXmccKoDl7v7jCEccN
Rnb2uGFkYD8ICk/b5GF3h6yyJTR9k/73/+gUxP3pfoi7yxY/ePsXldSeg7A/pdZC
OiI/9owXpqTKOHvk3Wg3/zGesk6Qrb7muqrzydv9j1ZdG3GFYMHSMQ7wMGbark08
MJJWEvlPHp8czTGZZl17zr4HN4Q81+zf+SbU6Q2eQv3Cw7NLmubtz8IdmN+ETQLS
8CThRt4qpF5wd1Xq1q6GnV6Usr1JDG3eB495o7QH7lDhBbYWEBvFs6PfQmiol439
5B2hyVIa+usY3QGLfQuRAIYWwZl237E/g/pjfllhkTbgvIHEwS7sybwGZ6jFVYu0
P8tH8vODYeNIXYZm/O+RDopROsF5LmP4cCBLPvd634kiqnnUkAhrxuJ/la5Mrmh8
wLnbYBqrMw9jvKEp6A0PuXckKTKLKaFRIusdyfNnvSBV70pLib8KUZKYZZUPIuLK
q4knKATzljh9DP5S1uysJDFnHrCND5emgrWSzkrphjYy6r2KQSE=
=2CSk
-----END PGP SIGNATURE-----

--9JDqiozpONwf8mh0mKeivkpGuUwdJdQeK--
