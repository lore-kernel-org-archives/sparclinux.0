From: Matthew Smith <matt@kbc.net.au>
Date: Thu, 15 Sep 2005 12:15:53 +0000
Subject: MrCoffee Problem from i386 server
Message-Id: <43296329.1050001@kbc.net.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

I have been trying to get Linux - any Linux - to work with my MrCoffee
Javastation.

My server setup:

Suse Linux 9.2/x86
rarpd V1.1
isc-dhcpd V3.0.1
tftpd V0.39 Release 2.2

MrCoffee is running OpenBoot 2.30 and has 65Mb of RAM.

After a few network problems, which I cleared up with my friend Mr
Tcpdump, the Javastation can get an address and load a boot file.

The problem is that EVERY file I try to send gives the "The file just
loaded does not appear to be executable\nok" error.

My research regarding this messages suggests that the files I am sending
are not in aout format.  However, I question this, as the problem occurs
with the latest version of Prol (which I don't think I really need as
I've got the old firmware), the pre-compiled kernels presented in the
HOWTO and also a Slackware kernel that is supposed to work.

Would all of these have been presented in a non-aout format, or is there
something else going on here, like some sort of file corruption in the
transmission process?

On a related matter - just where does one get elf2aout for Linux/x86?
All the Google references I found were for NetBSD.  I managed to find
one version of elf2aout.c but, when I tried to compile it, I found that
I was lacking a large number of dependencies.

Unfortunately, I don't have any other Sun hardware to play with at the
moment.

Cheers

M

-- 
Matthew Smith
South Australia
http://www.kbc.net.au
