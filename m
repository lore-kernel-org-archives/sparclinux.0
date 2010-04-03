From: David Miller <davem@davemloft.net>
Date: Sat, 03 Apr 2010 22:12:34 +0000
Subject: Re: Kernel panic - not syncing: Irrecoverable deferred error trap
Message-Id: <20100403.151234.30951869.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
In-Reply-To: <1270240845.1783.52.camel@deblnxsrv254.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 03 Apr 2010 17:13:46 +0200

> On Sat, 2010-04-03 at 01:16 -0700, David Miller wrote:
>> Out of curiosity do you have multiple monitors hooked up to the
>> XVR-1200 device, or just one?
> 
> Ahhh ahhm ... choose a other option, non monitors is hooked up.

Ok, so the device node we need to ignore seems to show up
on any card that supports multihead at all, regardless of
whether there are monitors attached to the inputs.

And this set of cards would include at least the XVR-1200

>> I bet this might explain the XVR-600 failures I could not reproduce,
>> as seen by Paul Cao, CC:'d.  Paul if you had two monitors hooked up to
>> your XVR-600, try next time installing with just one monitor attached.
>> 
>> Frans, if you could test the patch below I'd really appreciate it.
> 
> Gonna do this compile run next. Just a 2.6.26 or 2.6.34?

It doesn't matter, either way works to test this fix.

Thanks again.
