From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 14 Apr 2016 10:52:52 +0000
Subject: Re: Enable module aliases for vio on sparc/sparc64
Message-Id: <570F7684.7040401@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <570B52AE.8080603@physik.fu-berlin.de>
In-Reply-To: <570B52AE.8080603@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sam!

On 04/14/2016 12:27 PM, Sam Ravnborg wrote:
> Great work - good to see all the progress on sparc64 in debian!

Thanks!

>>> >From b7e3362d71c9d1cb972e5c16e4b9054f8f3de63f Mon Sep 17 00:00:00 2001
>> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Date: Thu, 14 Apr 2016 01:16:14 +0200
>> Subject: [PATCH 1/2] sparc: Implement and wire up modalias_show for vio.
> 
> It would be nice if you could add here the effect this patch has - that
> it fixes the debian installer.

Hmm, I'm not sure whether this belongs here. I thought it was obvious
what these two changes are for due to the canonical function names.

>> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> ---
>>  arch/sparc/kernel/vio.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
>> index cb5789c..e7fd1e5 100644
>> --- a/arch/sparc/kernel/vio.c
>> +++ b/arch/sparc/kernel/vio.c
>> @@ -105,9 +105,18 @@ static ssize_t type_show(struct device *dev,
>>  	return sprintf(buf, "%s\n", vdev->type);
>>  }
>>  
>> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>> +                             char *buf)
> Please use tabs and the appropriate number of spaces to indent.

I used the same indentation that is used for modalias_show in
arch/powerpc/kernel/vio.c but I wasn't sure what the proper
indentation would be in this case.

Can you suggest the right indentation?

>> +{
>> +	const struct vio_dev *vdev = to_vio_dev(dev);
>> +
>> +	return sprintf(buf, "vio:T%sS%s\n", vdev->type, vdev->compat);
>> +}
>> +
> 
> At sparclinux we usually submit one patch per mail.
> And patches which are specific for either sparc32 or sparc64 are prefixed so.
> 
> Like this
> [PATCH 1/2] sparc64: ...
> [PATCH 2/2] sparc64: ...

Yeah, I know. I can re-send them with git send-email if that's desired,
I just wanted to avoid cluttering the discussion too much.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
