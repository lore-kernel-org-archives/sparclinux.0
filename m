From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 16 Mar 2017 13:19:28 +0000
Subject: Re: Retrieving disk info from sunvdc using udevadm
Message-Id: <6f61c90b-394b-d20d-c233-a5c070caf360@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
In-Reply-To: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/16/2017 01:44 PM, John Paul Adrian Glaubitz wrote:
> On 03/16/2017 01:39 PM, James Clarke wrote:
>> Patching d-i might make sense, since it will ensure other architectures =
don't have similar issues, but I believe the problem is in udev itself,=20
>> specifically 60-cdrom_id.rules[1] which needs to whitelist "vdisk*" as p=
ossible CDs.
>=20
> Ah, good point. I will try patching the file and see if that helps.

It does. Sent a pull request to systemd upstream [1].

Adrian

> [1] https://github.com/systemd/systemd/pull/5599

- --=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYv+KdYTgKVaVRgAGdCY7N/W1+RMFAljKkNwACgkQdCY7N/W1
+ROC6xAArSbF8zFTTwMu8D1IASAHyNzFa8GpdPfKpaHOKRVZwuTADf4RuVsEct6f
fNy5k1oMXJxTOiguOA4rkuWQjtyVOUVXhxh5W+xBtEDCrz4NSvBw9m4WbpWKbCtk
zgkvq1jXVuiut81VLbZhYDlIjMNcyplHs9tpwqQXbQfWSo0Xu8Yb9exWkSs1/Jg/
O7y0kyUQqkhIHU0stsgsZh+uP97PAFobBfBNhtSbRRNbMQr2nY1v+AHpTvoaHMrI
CLBWXGCJgM/64HKIiBe3TWF9RPwehyLRUgoTKfWDCCst+Yi3OZZ7LGGSdef9tiux
iF1e173ZjWEMnmB78ejogRaZz+TZWAIEBOAH2Bcf83ycm7rnjW6mUShAxt+W7pLN
q1RdFXrNLwVlXmFAlrvLyRTWj6csLgj3Iu8JD3Qn9TE8zWHBXP83EnOeTyyAzERs
716SrkwkopkAcoeBqR2RhvJqi5/DhdPZfZXXCbvF+360BPqGldEkG+FlJdvYtUka
m5lnmGiSFsDZ+wsSvuPoAALWnAuYo7S0v5TFyHO5z3YHs/q9p8n1Ucm36bKHHyYq
qvXB/9k7t+PGd8Kjk3zgB/Nx2EkoCB3VMpxi6QRKzkyOD+aJ/+NLcck2IyNikDMy
eimsN96lWhND7uSYnUi+U8AvxZhHZkTjBwnBRZv3OOM565SkLzM=82ZK
-----END PGP SIGNATURE-----
