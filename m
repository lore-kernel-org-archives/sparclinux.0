From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 29 Jun 2006 20:27:58 +0000
Subject: Re: booting the T1000
Message-Id: <1151612878.5166.1.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <200606290937.49481.rene@exactcode.de>
In-Reply-To: <200606290937.49481.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2006-06-29 at 09:37 +0200, Rene Rebe wrote:
> Hi all,
> 
> I gave the current Ubuntu boot image a try on a T1000. The file I got has this
> md5sum:
> 
> 49f61b1efbc662b4f12061a9571ac65b  boot.img
> 
> I used the existing arpd and hpa-tftpd setup to network boot that new box, but
> the box does not appear to like loading the kerne image.

Try this:

T2000 fails to net boot from a Linux tftp boot server 
ALOM issues a broadcast not the ip of the tftp server 
Introduced in OBP 4.17 as part of WANboot project 
Workaround is to force OBP to transmit an ip address:

setenv network-boot-arguments rarp,file=tftp://10.20.30.40

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

