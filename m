From: Eric Brower <ebrower@usa.net>
Date: Wed, 31 Mar 2004 19:56:06 +0000
Subject: Re: E250 LED indicators
Message-Id: <406B2256.6000308@usa.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have a mostly written driver that support environmental monitoring and 
LEDs on the E250.  It will handle temperature and fan monitoring, and 
can control all the LEDs (currently is only twiddles the activity LED).

The bigger issue that has been keeping this driver off the list to date 
is that the current PCF8584 (I2C bus controller) support must be 
rewritten to support multi-master operation and I've not mustered the 
enthusiasm to do it yet.  Without such support, collisions result 
infrequently in misread or miswritten data that results in possibly 
bogus overheat conditions or LED states on the front status panel.

And since you asked, I'll poke a sore spot....

Another issue is the difference between the Solaris driver and existing 
Linux envctrl driver(s).  When the power-off temperature threshold is 
met, Linux does a friendly shutdown.  Solaris does a hard power-off, 
which I feel is appropriate if we implement notification at the warning 
threshold (bbc-envctrl and my envctrltwo do this, but envctrl does not).

However, due to the oft-lamented issue of sparc and sparc64 refusing to 
power-down a system completely if it is on a serial console, you gain 
little benefit from halting to OBP.  DaveM-- I'll float you a sysctl 
patch for sparc64 and sparc if you'd consider it and find the current 
"protection" valuable, otherwise perhaps machine_power_off should 
actually power-off, machine_halt should halt and userspace commands 
should get smarter about whether they ask the system to halt or 
power-off.  As I recall, the Red Hat patches to /sbin/shutdown do 
provide the distinction, though the userspace may not have "closed the 
loop" to do the right thing by default on serial console installs.

To make a long answer short-- I can send you the work-in-progress driver 
off-list, but I recommend running it in debug mode so that shutdowns are 
not actually performed, otherwise you may get false positives.  Let me know.

E

Costas Magkos wrote:
> Hi debian people,
> 
> I have a Sun Enterprise E250 running sarge. E250 has a front panel with 
> LEDs used as health and fault indicators, which apparently work only 
> when the system is running Solaris.
> 
> Does anyone know of a workaround for them to work under debian?
> 
> Thanx in advance.
> 
> ~kmag
> 
> 
> Costas Magkos
> Internet Systematics Lab
> NCSR "Demokritos"
> Athens, Greece
> 
> 

