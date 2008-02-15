From: =?iso-8859-1?Q?Pablo_Andr=E9s_Martikian?=
Date: Fri, 15 Feb 2008 11:28:57 +0000
Subject: bbc_envctrl & sunblade1000 temp/fan monitoring
Message-Id: <BAY123-W223997AE674E1FB857BC07D1260@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi all,

Sorry to bother, I hope this is the right email. I'll try to be short.

I recovered a SunBlade1000. The kernel thread works perfect (just a little adjustement on the temp ranges so the fan doesn't blow my ears). I wanted to gather in some way the info gathered by the kernel thread. Using the i2c or lm_sensors or kernel hardware sensors didn't work for me. As I saw that kenvctrl kernel thread, it reads the values and modifies the fan speeds as needed, but I was wondering if there is any way to get the values it reads, so I could know the temperature and fan speeds.

Maybe I didn't search enough, or maybe there is no other way, so I modified the bbc_envctrl.c to print the values via the procfs to the /proc/kenvctrl file. I just added a spinlock and the create_proc_file and destroy. This is the output I show:

# cat /proc/kenvctrl
TEMP0: cpu 73 amb 27
TEMP1: cpu 71 amb 27
FAN0: psuppy 1 cpufanspeed 44 sysfanspeed 41

I attach the source. I think the spinlock is well used.

I was wondering.....in case there is no other way to obtain the values....could it be possible to think of updating the bbc_envctrl to show the values to the procfs as I did here? is it doable? or is it just too much work to do for an almost obsolete hardware?

I think it could be extremely easy afterwards to show that info using something like gnome-sensors-applet, as it's plugins seems easy to create. 

Sorry for the inconvenience in case it is not the right email list.


....well in case it is the correct one, I leave a question in case samebody knows......the cpufanspeed and sysfanspeed (as it is shown in a comment somewhere in the bbc_envctrl.c), what are they?  voltage? or RPMs?   and in either case.....by what number we need to multiply those values to obtain the correct human-readable number?

Thank you very much
Pablo
_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/