From: =?UTF-8?B?UmHDumwgUG9yY2Vs?= <armin76@gentoo.org>
Date: Mon, 26 Oct 2009 15:12:14 +0000
Subject: Re: temperature & fan-control
Message-Id: <4AE5BC4E.4060101@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
In-Reply-To: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Frans van Berckel wrote:
> On Fri, 2009-10-23 at 21:24 +0200, Raúl Porcel wrote:
>> Frans van Berckel wrote:
>>> Hi,
>>>
>>> Is speeding the fans on a Blade 1000/2000 and Fire 280R well supported
>>> by the kernel? What sensor modules & tools are needed to compile?
>>>
>>> Thanks,
>>>
>>> Frans van Berckel
>> Frans,
>>
>> can't say about the 280R, but the fan control on the Blade 1000/2000
>> worked until kernel 2.6.29, when it stopped working and hasn't worked
>> since then. If you downgrade to a 2.6.28 kernel for example, you don't
>> need any tool for it to work, you just need the CONFIG_ENVCTRL option
>> enabled in your kernel either as built-in or as a module.
>>
>> @all: feel free to correct me if i'm wrong :)
> 
> Hi Raúl,
> 
> Thanks for guiding. Did some testing & checking the envctrl sources, I
> found out it got to be the bbc parts for the SunBLADE-1000.
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=drivers/sbus/char;hb=HEAD
> 
> Next I did boot into 2.6.28-6-sparc64-smp but modprobe show's the -22
> error while loading the bbc module and does not slow down the fans.
> 
> Oct 24 16:35:20 sunbladesrv249 kernel: [  994.142927] i2c-0: Regs at
> 000007fe7e00002e, 8 devices, own a0, clock 10.
> Oct 24 16:35:20 sunbladesrv249 kernel: [  994.145987] bbc_i2c: probe of
> f007f00c failed with error -22
> 
> So that's faling. I just did upgrade to Sun IEEE Boot Prom 'OBP 4.16.4
> 2004/12/18 05:18', to be sure but isn't solving my problem.
> 
> Did you start a bug ticket yet?
> 
> 
> Thanks,
> 
> Frans van Berckel
> 
> 
> 
> 

Hi,

maybe it was 2.6.27 the latest working? And no, i didn't file a bug,
feel free to do it yourself.

