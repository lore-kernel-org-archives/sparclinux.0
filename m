From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 31 Dec 2003 23:18:50 +0000
Subject: Re: socal
Message-Id: <20031231231850.GA16561@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 31, 2003 at 02:29:26PM -0800, Aaron Wirtz wrote:

> Does anyone know of a patch that fixes the broken socal/fcal drivers
> under 2.4.x or, failing that, does anyone know what version of the
> linux kernel and the Solaris microcode Jakub was using in the past
> (1999) when he had the driver working?

Microcode, I don't know.  The driver was added in 2.2.4.  That version
doesn't work either.

> As a side note, all of the socal microcode I have seen so far uses
> the full 64kb of data and has none of the null padding at the end
> that Jakub mentioned in his post - this confuses part of the driver
> code (65536 is too big for an unsigned int) so I just cut out the
> code that adds the null padding for

Huh?  The microcode needs to be 64k in size (or less than that if you
chop off the 0s at the end).  If you disassemble the solaris driver
you will see that their ucode is exactly 64k and that the functions
they call to load it expect 64k.  That value fits in an unsigned int
on any sane platform.  Probably you've extracted the microcode
wrongly.

However, you might as well load an ASCII-art rendition of Bill Joy,
since even with the right microcode the driver does not work.  In
fact, I'd recommend it.  Let us know if it helps.

> When I try to load fcal, it complains that there are no devices.
> 
> The same machine runs fine with the solaris socal driver under Solaris 9.

Unless Jakub wants to look at it or you have the manual for this chip
and plenty of patience, forget it.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
