From: Otto Solares <solca@guug.org>
Date: Wed, 28 Jan 2004 20:29:23 +0000
Subject: GEM nic disabled problem
Message-Id: <20040128202923.GD10435@guug.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

i am getting repetitive errors with a Sun GEM nic,
the errors:

eth0: Link down
eth0: MII PHY ID: 437420 Enable Semiconductor
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled

when it exhibits this problem, network traffic
stops for aprox. 5 seconds, then continues to
work again until the problem presents again.

I know for sure that 2.4.18 to 2.4.22 have this
problem.  2.6 fixes the problem, i am running woody
and will not use a 2.6 kernel so if somebody knows
if this is a known issue in 2.4?

-solca

