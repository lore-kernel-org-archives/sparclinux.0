From: joshk@triplehelix.org (Joshua Kwan)
Date: Sat, 05 Jun 2004 14:39:07 +0000
Subject: Re: Take 3: sparc64 CDs work?
Message-Id: <20040605143907.GB1959@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1UWUbFP1cBYEclgG"
List-Id: <sparclinux.vger.kernel.org>
References: <20040605001932.GA22926@darjeeling.triplehelix.org>
In-Reply-To: <20040605001932.GA22926@darjeeling.triplehelix.org>
To: sparclinux@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 05, 2004 at 03:21:59PM +0200, Frederik Dannemare wrote:
> [...]
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Kernel panic: VFS: Unable to mount root fs on 00:00
>  Press L1-A to return to the boot prom

Curses!

I'm back to having no idea... Also no idea why it worked for that one
guy. Possibly it is a kernel bug only on some machines? That's even more
insidious. Right now, the situation makes no sense at all, even less
than it did before...

A summary:

* SILO 1.3.2 does not work with more machines than 1.4.5 breaks
* rootfstype=3Dext2 fixed it for one person, indicating corruption
  of the initrd by the FS checks
* Ben's kernel patch did not help.

so no rhyme or reason wrt fixes.

--=20
Joshua Kwan

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQMHbCqOILr94RG8mAQIsxA/9GuqS5BmYEaeO7bLs6cGQXx59zqrOEXU0
I6HRzkZJHtpQkgCbTGh1Jux3mbKuqbztmxKPYB6OePrHjQ0b1qLla7/IES3PEOa3
AJ9ar/rCH3lzZGrMOB1VZ2XUT22OqDx71pHIFR+JKj198r2DPJWlcyjZ7ZOYJ7wE
QWfvbB82u8cHHBYit7ivMEw5CZyHl7PvSGhpBQADFzJxKhfopd+lloN0FtjArHug
s9pn/nN5Dw6NtCdryWuxOdQBihxsqq44r/6lzwJkfPwk/2kbSgapbA5Gc+KUZQet
mKRqHJc1ba2zZf7Pri4Hj4fT2KQz7mxDkFVq98crcFIxPj/f2dw4X2lRfOajGkwD
z75Bv2R0zdNNKWisLBBoRN6pH8+fi1Ejlh0mvc4qc7KZgY0YPaiJ9PEQxABZK+KC
qpoK+XlKp5u3Wev/gqKQ8KLBRMS0A6N1rxD5s7cWwZ6mnKWsH8McyPkdkJ+SRyZ9
LkHlYs7uN4wzXBEV7vdSM9fsVIRwEfHjn3/66wz++xClu+NFNqqgLLENhP8qS7OH
DkWqhmXtiPMoCZikzOMiqkN/yRYI8/7PlxTx5pK6TG/ZKv5tS8gjv90gL/eYRDuf
I9aQtnnMY7rcf4v3YGcDxLjFYyC3j/0X2txr5mkSVMeAVFiIIL4eyBeYHL4pNXWq
pWD2II5bWCQ=
=0CZa
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
