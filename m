From: Balint Cristian <rezso@rdsor.ro>
Date: Sun, 09 May 2004 16:30:43 +0000
Subject: Re: sun4c (SS IPX) serial console problem/strangenes. [keyboard test]
Message-Id: <200405091930.43146.rezso@rdsor.ro>
List-Id: <sparclinux.vger.kernel.org>
References: <200405091508.29649.rezso@rdsor.ro>
In-Reply-To: <200405091508.29649.rezso@rdsor.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sunday 09 May 2004 18:34, Patrick Finnegan wrote:
> Balint Cristian declared on Sunday 09 May 2004 07:08 am:
> > 	I tryed with/without video=sbus:off with/without console=ttyS0,9600
> > with monitor attached, without monitor attached to trick sense of 13W3
> > but _always_ "alloc_io_res(cgsix ram): cannot occupy"
> 
> Sun machines use keyboard detection (not monitor detection) to determine 
> whether to boot using a serial console or framebuffer+keyboard.  Have 
> you tried booting without the keyboard?  Also, can you try removing the 
> framebuffer from the system and see what happens?

Yes of course, tryed with/without keyboard, doesnt known exactly if has/not
monitor detection.

	In a very strange mode with keyboard connected and monitor connected,
and having input = keyboard, output = screen and passing 
"console=ttyS0,9600" worked :) i was able to see serial ongoing at last !

	That was the only working mode, now I am little bit puzzled about how
console work on sparcs.
	And still doubted why in 2.4 work and why not in 2.6 too.

I go test Keith's patch for the io_alloc error, and come in few minutes report succes/fail.

cristian
> 
> Pat
