From: joshk@triplehelix.org (Joshua Kwan)
Date: Mon, 31 May 2004 16:27:03 +0000
Subject: Re: new debian-installer images for sparc
Message-Id: <20040531162703.GG2384@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Cp3Cp8fzgozWLBWL"
List-Id: <sparclinux.vger.kernel.org>
References: <20040531034458.GF2384@triplehelix.org>
In-Reply-To: <20040531034458.GF2384@triplehelix.org>
To: sparclinux@vger.kernel.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 31, 2004 at 09:35:17AM -0400, Ben Collins wrote:
> The only way it's going to work is if the kernels are less than 3.4Megs
> uncompressed. This is probably fine for cd boots though.

ergh. I might be just getting in under the gun.

root@june:/boot$ zcat vmlinuz-2.4.26-sparc64 > vmlinux
root@june:/boot$ du vmlinux
3523    vmlinux

Or maybe not. But it's easy to trim the kernel images down, especially
for sparc64. I think.

> GOod thing is, I have time today for some sparc stuff. Well, that is, if
> I don't get my Harley Fatboy today. Even if I do, I will work in some
> debug time for this initrd problem :)

Cool!

Back to Biology...

--=20
Joshua Kwan

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQLtc1qOILr94RG8mAQJi+Q/+Kj0lElzzpeyNE8zxgLwtVthYndMwI5gP
lpq1GnyJCBP9jhpPaIZH8/8vTwU6DFLyr3MByobwpOXmoDOzV+O15nK4JDMrMrvA
Hb7sD5PjNaKi8BLRa+E3kCF04KIiEXf1/hPpro61qCtm4iu2JcoNb7Mlp4a/C0oK
++6ciISOU4CYqValcnJprIcF9xVNwaXdmi9Fa+cBkzUtVDvduy/sWTSfVg7f2A8r
cCb/08WFvg5u8FmwSy4RRWfB0bhJ2loMS9oLI5CHTYDss1kn98kXD31Hp/iw+SEE
inQs1i6o3J0XDh4tQboTRL4bK5htTzMEcu2t6PC+X8XdMAYgx1ake8ZHCn/Tt5KR
rseRCiiRHbrlVs/6kwnxa2tF9rmwxHzAr9lPRUums87xxtkmEuh0SnljswkOIt3S
Jh41agRlduiNA6DHP4vdHYi/6stK4r6Lhj7aSjXQfRgCYUJxJN6Bl9V6val/2bvx
cKKPrnGNWPHvwK9iJpjei2/spp1XA3i11jWAuUJstGOwser9wpecjRF2BpbZIpwC
xmoR3UO+J0JvrMYc64Az9YjnSIHiDjg3TGgK+wPw1WEeT+bf6qJ2dSvzhqWxqmxJ
9mH4JNvAxtEBjc46T197OBzDT5YKMt/ecaBZIfDD3DqU4JVJifb7yTW9vOXB1Eky
x+6Xoiq7fMo=
=JcbP
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
