From: Gustavo Zacarias <gustavoz@gentoo.org>
Date: Tue, 03 Oct 2006 12:44:36 +0000
Subject: Re: Problems with qla2xxx drivers in recent kernels
Message-Id: <45225B34.4000605@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20061003045359.GA4269@droopy.oc.cox.net>
In-Reply-To: <20061003045359.GA4269@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jurij Smakov wrote:

> Hi,
> 
> The qlogicfc driver has been removed starting with 2.6.17, and qla2xxx driver was 
> supposed to replace its functionality. By now we have received a couple of 
> reports, stating that the qla2xxx drive in 2.6.17 and 2.6.18 does not detect the 
> drives in SunFire 280R [0] and SunBlade 1000 [1], which qlogicfc in 2.6.16 works 
> fine. I wonder whether this problem is known, and if it is, whether there are any 
> plans to resolve it. 

Did you build said kernels with CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE
enabled? From what we've seen it's required for them to work on those
machines.

- --
Gustavo Zacarias
Gentoo/SPARC monkey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFIls0V3G/IBCn/JARAgvsAJ9wLFlDT16S7X89VOak4brChBhTUwCfQOjj
4WMVynfgSrzCccyKPIxsenI=3uhn
-----END PGP SIGNATURE-----
