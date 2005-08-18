From: Jason Wever <weeve@gentoo.org>
Date: Thu, 18 Aug 2005 13:50:58 +0000
Subject: Re: Questions on CPU frequency drivers for UltraSPARC IIe and III
Message-Id: <Pine.LNX.4.63.0508180750260.21758@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817221559.71501529@enterprise.weeve.org>
In-Reply-To: <20050817221559.71501529@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 17 Aug 2005, David S. Miller wrote:

>
> Jason, give this patch a spin, it should clear up the two
> bugs you spotted.
>
> 1) The clock tick values given to the cpufreq layer need to be
>   in KHZ not MHZ.
>
> 2) The us2e/us3 drivers were not providing a "->get()" method which
>   is why the cpuinfo_cur_freq sysfs field was not provided.

Everything looks good now with this patch on both the Blade 100 and Blade 
1000.  Thanks!

- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDBJJEdKvgdVioq28RAr3kAJ9uf4ej/lz05cGsllyCG8Z+cpFiIgCgn4sw
SBVH3ZMfQ8c2kNieWE18DOQ=9Xel
-----END PGP SIGNATURE-----
