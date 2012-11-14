From: David Miller <davem@davemloft.net>
Date: Wed, 14 Nov 2012 22:49:38 +0000
Subject: Re: [PATCH] drivers/of: Constify device_node->name and ->path_component_name
Message-Id: <20121114.174938.1893866220809474233.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1352932107-14782-1-git-send-email-grant.likely@secretlab.ca>
	<20121114.173304.405703188822325414.davem@davemloft.net>
	<CACxGe6vGVK1BQ8Zw+AH3_zSCsCLVfNENb-Qwn45tb+zwC9Mheg@mail.gmail.com>
In-Reply-To: <CACxGe6vGVK1BQ8Zw+AH3_zSCsCLVfNENb-Qwn45tb+zwC9Mheg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, benh@kernel.crashing.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Nov 2012 22:42:26 +0000

> On Wed, Nov 14, 2012 at 10:33 PM, David Miller <davem@davemloft.net> wrote:
>>
>> You're making other changes here, such as the kstrdup() stuff,
>> seperate that into another patch.
> 
> It's part of the same change. The original code was allocating a
> buffer, saving the pointer in the name field and then modifying it.
> Making the code to a kstrdup() gets rid of modifying the const buffer.

Please mention that in your commit message then, thanks.
