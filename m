From: Jason Wever <weeve@gentoo.org>
Date: Thu, 18 Aug 2005 23:10:02 +0000
Subject: Re: Questions on CPU frequency drivers for UltraSPARC IIe and III
Message-Id: <Pine.LNX.4.63.0508181707510.21758@stargazer.weeve.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817221559.71501529@enterprise.weeve.org>
In-Reply-To: <20050817221559.71501529@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 18 Aug 2005, David S. Miller wrote:

> From: Jason Wever <weeve@gentoo.org>
> Date: Thu, 18 Aug 2005 07:50:58 -0600 (MDT)
>
>> Everything looks good now with this patch on both the Blade 100 and Blade
>> 1000.  Thanks!
>
> Thanks for testing :-)
>
> Stupid question... have you actually tried to change the
> frequency either manually or with a daemon like "cpuspeed"?
> That might be interesting :)

cpufrequtils includes tools to either change the speed manually or set a 
governor to do so.  I've used the tool to set the governor to "ondemand" 
on the Blade 1000 and it seems to work fine (the cpufreq-info tool reports 
both CPUs running at 23.4 MHz when idle).   I can set the governor as well 
on the Blade 100 but I haven't seen if the CPU frequency scales down yet 
as I've had it busy compiling things all day.

Cheers,
- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDBRVLdKvgdVioq28RAnkpAKCKghR5/w3fUG2UVcoelx0Xg2scOwCffAYt
g880CDGkzSR9MqqB48OBPKY=S9C6
-----END PGP SIGNATURE-----
