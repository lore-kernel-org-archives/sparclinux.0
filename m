From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 29 Nov 2004 23:17:46 +0000
Subject: cups backend/usb ioctl call goes wrong on sparc64
Message-Id: <1101770266.12907.158.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm Running Debian Testing with
cupsys 1.1.20final+rc1-10
kernel-image-2.6.8-1-sparc64

I've found a problem with the cups usb backend on sparc64 systems. The
ioctl32 code isn't translating LPIOC_GET_DEVICE_ID ioctl calls
properly. This means that backend/usb cannot identify which printer is
actually registered as a particular usb device.

The giveaway message from the kernel is

Sep  7 13:22:12 shirehall kernel: ioctl32(usb:1729): Unknown cmd fd(0)
cmd(44005001){04} arg(efffec48) on /dev/usb/lp0

which is caused when running usb.

shirehall:/usr/lib/cups/backend# ./usb
direct usb:/dev/usb/lp0 "Unknown" "USB Printer #1"
direct usb:/dev/usb/lp1 "Unknown" "USB Printer #2"
direct usb:/dev/usb/lp2 "Unknown" "USB Printer #3"
direct usb:/dev/usb/lp3 "Unknown" "USB Printer #4"
...

I see this in the strace output as.

shirehall:/usr/lib/cups/backend# strace ./usb 2>&1 | grep ioctl
ioctl(3, SNDCTL_DSP_SYNC, 0xefffebb8)   = -1 EINVAL (Invalid argument)

or as a numeric value

shirehall:/usr/lib/cups/backend# strace -e raw=ioctl ./usb 2>&1 | grep
ioctl
ioctl(0x3, 0x44005001, 0xefffebb8)      = -1 (errno 22)

I've demonstrated that this is a 32bit binary problem by compiling
backend/usb as a 64bit binary which works fine.

I'm using Debian kernel 2.6.8-1-sparc (although I did see a similar
problem with 2.4.x sometime ago but didn't get chance to
report/investigate).

Now ideally I would say that the way to fix this would be to correct
the ioctl32 code in the kernel but it seems that the
LPIOC_GET_DEVICE_ID ioctl number is dependent upon the structure
passed in.

#  define LPIOC_GET_DEVICE_ID(len)      _IOC(_IOC_READ, 'P',
IOCNR_GET_DEVICE_ID, len)

This could be hardcoded for this specific value but it doesn't seem
very clean.

I'm not sure what the correct way to fix this is. Anyone have any
suggestions.

I'm going to log a Debian bug to track this issue and I've copied
Kenshi Muto the Debian cupsys maintainer.

Richard


-- 
richm@oldelvet.org.uk

