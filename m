From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Fri, 14 Jan 2011 11:39:28 +0000
Subject: Re: [PATCH v3] cassini: Use local-mac-address prom property for Cassini
Message-Id: <4D3035F0.6020503@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1294324455.6193.70.camel@duncow>
In-Reply-To: <1294324455.6193.70.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

All,

FYI Sinan Akman has reported that cassini does not compile for x86 any 
longer. Message included below.

Does anyone have suggestions as to the best way to resolve this?

Also are there any other lists that this should be forwarded to?

Regards

Richard


-------- Original Message --------
Subject: Re: [PATCH] cassini: Use local-mac-address prom property for 
Cassini MAC address
Date: Thu, 13 Jan 2011 20:28:54 -0500
From: Sinan Akman <sinan@writeme.com>
To: richm@oldelvet.org.uk

Richard, cassini  doesn't compile now for x86 after :

http://www.spinics.net/lists/sparclinux/msg07607.html

pci_device_to_OF_node is not defined for all archs so
perhaps you are better of leaving CONFIG_SPARC instead
of having CONFIG_OF.

Feel free to forward this to list (did this ever
appear in lmkl or only sparclinux ?).

If you have another patch on that and cc me I can
compile test for you on x86.

-- sinan


On 06/01/2011 19:51, David Miller wrote:
> From: Richard Mortimer<richm@oldelvet.org.uk>
> Date: Thu, 06 Jan 2011 14:34:15 +0000
>
>> > From 603b3377a6857448006c886f10c607d07c102b64 Mon Sep 17 00:00:00 2001
>> From: Richard Mortimer<richm@oldelvet.org.uk>
>> Date: Thu, 6 Jan 2011 00:08:54 +0000
>> Subject: [PATCH] cassini: Use local-mac-address prom property for Cassini MAC address
>>
>> Fallback on the local-mac-address prom property if the Cassini device
>> does not have an address programmed in the VPD ROM. This uses the same
>> technique as implemented by the sungem driver.
>>
>> The problem was reported by Frans van Berckel using Debian kernel 2.6.34-7
>> on Sun Fire V440. udev was assigning a new eth<n>  device name on each reboot
>> because the cassini driver was using a random MAC address.
>>
>> Fix tested on 2.6.34-7 and 2.6.37 Sun Fire V440. Compile tested against
>> 2.6.36 davem/sparc-2.6.git
>>
>> Reported-by: Frans van Berckel<fberckel@xs4all.nl>
>> Tested-by: Frans van Berckel<fberckel@xs4all.nl>
>> Reviewed-by: Julian Calaby<julian.calaby@gmail.com>
>> Reviewed-by: Sam Ravnborg<sam@ravnborg.org>
>> Signed-off-by: Richard Mortimer<richm@oldelvet.org.uk>
>
> Applied, thanks a lot.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
