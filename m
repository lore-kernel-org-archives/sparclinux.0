From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 29 Jun 2006 17:08:56 +0000
Subject: Re: [PATCH] sparc: remove sunzilog_console_init
Message-Id: <20060629170856.GB4800@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20060628141601.GA31139@palantir8>
In-Reply-To: <20060628141601.GA31139@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jun 28, 2006 at 10:05:52AM -0700, Raymond Burns wrote:
> Hi
> 
> Odd but I went the other direction, I added the line:
> 
> console_initcall(sunzilog_console_init);
> 
> near the bottom of the sunzilog.c file.

Yes, that would work too. Basically restoring part of the 2.6.16 code.

> which removes the compiler warning but did not solve the trouble I
> have where /dev/console cannot be opened: 
> 
> Warning: unable to open an initial console.

This is probably an different issue then. Best start a new thread
and post the console output, kernel version, if you're using udev
or devfs, 'ls -l /dev/console'.

> Someone has went to length to rewrite a fair portion of the serial
> code to attain compatability with generic handling of serial ports.
> 
> What direction is serial port code going now?

I don't know what the intention behind it all is. I just do some local
fixing/optimizing where I see fit and can contribute.

-- 
Martin
