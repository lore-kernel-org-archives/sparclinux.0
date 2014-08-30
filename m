From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sat, 30 Aug 2014 19:20:00 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <CALMQjD_asRUcW8r7v-b5oMUJtdVWiHuYsQnfpiiCgz7UC31QBA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1309240010220.15075@math.ut.ee>
	<alpine.SOC.1.00.1310011134250.26098@math.ut.ee>
	<20140404.165202.33247787406066736.davem@davemloft.net>
	<20140812.233033.2016564874125097713.davem@davemloft.net>
	<alpine.SOC.1.00.1408190946280.27327@math.ut.ee>
	<alpine.SOC.1.00.1408201517210.57@math.ut.ee>
	<53FBF51C.1090503@daenzer.net>
	<alpine.LRH.2.11.1408260954250.4606@siim2.ut.ee>
	<53FD416C.3060005@daenzer.net>
In-Reply-To: <53FD416C.3060005@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Meelis Roos <mroos@linux.ee>
Cc: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, David Miller <davem@davemloft.net>, dri-devel@lists.freedesktop.org

On 27 August 2014 04:24, Michel Dänzer <michel@daenzer.net> wrote:
> On 26.08.2014 16:07, Meelis Roos wrote:
>>>>>
>>>>> r100 init hangs in a different place. Original dmesg first, then my
>>>>> instrumented dmesg (seems to get further):
>>>>
>>>>
>>>> The instrumented dmesg had a couple of my local test changes and was
>>>> bad now that I had ROM. Reverted them exept my readb changes (instead
>>>> of direct dereferences of iomapped space) and redid
>>>> logging to be more precise.
>>>>
>>>>> [drm] radeon kernel modesetting enabled.
>>>>> PCI: Enabling device: (0000:02:02.0), cmd 82
>>>>> [drm] initializing kernel modesetting (RV100 0x1002:0x5159
>>>>> 0x1002:0x0908).
>>>>> [drm] register mmio base: 0x10000000
>>>>> [drm] register mmio size: 32768
>>>>> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR
>>>>
>>>>
>>>> This was still the unchanged kernel hanging.
>>>>
>>>> Below is a new debug log to pinpoint the hang. It seems to hang in
>>>> r100_gfx_get_rptr but not on first try.
>>>
>>>
>>> It's most likely hanging in readl() in r100_mm_rreg() then.
>>
>>
>> Yes, it is doing direct readl() there. But what does this hang mean?
>
>
> I'm not sure if the read can hang because of the GPU, or if indicates a more
> fundamental PCI issue. Dave?
>
>
>
>> By the way, I get these warnings from r100. Seem to be unrelated but
>> still worth reporting IMHO:
>
>
> Looks unrelated indeed.
>
>
>
> --
> Earthling Michel Dänzer            |                  http://www.amd.com
> Libre software enthusiast          |                Mesa and X developer

Hi,

Just a short question regarding the test setup.
Is the video card a Sun XVR-100 or is it a vanilla ATI RV100 ?
(If it is a vanilla RV100 there might be some kind of initialization issue
as the video ROM is not executed during boot?)

Regards,
Kjetil Oftedal
