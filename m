From: sjoerd@spring.luon.net (Sjoerd Simons)
Date: Thu, 11 Nov 2004 11:00:24 +0000
Subject: ioct32 bit compatibilty questions
Message-Id: <20041111110024.GA8836@spring.luon.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

  I'm trying to get ALSA working on my ultra 5 (thatis working with 32 bit
  userspace). With vanilla 2.6.9 the machine just hangs when running alsa
  mixer. 

  After some debugging it seems that some alsa ioctl have a pointer to a
  userspace pointer in their argument struct. When doing a copy_to_user in the
  native ioctl to that address (thus directly to the 32bit userspace program
  while get_fs() = KERNEL_DS), the machine just hangs.  Is this something 
  that can't be done on sparc64 ?

  I've ``fixed'' the SNDRV_CTL_IOCTL_ELEM_LIST to create a buffer and pass that
  to userspace in the handler instead of doing it directly in the native ioctl.
  Is this the right way ? 
  
  At least alsamixer is working now :) Some other ioctl have the same problem,
  that i still need to fix.

  Any advice is appreciated :)

  Sjoerd
-- 
Any sufficiently advanced technology is indistinguishable from magic.
		-- Arthur C. Clarke
