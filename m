From: joshk@triplehelix.org (Joshua Kwan)
Date: Sun, 04 Apr 2004 05:38:37 +0000
Subject: netbooting with a HME
Message-Id: <20040404053837.GB5698@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been trying to boot my SS10 over the network with the new HME card
I've just received. After lots of screwing around I discovered that it
required me to use a crossover cable to be able to successfully netboot,
as opposed to having a hub inbetween the HME and the boot server, where
the PROM would complain about a Timeout waiting for ARP/RARP packet. I
read in a few places that this might have to do with the fact that my
hub is autosensing. Is there anything I can do with the PROM to make
this work?

Thanks,
--=20
Joshua Kwan

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQG+fXKOILr94RG8mAQLGyhAA96zJRL22056BE8Q9OiZlWeMRdylzu0Us
ifY79phhZYDicMFpo5Gv+gpb9Yu/SCWnClzqyDt0llkJgTlAHEPMrLf7cmQ6EBkZ
B4CoOmZLdkv4bBmkY37IW6VgWCNXvZ6avRW8PEKrZ+0Krw960hCyoC75cuIJcZy3
928pDql0UTWLl2YLpFcfXDwc21THwWYWHO2MNa8luVtn9M+2tD3c7lkS/KbTFMzq
95DlPWw8PZKGZ4bNsA5pTAZyrhFa1QMYOTWnwUAJU5HRzUnA1rfP0Do1362OYapn
+zbH2gknyT9AS50D+4MhLTvMs7TjLjyWYGVrcgd2LCBCm9CeKdPCjJKZEHEGU4/0
Vf0cbjr7dlcTQyQ9gio5Ym3hG/Um7xL3868jd0Mc9IrSvC5hjBwhNPh82wsK2k+l
pl1gUkGGP7/1NQu7T77OToXyCXEMHTnvJFObL7EOfYYScUMlYi/xVjtD+/dBT4eP
hEF4LnTWUqnvVMylv940s3PcPIewdCYR7hzEWiYWlafFiqZU0laG1KN/gSRcjaQl
fwjh3OC8KFDyhumAoVANHRaypUP/TJITK0jSSwL8uZ5wdbHkfcmipzbsLuve3rZK
5Xe4HWofFYLXQW+KzrWFm6tyuIECocb2924OORs4XT1j/M6CCPfq6PE9LaxCtF5d
kjGpPEW6a1U=
=TSg2
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
