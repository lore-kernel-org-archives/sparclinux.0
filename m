From: Jason Wever <weeve@gentoo.org>
Date: Wed, 31 Mar 2004 00:21:08 +0000
Subject: Re: Compiling sunlance as a module
Message-Id: <20040330172108.351d4813@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__30_Mar_2004_17_21_08_-0700_548dLlyoK=pAP7jm"
List-Id: <sparclinux.vger.kernel.org>
References: <20040330234412.GB5439@artsapartment.org>
In-Reply-To: <20040330234412.GB5439@artsapartment.org>
To: sparclinux@vger.kernel.org

--Signature=_Tue__30_Mar_2004_17_21_08_-0700_548dLlyoK=pAP7jm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 30 Mar 2004 18:09:24 -0600
"Art Haas" <ahaas@airmail.net> wrote:

> My main computer is an old Pentium computer, and I have an ethernet card
> using the 8139too driver, and this machine doesn't have any problem
> loading the module, and I haven't (knowingly) done anything special to
> load it prior to the machine bringing up the eth0 interface. It would
> not be surprising if my problem is a configuration error, but when I
> compare my sparc-configuration to the i386-configuration, things look
> similiar in the networking type areas.

Are you running hotplug on the i386 box?  That can result in the module
being auto-loaded as well as any other automatic hardware detection
software.

If the kernel is auto-loading the module without outside assistance, I'd
be interested to know how that works.

-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature=_Tue__30_Mar_2004_17_21_08_-0700_548dLlyoK=pAP7jm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAag70dKvgdVioq28RAsyxAKCzGBP26FGf7ekgNOVpaoJjob4G5QCcCdKy
nVZfgBDlDmuwvnzDqtv4OLE=
=asKP
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Mar_2004_17_21_08_-0700_548dLlyoK=pAP7jm--
