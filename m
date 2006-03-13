From: Jason Wever <weeve@gentoo.org>
Date: Mon, 13 Mar 2006 04:59:04 +0000
Subject: Re: ESP busted
Message-Id: <Pine.LNX.4.64.0603122155450.10262@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060309.131637.114886710.davem@davemloft.net>
In-Reply-To: <20060309.131637.114886710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 12 Mar 2006, David S. Miller wrote:

> From: Jason Wever <weeve@gentoo.org>
> Date: Sun, 12 Mar 2006 20:14:25 -0700 (MST)
>
>> With gcc-3.3.5 and gcc-3.3.6, esp works fine with or without the patch on
>> 2.6.16-rc6.  If gcc-3.4.5 is used to compile 2.6.16-rc6, the patch does
>> not really appear to change anything as the esp errors happen with or
>> without it.
>
> I thought the ESP errors appeared with gcc-3.3.x, why were
> you testing any of my patches with that compiler if that was
> not the failure case to begin with?

From the original testing I did, it appears that gcc-3.4.5 is the 
problematic one.  The reason I tested against gcc-3.3.x was because that 
appeared to be what you and Josh were working with during this past week.

Cheers,
- -- 
Jason Wever
Gentoo/Sparc Team Co-Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEFPwbdKvgdVioq28RAvVpAKCsCFKAbQUnL7H8ElWLnSGD5CXMvwCfejG1
GyJQFUkeFy0ejtEk9n6e0dM=R9f5
-----END PGP SIGNATURE-----
