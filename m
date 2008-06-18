From: Frans Pop <elendil@planet.nl>
Date: Wed, 18 Jun 2008 16:14:25 +0000
Subject: Re: [PATCH] sparc: correct module name in Kconfig help for SCSI_SUNESP
Message-Id: <200806181814.25654.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <200806171353.49127.elendil@planet.nl>
In-Reply-To: <200806171353.49127.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 18 June 2008, David Miller wrote:
> > Should the help text maybe also mention that it supports SUNW,fas
> > devices? It's still SBUS of course, but it may not be immediately
> > obvious that esp also covers fas.
>
> That might make the help text better, sure.

How about this:

 	   This is the driver for the Sun ESP SCSI host adapter. The ESP
-	   chipset is present in most SPARC SBUS-based computers.
+	   chipset is present in most SPARC SBUS-based computers and
+	   supports the Emulex family of ESP SCSI chips (esp100, esp100A,
+	   esp236, fas101, fas236) as well as the Qlogic fas366 SCSI chip.

Not sure if the chip details are correct, but I suspect you will :-)

If OK, would you prefer a separate patch for this or can you merge it into 
my previous patch?

Cheers,
FJP
