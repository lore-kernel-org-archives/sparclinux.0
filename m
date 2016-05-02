From: David Miller <davem@davemloft.net>
Date: Mon, 02 May 2016 00:43:18 +0000
Subject: Re: [PATCH 2/2] sparc: Implement and wire up vio_hotplug for vio.
Message-Id: <20160501.204318.4433399166886128.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1460657682-12209-3-git-send-email-glaubitz@physik.fu-berlin.de>
In-Reply-To: <1460657682-12209-3-git-send-email-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 2 May 2016 01:13:19 +0200

> Hi!
> 
> On 04/28/2016 11:13 AM, John Paul Adrian Glaubitz wrote:
>> On Wed, Apr 27, 2016 at 10:00:32PM -0400, David Miller wrote:
>>> My tree may never be rebased, as people clone and do work against it,
>>> therefore any commit made there is permanent.
>>>
>>> Please just be careful with patches you submit in the future, thanks.
>> 
>> Well, my patches are
>> 
>>       Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> 
>> so, I think did everything correctly on my side. I don't exactly know
>> my name was cut off, but I guess it's too late now -.-.
> 
> I was just wondering: Would it be possible to ask Linus to fix my name
> when he pulls in the changes from the sparc tree? From what I can see,
> the current changes are not in Linus' tree yet, so there might be a
> chance to fix the problem.

Doesn't work like that, the commit message is part of the SHA1 ID hash
and that cannot change.
