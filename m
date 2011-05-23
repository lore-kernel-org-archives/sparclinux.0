From: Kjetil Oftedal <oftedal@gmail.com>
Date: Mon, 23 May 2011 17:28:11 +0000
Subject: Sun4d boot crash in sun4d_init_timers
Message-Id: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

The current sparc-next-2.6 encounters a zero pointer on sun4d during boot. 
I have bisected it down to the changes made during the introduction of 
genirq. 

The problematic change is in sun4d_init_timers(). sun4d_build_device_irq() 
is now called from there with NULL as the first parameter, which will for 
obvious reasons not work. 

I've tried to change sun4d_build_device_irq() to allow building a device irq 
for the timer interrupt without any platform device, as it is a cpu local 
interrupt(?), and just bypassing all the sbus specifics in 
sun4d_build_device_irq(), down to irq_alloc(). (Setting pil to real_irq and 
board to 0).

With such a change request_irq() fails with -90, which is probably -ENOSYS 
from __setup_irq(). 

Any suggestions on how this could be fixed ?

-
Kjetil Oftedal







