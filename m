From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Aug 2011 10:06:34 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110825100634.GB29290@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 24, 2011 at 04:17:11PM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 24 Aug 2011 23:03:24 +0200
> 
> >>>From your config I can see you have:
> > CONFIG_I2C_ALI1535=m
> > CONFIG_I2C_ALI1563=m
> > 
> > They both mention ALI7101 in their help text.
> > 
> > Just to give a hint if this is the casue could you try to disable one
> > or both of these to see if this has any effect.
> 
> Neither of these drivers should ever be enabled on platforms like
> sparc64.  They do direct I/O space writes by decoding the control
> register of the SMBBA chip in PCI config space then directly using
> that address for I/O port accesses.
> 
> Either these drivers need to be written to be more portable else
> they need to have appropriate Kconfig guards.

You mean...

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 646068e..a5d0d7c 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -9,7 +9,7 @@ comment "PC SMBus host controller drivers"

 config I2C_ALI1535
        tristate "ALI 1535"
-       depends on PCI
+       depends on PCI && !SPARC
        help
          If you say yes to this option, support will be included for the SMB
          Host controller on Acer Labs Inc. (ALI) M1535 South Bridges.  The SMB
@@ -21,7 +21,7 @@ config I2C_ALI1535

 config I2C_ALI1563
        tristate "ALI 1563"
-       depends on PCI && EXPERIMENTAL
+       depends on PCI && !SPARC && EXPERIMENTAL
        help
          If you say yes to this option, support will be included for the SMB
          Host controller on Acer Labs Inc. (ALI) M1563 South Bridges.  The SMB

...?

They're all under "PC (sic) SMBus host controller drivers" so maybe
the entire menu should be preventively killed under SPARC?

OTOH the Debian .32 config (from 'stable') includes one of them -
CONFIG_I2C_ISCH=m.

-- 
     2. That which causes joy or happiness.
