From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 22:26:20 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <2e01ca3b-ff82-70c7-9048-1def2640fb6f@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/24/2016 11:05 PM, Aaro Koskinen wrote:
> I think that's your job to try. If you want to "add 64-bit support"
> (instead of forcing it to everybody), do the required changes so that
> it's still works for everybody without extra fiddling.

Don't be so rude, I'm not forcing anything onto anyone.

>>> Also you broke the tilo build...
>>
>> Not here. Just tried it again and it builds fine. Can you be more specific?
> 
> The same issue as with silo.

Don't you think your statements are a bit misleading then? I didn't break anything,
I changed the default target to 64-bit which is somewhat reasonable in the year
2016, isn't it.

Or are you going to tell me now that your 333 MHz, 128 MiB RAM Sun Ultra 5 is
your everyday production machine?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
