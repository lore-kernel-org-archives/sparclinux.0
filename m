From: David Miller <davem@davemloft.net>
Date: Tue, 03 Jun 2008 22:16:12 +0000
Subject: Re: silo 64mb image
Message-Id: <20080603.151612.236122476.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Tue, 6 May 2008 16:45:10 -0500

> Ive been putting the fedora SPARC development tree on various boxes.  We have 
> silo with the patch to boot up to 64Mb images.  so far i've successfully 
> been able to run it on a Ultra 5, E220R, Netra X1, but  my attempts on 
> SB1000, Ultra Book and T2000 have resulted in the boxes unable to find silo 
> at all.    I don't get as far a S   the box just sits there indefinitely.

If it doesn't get as far as 'S', this means the bootblock is
corrupted.  Nothing in my patch changed the bootblock, nor how it is
installed.

Either your silo was misbuilt or the parameters given to it during
installation were setup incorrectly and this spammed your bootblock.

Also, double-check your boot-device OF environment variable.
