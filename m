From: Mike Hemstock <hemstock@tiscali.co.uk>
Date: Sat, 10 Jan 2004 18:39:58 +0000
Subject: Linux on a SUN E5500
Message-Id: <200401101839.58257.hemstock@tiscali.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi folks,

We have bits of SUN kit lying around at work and I've assembled them to make 
an E5500.  The box has the following:

2x StorEdge D1000 HVD disk carriers with 4 9.1Gb SCSI disks a piece
1x Fibrechannel Enterprise Network Array with 4 9.1Gb disks
Single Ended SCSI IO card 270-3113-30 Rev S 5013113006645

Sbus IO card with:

Fore ATM SBA-200
HVD SCSI C479929A73722
Fibre channel Vixel OE1063SV 370233012343

I have tried to install Debian on this however, it boots the installer and 
then tells me that there are no disks found.  I'm not sure where to go from 
here.  There are a few hardware problems with the box.  I have tried to 
install SuSE and it hangs and Solaris reports memory errors.  I need to do 
some hardware fixing, but I'd like to get a general finger in the air of what 
to expect when trying to build this box.  Does anyone think that Debian will 
support the hardware?  What is the best Sparc Linux for E5500?  Basically I 
just need some advise on getting started.

Many thanks,
Mike.

