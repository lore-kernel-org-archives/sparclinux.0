From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 11 Aug 2011 18:41:35 +0000
Subject: Re: Bug report: booting 3.1-rc1 on Sunfire V120 fails
Message-Id: <20110811184135.GA22714@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <400C43189542CE41BC0A5B252FC90136A995C8D7EB@SJEXCHCCR02.corp.ad.broadcom.com>
In-Reply-To: <400C43189542CE41BC0A5B252FC90136A995C8D7EB@SJEXCHCCR02.corp.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 11, 2011 at 08:52:05AM -0700, Pieter-Paul Giesberts wrote:
> Hi, 
> 
> I have just compiled the latest 3.1.0-rc1 kernel from Greg's staging repository and tried to boot it on a Sunfire V120, but it crashes during boot, the log is shown below. The 3.0.0 and older kernels from the same repository worked fine on the same machine. ali7101 seems to be the culprit.
> 
> Regards, Pieter-Paul Giesberts
...

Hi Pieter-Paul.

Can you try to pass "initcall_debug" on the commandline to the kernel.
We need to know exactly which initcall causes the oops.

Or at least I could not get enough info from the oops.

	Sam
