From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 16 Mar 2007 19:47:00 +0000
Subject: Re: sparc32 esp connected CDROM failures
Message-Id: <1174074420.3628.33.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1173976389.16911.13.camel@dhcp-32-109.ord.redhat.com>
In-Reply-To: <1173976389.16911.13.camel@dhcp-32-109.ord.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2007-03-15 at 18:01 -0700, David Miller wrote:
> From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
> Date: Thu, 15 Mar 2007 11:33:09 -0500
> 
> > While this isn't technically a blocker for Aurora, its a rather big
> > annoyance. Not sure where to look on how to fix this one, but very
> > willing and able to test. First test will be with a gcc34 built kernel
> > to rule out compiler.
> 
> Let me see if the same bug triggers with current trees on my
> sparc64 sbus machines.  I tested those, but I don't think I
> hit CDROM's.  :-/

Dusted off an Ultra1 to test this, and I get the following from dmesg:

sr 0:0:6:0: CD-ROM           TOSHIBA  XM-5401TASUN4XCD 1036 PQ: 0 ANSI:
2
esp0: target 6 asynchronous
sr0: scsi-1 drive
Uniform CD-ROM driver: Revision: 3.20
sr 0:0:6:0: Attached CD-ROM sr0
sr0: CDROM (ioctl) error, command: <6>Get configuration 46 00 00 00 00
00 00 00 20 00
sr: <<DEFERRED>> [descriptor]: sense key=0xf
    <<VENDOR>> ASC=0xf8 ASCQ
SC=0xf8 ASCQ=0x0

The ioctl error repeats once more in the sequence...but the CDROM seems
to work ok, as compared to sparc32, where it refuses to work.

Hmm.

~spot

