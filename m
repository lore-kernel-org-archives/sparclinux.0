From: "C.Newport" <crn@netunix.com>
Date: Thu, 18 Mar 2004 01:00:54 +0000
Subject: Ultrasparc 2 SMP 2.4.26-pre4 fails
Message-Id: <200403180100.54517.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I am having problems getting 2.4.x to work in SMP mode on my 
Ultra2 Creator. 2x 300MHz, 384Mb

The story so far :- 
System has 2.2.20-pre2 SMP installed, this works fine.
Built 2.4.25 using default config, boot fails locking up solid at
 Remapping the kernel... done.
 Booting Linux...
 Starting CPU 1...

At this point Stop-A does not work, so the lockup is really tight.
Reboot with maxcpus=1 works fine.

Patch to 2.4.26-pre4, rebuild, same symptoms.
gcc --version
 2.95.3

Am I wasting my time trying to get 2.4.x SMP working ?, checking
back in the list, others seem to have had similar problems but the
fixes seem to refer to 2.6 only.

I could do more testing but this would need the latest SILO, the
above kernels are stripped because the default config is too big.

Thanks,
Chris Newport
 

