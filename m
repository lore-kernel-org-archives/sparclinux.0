Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68443AAF56
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841305; cv=none; b=lQrMTKSKZifgnmzYFdP/0PQVHKei/FRbzegzz9NBizlEku3WjfIX4twuq/1bh/GsYDBkBfb8lHtufVjPAahQKWK6U7Zu+2umOMbVE4RbnU2nudFskHp31Zrf1jBWzyntCY7TFuaa6ze+D6KTV9QVGNWMxgE8CdsBkNEZwYC52QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841305; c=relaxed/simple;
	bh=WoNz3WCxDdKybjSCg5gY111bGEDmUMC63EojmiMxyn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgI9YV07whYFH78rbtVYBwtA55CDHR82wT29VNDm5dYkF/aLmKM1X5qUyIxLA7TY9UO4DE91fy/viZSgWF1K10yDrMU5WJtC+JX3n0YHj6lIiF+dQZUYOcmCZKVQCVALprJwckan/xt8RDEfN8rlnAX+Eri9UKIbzmJxyWpbFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QxeOyTzV; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QxeOyTzV"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-93e441e14a1so162176685a.2
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 14:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791841303; x=1792446103;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7fRjyjPaygPyac6Q2934hJ/KUw5dbvEUBwLV/bpzblk=;
        b=J+ZEjPoySqGGpboszuUdrQFkj64EeKkPkySZs3MRIayM1VFfxXE8VeA9ysVPilD3hG
         S7hhWdybPt0nqaJItTDy2Jsw48odcqTWsHIOeRlirSk+KNElP03i6o7yXDUGdvQBkzFH
         3D6TDdOa2Vw0+FWJJtfHnmR+yM3zOKAYSK4TIV1AC/P3qD2B/jSDvjWQmkrzLAo7XUkb
         I0Osms1ihEZQeFAbnajwpL4vUP//en0Cf+kE7joAHG8j309xSzTVlt1AnmP2mUESdnfY
         W/g0RaqE29fWKjxxAwgcKk+YFu5Ajj6iNFjtTEe0S1hwDvPfcHlzhdEen1c6Kvs5ul+h
         HnWQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2L3LovhACLaoctvKdlxbFxUWRS6kEgzzkCZrov/WEhPT5+J7bEu+XPPNrrrG1X4qN4EMYY6pu+q/1@vger.kernel.org
X-Gm-Message-State: AFq9FYKJRa/BdmnsjHY4dqm5TomYO/UU67nY1RHeYg//cTm498gnTCr/
	GJfGjQoBkS61JDUegyYJOPKRifYZumGrC5Iveig2usRFByZ7gdHf6S0OEm/qu7yCJp+T/gJahkq
	q1kSBIwlLCzSrmI1DX1CxXZBbEoRKNmmXnerX2UXnTN78/LbBXTbzMA0x4GT9ZL70Klefbj0JrG
	dSguoYPOj9xgIIwlRMCkItDCeOttd33CIwAdhOx76UhGl1zBAT44Y+AoqRMQ4bYmYDqKUQQ9FWl
	R+1w852zXGfA+TeJUPmJQ==
X-Gm-Gg: AYBFou16HZdx3bsJChef2ZTSZCZ1IlqrqFehWrclZy6TevU/ZrOytDP4VLPVQ0WxaIr
	v9YiXQWriM13X+sgu5FdT7TFLCG6tTmUOROVWbgpjjfVTMQe6MfVwEcAmH9ddB0ZuvfnLC29TqT
	CM7rlGfrb7rhPMXvRXYHMbhAKGNYBeU/FxVy6giwrAa0VqHlTmNqieJR1zSHjxA+uSGVArF67an
	zVyV0/EZ94vX6jl/GylOKk1lpg3OAshsdRMlj9hw06zKHooFod24zN6+1TOkneoIH1CidhWIu0h
	1Qx9e1MoF4okHlWuAF91M3i0uD5/wJdcgD2+fADuFQoFtaMpLcO/5IDdzs2anAVoEVg0duldEh3
	M04wSsMIL06fBh98lghx2noNVQhbWw+Apx/ygaL5YEQfqQ4hKqSjO9GamTb0fr6ljhBK3Wkqwn7
	3plQfI+VMgb32HUbM8v/GQGb1tQrM4cetEiaTpN8KCm0M=
