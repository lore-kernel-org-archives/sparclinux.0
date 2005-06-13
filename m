From: Jason Wever <weeve@gentoo.org>
Date: Mon, 13 Jun 2005 22:43:15 +0000
Subject: Re: Working config wanted for 2.6.11, Ultra 5, sparc64
Message-Id: <Pine.LNX.4.63.0506131640370.24772@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
In-Reply-To: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 13 Jun 2005, David S. Miller wrote:

> From: Jason Wever <weeve@gentoo.org>
> Date: Mon, 13 Jun 2005 14:56:49 -0600 (MDT)
>
>> As for LCDs, in times past to get my Samsung 17" LCD to work, I had to
>> specify both an OBP level resolution and refresh rate as well as in the
>> kernel arguments for the atyfb driver (since atyfb doesn't always seem to
>> respect the OBP defined rates).
>>
>> The OBP setting that worked in my case was
>> output-device=3Dscreen:r1280x1024x60 and the kernel argument was
>> video=3Datyfb:1024x768@60 (never did quite get a 1280x1024 console going=
).
>
> Ok.  This is very peculiar because there was a long'ish
> thread where we specifically fixed ATY in the 2.6.x kernel
> to adhere to the OBP settings precisely.

When abouts in the 2.6 series was this?  I used 2.6.6 for a long time on=20
the Blade 100 with this config (due to SCSI lockup issues with a SYMBIOS=20
card in other versions of 2.6) but I haven't tested >=C2.6.11 in a=20
non-headless configuration.

Cheers,
- --=20
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCrgwFdKvgdVioq28RAlx8AKCrTB7V+U2W/peH6OelPv/u57OaLQCggVhy
bIm5yz+oimcJ1KMbqLax2rs=3Dl/Zf
-----END PGP SIGNATURE-----
