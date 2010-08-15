From: David Miller <davem@davemloft.net>
Date: Sun, 15 Aug 2010 06:36:16 +0000
Subject: Re: Serial console issue with 2.6.32
Message-Id: <20100814.233616.258120668.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201003151809.27436.elendil@planet.nl>
In-Reply-To: <201003151809.27436.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Wed, 2 Jun 2010 19:53:34 +0200

> On Wednesday 26 May 2010, David Miller wrote:
>> From: Frans Pop <elendil@planet.nl>
>> Date: Wed, 17 Mar 2010 11:50:07 +0100
>>
>> > Now that I know it's not a huge issue for me personally. It just means
>> > I can no longer use my Sparc box for testing use of console= for
>> > Debian installations, which is a pity as it's the most suitable box I
>> > have for that.
>> >
>> > I'm not sure how much this is going to throw off other users, but I
>> > suspect the majority (except maybe for long time sparc sysadmins)
>> > would expect console= to be honored.
>>
>> Frans, is this patch enough to get the behavior you want?
>>
>> --------------------
>> sunserial: Don't call add_preferred_console() when console= is
>> specified.
> 
> Thanks for the patch David. I've tried to test with it, but for some reason 
> the box does not boot at all with .34 (both with and without the patch) if 
> I pass console=ttyS0. If I don't pass the parameter it boots fine.
> 
> Need to investigate (using netconsole or earlier kernels), but that will 
> take some more time.

Frans, I just wanted to let you know that I'm actively trying to debug this
now.  On my SunBlade100 I can see similar behavior.  If I hook up a video
head and a keyboard, yet give "console=ttyS0" on the command line it doesn't
try to use the serial console for kernel messages.

I'll let you know when I have a fix to test.

Thanks for your patience.
