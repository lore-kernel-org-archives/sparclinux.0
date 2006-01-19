From: "Mark Fortescue" <mark@mtfhpc.demon.co.uk>
Date: Thu, 19 Jan 2006 18:30:48 +0000
Subject: RE: UFS Write Support
Message-Id: <DGEKIABPPPEBAOMKAJCEKEELCBAA.mark@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <43CFD016.70600@jg555.com>
In-Reply-To: <43CFD016.70600@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

My experience is that it is very dangerous.

This may be partly because I am trying to write to a Sunos 4.1.1 BSD 4.2 UFS
filing system so I have had to make some changes but I suspect that this is
not the only thing as the alterations I have made should have taken care of
all the issues regarding the Sunos 4.1.1 version of UFS.

My first attempt to get it working exposed a fault that resulted in the
directory being lost on file creation (2.6.8.1 on Sparc [32]).
More recently, file creation seems to have been sorted out but changing the
size of a file hung the kernel (2.6.10 on ix86).

One big issue is an appropriate fsck.ufs program to fix any errors generated
by kernel crashes. The ones I have found do not lend themselves to the Sunos
version of BSD 4.2 UFS. As a result I have not done much work on finding out
what is failing in the UFS module.

I am testing the UFS code out using /dev/loop0 and a floppy disk image
created under Sunos 4.1.

If you have the time to investigate the current status of the module, I
suggest that this sort of approach should be used as if there is a problem,
the floppy image can quickly be restored to a known valid filing system to
allow any fixes to be tested, and you can try out various different flavours
of UFS by creating floppy disks/images using the appropriate OS/commands.

 If you find that it works for your flavour/version of UFS I would be
interested to know as I would like to use UFS on my Sparc.

Regards
	Mark Fortescue


-----Original Message-----
From: sparclinux-owner@vger.kernel.org
[mailto:sparclinux-owner@vger.kernel.org]On Behalf Of Jim Gifford
Sent: 19 January 2006 17:45
To: sparclinux@vger.kernel.org
Subject: UFS Write Support

What is the current status of UFS write support in the kernel? Is it
been actively maintained or is it a dead?

--
----
Jim Gifford
maillist@jg555.com

-
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

