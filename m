From: David Miller <davem@davemloft.net>
Date: Fri, 16 May 2008 23:53:49 +0000
Subject: [PATCH 0/2]: Niagara2 RNG driver.
Message-Id: <20080516.165349.255632578.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org


These next two patches implement the RNG driver for Niagara2.
They are also available on the master branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/davem/n2rng-2.6.git

The driver transparently works on both control and guest nodes in
virtualized environments.

I've testedit on both single and dual socket Niagara2 systems, and
rngd seems to be happy with the output.  Below is a typical driver
load and rng stats message log.

Signed-off-by: David S. Miller <davem@davemloft.net>

--------------------
[1102905.419644] n2rng.c:v0.1 (May 15, 2008)
[1102905.419687] n2rng f027a3c8: Registered RNG HVAPI major 2 minor 0
[1102905.419707] n2rng f027a3c8: Found Victoria Falls RNG, units: 2
[1102905.423798] n2rng f027a3c8: Selftest passed on unit 0
[1102905.432773] n2rng f027a3c8: Selftest passed on unit 1
[1102905.432813] n2rng f027a3c8: RNG ready
--------------------
May 16 16:34:07 maramba rngd[4674]: stats: bits received from HRNG source: =
500064
May 16 16:34:07 maramba rngd[4674]: stats: bits sent to kernel pool: 440512
May 16 16:34:07 maramba rngd[4674]: stats: entropy added to kernel pool: 44=
0512
May 16 16:34:07 maramba rngd[4674]: stats: FIPS 140-2 successes: 25
May 16 16:34:07 maramba rngd[4674]: stats: FIPS 140-2 failures: 0
May 16 16:34:07 maramba rngd[4674]: stats: FIPS 140-2(2001-10-10) Monobit: 0
May 16 16:34:07 maramba rngd[4674]: stats: FIPS 140-2(2001-10-10) Poker: 0
May 16 16:34:07 maramba rngd[4674]: stats: FIPS 140-2(2001-10-10) Runs: 0
May 16 16:34:07 maramba rngd[4674]: stats: FIPS 140-2(2001-10-10) Long run:=
 0
May 16 16:34:07 maramba rngd[4674]: stats: FIPS 140-2(2001-10-10) Continuou=
s run: 0
May 16 16:34:07 maramba rngd[4674]: stats: HRNG source speed: (minB5.351; a=
vgV0.278; max314.314)Kibits/s
May 16 16:34:07 maramba rngd[4674]: stats: FIPS tests speed: (mini9.644; av=
g=9559.709; max 302.755)Kibits/s
May 16 16:34:07 maramba rngd[4674]: stats: Lowest ready-buffers level: 2
May 16 16:34:07 maramba rngd[4674]: stats: Entropy starvations: 0
May 16 16:34:07 maramba rngd[4674]: stats: Time spent starving for entropy:=
 (min=3D0; avg=3D0.000; max=3D0)us
