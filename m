From: Vincent Cojot <coyote@step.polymtl.ca>
Date: Thu, 08 Apr 2004 19:52:10 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <Pine.GSO.4.58.0404081542420.23673@step.polymtl.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 8 Apr 2004, David S. Miller wrote:

> > On Thu, 8 Apr 2004, Alexey Nezhdanov wrote:
> >
> > > Unfortunately it seems that I've already tryed it with the same result. Can
> > > you please send me md5 of your file?
> > > Mine is
> > > b85b3eb7ba3176745b60fa1f47b03bc3  aurora.img
> >
> > raistlin@thorbardin:[~][1008]$ md5sum  /tftpboot/tftp64.img
> > b85b3eb7ba3176745b60fa1f47b03bc3  /tftpboot/tftp64.img
> >
> > It's the same image.. (Sorry, I had missed that part in your message...)
>
> I think it's the graphics card, you probably are using one we
> don't have any drivers for yet.  What's in the machine?

Alexey has both an M64 and an Expert3D-Lite in his sb2k machine and
they're both pretty standard so I guess it -should- work for him, at least
via a serial install. I suggested to him on #sparc that he removes both
cards and tries a serial install again..

On my side, I have an XVR-1000 (MAJC5200) in my sb2k so it shouldn't work
but in fact it does.. :) I always got the 'Fast data access MMU miss' at
the console when netbooting but I have reproductibly installed Aurora 1.0
from CD-ROM on my machine (netbooting worked fine too) by using the ttya
serial port. Once I got it installed on a SCSI disk, the console started
working in text mode just fine with my SUN Type-6 USB keyboard and
logitech mouse..

,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'`^`'~*-,
Vincent S. Cojot, Computer Engineering. STEP project. _.,-*~'`^`'~*-,._.,-*~
Ecole Polytechnique de Montreal, Comite Micro-Informatique. _.,-*~'`^`'~*-,.
Linux Xview/OpenLook resources page _.,-*~'`^`'~*-,._.,-*~'`^`'~*-,._.,-*~'
http://step.polymtl.ca/~coyote  _.,-*~'`^`'~*-,._ coyote@step.polymtl.ca

They cannot scare me with their empty spaces
Between stars - on stars where no human race is
I have it in me so much nearer home
To scare myself with my own desert places.       - Robert Frost


