From: Patrick Finnegan <finnegpt@purdue.edu>
Date: Sun, 09 May 2004 15:34:31 +0000
Subject: Re: sun4c (SS IPX) serial console problem/strangenes.
Message-Id: <200405091034.31613.finnegpt@purdue.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <200405091508.29649.rezso@rdsor.ro>
In-Reply-To: <200405091508.29649.rezso@rdsor.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Balint Cristian declared on Sunday 09 May 2004 07:08 am:
> 	I tryed with/without video=sbus:off with/without console=ttyS0,9600
> with monitor attached, without monitor attached to trick sense of 13W3
> but _always_ "alloc_io_res(cgsix ram): cannot occupy"

Sun machines use keyboard detection (not monitor detection) to determine 
whether to boot using a serial console or framebuffer+keyboard.  Have 
you tried booting without the keyboard?  Also, can you try removing the 
framebuffer from the system and see what happens?

Pat
-- 
PLUG Vice President & Treasurer       --  http://plug.purdue.org
The Computer Refuge                   --  http://computer-refuge.org
Purdue University Research Computing  --  http://www.itap.purdue.edu/rcs
