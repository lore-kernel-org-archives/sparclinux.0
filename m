From: joshk@triplehelix.org (Joshua Kwan)
Date: Wed, 21 Jul 2004 06:47:05 +0000
Subject: Weird serial problems in 2.6.7
Message-Id: <20040721064705.GE23921@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cmJC7u66zC7hs+87"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently working on 2.6.7 packages for Debian. Works fine, more or
less, but I'm having a weird problem with serial console. Seems to be
clobbering every second character in the output, for example:

eh:HPYMA PICerO 010ae tent 8:0:0:d:3:7

is

eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:8d:23:77

when I look at it in dmesg.

All userspace output to the serial console appears correctly. Note, this
is not booting with 'console=3DttySx'; this is just using the built-in
keyboardless/monitorless behavior of SPARC machines.

Is there some obscure setting in the PROM that can be set to fix this?
I don't think I experience this in 2.4.26 (don't feel like booting it
right now but will do so on request.)

Thanks

--=20
Joshua Kwan

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQP4RaKOILr94RG8mAQITKw//cw2b8tsL+Oql2Cht+hpSJYio8yR7uCUo
/eAPW4RY5zclsAP8ZJD6+sby7mD/pt7zBnRU5W3xWmVbVLDeTO+pyCPGNFH7cLPp
MDbQvDAx/gSZRWv0yNn1yinSlL9FR2LMaL+XBH2VF4IG4T3L/n0+cjBJ0V+9oHdf
9zUx/egZEschd0D4uZ0/8W6nnVkptcFU2lIgYqLQLW66nBRmjpymti46ndFxLAGG
XZKBmhniHQF3k/JMFPA/dSlENk8zKhj79Z0XJD1hgjJqUS1ru0LytFlRr2UnQ5PY
OlKqQ5nQ7vWMzNcdv/XvIYqnGP+Ok6xb+EsQDJ05RZGCAJLMeLDWXh4lrPJTQbDM
wDPrPW3PzirWJbKIRQNkhipl6vgSsMEvCizH2BY55nEoDxDn62s8F91uXBHQJd/q
mTFRMslj5hGuZSZqo/dIF3NqskwA5LMh2nZv7lu+rRazNv1d3tj2ooS76+6yb0J9
xhSDkgkYMxd18fSUmE4rhpsktKskFN4asR2jL/H/4Hiv7Lvo+hsAa72cxU8WO5jg
/ae5fANcU4xKkkcr/HgTOim7CxIA3y7RbmfI81aYRzeO4rUmxVr5CcTgSWDK5gys
/IlvTRf6Q0LblsiIPjn/6cSZ9eJZjOcEdSy68JUlrkcaLbohLTOP59bYrq4Gz40+
oX4mslpnDPg=
=Wgs7
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
