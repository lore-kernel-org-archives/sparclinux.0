From: David Miller <davem@davemloft.net>
Date: Wed, 24 Aug 2011 23:17:11 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110824.161711.964317928211562698.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 24 Aug 2011 23:03:24 +0200

>>From your config I can see you have:
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI1563=m
> 
> They both mention ALI7101 in their help text.
> 
> Just to give a hint if this is the casue could you try to disable one
> or both of these to see if this has any effect.

Neither of these drivers should ever be enabled on platforms like
sparc64.  They do direct I/O space writes by decoding the control
register of the SMBBA chip in PCI config space then directly using
that address for I/O port accesses.

Either these drivers need to be written to be more portable else
they need to have appropriate Kconfig guards.
