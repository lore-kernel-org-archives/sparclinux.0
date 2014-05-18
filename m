From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 18 May 2014 17:32:15 +0000
Subject: Re: format string mismatch in arch/sparc/kernel/sysfs.c
Message-Id: <20140518173215.GA6040@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <5378BB37.2000402@gmx.de>
In-Reply-To: <5378BB37.2000402@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Torlaf.

> I'm just wondering if the format mismatch error is intentionally left in the code or not :
> 
> [arch/sparc/kernel/sysfs.c:154]: (warning) %ld in format string (no. 1) requires 'long *' but the argument type is 'unsigned long *'.

This is something we should fix.
My gcc does not give this warning - how did you produce the warning above?
Also we use -Werror on purpose to catch warnings so they get fixed - so
your build should have errored out.

Do you care to send a patch so you get proper attribution.

	Sam
