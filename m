From: Frans van Berckel <fberckel@xs4all.nl>
Date: Mon, 03 Jan 2011 19:52:29 +0000
Subject: Re: Sun Fire V440 fan control
Message-Id: <1294084349.1549.91.camel@deblnxsrv222>
List-Id: <sparclinux.vger.kernel.org>
References: <1294070842.1549.53.camel@deblnxsrv222>
In-Reply-To: <1294070842.1549.53.camel@deblnxsrv222>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2011-01-03 at 09:32 -0800, David Miller wrote:
> I have an implementation I wrote 2 years ago which ought to cover
> those devices, but they need a bit of dusting off and reworking
> the integrate the I2C controller driver properly into the tree.

That would be nice, in your spare time left :) But today's kernel (-35
-36 -37) does not boot with this server. That's because the screen
freezes after switching the console line.  I know, have to hookup a
serial console for seeing what goes on. But still hope fixing that, so I
will be able to help you with testing this new I2C controller driver.

Thanks,


Frans van Berckel

