From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 11 Nov 2005 18:54:09 +0000
Subject: detecting smp systems
Message-Id: <1131735249.2300.21.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In 2.6, it appears that the behavior for SMP systems has changed.

In 2.4, we could parse /proc/cpuinfo and look at the value of 
ncpus probed    : ####

Using this, we could determine whether the hardware was SMP or not, and
install the SMP kernel package. In 2.6, with the UP kernel, this value
always shows up as 1, regardless of the number of the physical cpus in
the system.

This means that 2.6 is not probing all of the cpus with the UP kernel,
instead, stopping at the first one it finds.

Is there some other method we should be using (with the UP kernel
booted) to detect whether the hardware is SMP capable or not?

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

