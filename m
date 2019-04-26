From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 26 Apr 2019 12:07:53 +0000
Subject: Re: Naming inconsistency for serial device on sparc
Message-Id: <69b3b589-6a35-3732-6413-8328b1608238@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4c392da4-8291-fe26-fb38-22535872f127@physik.fu-berlin.de>
In-Reply-To: <4c392da4-8291-fe26-fb38-22535872f127@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

On 4/14/19 11:13 PM, David Miller wrote:
>>> It's probably been there for so long that changing it is likely to
>>> have a risk of breaking some other piece of software.
>>
>> Hmm, good point. We could maybe change it in the Debian kernel for testing
>> purposes and see if anything breaks for our users.
>>
>> I'll report back.
> 
> That would cover Debian, but what about other distros whose components
> are looking for the "wrong" name?

I have talked with the Gentoo SPARC people on #gentoo-sparc OFTC now and
then don't have a particularly strong on opinion on the subject, so I think
it should be safe to fix the inconsistency bug in the driver.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