X-Received: by 2002:a05:620a:4614:b0:93c:c7e6:3eb4 with SMTP id af79cd13be357-93ebd28ced8mr1758197385a.54.1791841302700;
        Mon, 12 Oct 2026 14:41:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93ef4ff99c5sm20252485a.3.2026.10.12.14.41.41
        for <sparclinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:41:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3515266f6eeso4379998eec.0
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791841301; x=1792446101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fRjyjPaygPyac6Q2934hJ/KUw5dbvEUBwLV/bpzblk=;
        b=QxeOyTzVDZJ/1+vQKNsMOWgr3H/A2RrBunnSsoR4vdFbgG/F5b231KgB2bEfuSYmZ6
         4CJ94CjB+R32Nl2qwZ0kGbj7YqxAvf2BBOz32ht3+PN2vlPkGJP7IEODpvDXCBMJdkLZ
         6g8ScM47S4NZVRmh8VRWHlgvCHBJ1/ZGmnjsE=
X-Forwarded-Encrypted: i=1; AKwUvBwE4o77JfoGkTG8Lok9u63BHHu9d01x+AUr4NKDUm92vTp8e8uhn4n3aZG3XgkjLb0/03pbnvBhhZio@vger.kernel.org
X-Received: by 2002:a05:7301:618f:10b0:359:8492:20ff with SMTP id 5a478bee46e88-35984922299mr8367829eec.12.1791841300612;
        Mon, 12 Oct 2026 14:41:40 -0700 (PDT)
X-Received: by 2002:a05:7301:618f:10b0:359:8492:20ff with SMTP id 5a478bee46e88-35984922299mr8367798eec.12.1791841300003;
        Mon, 12 Oct 2026 14:41:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353814b556esm41603546eec.18.2026.10.12.14.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:41:39 -0700 (PDT)
Message-ID: <1e813008-1874-4164-a803-b1af26332d35@broadcom.com>
Date: Mon, 12 Oct 2026 14:41:37 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Avoid D3 on PLX PEX 8532/8533/8548 downstream ports
To: Bjorn Helgaas <helgaas@kernel.org>, Imre Kaloz <kaloz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Srinath Mannam <srinath.mannam@broadcom.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>
References: <20261012213447.GA1392402@bhelgaas>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20261012213447.GA1392402@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/12/26 14:34, Bjorn Helgaas wrote:
> [+cc several Broadcom folks, help with possible switch erratum]
> 
> On Sun, Sep 27, 2026 at 12:56:09PM +0200, Imre Kaloz wrote:
>> Runtime PM suspends an idle downstream port of a PLX/Broadcom PEX
>> 8532/8533/8548 switch to D3hot, but that takes the whole switch down
>> with it: any device behind another port of the same switch then
>> faults with a fatal bus error on its next access, e.g. mptsas probe
>> on a Sun Ultra 45.
>>
>> This surfaced on sparc64 once commit a5fb3ff63287 ("PCI: Allow PCI
>> bridges to go to D3Hot on all non-x86") let bridges enter D3hot. Keep
>> these downstream ports out of D3 by setting PCI_DEV_FLAGS_NO_D3.
> 
> I don't really have any objection to this, but I am concerned that
> this quirk only applies to a few specific devices, but
> https://admin.pci-ids.ucw.cz/read/PC/10b5 shows a TON of
> similar-looking switches that I assume have the same behavior, so
> this may be just the tip of the iceberg.
> 
>> Fixes: a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Our internal portal does not have any document for the 8532/8533/8548 so 
unfortunately I cannot help here with identifying an errata document.
-- 
Florian
