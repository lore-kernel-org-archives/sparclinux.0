From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 14 Apr 2019 21:17:01 +0000
Subject: Re: Naming inconsistency for serial device on sparc
Message-Id: <b1cd67b2-5f93-72d4-78ea-79966fbbe99d@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4c392da4-8291-fe26-fb38-22535872f127@physik.fu-berlin.de>
In-Reply-To: <4c392da4-8291-fe26-fb38-22535872f127@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/14/19 11:13 PM, David Miller wrote:
>> Hmm, good point. We could maybe change it in the Debian kernel for testing
>> purposes and see if anything breaks for our users.
>>
>> I'll report back.
> 
> That would cover Debian, but what about other distros whose components
> are looking for the "wrong" name?

I'm not aware of any actively maintained sparc(64) Linux distributions
besides Debian and Gentoo and I know the folks from the latter, so I
could ask them for their opinion as well.

Oracle unfortunately stopped development of Oracle Linux for SPARC.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
