From: Chris Ricker <kaboom@gatech.edu>
Date: Wed, 07 Apr 2004 17:39:22 +0000
Subject: non-PROM console and Permedia
Message-Id: <Pine.GSO.4.58.0404071329010.1810@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I've been toying with an Ultra 60 I ran across which has a cruddy Permedia 2
video card in it:

0000:02:01.0 Display controller: Texas Instruments TVP4020 [Permedia 2] (rev 
11)

Under 2.4, it comes up fine using the frame buffer.

Under 2.6 (trying with 2.6.5), I can't get it to come up with the frame 
buffer. Every combination of compile options relating to the frame buffer 
just causes it to hang after displaying "Booting Linux...". If I disable all 
the frame buffer support and just leave the PROM console, that works.

Am I just missing the exact combination of compile options needed, or did 
the Permedia 2 framebuffer console support break between 2.4 and 2.6?

thanks,
chris
