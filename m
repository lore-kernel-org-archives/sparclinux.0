From: Jason Wever <weeve@gentoo.org>
Date: Mon, 20 Jun 2005 02:07:12 +0000
Subject: 2.4 kernels and max # of rules with iptables
Message-Id: <20050619200712.036920e1@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Sun__19_Jun_2005_20_07_12_-0600_r7zCy_3lb1wW4EwO"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature_Sun__19_Jun_2005_20_07_12_-0600_r7zCy_3lb1wW4EwO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

I don't know if anyone else has run into this or not, but over in Gentoo
we've had a user report[1] of a "hard limit" as to the number of rules
you can have with iptables on the 2.4 kernels before it starts erroring
out. Currently, it seems that the limit is 857 rules, and the error
given is "iptables: Memory allocation problem".

I've been able to confirm this behavior on 2.4.31 (using
iptables 1.2.11 and 1.3.1) and was able to load more than 10,000 rules
in 2.6.12-rc3 before I gave up.

Current Gentoo userland is using either kernel headers from 2.4.23 (for
stable keywords) and 2.4.26 (for testing keywords).

If anyone has any suggestions or pointers, I'd be glad to hear them.

[1] - https://bugs.gentoo.org/show_bug.cgi?id=3D75668

Thanks,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature_Sun__19_Jun_2005_20_07_12_-0600_r7zCy_3lb1wW4EwO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCtiTTdKvgdVioq28RAihoAJ4rp3TiMumhERT8SLrh/3Uif1Kk+QCdGD95
G+XQnn8fddAgk5KTnipLh6Y=
=eyi0
-----END PGP SIGNATURE-----

--Signature_Sun__19_Jun_2005_20_07_12_-0600_r7zCy_3lb1wW4EwO--
