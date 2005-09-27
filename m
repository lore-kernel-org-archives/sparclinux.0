From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Date: Tue, 27 Sep 2005 21:18:59 +0000
Subject: Re: [sparc32] Kernel module to control front LED
Message-Id: <20050927211859.GD15421@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050826192113.02c642a4@huginn.midgard.yggdrasill>
In-Reply-To: <20050826192113.02c642a4@huginn.midgard.yggdrasill>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Em Tue, Sep 27, 2005 at 01:28:28PM -0700, David S. Miller escreveu:
> From: Metalhead <metalhead@metalhead.ws>
> Date: Fri, 26 Aug 2005 19:21:13 +0200
> 
> >  I've written a kernel module that allows you to control the fron
> > LED on Sparcstations via /proc. It can also be compiled into the
> > kernel, supporting display of the system load (a la NetBSD and
> > OpenBSD) then.
> >
> > Please find the patch against a vanilla 2.4.30 tree included. The
> > sources and the patch can also be found at
> > http://www.metalhead.ws/led.tar.gz.
> 
> Thanks for the submission, looks cool.
> 
> Can I suggest one cleanup?
> 
> +	} else if((*buf > '0') && (*buf <= '9')) { /* 0 would cause division by
> +						      zero */
> +		for(l = 0; *buf != '\0'; buf++) { /* convert to number */
> +			l = 10 * l + (*buf - '0');
> +		}
> +		print_debug("Starting to blink...");
> +		led_blink(l);
> 
> The kernel has a library function called simple_strtoul() which
> you should probably use instead of this hand-crafted version.
> 
> Also, when you resubmit with this fixed, please provide a
> "Signed-off-by: " for yourself so that I can apply your patch.
> 
> Thanks a lot.

Is this in any way similar to what the guardian service processor in
PARISC64 machines provide? I.e. one can see what the leds in the machine
front panel remotely :-)

- Arnaldo

GSP>
********** VIRTUAL FRONT PANEL **********
System Boot detected
*****************************************
LEDs:  RUN      ATTENTION     FAULT     REMOTE     POWER
       FLASH    FLASH         OFF       ON         ON
LED State: Running non-OS code.  Non-critical error detected.
Check Chassis and Console Logs for error messages.

platform                  config                  
