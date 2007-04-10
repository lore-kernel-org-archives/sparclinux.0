From: Jason Wever <weeve@gentoo.org>
Date: Tue, 10 Apr 2007 21:26:04 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <Pine.LNX.4.64.0704101517170.13763@stargazer.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463810780-1814336577-1176239917=:13763"
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810780-1814336577-1176239917=:13763
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.0704101524041.13763@stargazer.weeve.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 10 Apr 2007, David Miller wrote:

> From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
> Date: Tue, 20 Mar 2007 21:53:26 +0100
>
>> =09I have tried the last 2.6.21-rc4. Same bug.
>
> The good news is that I can reproduce this problem now on my
> Ultra2, I'll try to figure out what's wrong.

If it is of any use, I have encountered this issue with an Ultra 1 as=20
well.  I was using a shell script with an endless loop to untar a=20
snapshot of the Gentoo portage tree.

I can provide more details like specific kernel versions tested on the=20
Ultra 1 when I get home if that would be useful to anyone (I know I=20
haven't tested >=3D2.6.18 with it off the top of my head).

Cheers,
- --=20
Jason Wever
Gentoo/Sparc Team Co-Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGHADwdKvgdVioq28RAgAXAJ0dY5RX9zxWqcmwKbTsRVaRu9NaXACeOh+4
xhadk40/MslJ6vWIw9ILwWM=3D
=3Dksxg
-----END PGP SIGNATURE-----
---1463810780-1814336577-1176239917=:13763--
