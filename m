From: Chris Newport <crn@netunix.com>
Date: Thu, 03 Mar 2005 16:25:16 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <42273A6C.4010704@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dennis Jenkins wrote:

>Does this mean that I will be able to successfully
>compile a 2.6 kernel using gcc 3.3.5 on my sparc64
>gentoo box?  Yeah!
>
>now.. If only I (or someone) could fix the fcal/socal
>driver.  I even tried using the socal_asm.h firmware
>patch derived from the Solaris 10 "socal" firmware. 
>No luck. :(
>  
>
First check if you should be using the soc or socal drivers.
A handbook search at sunsolve for the barcode on your board will
tell you if it is FC/25 or FCAL - just take the first 7 chars and insert
a dash like this 501-1234.  The  SSA1xx  arrays with 3 pull-out drawers
each containing 10 drives need the soc card and drivers. Later arrays 
such as the A5000 need the socal card and drivers.

The soc/pluto stuff has not been maintained since 2.2.x and AFAIK this 
is also true for socal.

Take a look at http://www.splack.org/fibrechan.html for the lowdown on
how to get soc working on 2.2.x, once you have that working it should
be possible to port the existing drivers to 2.4 and then 2.6.

