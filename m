From: Nicolas Boullis <nboullis@debian.org>
Date: Sat, 30 Oct 2004 23:21:57 +0000
Subject: PATCH to fix smbfs on sparc64
Message-Id: <20041030232157.GA5207@tintin>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On sparc64, smbumount fails when called by a non-privileged user 
because the SMB_IOC_GETMOUNTUID ioctl is broken. The attached patch 
solves this and declares the new SMB_IOC_GETMOUNTUID as compatible with 
32-bit userspace. I guss the second part of the patch should be handled 
by this list. How about the first part? Should I send it to the 
linux-kernel mailing-list? Or to the smbfs maintainer directly?


Thanks,

Nicolas Boullis
