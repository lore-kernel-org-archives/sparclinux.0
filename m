From: Florian Vaussard <florian.vaussard@epfl.ch>
Date: Tue, 04 Feb 2014 12:13:20 +0000
Subject: Re: [PATCH v3 0/5] can: sja1000: cleanups and new OF property
Message-Id: <52F0D960.3010501@epfl.ch>
List-Id: <sparclinux.vger.kernel.org>
References: <1391175277-19833-1-git-send-email-florian.vaussard@epfl.ch> <52EBA7E2.6090007@pengutronix.de> <52EBAA28.1070307@gaisler.com> <52F0A29C.9000604@gaisler.com>
In-Reply-To: <52F0A29C.9000604@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Larsson <andreas@gaisler.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/04/2014 09:19 AM, Andreas Larsson wrote:
> On 2014-01-31 14:50, Andreas Larsson wrote:
>> On 2014-01-31 14:40, Marc Kleine-Budde wrote:
>>> On 01/31/2014 02:34 PM, Florian Vaussard wrote:
>>>> Hello,
>>>>
>>>> (could someone with a SJA1000 on SPARC perform a functional test
>>>> to see if interrupts are working? it would be great :-)
>>>>
>>>> Changes since v2:
>>>> - Dropped patch 1 "can: sja1000: remove unused defines"
>>>> - Addressed Marc's comments on patch 4 and 6 (now 3 and 5)
>>>>
>>>> Changes since v1:
>>>> - Merge sja1000_of_platform.c into sja1000_platform.c (patch 4)
>>>>
>>>> The first part of this series performs serveral small cleanups
>>>> (patches 1 and 2).
>>>>
>>>> Patch 3 merges sja1000_of_platform.c into sja1000_platform.c.
>>>> Changes are pretty conservatives (mostly copy/paste/move). IRQ
>>>> is treated differently in the OF and non-OF versions, thus this
>>>> is where the fused version differs the most.
>>>>
>>>> The final part introduces the 'reg-io-width' binding (already used
>>>> by some other drivers) to perform a similar job as what was done
>>>> with IORESOURCE_MEM_XXBIT. This is needed on my system to correctly
>>>> take into account the aliasing of the address bus.
>>>>
>>>> All patches were tested using OF boot on my OMAP3 system with a
>>>> memory-mapped SJA1000. Thus, the non-OF path is not tested, as
>>>> I do not have a platform data at hand.
>>>
>>> Nice, looks good now. I'll give Andreas some time to test on sparc and
>>> then apply the patches.
>>
>>
>> I am on it. I will dig up some hardware for this on Monday to test it.
> 
> Works splendidly. You can add:
> 
> Tested-by: Andreas Larsson <andreas@gaisler.com>
> 

Waohhh, great :D Thank you!

Regards,
Florian
