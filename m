From: joshk@triplehelix.org (Joshua Kwan)
Date: Fri, 20 Aug 2004 22:19:43 +0000
Subject: Re: Buglet making vmlinux with -j
Message-Id: <20040820221943.GL8070@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1XWsVB21DFCvn2e8"
List-Id: <sparclinux.vger.kernel.org>
References: <200408202156.06459.crn@netunix.com>
In-Reply-To: <200408202156.06459.crn@netunix.com>
To: sparclinux@vger.kernel.org


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2004 at 10:05:34PM +0100, Ciaran McCreesh wrote:
> It's known behaviour for 2.4.x (2.6.x should work). Keith had a patch,
> although I believe it wasn't applied because of suspected side effects.

Yes, 2.6.x works; the problem for me on 2.4 is that a make -j2 will omit
building of init/, and the compile will fail because init/main.o is not
found.

Even though 'vmlinux' explicitly has a make dependency on init/main.o.
*twilight zone*

--=20
Joshua Kwan

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQSZ4/qOILr94RG8mAQJ2UhAA8oOMICIKGzoVzimNH7bFbz9adk9eGkX1
6ap+spb9gXhqATPcIgdurGvEGX2z30eZ4/vzR7RnKeTBaOU4OTMRXkhhs1zj/rbO
WwIprI8s//ewTM7QVYTSiikhIaYohP7jIKV6X+I+aPVhzbOhWikUEHDaxfIhwHgX
mqWf9ik6TqlIEf1iI9xZyeMxz/gPjOjqAKi1FrcaQSM/4U52HtrrdjHPlHP04wDO
fd8ivujUccN9aDs0fBOEYtDCCo5jkZ9niNOZ0Jz97MlSFLG7XdpZn1bRxomsqj6o
/IcbW4P2J9ywAc6AQX4tciGUYqdIAF9ptrljUX6I1+/2475V+w82BWpPZcvfwBEk
VzKZQ7BSNfPGN1d4nisXu/t8S6caBe6H6P9G7FBhaWF6Q7IYMsrIlk7QwktWUSi/
u6Hqp0UoRlWWVHiNjo6+e/d5eig9l6F1qy6DMGyF6dfPx2lZuEdWaevfz2iBqYK9
I/0UPWV2X9ZqtqlSIjHvRSS/3O4GoBQppULRhQgrhP0RuFWFk56tCLbmEHkozn46
je7GB92nERg3VAwytdG1s7aGIygQh/DHX6IeegBsGne6Bfd7OTQfLcSZNlxAg43V
4KNqRXLc/Kb7vgAM31DHcclvZ7xNHfEgjx7p4EUarNwFKEHQEMhvbqSORVtc9tA2
YKwbpvo3Ugw=
=xCXL
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
