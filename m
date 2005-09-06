From: Jason Wever <weeve@gentoo.org>
Date: Tue, 06 Sep 2005 16:48:20 +0000
Subject: Re: PCI device issues between Blade 100 and Blade 100
Message-Id: <Pine.LNX.4.63.0509061047390.18044@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050904153024.630204cb@enterprise.weeve.org>
In-Reply-To: <20050904153024.630204cb@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 5 Sep 2005, David S. Miller wrote:

> From: Jason Wever <weeve@gentoo.org>
> Date: Mon, 5 Sep 2005 09:41:31 -0600
>
>> Looking at the ehci driver messages, it shows (among other things);
>> ehci_hcd 0001:00:01.2: request interrupt 10,20e failed
>>
>> Then looking for interrupt 10 in /proc/interrupts shows;
>> 10:          0          0  rtc:224
>
> Give this a spin:

This appears to have done the trick, both the USB 2.0 controller and the 
sound card driver load correctly now.

Thanks!
- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHchWdKvgdVioq28RAp20AKC5pIunf8VLEtHq+GP7OQ2N28FKegCfY99W
OUqq2a9NjpsIbNtc3C+ArrMvq
-----END PGP SIGNATURE-----
