From: mark@mtfhpc.demon.co.uk
Date: Tue, 21 Aug 2007 10:23:49 +0000
Subject: Re: Re. [SPARC32]: Fix bogus ramdisk image location check.
Message-Id: <E1INQtp-0005in-IC@pr-webmail-1.mail.demon.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46CA19DE.3000108@earthlink.net>
In-Reply-To: <46CA19DE.3000108@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Robert,

Can you put some prom_printf's or printk's in to find out where your initrd ramdisk is ending up. 

The code relies on ordering/alignment in the linker script which is not a good idear so the aim needs to be to create some code that correctly identifies the location of the ramdisk without using hard coded offsets based on '&end' and 2*4096 :). I will have another look at the code later on this week and see if I can work out somthing that does the same thing but with more flexibility in what can be done to the linker script (i.e. does not rely on specific alignments and ordering in the linker script).

The information about where the ramdisk is may present a simple solution.

Regards
    Mark Fortescue.

