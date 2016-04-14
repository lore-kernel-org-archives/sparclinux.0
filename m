From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 16:00:02 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570FBE82.2030103@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/14/2016 03:30 PM, Sam Ravnborg wrote:
>> Hmm, I'm not sure whether this belongs here. I thought it was obvious
>> what these two changes are for due to the canonical function names.
> Just a suggestion - skip it as you prefer.

Ok, thanks!

>> I used the same indentation that is used for modalias_show in
>> arch/powerpc/kernel/vio.c but I wasn't sure what the proper
>> indentation would be in this case.
>>
>> Can you suggest the right indentation?
> You shall uses tabs and the necessary number of spaces so the
> arguments are aligned with the first argument.
> So the alignment is fine - just replace preceeding spaces with tabs.
> 
> Like this:
> static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> 			     char *buf)
> 
> Three leading tabs, then 5 spaces.

Alright, will do.

>> Yeah, I know. I can re-send them with git send-email if that's desired,
>> I just wanted to avoid cluttering the discussion too much.
> It is my understanding that this is simpler for davem when applying patches.
> But maybe patchwork makes things easier with respect to attached patches.
> Anyway - if you follow the normal pattern then everything should just works.
> 
> Most important, document what was changed from v1 to v2 -
> so when davem and other looks at this they know what was changed.

I'll wait for davem to chime in and then post the patches the
way he prefers.

Thanks for the suggestions!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
