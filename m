From: Jason Wever <weeve@gentoo.org>
Date: Thu, 18 Aug 2005 04:15:59 +0000
Subject: Questions on CPU frequency drivers for UltraSPARC IIe and III
Message-Id: <20050817221559.71501529@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Wed__17_Aug_2005_22_15_59_-0600_sH41hmDgtGrihZnY"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature_Wed__17_Aug_2005_22_15_59_-0600_sH41hmDgtGrihZnY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

Was doing some playing around tonight with the CPU frequency drivers in
the 2.6 kernels and noticed a couple of things that I was wondering
about;

1) The max frequency for the CPUs appears to be off by 3 decimal places.
Originally, I had checked with cpufreq-info from the cpufrequtils
package[1], and then later confirmed by checking the
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq file by hand.=20
The values I was getting were 502000000 (502.00 GHz) on a 500 MHz Blade
100 and 750000000 (750.00 GHz) on either CPU in a dual 750 MHz Blade
1000.  I'm guessing this is a problem with how the speeds are being
reported to sysfs?

2) The minimum CPU frequencies possible being reported for the Blade 100
and Blade 1000 are 62750000 and 23437500 respectively.  Are these
accurate (even with the possibility mentioned above being taken into
account)?  They seem a bit low to me (based on what I've seen from the
x86 world).

3) On x86, amd64 and PPC, there exists a file called
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq which shows the
current running frequency of the CPU.  For both the IIe and III cpufreq
drivers, this is missing.  Is there any reason for this (like no good
way to poll the CPUs) or is it just a possible change in cpufreq stuff
that wasn't synced up with sparc?

[1] -=20
http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html

Thanks,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature_Wed__17_Aug_2005_22_15_59_-0600_sH41hmDgtGrihZnY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDBAt/dKvgdVioq28RAnPvAJ4/HR+tPkGDL1HqwO8201f+Nf8yNACePTCC
njRWPSMpiB0osJ1Ok+eTHik=
=gCPn
-----END PGP SIGNATURE-----

--Signature_Wed__17_Aug_2005_22_15_59_-0600_sH41hmDgtGrihZnY--
