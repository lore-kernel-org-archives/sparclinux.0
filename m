From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 18 Sep 2017 18:05:45 +0000
Subject: Re: [PATCH 2/2] arch: change default endian for microblaze
Message-Id: <e755625e-0b3a-4027-0754-4873fc8446b1@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1505753609-602923-1-git-send-email-babu.moger@oracle.com>
 <1505753609-602923-3-git-send-email-babu.moger@oracle.com>
 <cf4bd066-b349-070a-ddf9-d6ae02f44cd7@monstr.eu>
In-Reply-To: <cf4bd066-b349-070a-ddf9-d6ae02f44cd7@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org


On 9/18/2017 12:49 PM, Michal Simek wrote:
> On 18.9.2017 18:53, Babu Moger wrote:
>> Fix the default for microblaze. Michal Simek mentioned default for
>> microblaze should be CPU_LITTLE_ENDIAN.
>>
>> Fixes : commit 206d3642d8ee ("arch/microblaze: add choice for endianness
>> 	and update Makefile")
>>
>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> ---
>>   arch/microblaze/Kconfig |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>> index 9d26abd..4f798aa 100644
>> --- a/arch/microblaze/Kconfig
>> +++ b/arch/microblaze/Kconfig
>> @@ -39,7 +39,7 @@ config MICROBLAZE
>>   # Endianness selection
>>   choice
>>   	prompt "Endianness selection"
>> -	default CPU_BIG_ENDIAN
>> +	default CPU_LITTLE_ENDIAN
>>   	help
>>   	  microblaze architectures can be configured for either little or
>>   	  big endian formats. Be sure to select the appropriate mode.
>>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
Thanks.
> If you want me to take this through my microblaze tree please let me know.
Sure. Thanks
>
> Thanks,
> Michal
>

