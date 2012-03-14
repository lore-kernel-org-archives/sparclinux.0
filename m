From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 Mar 2012 05:02:46 +0000
Subject: Re: New build failures in sparc.
Message-Id: <20120314160246.6513bd6b963fc37de4f35d1c@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__14_Mar_2012_16_02_46_+1100_v/qbiDM90bL2j5wD"
List-Id: <sparclinux.vger.kernel.org>
References: <20120314102830.aa7b1139bff158d30ac57505@canb.auug.org.au>
	<20120313.173741.18086192847996966.davem@davemloft.net>
	<20120314040102.GA26084@thor.bakeyournoodle.com>
	<20120313.214609.1139946570476396180.davem@davemloft.net>
In-Reply-To: <20120313.214609.1139946570476396180.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: tony@bakeyournoodle.com, paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-next@vger.kernel.org

--Signature=_Wed__14_Mar_2012_16_02_46_+1100_v/qbiDM90bL2j5wD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 13 Mar 2012 21:46:09 -0700 (PDT) David Miller <davem@davemloft.net>=
 wrote:
>
> See the patch I sent to Linus which landed in his tree an hour or so
> ago:
>=20
> --------------------
> [PATCH] sparc32: Add -Av8 to assembler command line.

I will cherry-pick that onto the end of linux-next today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__14_Mar_2012_16_02_46_+1100_v/qbiDM90bL2j5wD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPYCZ2AAoJEECxmPOUX5FESfYP+gNzaoUlBMQ8mlTtXGh7+sVG
tlpw+s4jtc03z9/Cb0eGBDV2uwrgpVFUGokHGRUUSkhMy5Zbo2YTJZteuQdLSUwK
AK10FFn7YuFqTBe2zz6xUWdqUDSCbwlGFLi/n3v4d+O+Cr0PwXya01Z+HHBdFXPn
O2MQ8RS1rs08C7ybdqo8D1SXTTrTtnKQXLjB4X4JCJsEgBTnMGClEStaacl8x5im
alV77QIceWMSmZAs9/hY01PqEe6t1PwISb6BpOZ1tfZU1Pn0BG7ysb39IrkZlctd
9u+xmOJad6j70rDEkjYaD4s27tL9VFEViCJcMdb1jBjKSFOD2KVH+IByzRagksnF
fw6cPwxvUz9UI6j1eYCDob5541D+p/9yn2zTb28MdesV90TkP4Sift6A75cEe2CF
0ZjprltJn43ABwXPxD1/n7nEk6JhnRfiODO2+f/qqj6JHStCeIqS196qY6+msXC8
kZebnJAmm6pqJX9geQJtEudzX1JC60aB/rUGp6dKMCftGfSyrPJZAz3hCkqwqsYy
8Oxtl9DJT4Cf17DNF6XLYy9SEaYkZ7XePEgm7z9ctQSrk4/UvdDo0NG6KMLJsr5I
NjsHfG1tKgsnaEcJbb2sEQJyJcNgmYtswcSdYDdTpe83LFHAEbaz5iDZ2NOjLvtN
rU6HMNQjmUrKPMEhkLhf
=bvYh
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Mar_2012_16_02_46_+1100_v/qbiDM90bL2j5wD--
