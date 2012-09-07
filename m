From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 07 Sep 2012 08:33:58 +0000
Subject: Re: [PATCH] silo: Don't touch %tick_cmpr on sun4v cpus.
Message-Id: <20120907083358.GA6551@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120815.011416.353619816610212386.davem@davemloft.net>
In-Reply-To: <20120815.011416.353619816610212386.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Aug 19, 2012 at 03:29:59PM -0700, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sun, 19 Aug 2012 23:29:05 +0100
> 
> > On Sun, Aug 19, 2012 at 03:24:45PM -0700, David Miller wrote:
> >> From: Jurij Smakov <jurij@wooyd.org>
> >> Date: Sun, 19 Aug 2012 16:41:42 +0100
> >> 
> >> > I just uploaded a new silo package (1.4.14+git20120819-1) including 
> >> > these fixes to unstable, and would encourage everyone to test it (it 
> >> > should appear on the mirrors within a few hours). After a grace period 
> >> > of 10 days we are going to arrange for its propagation to testing, 
> >> > given that no problems are reported.
> >> 
> >> Thanks a lot Jurij.
> >> 
> >> Just FYI I also pushed a ext4 fix into the SILO tree yesterday
> >> after I received positive feedback from a bug reporter.
> > 
> > This fix is included in the latest uploaded version as well.
> 
> Excellent.

The new silo has propagated to testing and should be used in this 
installer image:

http://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/sparc/iso-cd/debian-testing-sparc-netinst.iso

If you could give it a try to confirm that it now boots successfully 
on your machine, it would be appreciated.

Thanks.
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
