From: "Fabio M. Di NItto" <fabbione@fabbione.net>
Date: Sat, 08 Jan 2011 09:01:43 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <4D2827F7.60507@fabbione.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 01/07/2011 11:41 PM, Sam Ravnborg wrote:
>>
>> What kernel version are you running exactly? config says 2.6.36-rc7, if
>> so it's missing other fixes related to the console handover.
>>
>> Basically, grab 2.6.37 that was released a day ago and apply the patch.
>>
>> If the problem persist, please comment out the call to
>> unregister_console and boot with -p. That should give us enough extra
>> output to see where it's hanging.
> 
> Just a quick status.
> I used HEAD from mainline today as it included all my sparc patches.
> [Initially it oopsed but this was unrelated].
> 
> After enabling all ATYFB related options in the config
> I could see that it got probed and I got output on the screen.

Oh ok.. so you do use the card output (that would have been useful info
earlier ;)). All my tests were around fixing serial console (as it's
really the only one I have). I'll try to hook up a monitor to the SB100
and see if I can reproduce here.

Fabio
