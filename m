From: Jason Wever <weeve@gentoo.org>
Date: Fri, 24 Sep 2004 22:56:23 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <20040924165623.54212fd6@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__24_Sep_2004_16_56_23_-0600_9tGcBSe3W1Nu9mdZ"
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
To: sparclinux@vger.kernel.org

--Signature=_Fri__24_Sep_2004_16_56_23_-0600_9tGcBSe3W1Nu9mdZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 24 Sep 2004 13:44:53 -0700
"David S. Miller" <davem@davemloft.net> wrote:

> Jason, see if this patch gets your SB100 working again.
> Thanks.

This definitely did the trick here.  System now boots normally.  Off to
stress test the disk I/O issue.

Thanks!

-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature=_Fri__24_Sep_2004_16_56_23_-0600_9tGcBSe3W1Nu9mdZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBVKYXdKvgdVioq28RAj53AJ9PtSSNxiMtVesYzw2flhsJo3EFyQCfTyY6
5JWxGSmk57KaAfwyBfSrmdM=
=nBLi
-----END PGP SIGNATURE-----

--Signature=_Fri__24_Sep_2004_16_56_23_-0600_9tGcBSe3W1Nu9mdZ--
