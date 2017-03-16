From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 16 Mar 2017 12:44:50 +0000
Subject: Re: Retrieving disk info from sunvdc using udevadm
Message-Id: <4229d955-9a10-827d-792d-a88a92ddcbb9@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
In-Reply-To: <b6ac708b-63f6-59b6-6311-f697f8c11393@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/16/2017 01:39 PM, James Clarke wrote:
> Patching d-i might make sense, since it will ensure other architectures don't have similar issues, but I believe the problem is in udev itself,
> specifically 60-cdrom_id.rules[1] which needs to whitelist "vdisk*" as possible CDs.

Ah, good point. I will try patching the file and see if that helps.

> Certainly if you invoke /lib/udev/cdrom_id manually it is able to distinguish between CDs and non-CDs.

I have actually been fumbling with that in the past. That was when I fixed
the autoloading mechanism.

Adrian

- -- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYv+KdYTgKVaVRgAGdCY7N/W1+RMFAljKiL8ACgkQdCY7N/W1
+RNcMw//XIBd7T5xnVb7ENWRrld8vMiBP9zl7xkHg7s8zjJ7uQDPlm/P/Styc1fU
IjLOpVSuZyS83uRe33R62SgIEmv1PKKotvmYJXBznIaLZnSrDEwEuISJregJU2Jb
Nb9eYppwyDi/flpxqaKuTHIVrkGyJRU7LAMv1Gd91L5ELqNUAfmF5hsx9A1q4rgJ
ARpw+nQf15zdy0YTgxTXlFz2f8rPYFOv0ueh5ZGqfn8zFQiFZh49OtLghkkpjdFF
SZ4+rQ5NlquAl2WOLXudlC/oIopNhEb6J7nXnI056vuOTHQvhDnPw0wF7tcdf97g
PHxZpr1KRYQrqG3Q/AVAR5uOfxvNKBJUL/sUmBXkY3WLUMeUafzXAIqMWAw81FpB
VIFj6yDkhDFr0bFgAj2GhmoCLnH8izmuUKEK3GSJndsoftP8ilXe4OU0E4/kJxB9
w/LW52YqXb+ih0k2bh2iMdzhzRCo/qyVNJzCHwkv1EDVVHnwV3HlWS29wKlMezcM
4uU6FJPytiAuBs9f8MM0QtHq/u1bqUsghdlgw3SsZYDkXjISW/awMLkjAASf/RSD
c9hKl5kTAg5lMG2Na5NhUloiQ0CLKFRL7UES7PKMbqbQj4lC1MbZDYSgXPRGNjfc
aPuohLXE7+isGBCGRYdwRWXR58kOdyFB9OkPrdwVVLAdFwBy+A8=zoL8
-----END PGP SIGNATURE-----
