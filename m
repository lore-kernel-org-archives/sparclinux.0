From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
Date: Wed, 30 May 2007 20:04:38 +0000
Subject: Stuck process on debian unstable bring the machine down
Message-Id: <465DD8D6.4000204@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, I'm running a smp kernel on an U60.
I was trying to compile the source package of mono 1.2.4-3 on my machine 
when I got something really strange.

The compilation process got stuck in the dh_shlibdeps invokation.

When searching for the shlib, I got a process dpkg query which suddendly 
went to 100% CPU usage.
After further examination, the top indicates that the proces uses 1700m 
of virtual mem, with 39m of rss.
Strangely, the process eats all cpu cycles of the machine bringing the 
load to a steady 70.
The process is unkillable and an strace on it shows absolutely nothing 
which is plain weird.

This problem shows up either with 2.6.21.3-smp kernel and 2.6.20.12-smp.
Those kernels are home compiled.

	Can someone help me explain this oddity. I'm rebooting the machine for 
the 3rd time in two whereas it was working flawlessly for days.

	Seb
