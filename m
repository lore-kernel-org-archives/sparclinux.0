From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 04 Jun 2012 20:44:30 +0000
Subject: Re: sparc32: some more testing
Message-Id: <20120604204430.GA28421@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jun 04, 2012 at 10:09:42PM +0200, Marcel van Nies wrote:
> Hi,
> 
> I forgot to attach the patch to revert commit
> 4d14a459857bd151ecbd14bcd37b4628da00792b.

Just a random guess...
Try to drop the tsunami special blockops to see 
if that has any effect.

Just comment out this line:

	hypersparc_setup_blockops();

in srmmu.c

That function replaces a few functions in lib/blockops
with hypersparc optimized versions.

I assume the effect is none - but it could be good to know.
Next step would be to try to be less optimal in the various flush
functions - but I do not yet feel comfortable enough to provide
you with a patch to do this.

I had something cooked up myself that just did flush_all for all
of the operations. But this was not the issue here so I dunno if
that has any effect or if it worked at all.

	Sam
