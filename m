From: joshk@triplehelix.org (Joshua Kwan)
Date: Mon, 19 Apr 2004 16:08:41 +0000
Subject: CONFIG_I2C on sparc64
Message-Id: <20040419160841.GL30964@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XigHxYirkHk2Kxsx"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey everyone,

I'm dealing with 2.4 sparc kernels for Debian and getting unresolved
symbols in everything involving i2c, for example:

depmod: *** Unresolved symbols in /lib/modules/2.4.26-sparc64/kernel/driver=
s/media/video/tuner.o
depmod:         i2c_detach_client_R13852119
depmod:         i2c_attach_client_R29fbc42c
depmod:         i2c_master_recv_R7bd34477
depmod:         i2c_add_driver_R64fc78c7
depmod:         i2c_probe_Red036271
depmod:         i2c_del_driver_Re73c7489
depmod:         i2c_master_send_Rbcec30fe

I tried adding source drivers/i2c/Config.in in arch/sparc64/config.in
and enabled I2C and the bit-banging interfaces. This appears to have
worked just fine...

So am I missing something here? Why has this been overlooked since
2.4.24?

--=20
Joshua Kwan

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQIP5h6OILr94RG8mAQL4Dg/7B52OcCh6bX8bjnz1Zqs2iUgu2qJZAQnJ
hKjKnTyLCrjJ0FQ1RoM2EX9so0OPz2UUz1lL3hvgccWKadrMpiHIDaYsUvDA/8Bv
85jZMt9WV/BSzLkHGnyXxkXp1mH7UQlSG/yD+HvWQJesbusHj5Zw/a/ZnHA/ThLa
eTTyjIUhrRRuEr73Dvec7lPZmI2OEDpQcO3xMa6H9H007WUJfiWL8loFQIj2YgB+
Vx6jbJrXfF8EHOpH88cgOcs2IXJIdmuBsCgI1HmrzbdOd6sTzWshEolP7e4d6HKi
Bi+peZxKDPh8iHEc2T33tNp2Z3dLJutUquQ3N4FPg1acMViI2/ndLFY/jotYkgB/
kyVETCZwgiocujbuHui24XResJNmHe4qGbi6t1Dr6ynAJjXShPzGXt+sVzTl0j3I
Tl/QJ516NqtIAPcBmucAXD0HSeaSTwBn7SRfVKlqUYhxbcgsHDBW79eEKK20cWt0
+VQqcoYV8nQBb4cygJV3zlyAH+DesSUXtgqCLe4lYekO8SdLkuvAV5bXj8kFfhVu
cm02ps9950T9YqhbkNcT7vYxcfrUo64SjEVkDsg04wogSf0c25aygAIkJjyzhAWD
cvRfoESsQpR2RtogRkanHFq0NMbsLkAnKGGT8r86aGaKAcS7snXzkqDBJD3Psrve
ANIRL2Ou5WU=
=kX47
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--
