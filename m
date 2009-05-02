From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 02 May 2009 10:28:05 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090502102805.GA7054@droopy.oc.cox.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
To: sparclinux@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

+ attachment for real.

On Sat, May 02, 2009 at 11:25:37AM +0100, Jurij Smakov wrote:
> On Tue, Apr 28, 2009 at 01:44:57AM -0700, David Miller wrote:
> > It won't, most likely because the device name is totally different
> > for Niagara's console device vs. the serial console device used
> > on all other types of boxes.
> 
> Installer's rootskel uses the attached code to detect whether console
> is serial or not (by checking whether ioctl(0, TIOCGSERIAL, buffer)
> succeeds). Can you compile and run it on Niagara's serial console, to
> see whether this mechanism detects it correctly?
> 
> Best regards,
> -- 
> Jurij Smakov                                           jurij@wooyd.org
> Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC

-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC

--qMm9M+Fa2AknHoGS
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="console-type.c"

/*
 * Licensed under GPLv2
 *
 * Adapted for Debian Installer by Frans Pop <fjp.debian.org> from
 * cttyhack from busybox 1.11, which is
 *
 * Copyright (c) 2007 Denys Vlasenko <vda.linux@googlemail.com>
 */

#include <sys/ioctl.h>
#include <stdio.h>

enum { VT_GETSTATE = 0x5603 }; /* get global vt state info */

int main(int argc, char ** argv)
{
	/*
	 * Use an (oversized) dummy buffer as we're not interested in
	 * returned values.
	 * TIOCGSERIAL normally uses serial_struct from <linux/serial.h>
	 * VT_GETSTATE normally uses vt_stat from <linux/vt.h>
	 */
	char buffer[1024]; /* filled by ioctl */

	if (ioctl(0, TIOCGSERIAL, buffer) == 0) {
		/* this is a serial console */
		printf("serial\n");
	} else if (ioctl(0, VT_GETSTATE, buffer) == 0) {
		/* this is linux virtual tty */
		printf("virtual\n");
	}

	return 0;
}

--qMm9M+Fa2AknHoGS--
