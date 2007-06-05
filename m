From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 05 Jun 2007 08:42:06 +0000
Subject: Sun Floppy Driver
Message-Id: <Pine.LNX.4.61.0706050931200.6872@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

My sun4c SS1 Clone has a 'pre-1991 82077' FDC. I have patched my kernel so 
that it alows SS1 to have an 82077 FDC but this would apear to only 
facilitate the FDC detection. Trying to use /dev/fd0 gives block I/O 
errors.

Has any one got experience/sugesgions as to the best way of debugging the 
sun FDC code that they can pass on to me.

Regards
 	Mark Fortescue.

