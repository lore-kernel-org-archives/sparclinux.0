From: David Miller <davem@davemloft.net>
Date: Sun, 14 Apr 2019 21:13:07 +0000
Subject: Re: Naming inconsistency for serial device on sparc
Message-Id: <20190414.141307.457991163788853147.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4c392da4-8291-fe26-fb38-22535872f127@physik.fu-berlin.de>
In-Reply-To: <4c392da4-8291-fe26-fb38-22535872f127@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 14 Apr 2019 22:25:57 +0200

> On 4/14/19 10:18 PM, David Miller wrote:
>> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Date: Sun, 14 Apr 2019 09:21:32 +0200
>> 
>>> Is there any particular reason this device name mismatch exists or
>>> is it just a bug we can fix?
>> 
>> It's probably been there for so long that changing it is likely to
>> have a risk of breaking some other piece of software.
> 
> Hmm, good point. We could maybe change it in the Debian kernel for testing
> purposes and see if anything breaks for our users.
> 
> I'll report back.

That would cover Debian, but what about other distros whose components
are looking for the "wrong" name?
